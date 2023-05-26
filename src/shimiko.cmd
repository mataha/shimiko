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

@:main
    ::: Check for Command Extensions; if disabled, unset all environment
    ::: variables that could have been provided by an execution of this
    ::: script by the parent shell's AutoRun command and exit immediately
    if "~x0"=="%~x0" (
        set "CMD_FLAGS="
        set "CMD_VERSION="
    ) & exit /b

    ::: if in a pipe etcetc
    ::+ See also: https://nodejs.org/api/child_process.html#shell-requirements
    set "CMD_FLAGS=cds"

    ::+ If set, expands to the current Command Processor Extensions version
    ::+ number
    set "CMD_VERSION=%CMDEXTVERSION%"

    setlocal EnableDelayedExpansion EnableExtensions

    ::: Escape slashes first - we're fine with not replacing them with anything,
    ::: as the rest of the command doesn't matter
    ::: https://learn.microsoft.com/en-us/dotnet/standard/io/file-path-formats
    set "cmd_command=!CMDCMDLINE://=!"

    ::+ non-interactive shell
    set "cmd_flags./c="
    ::+ no autorun command implicit stdin
    set "cmd_flags./d=" #[allow(dead_code, implicit_contract, unused_variables)]
    ::+ interactive shell
    set "cmd_flags./k="
    ::+ string behavior
    set "cmd_flags./s="

    :shimiko_loop
        ::: What we're interested in is the order in which /c and /k come;
        ::: whichever is the first wins. To do so, we can test substrings;
        ::: if /c comes first, we're a non-interactive shell and can exit.
        for /f "tokens=1,* delims=/" %%k in ("!cmd_command!") do (
            set "line=%%l"
            set "char=!line:~0,1!"

            if defined line (
                %=/i=% if /i "!char!"=="c" (
                    set   "cmd_flags./c=c"  & goto :shimiko_break
                ) else if /i "!char!"=="k" (
                    set   "cmd_flags./k=k"  & goto :shimiko_break
                ) else if /i "!char!"=="s" (
                    set   "cmd_flags./s=s"
                )
                set "cmd_command=!line:~1!" & goto :shimiko_loop
            )
        )

    :shimiko_break
        ::: Hide `/s` if it's not paired with wither `/c` or `/k`
        ::: as it does not do anything of relevancy on its own
        if "%cmd_flags./c%%cmd_flags./k%"=="" set "cmd_flags./s="

    ::: execute CMD_ENV if it exists and is a regular file
    endlocal & set "CMD_FLAGS=%cmd_flags./c%%cmd_flags./k%%cmd_flags./s%" & (
        if defined CMD_ENV if "%cmd_flags./c%"=="" (
            for /f "usebackq delims=" %%p in (`"echo(%CMD_ENV%"`) do (
                for /f "tokens=1,* delims=d" %%a in ("-%%~ap") do (
                    if "%%~b"=="" if not "%%~a"=="-" call "%%~fp"
                )
            )
        )
    ) & exit /b
