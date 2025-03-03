#!/usr/bin/env gawk -f
# step3.awk
# This script compiles a list of word frequencies in the input.
# Each field of the input is considered a word.
# The output is in the format "[number found] [word]", which one record per word.

{
  # Tally the current field into the frequencies map.
  for (i = 1; i <= NF; i++) {
    if ($i in frequencies) {
      frequencies[$i] += 1
    } else {
      frequencies[$i] = 1
    }
  }
}

END {
  # Print the contents of the frequencies map.
  for (var in frequencies) {
    print frequencies[var] " " var
  }
}