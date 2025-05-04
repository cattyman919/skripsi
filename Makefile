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

BUILD_FLAGS = -synctex=1 -pdf -shell-escape -file-line-error

SKRIPSI_FLAG = -outdir=../out/$(SKRIPSI)
JOURNAL_FLAG = -outdir=../out/$(JOURNAL)

# Targets
all: $(SKRIPSI) $(JOURNAL)

$(SKRIPSI): $(SKRIPSI)/$(SKRIPSI).tex pustaka.bib settings.tex $(SKRIPSI)/istilah.tex
	@echo "Memulai kompilasi $(SKRIPSI).pdf ke direktori out ..." && \
	cd skripsi && \
	$(LATEXMK) $(BUILD_FLAGS) $(SKRIPSI_FLAG) $(SKRIPSI) && \
	echo "Kompilasi selesai: $(SKRIPSI)"

$(JOURNAL): $(JOURNAL)/$(JOURNAL).tex pustaka.bib settings.tex
	@echo "Memulai kompilasi $(JOURNAL).pdf ke direktori out ..." && \
	cd journal && \
	$(LATEXMK) $(BUILD_FLAGS) $(JOURNAL_FLAG) $(JOURNAL) && \
	echo "Kompilasi selesai: $(JOURNAL)"
# Continuous Preview (Recommended for development)
pvc_skripsi:
	@echo "Memulai mode Preview Continuously (PVC)... Tekan Ctrl+C untuk berhenti." && \
	cd skripsi && \
	$(LATEXMK) -pvc $(BUILD_FLAGS) $(SKRIPSI_FLAG) $(SKRIPSI)

pvc_journal:
	@echo "Memulai mode Preview Continuously (PVC)... Tekan Ctrl+C untuk berhenti." && \
	cd journal && \
	$(LATEXMK) -pvc $(BUILD_FLAGS) $(JOURNAL_FLAG) $(JOURNAL)

# Cleanup targets
mostlyclean:
	@echo "Membersihkan file auxiliary (mostlyclean)..."
	-$(LATEXMK) -silent $(SKRIPSI_FLAG) -c
	-$(LATEXMK) -silent $(JOURNAL_FLAG) -c

clean_skripsi:
	@echo "Membersihkan semua file hasil kompilasi $(SKRIPSI)..."
	-$(LATEXMK) -silent $(SKRIPSI_FLAG) -C
	-$(RM) out/$(SKRIPSI).pdf
	-$(RMDIR) out/$(SKRIPSI)

clean_journal:
	@echo "Membersihkan semua file hasil kompilasi $(JOURNAL)..."
	-$(LATEXMK) -silent $(JOURNAL_FLAG) -C
	-$(RM) out/$(JOURNAL).pdf
	-$(RMDIR) out/$(JOURNAL)

clean:
	@echo "Membersihkan semua file hasil kompilasi (clean)..."
	-$(LATEXMK) -silent $(SKRIPSI_FLAG) -C
	-$(LATEXMK) -silent $(JOURNAL_FLAG) -C
	-$(RM) out/$(SKRIPSI).pdf
	-$(RMDIR) out/$(SKRIPSI)
	-$(RM) out/$(JOURNAL).pdf
	-$(RMDIR) out/$(JOURNAL)

# Phony targets (targets that are not files)
.PHONY: all $(SKRIPSI) $(JOURNAL) pvc mostlyclean clean

# Suppress echoing of commands
#.SILENT:
