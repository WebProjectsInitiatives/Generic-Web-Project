#!/bin/sh

################################################################################
# Project Template - Windows - Git hooks - Check the commit message syntax     #
################################################################################

# regex to validate in commit message
commit_regex="^((\[(([0-9a-z|\-âéÇêîôûàèùëïü ]{1,})|([A-Z]{1,}-[0-9]{1,}))\])|(WIP:)) .{1,}"
error_msg="Aborting commit. Your commit message is missing either a numbered issue '[EXAMPLE-1111] example' or '[devops] example' or 'WIP: example'"

# check if regex match with the commit msg
if ! grep -E "$commit_regex" "$1"; then
    echo "$error_msg" >&2
    exit 2
fi
