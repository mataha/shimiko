@if not defined DEBUG echo off

@goto :main


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
