return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  opts = {
    provider = "xai",
    providers = {
      openai = {
        model = "o1",
        extra_request_body = {
          reasoning_effort = "high",
        },
      },
      gemini = {
        model = "gemini-2.5-flash",
        extra_request_body = {
          temperature = 0.5,
        },
      },
      deepseek = {
        __inherited_from = "openai",
        api_key_name = "DEEPSEEK_API_KEY",
        endpoint = "https://api.deepseek.com",
        model = "deepseek-coder",
        extra_request_body = {
          max_tokens = 8192,
        },
      },
      xai = {
        __inherited_from = "openai",
        api_key_name = "XAI_API_KEY",
        endpoint = "https://api.x.ai/v1",
        model = "grok-3-mini",
      },
    },
    rag_service = {
      enabled = false, -- enabled it only when avante implement otimizations
      host_mount = os.getenv("HOME") .. "/Projects",
      provider = "ollama",
      llm_model = "gemma3:4b",
      embed_model = "nomic-embed-text",
      endpoint = "http://host.docker.internal:11434",
    },
    auto_suggestions_provider = "claude",
    behavior = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      enable_cursor_planning_mode = true,
    },
    mappings = {
      suggestion = {
        accept = "<C-l>",
        next = "<C-]>",
        prev = "<C-[>",
        dismiss = "<C-x>",
      },
    },
  },
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "echasnovski/mini.pick",
    "nvim-telescope/telescope.nvim",
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  keys = {
    { "<leader>ax", "<cmd>AvanteClear<cr>", desc = "avante: Clear chat", mode = { "n" } },
  },
}
