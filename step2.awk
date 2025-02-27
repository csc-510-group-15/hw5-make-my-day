#!/usr/bin/env gawk -f
# step2.awk
# This script removes common stop words from each line of input.
# It reads from step1.txt and writes the output to step2.txt.

BEGIN {
  # Define the list of stop words
  stopwords = "is the in but can a of to that it for on with as this was at by an be from or are"
  n = split(stopwords, wordArray, " ")
  for (i = 1; i <= n; i++) {
    stop[wordArray[i]] = 1
  }
}

{
  # Process each word in the line; output only if not a stop word.
  output = ""
  for (i = 1; i <= NF; i++) {
    if (!(tolower($i) in stop))
      output = output $i " "
  }
  print output
}
