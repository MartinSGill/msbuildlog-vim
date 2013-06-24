" Vim syntax file
" Language: MSBuild Log File
" Maintainer: Martin Gill

if exists("b:current_syntax")
  finish
endif

syn sync fromstart

syn match beginBuild /^Build started .*$/
syn match toolsVersion /^Building with tools version.\{-}\n/ contains=name


" Property Regions
syn match initialEnv /^Environment at start of build:\_.\{-}\n\n/ fold contains=propDef,propContinue
syn match initialProps /^Initial Properties:\_.\{-}\n\n/ fold contains=propDef,propContinue

" Properties
syn match  propDef      contained /^\w.\+ = .\{-}\n/ contains=propName,propOperator
syn match  propName     contained '^\S\+'
syn match  propOperator contained ' = '
syn match  propContinue contained /^\s\+\S\+\n/

" Item Regions
syn match initialItems /^Initial Items:\_.\{-}\n\n/ fold contains=itemList

" Items
syn match itemList contained /^\w\_.\{-}\n\n/ fold contains=itemName,itemEntry
syn match itemName contained /^\S\+\n/
syn match itemEntry contained /^\s\+\S\+\n/

syn region name contained start=/\v"/ end=/\v"/

" Projects
syn match   projectStart    /^Project .\+\n/ contains=projectTarget,name,projectNodeId1,projectNodeId2
syn match   projectTarget   /(\@<=\w\+\(\starget\)\@=/ contained
syn match   projectNodeId1  /(\d\(\d\|:\)*)/ contained
syn match   projectNodeId2  /node \d\+/ contained
syn match   projectEnd      /^Done Building Project.*$/ contains=name,projectTarget 

" Action Id  e.g. (TaskId:123)
syn match   actionId contains=actionIdName,actionIdValue /(\w\+Id:\d\+)/
syn match   actionIdName contained /\w\+/
syn match   actionIdValue contained /\d\+/

syn match   doneAction      /^Done \(executing\|building\) .\{-}\n/ contains=name,actionId 
syn match   startAction     /^\c\(Task\|Target\) ".\{-}\" \(skipped\)\@!.\{-}\n/ contains=name,actionId
syn match   skippedAction   /^\c\(Task\|Target\) ".\{-}\" skipped.\{-}\n/ contains=name,actionId
syn match   usingTask       /^Using ".\{-}" task from.\{-}\n/ contains=name

syn match   taskParameter   /^\s\+Task Parameter:/
syn match   globalProps     /^\s\+Global Properties:/

syn match   overrideTarget  /^Overriding target .\{-}\n/ contains=name

" Highlighting

hi def link beginBuild      PreProc

hi def link name            String

hi def link projectStart    PreProc
hi def link projectEnd      PreProc
hi def link projectTarget   Identifier
hi def link projectNodeId1  Number
hi def link projectNodeId2  Number

hi def link initialEnv      Define
hi def link initialProps    Define
hi def link initialItems    Define
hi def link toolsVersion    Define

hi def link itemList        Normal
hi def link itemName        Identifier
hi def link itemEntry       Constant

hi def link propDef         Constant
hi def link propName        Identifier
hi def link propOperator    Operator
hi def link propContinue    Constant

hi def link actionId        Normal
hi def link actionIdName    Constant
hi def link actionIdValue   Number

hi def link doneAction      PreProc          
hi def link startAction     PreProc      
hi def link skippedAction   Ignore
hi def link usingTask       Define
hi def link taskParameter   Define
hi def link globalProps     Define

hi def link overrideTarget  Exception

let b:current_syntax = "msbuildlog"
