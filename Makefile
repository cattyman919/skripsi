# Latex Builder
LATEXMK = latexmk

# Windows

# RMDIR = rd /s /q 
# RM = del /Q 

# Linux / Mac
RMDIR = rm -rf 
RM = rm -f  

# Project-specific settings
SKRIPSI = skripsi
JOURNAL = journal

BUILD_FLAGS = -synctex=1 -pdf -shell-escape -file-line-error -auxdir=../aux -outdir=../out

# Targets
all: $(SKRIPSI) $(JOURNAL)

$(SKRIPSI): $(SKRIPSI)/$(SKRIPSI).tex pustaka.bib settings.tex $(SKRIPSI)/istilah.tex
	@echo "Memulai kompilasi $(SKRIPSI).pdf ke direktori out ..." && \
	cd skripsi && \
	$(LATEXMK) $(BUILD_FLAGS) $(SKRIPSI) && \
	echo "Kompilasi selesai: $(SKRIPSI)"

$(JOURNAL): $(JOURNAL)/$(JOURNAL).tex pustaka.bib settings.tex
	@echo "Memulai kompilasi $(JOURNAL).pdf ke direktori out ..." && \
	cd journal && \
	$(LATEXMK) $(BUILD_FLAGS) $(JOURNAL) && \
	echo "Kompilasi selesai: $(JOURNAL)"
# Continuous Preview (Recommended for development)
pvc_skripsi:
	@echo "Memulai mode Preview Continuously (PVC)... Tekan Ctrl+C untuk berhenti." && \
	cd skripsi && \
	$(LATEXMK) -pvc $(BUILD_FLAGS) $(SKRIPSI)

pvc_journal:
	@echo "Memulai mode Preview Continuously (PVC)... Tekan Ctrl+C untuk berhenti." && \
	cd journal && \
	$(LATEXMK) -pvc $(BUILD_FLAGS) $(JOURNAL)

clean_skripsi:
	@echo "Membersihkan semua file hasil kompilasi $(SKRIPSI)..."
	-$(RM) out/$(SKRIPSI).pdf

clean_journal:
	@echo "Membersihkan semua file hasil kompilasi $(JOURNAL)..."
	-$(RM) out/$(JOURNAL).pdf

clean:
	@echo "Membersihkan semua file hasil kompilasi (clean)..."
	-$(RM) out/$(SKRIPSI).pdf
	-$(RM) out/$(JOURNAL).pdf

# Phony targets (targets that are not files)
.PHONY: all $(SKRIPSI) $(JOURNAL) pvc mostlyclean clean

# Suppress echoing of commands
#.SILENT:
