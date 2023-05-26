@if "~x0"=="%~x0" set CMD_FLAGS=&set CMD_VERSION=&exit/b
@setlocal EnableDelayedExpansion EnableExtensions&set+=!CMDCMDLINE://=!&set,=&set[=&set]=&set(= @if /i &set\=goto:-)else&set;=@for /f "tokens=1,* delims=
:_
%;%/" %%k in ("!+!") do @set.=%%l&set:=!.:~0,1!&if defined . ((%(%"!:!"=="c" (set[=c&%\%%(%"!:!"=="k" (set]=k&%\%%(%"!:!"=="s" set,=s)&set+=!.:~1!&goto:_)
:-
%(%%[%%]%~==~ set,=
@endlocal&set/a "CMD_VERSION=%CMDEXTVERSION%+0"2>&1>nul&set CMD_FLAGS=%[%%]%%,%&if defined CMD_ENV%(%%[%~==~ %;%:" %%o in ('"echo(:%CMD_ENV%"') do %;%d" %%a in ("-%%ap") do%(%%%b~==~%(%not %%a~==-~ 2>nulcall "%%~fp"
@exit/b
::! Copyright (c) Mateusz "mataha" Kazimierczuk; all rights reserved.
::!
::! Permission is hereby granted, free of charge, to any person obtaining a
::! copy of this software and associated documentation files (the "Software"),
::! to deal in the Software without restriction, including without limitation
::! the rights to use, copy, modify, merge, publish, distribute, sublicense,
::! and/or sell copies of the Software, and to permit persons to whom
::! the Software is furnished to do so, subject to the following conditions:
::!
::! The above copyright notice and this permission notice shall be included in
::! all copies or substantial portions of the Software.
::!
::! THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
::! IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
::! FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
::! THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
::! LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
::! FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
::! DEALINGS IN THE SOFTWARE.
::!
::! Except as contained in this notice, the name(s) of the above copyright
::! holders shall not be used in advertising or otherwise to promote the sale,
::! use or other dealings in this Software without prior written authorization.
