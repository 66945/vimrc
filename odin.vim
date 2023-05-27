if exists("b:current_syntax")
  finish
endif

syntax keyword odinUsing using
syntax keyword odinTransmute transmute
syntax keyword odinCast cast
syntax keyword odinDistinct distinct
syntax keyword odinOpaque opaque
syntax keyword odinWhere where

syntax keyword odinStruct struct
syntax keyword odinEnum enum nextgroup=odinEnumType skipwhite
syntax keyword odinUnion union
syntax keyword odinBitField bit_field
syntax keyword odinBitSet bit_set

syntax keyword odinIf if
syntax keyword odinWhen when
syntax keyword odinElse else
syntax keyword odinDo do
syntax keyword odinFor for
syntax keyword odinSwitch switch
syntax keyword odinCase case
syntax keyword odinContinue continue
syntax keyword odinBreak break
syntax keyword odinSizeOf size_of
syntax keyword odinOffsetOf offset_of
syntax keyword odinTypeInfoOf type_info_of
syntax keyword odinTypeIdOf typeid_of
syntax keyword odinTypeOf type_of
syntax keyword odinAlignOf align_of

syntax keyword odinOrReturn or_return
syntax keyword odinOrElse or_else

syntax keyword odinInline inline
syntax keyword odinNoInline no_inline

syntax match odinTodo "TODO"
syntax match odinNote "NOTE"
syntax match odinXXX "XXX"
syntax match odinFixMe "FIXME"
syntax match odinNoCheckin "NOCHECKIN"
syntax match odinHack "HACK"

syntax keyword odinDataType string cstring bool b8 b16 b32 b64 rune any rawptr f16 f32 f64 f16le f16be f32le f32be f64le f64be u8 u16 u32 u64 u128 u16le u32le u64le u128le u16be u32be u64be u128be uint uintptr i8 i16 i32 i64 i128 i16le i32le i64le i128le i16be i32be i64be i128be int complex complex32 complex64 complex128 quaternion quaternion64 quaternion128 quaternion256 matrix typeid
syntax keyword odinBool true false
syntax keyword odinNull nil
syntax keyword odinDynamic dynamic
syntax keyword odinMap map
syntax keyword odinProc proc
syntax keyword odinIn in
syntax keyword odinNotIn notin
syntax keyword odinNotIn not_in
syntax keyword odinImport import
syntax keyword odinExport export
syntax keyword odinForeign foreign
syntax keyword odinConst const
syntax match odinNoinit "---"
syntax keyword odinPackage package

syntax keyword odinReturn return
syntax keyword odinDefer defer

syntax region odinRawString start=+`+ end=+`+
syntax region odinChar start=+'+ skip=+\\\\\|\\'+ end=+'+
syntax region odinString start=+"+ skip=+\\\\\|\\'+ end=+"+

syntax match odinStructDecl "\v<\w*>(\s*::\s*struct)@="
syntax match odinEnumDecl "\v<\w*>(\s*::\s*enum)@="
syntax match odinEnumType "\i\+" contained

syntax match odinTagNote "@\<\w\+\>" display

syntax match odinHalfRange "\.\.\<" display
syntax match odinRange "\.\." display
syntax match odinTernaryQMark "?" display
syntax match odinDeclaration ":" display nextgroup=odinType,odinMap,odinBitSet,odinProc skipwhite
syntax match odinType "\v(\w+\.)?[a-zA-Z0-9]+" contained
syntax match odinDeclaration "\:\:" display
syntax match odinDeclAssign ":=" display

syntax match odinAssign "=" display
syntax match odinBrackets "[\[\(\)\{\}]" display
syntax match odinArr "[\]]" display nextgroup=odinType
syntax match odinExtra "[*-/+><!,|;]" display
syntax match odinDot "\." nextgroup=odinMember,odinFunctionCall,odinConstant
syntax match odinMember "\w\+" contained
syntax match odinConstant "\v<[A-Z0-9,_]+>" display
syntax match odinFunctionDecl "\v<\w*>(\s*::\s*proc)@="
syntax match odinFunctionCall "\v\w+\s*(\()@="
syntax match odinReturnOp "->" display nextgroup=odinType skipwhite

