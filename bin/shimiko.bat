@if "~a0"=="%~a0" set CMD_FLAGS=&set CMD_RUNAS=&set CMD_SUBSHELL=&set CMD_VERSION=&call &goto.
@setlocal EnableDelayedExpansion EnableExtensions&set CMDEXTVERSION=&set+=!CMDCMDLINE!&set c=&set k=&set s=&set -=&set _=&set[= CMD_SUBSHELL&set]=@"%__APPDIR__%"&set,=@if defined &set(= @if /i &set\=goto])else&set;=@for /f "tokens=1* delims=
:[
%;%/" %%k in ("!+://=!") do @set.=%%l&set:=!.:~0,1!&%,%. ((%(%"!:!"=="r" (set c=c&%\%%(%"!:!"=="c" (set c=c&%\%%(%"!:!"=="k" (set k=k&%\%%(%"!:!"=="s" set s=s)&set+=!.:~1!&goto[)
:]
%]%fsutil.exe dirty query %SystemDrive% 2>nul>nul&&set _=1&%]%timeout.exe 0 2>nul>nul||set -=-&%(%%c%%k%~==~ set s=
%,%%[% (set/a%[%+=1)else set%[%=0
@endlocal&set CMD_FLAGS=%c%%k%%s%%-% &set CMD_RUNAS=%_%&set/a%[%=%CMD_SUBSHELL%&set/a CMD_VERSION=%CMDEXTVERSION%+0&%,%CMD_ENV%(%%c%%-%~==~ %;%" %%p in ('"echo(%CMD_ENV%"') do %;%d" %%a in ("-%%~ap") do%(%%%b~==~%(%not %%a~==-~ call "%%~fp"2>nul
@exit/b0
::: Copyright (c) Mateusz "mataha" Kazimierczuk
:::
::: Permission is hereby granted, free of charge, to any person obtaining a
::: copy of this software and associated documentation files (the "Software"),
::: to deal in the Software without restriction, including without limitation
::: the rights to use, copy, modify, merge, publish, distribute, sublicense,
::: and/or sell copies of the Software, and to permit persons to whom
::: the Software is furnished to do so, subject to the following conditions:
:::
::: The above copyright notice and this permission notice shall be included in
::: all copies or substantial portions of the Software.
:::
::: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
::: IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
::: FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
::: THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
::: LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
::: FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
::: DEALINGS IN THE SOFTWARE.
:::
::: Except as contained in this notice, the names of the above copyright
::: holders shall not be used in advertising or otherwise to promote the sale,
:.: use or other dealings in this Software without prior written authorization.
