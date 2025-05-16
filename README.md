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
  "yourusername/jtt.nvim",
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
      dart = { mode = "suffix", test_suffix = "_test", ext = ".dart" },
      python = { mode = "prefix", test_prefix = "test_", ext = ".py" },
      typescript = { mode = "dot_suffix", test_suffix = ".spec", ext = ".ts" },
    }
  })
```

## Options

| Option Name              | Type                         | Default Value                                                                                            | Required (Y/N) | Meaning                                      |
| ------------------------ | ---------------------------- | -------------------------------------------------------------------------------------------------------- | -------------- | -------------------------------------------- |
| languages                | [Table](#languages-options)  | [See Config](https://github.com/herisetiawan00/jtt.nvim/blob/main/lua/jtt/config/language_defaults.lua)  | Y              |List of pattern for each languages           |

### Languages Options
| Option name |  Type                                     |  Default Value          | Required (Y/N) | Meaning                                                                                | Example          |
| ----------- | ----------------------------------------- |  ---------------------- | -------------- | -------------------------------------------------------------------------------------- | ---------------- |
| mode        | String (`prefix`, `suffix`)               |                         | Y              | Mode is required to know how the file name structured and where is test identifier are | `prefix`         | 
| test        | String                                    |                         | Y              | Test file name identifier pattern                                                      | `test_`, `.spec` |
| ext         | String                                    | Current buffer file ext | N              | Filter for file extension to find                                                      | `.dart`, `.rs`   |

## Usage

- jtt need to be setup by calling `require("jtt").setup()`.
- Simply use `:JumpTest` to swap between implementation and test file.
- Add `vim.keymap.set("n", "<C-T>", "<cmd>JumpTest<cr>", { desc = "Swap between test file" })` to your config for easy movement (Optional)
