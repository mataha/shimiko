@if "~x0"=="%~x0" set CMD=&set CMD_ENV=&set CMD_FLAGS=&exit/b
@set CMD=%CMDEXTVERSION%&set CMD_FLAGS=cds&setlocal EnableDelayedExpansion EnableExtensions&set+=!CMDCMDLINE://=!&set,=&set[=&set]=&set;=@for /f "tokens=1,* delims=
:_
%;%/" %%k in ("!+!") do @set.=%%l&set:=!.:~0,1!&if defined . ((if /i "!:!"=="c" (set[=c&goto:-) else if /i "!:!"=="k" (set]=k&goto:-) else if /i "!:!"=="s" set,=s)&set+=!.:~1!&goto:_)
:-
@if %[%%]%~==~ set,=
@endlocal&set CMD_FLAGS=%[%%]%%,%&if defined CMD_ENV if %[%~==~ %;%:" %%o in (":%CMD_ENV%") do %;%d" %%a in ("-%%ap") do @if %%b~==~ if not %%a~==-~ call "%%~fp"
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
