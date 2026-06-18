; Forked from: https://github.com/nvim-treesitter/nvim-treesitter/blob/4916d6592ede8c07973490d9322f187e07dfefac/runtime/queries/python/injections.scm

(call
  function: (attribute
    object: (identifier) @_re)
  arguments: (argument_list
    (string
      (string_content) @injection.content))
  (#eq? @_re "re")
  (#set! injection.language "regex"))

(call
  function: (attribute
    object: (identifier) @_re)
  arguments: (argument_list
    (concatenated_string
      [
        (string
          (string_content) @injection.content)
        (comment)
      ]+))
  (#eq? @_re "re")
  (#set! injection.language "regex"))

((binary_operator
  left: (string
    (string_content) @injection.content)
  operator: "%")
  (#set! injection.language "printf"))

((comment) @injection.content
  (#set! injection.language "comment"))
