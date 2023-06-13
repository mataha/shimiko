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

@:main
    ::: Check for Command Extensions; if disabled, unset all environment
    ::: variables that could have been provided by an execution of this
    ::: script by the parent shell's AutoRun command and exit immediately;
    ::: we're operating in a different context here, so keep in mind that:
    :::   - `exit /b` outputs a 'The system cannot find the batch label
    :::     specified - EOF' error to stderr, thus it has to be silenced
    :::   - all `set` commands other than simple assignments are disabled
    :::     including usage of quotation marks to surround the expression
    if "~a0"=="%~a0" (
        set CMD_FLAGS=
        set CMD_VERSION=
    ) & exit /b

    setlocal EnableDelayedExpansion EnableExtensions

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
        ::: What we're interested in is the order in which /c and /k come;
        ::: whichever is the first wins. To do so, we can test substrings;
        ::: if /c comes first, we're a non-interactive shell and can exit.
        for /f "tokens=1,* delims=/" %%k in ("!cmd_command://=!") do (
            set "line=%%l"
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
                    (goto) 2>nul & exit /b 1 &@rem unreachable!("no AutoRun");
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

    ::: execute CMD_ENV if it exists and is a regular file
    endlocal & (
        set /a "CMD_VERSION=%CMDEXTVERSION% + 0" >nul 2>&1
    ) & (
        set "CMD_FLAGS=%cmd_flags./c%%cmd_flags./k%%cmd_flags./s% " &@rem Space!
    ) & (
        if defined CMD_ENV if "%cmd_flags./c%"=="" call :is_interactive && (
            for /f "usebackq delims=" %%p in (`"echo(%CMD_ENV%"`) do (
                call :is_regular_file "%%~p" && call "%%~fp" 2>nul
            )
        )
    ) & exit /b 0

:is_interactive () -> Result
    "%SystemRoot%\System32\timeout.exe" 0 >nul 2>nul & exit /b

:is_regular_file (path) -> Result
    for /f "tokens=1,* delims=d" %%a in ("-%~a1") do (
        if "%%b"=="" if not "%%a"=="-" (
            exit /b 0 &@rem FILE_ATTRIBUTE_NORMAL at the very least
        )
    )

    exit /b 1 &@rem FILE_ATTRIBUTE_DIRECTORY or not available or does not exist
