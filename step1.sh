# This script reads data.txt, removes punctuation, converts text to lowercase,
# and writes the output to step1.txt.

INPUT="data.txt"
OUTPUT="step1.txt"

# Remove any character that is not a letter or space,
# then convert uppercase to lowercase.
sed 's/[^a-zA-Z ]//g' "$INPUT" | tr 'A-Z' 'a-z' > "$OUTPUT"

echo "Step 1 complete: Cleaned text written to $OUTPUT"
