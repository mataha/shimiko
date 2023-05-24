@echo off&if "~x0"=="%~x0" exit/b2
setlocal EnableDelayedExpansion EnableExtensions&set:=!CMDCMDLINE://=!
:_
for /f "tokens=1,* delims=/" %%k in ("!:!") do set+=%%l&set.=!+:~0,1!&if /i "!.!"=="c" (exit/b1) else if /i "!.!"=="k" (goto:-) else if defined + set:=%%l&goto:_
:-
endlocal&for /f delims^= %%p in ("%HOMEDRIVE%%HOMEPATH%\.cmd") do for /f "tokens=1,2 delims=d" %%a in ("-%%~ap") do if "%%~b"=="" if not "%%~a"=="-" call "%%~fp"
exit/b
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
