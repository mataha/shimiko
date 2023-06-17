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
::: use or other dealings in this Software without prior written authorization.

@goto :main

:is_elevated () > Result
    for /f "delims=" %%p in ("%__APPDIR__%.") do (
        "%%~fp\fsutil.exe" dirty query "%SystemDrive%" >nul
    )

    exit /b

:is_interactive () > Result
    for /f "delims=" %%p in ("%__APPDIR__%.") do (
        "%%~fp\timeout.exe" 0 >nul 2>&1
    )

    exit /b

::: Checks if the file located by this path is a regular file.
::: Follows symbolic links in the path.
::: See also: https://learn.microsoft.com/en-gb/windows/win32/fileio/file-attribute-constants
:is_regular_file (path: string?) > Result
    for /f "tokens=1,* delims=d" %%a in ("-%~a1") do (
        if "%%b"=="" if not "%%a"=="-" (
            exit /b 0 "FILE_ATTRIBUTE_NORMAL or a normal or extended attribute"
        )
    )

    exit /b 1 "File does not exist, is a directory, or it cannot be determined"

@:main
    ::: Check for Command Extensions; if disabled, modify all environment
    ::: variables that could have been provided by an execution of this
    ::: script by the parent shell's AutoRun command manually, then reset;
    ::: we're operating in a different context here, so keep in mind that:
    :::   - `exit /b` outputs a 'The system cannot find the batch label
    :::     specified - EOF' error to stderr, thus it has to be silenced;
    :::     furthermore, environment will not be restored cleanly (script
    :::     title will persist), forcing us to `goto` to a terminal label
    :::   - `goto :EOF` makes a jump to a label named `EOF`; doesn't exit
    :::   - all `set` commands other than simple assignments are disabled
    :::     including usage of quotation marks to surround the expression
    if "~a0"=="%~a0" (
        set CMD_FLAGS=y?
        set CMD_RUNAS=%CMD_RUNAS%
        set CMD_VERSION=
    ) & call & goto :EOF

    setlocal EnableDelayedExpansion EnableExtensions & set CMDEXTVERSION=

    ::: Escape slashes first - we're fine with not replacing them with anything,
    ::: as the rest of the command doesn't matter
    ::: https://learn.microsoft.com/en-us/dotnet/standard/io/file-path-formats
    set "cmd_command=!CMDCMDLINE!"

    ::+ non-interactive shell
    set "cmd_flags./c="
    ::+ interactive shell
    set "cmd_flags./k="
    ::+ string behavior - strip quotes
    set "cmd_flags./s="

    :shimiko_loop
        ::: What we're interested in is the order in which `/c` and `/k` come;
        ::: whichever gets parsed first wins. To do so, we can test substrings;
        ::: if parser detects `/c` we're a non-interactive shell and can exit.
        ::: Escape slashes first - we're fine with them not being replaced; see
        ::: https://learn.microsoft.com/en-us/dotnet/standard/io/file-path-formats
        for /f "tokens=1,* delims=/" %%k in ("!cmd_command://=!") do (
            set "line=%%~l"
            set "char=!line:~0,1!"

            if defined line (
                %=/c=% if /i "!char!"=="r" (
                    set   "cmd_flags./c=c"  & goto :shimiko_break
                ) else if /i "!char!"=="c" (
                    set   "cmd_flags./c=c"  & goto :shimiko_break
                ) else if /i "!char!"=="k" (
                    set   "cmd_flags./k=k"  & goto :shimiko_break
                ) else if /i "!char!"=="s" (
                    set   "cmd_flags./s=s"
                ) else if /i "!char!"=="d" (
                    (goto) 2>nul & exit /b 1 "AutoRun commands are disabled"
                )

                set "cmd_command=!line:~1!" & goto :shimiko_loop
            )
        )

    :shimiko_break
        ::: Hide `/s` if it's not paired with wither `/c` or `/k`
        ::: as it does not do anything of relevancy on its own
        if "%cmd_flags./c%"=="" if "%cmd_flags./k%"=="" (
            set "cmd_flags./s="
        )

    call :is_elevated && set "cmd_runas=1" || set "cmd_runas="

    ::: execute CMD_ENV if it exists and is a regular file
    endlocal & (
        set "CMD_FLAGS=%cmd_flags./c%%cmd_flags./k%%cmd_flags./s%x"
    ) & (
        set "CMD_RUNAS=%cmd_runas%"
    ) & (
        set /a "CMD_VERSION=%CMDEXTVERSION% + 0" >nul 2>&1
    ) & (
        if defined CMD_ENV if "%cmd_flags./c%"=="" call :is_interactive && (
            for /f "usebackq delims=" %%p in (`"echo(%CMD_ENV%"`) do (
                call :is_regular_file "%%~p" && call "%%~fp" 2>nul
            )
        )
    ) & exit /b 0

    :EOF
