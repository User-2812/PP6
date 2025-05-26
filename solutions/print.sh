#!/usr/bin/env bash

print_greeting() {
    echo "Hello User-2812!"
}

print_vars() {
    local name="Bash"
    local version=5.1
    printf "Using %s version %.1f\n" "$name" "$version"
}

print_escape() {
    printf "Schoenen Tag noch: \n"
    printf "\e[32m Auf Wiedersehen :)\n\tDone!\n"
}

# Call your functions:
print_greeting
print_vars
print_escape
