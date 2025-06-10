# jtt.nvim

Inspired to [JetBrains Jump-to-Test](https://www.jetbrains.com/guide/java/tips/navigate-to-test/) but for Neovim.

Question? lets [discuss it](https://github.com/herisetiawan00/jtt.nvim/discussions)!

Have a problem or idea? Make an [issue](https://github.com/herisetiawan00/jtt.nvim/issues) or a [PR](https://github.com/herisetiawan00/jtt.nvim/pulls).

---

## Table of Contents

1. [Features](#features)
2. [Requirements](#requirements)
3. [Installation](#installation)
4. [Configurations](#configurations)
5. [Options](#options)
6. [Usage](#usage)

## Features

- Jump between source and test files with a single key mapping.
- Supports many languages out of the box.
- Easily extendable with custom language configurations.

## Requirements

- You need to install [fd](https://github.com/sharkdp/fd)

## Installation

Use your favorite plugin manager :)

```lua
{
  "herisetiawan00/jtt.nvim",
  config = function()
    require("jtt").setup()
  end
}
```

## Configurations

You can pass custom pattern into `setup({ ... })`.
Examples:

```lua
  require("jtt").setup({
    languages = {
      dart = { mode = "suffix", test = "_test", ext = ".dart" },
      python = { mode = "prefix", test = "test_", ext = ".py" },
      typescript = { mode = "suffix", test = ".spec", ext = ".ts" },
      elixir = {
        mode = "suffix",
        test = "_test",
        ext = ".exs",
        source_ext = ".ex",
        source_path_prefix = "lib",
        test_path_prefix = "test"
      }
    }
  })
```

## Options

| Option Name | Type                        | Default Value                                                                                           | Required (Y/N) | Meaning                            |
| ----------- | --------------------------- | ------------------------------------------------------------------------------------------------------- | -------------- | ---------------------------------- |
| languages   | [Table](#languages-options) | [See Config](https://github.com/herisetiawan00/jtt.nvim/blob/main/lua/jtt/config/language_defaults.lua) | Y              | List of pattern for each languages |

### Languages Options

| Option name        | Type                        | Default Value           | Required (Y/N) | Meaning                                                                                                                                                                                                                                                                                                                                                                                                  | Example                |
| ------------------ | --------------------------- | ----------------------- | -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------- |
| mode               | String (`prefix`, `suffix`) |                         | Y              | Mode is required to know how the file name structured and where is test identifier are                                                                                                                                                                                                                                                                                                                   | `prefix`               |
| test               | String                      |                         | Y              | Test file name identifier pattern                                                                                                                                                                                                                                                                                                                                                                        | `test_`, `.spec`       |
| ext                | String                      | Current buffer file ext | N              | Filter for file extension to find                                                                                                                                                                                                                                                                                                                                                                        | `.dart`, `.rs`, `.exs` |
| source_ext         | String                      | Value of `ext` option   | N              | File extension for source files if it differs from test files                                                                                                                                                                                                                                                                                                                                            | `.ex`                  |
| source_path_prefix | String                      | nil                     | N              | Path prefix for where source files are stored. This option should be used if the source file structure mirrors the test file structure (e.g. `app/models/user.rb` and `spec/models/user_spec.rb`) and you are working in a project with duplicate file names (e.g. `app/views/users/show.html.erb` and `app/views/posts/show.html.erb`). Usage requires `test_path_prefix` option to be defined as well. | `app`                  |
| test_path_prefix   | String                      | nil                     | N              | Path prefix for where test files are stored. Usage requires `source_path_prefix` option to be defined as well.                                                                                                                                                                                                                                                                                           | `spec`                 |

## Usage

- jtt need to be setup by calling `require("jtt").setup()`.
- Simply use `:JumpTest` to swap between implementation and test file.
- Add `vim.keymap.set("n", "<C-T>", "<cmd>JumpTest<cr>", { desc = "Swap between test file" })` to your config for easy movement (Optional)
