; inherits: c

; Forked from https://github.com/nvim-treesitter/nvim-treesitter/blob/4916d6592ede8c07973490d9322f187e07dfefac/runtime/queries/cpp/indents.scm

(condition_clause) @indent.begin

((field_initializer_list) @indent.begin
  (#set! indent.start_at_same_line 1))

(access_specifier) @indent.branch
