# Latex Builder
LATEXMK = latexmk

# Windows

RMDIR = rd /s /q 
RM = del /Q 

# Linux / Mac
#RMDIR = rm -rf 
#RM = rm -f  

# Project-specific settings
SKRIPSI = skripsi
JOURNAL = journal

BUILD_FLAGS = -synctex=1 -pdf -shell-escape -file-line-error -auxdir=../aux -outdir=../out

OUTPUT_SKRIPSI_NAME = "Seno Pamungkas Rahman_Skripsi"
OUTPUT_JOURNAL_NAME = "Seno Pamungkas Rahman_Journal"

# Targets
all: $(SKRIPSI) $(JOURNAL)

$(SKRIPSI): $(SKRIPSI)/$(SKRIPSI).tex pustaka.bib settings.tex $(SKRIPSI)/istilah.tex
	@echo "Memulai kompilasi $(SKRIPSI).pdf ke direktori out ..." && \
	cd skripsi && \
	$(LATEXMK) $(BUILD_FLAGS) -jobname=$(OUTPUT_SKRIPSI_NAME) $(SKRIPSI) && \
	echo "Kompilasi selesai: $(SKRIPSI)"

$(JOURNAL): $(JOURNAL)/$(JOURNAL).tex pustaka.bib settings.tex
	@echo "Memulai kompilasi $(JOURNAL).pdf ke direktori out ..." && \
	cd journal && \
	$(LATEXMK) $(BUILD_FLAGS) -jobname=$(OUTPUT_JOURNAL_NAME) $(JOURNAL) && \
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
	-$(RM) "out/$(OUTPUT_SKRIPSI_NAME)*.pdf"
	-$(RM) "out/$(OUTPUT_SKRIPSI_NAME)*.gz"

clean_journal:
	@echo "Membersihkan semua file hasil kompilasi $(JOURNAL)..."
	-$(RM) "out/$(OUTPUT_JOURNAL_NAME)*.pdf"
	-$(RM) "out/$(OUTPUT_JOURNAL_NAME)*.gz"

clean: clean_skripsi clean_journal

# Phony targets (targets that are not files)
.PHONY: all $(SKRIPSI) $(JOURNAL) pvc mostlyclean clean

# Suppress echoing of commands
#.SILENT:
