return {
    -- DAP
    {
        "mfussenegger/nvim-dap",
        config = function()
            vim.keymap.set("n", "<F8>", function() require("dap").continue() end, { desc = "Debug: Continue" })
            vim.keymap.set("n", "<F10>", function() require("dap").step_over() end, { desc = "Debug: Step Over" })
            vim.keymap.set("n", "<F11>", function() require("dap").step_into() end, { desc = "Debug: Step Into" })
            vim.keymap.set("n", "<F12>", function() require("dap").step_out() end, { desc = "Debug: Step Out" })
            vim.keymap.set("n", "<leader>b", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>B", function()
                require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Conditional Breakpoint" })
        end,
    },

    -- DAP UI
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            local function layout(name)
                return {
                    elements = { { id = name } },
                    enter = true,
                    size = 40,
                    position = "right",
                }
            end

            local layouts = {
                layout("repl"),
                layout("stacks"),
                layout("scopes"),
                layout("console"),
                layout("watches"),
                layout("breakpoints"),
            }

            local function toggle_debug_ui(idx)
                dapui.close()
                local uis = vim.api.nvim_list_uis()[1]
                if uis then
                    layouts[idx].size = uis.width
                end
                pcall(dapui.toggle, idx)
            end

            vim.keymap.set("n", "<leader>dr", function() toggle_debug_ui(1) end, { desc = "Toggle REPL" })
            vim.keymap.set("n", "<leader>ds", function() toggle_debug_ui(2) end, { desc = "Toggle Stacks" })
            vim.keymap.set("n", "<leader>dw", function() toggle_debug_ui(4) end, { desc = "Toggle Watches" })
            vim.keymap.set("n", "<leader>db", function() toggle_debug_ui(6) end, { desc = "Toggle Breakpoints" })
            vim.keymap.set("n", "<leader>dS", function() toggle_debug_ui(3) end, { desc = "Toggle Scopes" })
            vim.keymap.set("n", "<leader>dc", function() toggle_debug_ui(4) end, { desc = "Toggle Console" })

            local dap_group = vim.api.nvim_create_augroup("DapGroup", { clear = true })
            vim.api.nvim_create_autocmd("BufEnter", {
                group = dap_group,
                pattern = "*dap-repl*",
                callback = function() vim.wo.wrap = true end,
            })

            dapui.setup({})

            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

            dap.listeners.after.event_output.dapui_config = function(_, body)
                if body.category == "console" then
                    dapui.eval(body.output)
                end
            end
        end,
    },

    -- Mason DAP
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = { "delve", "codelldb" },
                automatic_installation = true,
                handlers = {
                    function(config)
                        require("mason-nvim-dap").default_setup(config)
                    end,
                    delve = function(config)
                        table.insert(config.configurations, 1, {
                            args = function()
                                return vim.split(vim.fn.input("args> "), " ")
                            end,
                            type = "delve",
                            name = "file",
                            request = "launch",
                            program = "${file}",
                            outputMode = "remote",
                        })
                        require("mason-nvim-dap").default_setup(config)
                    end,
                    codelldb = function(config)
                        table.insert(config.configurations, 1, {
                            name = "Launch File",
                            type = "codelldb",
                            request = "launch",
                            program = function()
                                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                            end,
                            cwd = "${workspaceFolder}",
                            stopOnEntry = false,
                        })
                        require("mason-nvim-dap").default_setup(config)
                    end,
                },
            })
        end,
    },
}