syntax match odinInteger "\-\?\<\d\+\>" display
syntax match odinFloat "\-\?\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\%([eE][+-]\=[0-9_]\+\)\=" display
syntax match odinHex "\<0[xX][0-9A-Fa-f]\+\>" display
syntax match odinDoz "\<0[zZ][0-9a-bA-B]\+\>" display
syntax match odinOct "\<0[oO][0-7]\+\>" display
syntax match odinBin "\<0[bB][01]\+\>" display

syntax match odinAddressOf "&" display
syntax match odinDeref "\^" display nextgroup=odinType

syntax match odinMacro "#\<\w\+\>" display
syntax region odinAttr start=/\v\@/ end=/\v\)/
syntax match odinTemplate "$\<\w\+\>"

syntax match odinCommentNote "@\<\w\+\>" contained display
syntax region odinLineComment start=/\/\// end=/$/  contains=odinCommentNote, odinTodo, odinNote, odinXXX, odinFixMe, odinNoCheckin, odinHack
syntax region odinBlockComment start=/\v\/\*/ end=/\v\*\// contains=odinBlockComment, odinCommentNote, odinTodo, odinNote, odinXXX, odinFixMe, odinNoCheckin, odinHack

highlight link odinUsing      Special
highlight link odinTransmute  Keyword
highlight link odinCast       Keyword
highlight link odinDistinct   Special
highlight link odinOpaque     Special
highlight link odinReturn     Keyword
highlight link odinSwitch     Conditional
highlight link odinCase       Conditional
highlight link odinProc       Special
highlight link odinIn         Special
highlight link odinNotIn      Special
highlight link odinContinue   Keyword
highlight link odinBreak      Keyword
highlight link odinSizeOf     Special
highlight link odinOffsetOf   Special
highlight link odinTypeOf     Special
highlight link odinTypeInfoOf Special
highlight link odinTypeIdOf   Special
highlight link odinAlignOf    Special
highlight link odinPackage    Special
highlight link odinOrReturn   Conditional
highlight link odinOrElse     Conditional
highlight link odinWhere      Conditional

highlight link odinInline Keyword
highlight link odinNoInline Keyword

highlight link odinImport  Special
highlight link odinExport  Special
highlight link odinForeign Special
highlight link odinNoinit  Keyword
highlight link odinDo      Conditional
highlight link odinDefer   Keyword
highlight link odinDynamic Special

highlight link odinMap Special
highlight link odinRange Operator
highlight link odinHalfRange Operator
highlight link odinAssign Operator
highlight link odinAddressOf Operator
highlight link odinDeref Operator

highlight link odinDeclaration Operator
highlight link odinType Type
highlight link odinDeclAssign Operator
highlight link odinAssign Operator
highlight link odinTernaryQMark Operator
highlight link odinReturnOp Operator
highlight link odinBrackets Special
highlight link odinArr Special
highlight link odinExtra Special
highlight link odinDot Special

highlight link odinMember Identifier

highlight link odinString String
highlight link odinRawString String
highlight link odinChar Character

highlight link odinStructDecl Type
highlight link odinEnumDecl Type
highlight link odinEnumType Type
highlight link odinStruct Special
highlight link odinEnum Special
highlight link odinUnion Special
highlight link odinBitField Special
highlight link odinBitSet Special

" :FunctionHighlighting
highlight link odinFunctionDecl Function
highlight link odinFunctionCall Function

highlight link odinMacro Macro
highlight link odinAttr Macro
highlight link odinIf Conditional
highlight link odinWhen Conditional
highlight link odinElse Conditional
highlight link odinFor Repeat

highlight link odinLineComment Comment
highlight link odinBlockComment Comment
highlight link odinCommentNote Todo

highlight link odinTodo Todo
highlight link odinNote Todo
highlight link odinXXX Todo
highlight link odinFixMe Todo
highlight link odinNoCheckin Todo
highlight link odinHack Todo

highlight link odinTemplate Constant

highlight link odinTagNote Identifier
highlight link odinDataType Special
highlight link odinBool Boolean
highlight link odinConstant Constant
highlight link odinNull Special
highlight link odinInteger Number
highlight link odinFloat Float
highlight link odinHex Number
highlight link odinOct Number
highlight link odinBin Number
highlight link odinDoz Number

let b:current_syntax = "odin"
