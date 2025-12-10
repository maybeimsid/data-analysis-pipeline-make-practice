
# Data Analysis Pipeline - IA4


# Input text files
DATA = data/isles.txt data/abyss.txt data/last.txt data/sierra.txt

# Word count outputs
COUNTS = results/isles.dat results/abyss.dat results/last.dat results/sierra.dat

# Plot outputs
FIGURES = results/figure/isles.png results/figure/abyss.png \
          results/figure/last.png results/figure/sierra.png

# Report output
REPORT = report/count_report.html

# Default target
all: $(FIGURES) $(REPORT)


# Word count rules
results/%.dat: data/%.txt scripts/wordcount.py
	mkdir -p results
	python scripts/wordcount.py --input_file=$< --output_file=$@


# Plotting rules
results/figure/%.png: results/%.dat scripts/plotcount.py
	mkdir -p results/figure
	python scripts/plotcount.py --input_file=$< --output_file=$@


# Report rule
$(REPORT): report/count_report.qmd $(FIGURES)
	quarto render report/count_report.qmd

# Clean rule
clean:
	rm -rf results
	rm -f report/count_report.html
