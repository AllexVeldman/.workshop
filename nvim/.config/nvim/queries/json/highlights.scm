; Forked from https://github.com/nvim-treesitter/nvim-treesitter/blob/4916d6592ede8c07973490d9322f187e07dfefac/runtime/queries/json/highlights.scm

[
  (true)
  (false)
] @boolean

(null) @constant.builtin

(number) @number

(pair
  key: (string) @property)

(pair
  value: (string) @string)

(array
  (string) @string)

[
  ","
  ":"
] @punctuation.delimiter

[
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

("\"" @conceal
  (#set! conceal ""))

(escape_sequence) @string.escape

((escape_sequence) @conceal
  (#eq? @conceal "\\\"")
  (#set! conceal "\""))

(comment) @comment @spell
