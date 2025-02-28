# Define variables
INPUT = data.txt
CLEANED = step1.txt
STOPPED = step2.txt
FREQS = frequencies.txt
TOP_WORDS = step3.txt
TABLE = step4.txt


# Run the full pipeline
all: $(TABLE)


# Step 1: Canonicalization (Kill punctuation, Lowercase, Remove Punctuation)
$(CLEANED): $(INPUT)
	sed 's/[^a-zA-Z ]//g' $< | tr 'A-Z' 'a-z' > $@


# Step 2: Remove stop words
# Stop words are (is|the|in|but|can|a|the|is|in|of|to|a|that|it|for|on|with|as|this|was|at|by|an|be|from|or|are)
$(STOPPED) : $(CLEANED)
	awk -f ./step2.awk $(CLEANED) > $@


# Step 3: Report frequency of words
$(FREQS): $(STOPPED)
	awk -f ./step3.awk $< | sort -nr > $@


# Step 4: Extract Top 10 most frequent words
$(TOP_WORDS): $(FREQS)
	gawk '$$2 && NR <=10 {print $$2}' $< > $@


# Step 5: Generate table of word frequencies per paragraph
$(TABLE): $(CLEANED) $(TOP_WORDS)
	gawk -f step4.awk $(STOPPED) > $@

# Cleanup
clean:
	rm -f $(CLEANED) $(STOPPED) $(FREQS) $(TOP_WORDS) $(TABLE)


step1:
	"$(MAKE)" clean $(CLEANED); head $(CLEANED)


step2:
	"$(MAKE)" clean $(STOPPED); head $(STOPPED)


step3:
	"$(MAKE)" clean $(TOP_WORDS); head $(TOP_WORDS)


step4:
	"$(MAKE)" clean $(TABLE); head $(TABLE) # | column -s, -t