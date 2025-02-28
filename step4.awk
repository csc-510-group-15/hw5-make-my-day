#!/usr/bin/env gawk -f
# step4.awk
# This script generates a table of word frequencies per paragraph in CSV format.

BEGIN {
  # Read the top words into an array
  while ((getline word < "step3.txt") > 0) {
    top_words[word] = 1
    top_words_list[++num_top_words] = word
  }
  close("step3.txt")

  paragraph = 1

  # Print the header row (top words)
  printf "Paragraph"
  for (i = 1; i <= num_top_words; i++) {
    printf ",%s", top_words_list[i]
  }
  print ""
}

{
  # If the line is empty, it signifies a new paragraph
  if (NF == 0) {
    paragraph++
    next
  }

  # Count word frequencies for the current paragraph
  for (i = 1; i <= NF; i++) {
    if ($i in top_words) {
      freq[paragraph, $i]++
    }
  }
}

END {
  # Print the frequency table
  for (p = 1; p <= paragraph; p++) {
    printf "%d", p
    for (i = 1; i <= num_top_words; i++) {
      word = top_words_list[i]
      printf ",%d", freq[p, word] + 0  
    }
    print ""
  }
}