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
    if "~x0"=="%~x0" exit /b 2

    setlocal EnableDelayedExpansion EnableExtensions

    ::: Escape slashes first - we're fine with not replacing them with anything,
    ::: as the rest of the command doesn't matter
    ::: https://learn.microsoft.com/en-us/dotnet/standard/io/file-path-formats
    set "cmd=!CMDCMDLINE://=!"

    :shimiko_loop
        ::: What we're interested in is the order in which /c and /k come;
        ::: whichever is the first wins. To do so, we can test substrings;
        ::: if /c comes first, we're a non-interactive shell and can exit.
        for /f "usebackq tokens=1,* delims=/" %%k in ('!cmd!') do (
            set "line=%%l"
            set "char=!line:~0,1!"

            if /i "!char!"=="c" (
                @rem This is a non-interactive shell.
                exit /b 1
            ) else if /i "!char!"=="k" (
                @rem This is an interactive shell.
                goto :shimiko_break
            ) else if defined line (
                set "cmd=!line:~1!"
                goto :shimiko_loop
            )
        )

    :shimiko_break
        ::: We've gone through all the arguments at this point
        ::: This has to be an interactive shell.

    endlocal & exit /b
