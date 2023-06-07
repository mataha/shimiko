@rem devutils
@rem ========
@rem
@rem Developer utilities for `shimiko` in the form of inline DOSKEY macros.
@rem
@rem Usage: devutils           Install all aliases in the current shell instance
@rem
@rem Variables:
@rem   SHELL            Primary command interpreter (default: 'cmd.exe')
@rem   STREAM           Primary output device (default: 'con')
@rem

@if "%DEBUG%"=="" echo off

if not [%1]==[] echo This program cannot accept arguments.>&2 & exit /b 1 2>nul

if "%OS%"=="Windows_NT" setlocal

if "%SHELL%"==""  set SHELL=cmd.exe
if "%STREAM%"=="" set STREAM=con

set debugging_marker=DEBUG
set debugging_default_value=on

set diagnostics_marker=DIAGNOSTICS
set diagnostics_default_value=1

set exit_status_marker=ERRORLEVEL

set text_debugging=Script debugging is
set text_diagnostics=Diagnostic logging is
set text_expansion=Delayed expansion is
set text_extensions=Command Extensions are

set text_enabled=ON
set text_disabled=OFF

@rem ===========================================================================

@rem Macros for setting exit success/failure status codes in a lightweight way
set $true=(call )
set $false=(call)

@rem `windir` over `SystemRoot` for compatibility with ancient Windows shells
set $doskey="%windir%\System32\doskey.exe"
set $findstr="%windir%\System32\findstr.exe"

@rem ===========================================================================

@rem Prints the given message and the line separator
@rem to the specified output stream.
set $println=echo

@rem Returns a successful result.
@rem Always succeeds.
%$doskey% /exename=%SHELL% true = ^>%STREAM% %$true%

@rem Returns an unsuccessful result.
@rem Always fails.
%$doskey% /exename=%SHELL% false = ^>%STREAM% %$false%

@rem Toggles and prints the status of command script debugging via `@echo on`
@rem for this invocation of the primary command interpreter
@rem (specified by the `SHELL` variable) to the primary output device.
%$doskey% /exename=%SHELL% ^' = ^>%STREAM% (if not "%%%debugging_marker%%%"=="%debugging_default_value%" ((set %debugging_marker%=%debugging_default_value%) ^& (%$println% %text_debugging% %text_enabled%.)) else ((set %debugging_marker%=) ^& (%$println% %text_debugging% %text_disabled%.))) ^& %$true%

@rem Toggles and prints the status of diagnostic logging for issue debugging
@rem for this invocation of the primary command interpreter
@rem (specified by the `SHELL` variable) to the primary output device.
%$doskey% /exename=%SHELL% ^'^' = ^>%STREAM% (if not "%%%diagnostics_marker%%%"=="%diagnostics_default_value%" ((set %diagnostics_marker%=%diagnostics_default_value%) ^& (%$println% %text_diagnostics% %text_enabled%.)) else ((set %diagnostics_marker%=) ^& (%$println% %text_diagnostics% %text_disabled%.))) ^& %$true%

@rem Prints the exit status of the most recently executed foreground command,
@rem i.e. `ERRORLEVEL`, for this invocation of the primary command interpreter
@rem (specified by the `SHELL` variable) to the primary output device.
%$doskey% /exename=%SHELL% ^? = ^>%STREAM% (if %exit_status_marker% 0 (if not %exit_status_marker% 1 (%$println% 0) else if not %exit_status_marker% 2 (%$println% 1) else if not %exit_status_marker% 3 (%$println% 2) else if not %exit_status_marker% 4 (%$println% 3) else if not %exit_status_marker% 5 (%$println% 4) else if not %exit_status_marker% 6 (%$println% 5) else if not %exit_status_marker% 32 (%$println% %%%exit_status_marker%%%) else if not %exit_status_marker% 33 (%$println% 32) else if not %exit_status_marker% 145 (%$println% %%%exit_status_marker%%%) else if not %exit_status_marker% 146 (%$println% 145) else if not %exit_status_marker% 9009 (%$println% %%%exit_status_marker%%%) else if not %exit_status_marker% 9010 (%$println% 9009) else if not %exit_status_marker% 9059 (%$println% %%%exit_status_marker%%%) else if not %exit_status_marker% 9060 (%$println% 9059) else (%$println% %%%exit_status_marker%%%)) else (%$println% %%%exit_status_marker%%%)) ^& %$true%

@rem Prints the status of `cmd.exe` Command Extensions (enabled or disabled;
@rem enabled by default) for this invocation of the primary command interpreter
@rem (specified by the `SHELL` variable) to the primary output device.
%$doskey% /exename=%SHELL% ^?^? = ^>%STREAM% ((set ^^^"^^^") ^>nul 2^>^&1 ^&^& (%$println% %text_extensions% %text_enabled%.) ^|^| (%$println% %text_extensions% %text_disabled%.)) ^& %$true%

@rem Accepts an optional string; if provided, prints all DOSKEY aliases defined
@rem for this invocation of the primary command interpreter (specified by the
@rem `SHELL` variable) matching the regular expression obtained by interpreting
@rem the given string to the primary output device, and all DOSKEY aliases
@rem defined for this invocation of the primary command interpreter otherwise.
@rem
@rem The regex is case-insensitive and can contain anchors, wildcards, repeats,
@rem escapes, word boundaries, character classes and class ranges (albeit in a
@rem limited form; see https://stackoverflow.com/a/20159191 for details).
%$doskey% /exename=%SHELL% ^! = if [$*]==[] (%$doskey% /macros:%SHELL% ^| ^>%STREAM% %$findstr% /irc:=) else %$doskey% /macros:%SHELL% ^| ^>%STREAM% %$findstr% /irc:$*

@rem Prints the status of delayed environment variable expansion (enabled
@rem or disabled) for this invocation of the primary command interpreter
@rem (specified by the `SHELL` variable) to the primary output device.
%$doskey% /exename=%SHELL% ^!^! = ^>%STREAM% (if "^!^"=="^!" (%$println% %text_expansion% %text_enabled%.) else (%$println% %text_expansion% %text_disabled%.)) ^& %$true%

if "%OS%"=="Windows_NT" endlocal

exit /b 0 2>nul
