#!/bin/bash

clear

test_files=($(basename -a $(find unit_tests/tests -type f -name "*.rs" ! -name "common.rs")))

cat ditto.txt

echo "\n"
echo "\033[31mSelect a test file to run:\033[0m"
echo "🧬 0) Run all tests 💥"

for i in "${!test_files[@]}"; do
    echo "🧪 $((i+1))) ${test_files[$i]}"
done

read -p "Enter number (0-${#test_files[@]}): " choice

if [ "$choice" -eq 0 ]; then
    cargo test
    exit
fi

((choice--))

if [[ $choice -ge 0 && $choice -lt ${#test_files[@]} ]]; then

    read -p "Enter the maximum block number (or 0 for the latest): " max_block

    export MAX_BLOCK=$max_block

    cargo test --test "${test_files[$choice]%.*}"
else
    echo "Invalid selection."
fi
