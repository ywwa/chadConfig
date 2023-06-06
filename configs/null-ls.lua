local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  b.formatting.deno_fmt,
  b.formatting.prettier.with {
    filetypes = {
      "html",
      "markdown",
      "css",
      "json",
    },
  },
  b.formatting.stylua,

  b.diagnostics.php,
  b.diagnostics.jsonlint,

  b.code_actions.eslint_d,
  b.code_actions.refactoring,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
