@(if not defined DEBUG echo off) & setlocal DisableDelayedExpansion & goto :main

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

:get_workspace_root (*workspace_root) -> Result
    setlocal & (if "%~1"=="" (exit /b 2))

    for /f "delims=" %%p in ("%~dp0.\..") do set "workspace_root=%%~fp"

    endlocal & (set "%~1=%workspace_root%") & exit /b 0

:is_regular_file (path) -> Result
    for /f "tokens=1,* delims=d" %%a in ("-%~a1") do if not "%%~b"=="" (
        exit /b 1 &@rem FILE_ATTRIBUTE_DIRECTORY
    ) else if not "%%~a"=="-" (
        exit /b 0 &@rem FILE_ATTRIBUTE_NORMAL at the very least
    ) else (
        exit /b 2 &@rem Who knows...
    )

@:main
    call :get_workspace_root root
    set "binary=%root%\src\shimiko.cmd"

    if defined CI set colors=

    call :is_regular_file "%binary%" || exit /b 2

    ::: Reset errorlevel
    (call )

    set CMD_ENV=
    set CMD_FLAGS=
    set CMD_VERSION=

    set "CMDCMDLINE="C:\WINDOWS\system32\cmd.exe" "
    call "%binary%"

    set "CMDCMDLINE="C:\Windows\SysWOW64\cmd.exe" "
    call "%binary%"

    set "CMDCMDLINE="C:\WIN DOWS\system32\cmd.exe" "
    call "%binary%"

    set "CMDCMDLINE=cmd"
    call "%binary%"

    set "CMDCMDLINE="cmd""
    call "%binary%"

    set "CMDCMDLINE="cmd.exe""
    call "%binary%"

    set "CMDCMDLINE="C:\WINDOWS\system32\cmd.exe""
    call "%binary%"

    set "CMDCMDLINE=cmd /q"
    call "%binary%"

    set "CMDCMDLINE="cmd" /q"
    call "%binary%"

    set "CMDCMDLINE="cmd.exe" /q"
    call "%binary%"

    set "CMDCMDLINE="%ComSpec%" /q"
    call "%binary%"

    set "CMDCMDLINE=cmd "/q""
    call "%binary%"

    set "CMDCMDLINE="cmd" "/q""
    call "%binary%"

    set "CMDCMDLINE="cmd.exe" "/q""
    call "%binary%"

    set "CMDCMDLINE="C:\WINDOWS\system32\cmd.exe" "/q""
    call "%binary%"

    set "CMDCMDLINE=cmd/q"
    call "%binary%"

    set "CMDCMDLINE="cmd"/q"
    call "%binary%"

    set "CMDCMDLINE="cmd.exe"/q"
    call "%binary%"

    set "CMDCMDLINE="C:\WINDOWS\system32\cmd.exe"/q"
    call "%binary%"

    set "CMDCMDLINE=cmd /q /c"
    call "%binary%"

    set "CMDCMDLINE="cmd" /q /c"
    call "%binary%"

    set "CMDCMDLINE="cmd.exe" /q /c"
    call "%binary%"

    set "CMDCMDLINE="C:\WINDOWS\system32\cmd.exe" /q /c"
    call "%binary%"

    set "CMDCMDLINE=cmd "/q" "/c""
    call "%binary%"

    set "CMDCMDLINE="cmd" "/q" "c""
    call "%binary%"

    set "CMDCMDLINE="cmd.exe" "/q" "/c""
    call "%binary%"

    set "CMDCMDLINE="C:\WINDOWS\system32\cmd.exe" "/q" "/c""
    call "%binary%"

    set "CMDCMDLINE=cmd/q/c"
    call "%binary%"

    set "CMDCMDLINE="cmd"/q/c"
    call "%binary%"

    set "CMDCMDLINE="cmd.exe"/q/c"
    call "%binary%"

    set "CMDCMDLINE="C:\WINDOWS\system32\cmd.exe"/q/c"
    call "%binary%"

    set "CMDCMDLINE=cmd /c "echo a""
    call "%binary%"

    set "CMDCMDLINE="cmd /c echo a""
    call "%binary%"

    set "CMDCMDLINE="cmd /c "echo a"""
    call "%binary%"

    set "CMDCMDLINE="C:\WINDOWS\system32\cmd.exe" /c ver"
    call "%binary%"

    set "CMDCMDLINE="C:\WINDOWS\system32\cmd.exe" /c "ver""
    call "%binary%"

    set "CMDCMDLINE="C:\WIN OWS\system32\cmd.exe" /c ver"
    call "%binary%"

    set "CMDCMDLINE="C:\WIN OWS\system32\cmd.exe" /c "ver""
    call "%binary%"

    set "CMDCMDLINE="C:\WIN OWS\system32\cmd.exe" /c ""C:\Users\user\drag-and-drop.cmd" C:\Users\user\test.cmd""
    call "%binary%"

    set "CMDCMDLINE="C:\WIN OWS\system32\cmd.exe" /c ""C:\Users\user\drag-and-drop.cmd" C:\Users\user\test.cmd C:\Users\user\test.cmd""
    call "%binary%"

    set "CMDCMDLINE="C:\WIN OWS\system32\cmd.exe" /c ""C:\Users\user\drag-and-drop.cmd" "C:\Users\user\te st.cmd"""
    call "%binary%"

    set "CMDCMDLINE="C:\WIN OWS\system32\cmd.exe" /c ""C:\Users\user\drag-and-drop.cmd" "C:\Users\user\te st.cmd" "C:\Users\user\te st2.cmd"""
    call "%binary%"

    rem Todo - test with command extensions disabled, delayed expansion disabled
