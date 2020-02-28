:: ############################################################################################
:: # [new-project-template] - Windows - Script Batch - Initialization of the project #
:: ############################################################################################

:: Shut down Windows current command echoing
@ECHO OFF

:: Change the title of the window, for pimpin' reasons :)
:: JK: this helps finding it among all open windows
TITLE Initialization of the project

:: If command line argument is "-y", then just go on, don't ask.
IF /I "%~1"=="-y" (GOTO :start)

:: If command line argument is --help, then just go on, don't ask.
IF /I "%~1"=="--help" (GOTO :explain) ELSE (GOTO :ask)
:explain
ECHO.
ECHO Usage: initialize the project
ECHO.
ECHO -y                 force without confirmation
ECHO --help             display this help screen

:: Ask people if they really want to proceed
:ask
ECHO.
SET /P confirm="These script require the command git. Are you SURE you want to launch the initialization script? (Y/y/N/n) "
ECHO.

:: Use that variable prompted from user to go further or not
IF /I "%confirm%"=="y" (GOTO :start) ELSE (GOTO :bypass)

:: Start the initialization of the project
:start

:: Git Init
ECHO.
ECHO ---------------------------------------------------
ECHO Git init
ECHO ---------------------------------------------------

:: Initialization of git to copy the git hook
if not exist .git (
    ECHO Initialization of git
    git init
) else (
    ECHO You already have a folder '.git'!
)

::Git hook
ECHO.
ECHO ---------------------------------------------------
ECHO Git hooks - commit-msg
ECHO ---------------------------------------------------

:: Copy of the git hooks into the folder .git\hooks of the project
ECHO Copy of the folder 'git-hooks-sources' into the folder '.git/hooks' of the project
copy /Y git-hooks-sources\commit-msg .git\hooks

:: Just stop here and go to the end!
GOTO end

:: If the user answered "n"
:bypass
ECHO OK, then. See you around! :)
ECHO ---------------------------------------------------

:: The end!
:end
