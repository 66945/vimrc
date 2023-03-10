if exists("b:current_syntax")
  finish
endif

syntax region block start=/@\[/ end=/\]/
highlight link block Keyword
