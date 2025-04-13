# Tools
LATEXMK = latexmk
# Use appropriate remove commands for your OS if needed for clean targets
RMDIR = rd /s /q 
RM = del /Q 
# RMDIR = rm -rf # Linux/macOS (Example)
# RM = rm -f  # Linux/macOS (Example)

# Project-specific settings
DOCNAME = thesis
TEXFILE = $(DOCNAME).tex
OUTDIR = out
PDF = $(OUTDIR)/$(DOCNAME).pdf
BUILD_FLAGS = -synctex=1 -pdf -shell-escape -outdir=$(OUTDIR) -file-line-error

# Targets
# Default target: Build the PDF incrementally
all: $(PDF)

# Rule to build the PDF using latexmk
# latexmk handles dependencies and multiple runs automatically
$(PDF): $(TEXFILE) src/**/*.*  *.bib settings.tex istilah.tex
	@echo "Memulai kompilasi $(DOCNAME).pdf ke direktori $(OUTDIR)..."
	$(LATEXMK) $(BUILD_FLAGS) $(DOCNAME)
	@echo "Kompilasi selesai: $(PDF)"

# Continuous Preview (Recommended for development)
pvc:
	@echo "Memulai mode Preview Continuously (PVC)... Tekan Ctrl+C untuk berhenti."
	$(LATEXMK) -pvc $(BUILD_FLAGS) $(DOCNAME)

# Cleanup targets
mostlyclean:
	@echo "Membersihkan file auxiliary (mostlyclean)..."
	-$(LATEXMK) -silent -outdir=$(OUTDIR) -c

clean:
	@echo "Membersihkan semua file hasil kompilasi (clean)..."
	-$(LATEXMK) -silent -outdir=$(OUTDIR) -C
	-$(RM) $(PDF)
	-$(RMDIR) $(OUTDIR)

# Phony targets (targets that are not files)
.PHONY: all pvc mostlyclean clean

# Suppress echoing of commands
#.SILENT:
