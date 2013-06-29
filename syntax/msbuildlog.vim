" Vim syntax file
" Language: MSBuild Log File
" Maintainer: Martin Gill

if exists("b:current_syntax")
  finish
endif

set nowrap

" need to sync a lot, to capture property regions
" but want avoid using fromstart as that's too slow
syn sync minlines=2500

syn match beginBuild /^Build started .*$/
syn match toolsVersion /^Building with tools version.\{-}\n/ contains=name


" Property Regions
syn match initialEnv /^Environment at start of build:\_.\{-}\n\n/ fold contains=propDef,propContinue
syn match initialProps /^Initial Properties:\_.\{-}\n\n/ fold contains=propDef,propContinue

" Properties
syn match  propDef      contained /^\w.\+ = .\{-}\n/ contains=propName,propOperator
syn match  propName     contained '\S\{-}\( =\)\@='
syn match  propOperator contained ' = '
syn match  propContinue contained /^\s\+\S\+\n/

" Item Regions
syn match initialItems /^Initial Items:\_.\{-}\n\n/ fold contains=itemName,itemEntry,itemProp

" Items
syn match itemName contained /^\S\+\n/
syn match itemEntry contained /^\s\{4}\S.\{-}\n/
syn match itemProp  contained /^\s\{8}.\{-} = .\{-}\n/

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
syn match   skippedAction   /^\c\(Task\|Target\) ".\{-}\" skipped.\{-}\n/
syn match   usingTask       /^Using ".\{-}" task from.\{-}\n/ contains=name

syn match   taskParameter   /^\s\+Task Parameter:/
syn match   globalProps     /^\s\+Global Properties:/

syn match   overrideTarget  /^Overriding target .\{-}\n/ contains=name

syn match   warning         /^.\{-}(\d\+,\d\+): warning : .\{-}\n/
syn match   error           /^.\{-}(\d\+,\d\+): error : .\{-}\n/

syn match   warningTotal    /^\s\{-}[1-9]\d*\s\+Warning(s)\n/
syn match   errorTotal      /^\s\{-}[1-9]\d*\s\+Error(s)\n/

syn match   buildSucceed    /^Build succeeded\.\n/
syn match   buildfailed     /^Build failed\.\n/

syn match   timeElapsed     /^Time Elapsed.\{-}\n/

syn match   perfSummary     /^\w\+ Performance Summary:/
syn match   perfEntry       /^\s\+\d\+ ms  .\{-}\s\+\d\+ calls\n/ contains=perfNumber,perfMs,perfCalls
syn match   perfMs          / ms/    contained
syn match   perfNumber      / \d\+/  contained
syn match   perfCalls       / calls/ contained


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

hi def link itemName        Identifier
hi def link itemEntry       Constant
hi def link itemProp        String

hi def link propDef         Constant
hi def link propName        Identifier
hi def link propOperator    Operator
hi def link propContinue    Constant

hi def link actionId        Normal
hi def link actionIdName    Constant
hi def link actionIdValue   Number

hi def link doneAction      PreProc          
hi def link startAction     PreProc      
hi def link skippedAction   Debug
hi def link usingTask       Define
hi def link taskParameter   Define
hi def link globalProps     Define

hi def link overrideTarget  Exception

hi def link error           ErrorMsg
hi def link errorTotal      ErrorMsg
hi def link warning         WarningMsg
hi def link warningTotal    WarningMsg

hi def link perfSummary     PreProc
hi def link perfEntry       Define
hi def link perfNumber      Number
hi def link perfMs          String
hi def link perfCalls       String


hi def link timeElapsed     PreProc

hi def link buildSucceed    PreProc
hi def link buildfailed     ErrorMsg

let b:current_syntax = "msbuildlog"

