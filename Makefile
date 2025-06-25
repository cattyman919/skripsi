# Latex Builder
LATEXMK = latexmk

ifeq ($(OS),Windows_NT)
    # Windows-specific settings
    RM = del /Q
		RMDIR = rd /s /q
else
    # Linux/Unix-specific settings
    RM = rm -f
		RMDIR = rm -rf
endif

PROJECT_ROOT := $(CURDIR)

# Files Requirement
SOURCES = pustaka.bib settings.tex

# Project-specific settings
NAME = Seno Pamungkas Rahman

SKRIPSI = skripsi
JOURNAL_IEEE = journal_ieee
JOURNAL_UI_ANA = journal_ui_ana

BUILD_FLAGS = -synctex=1 -pdf -shell-escape -file-line-error -auxdir=$(PROJECT_ROOT)/aux -outdir=$(PROJECT_ROOT)/out

OUTPUT_SKRIPSI_NAME = "$(NAME)_Skripsi"
OUTPUT_JOURNAL_IEEE_NAME = "$(NAME)_Journal_IEEE"
OUTPUT_JOURNAL_UI_ANA_NAME = "$(NAME)_Journal_UI_ANA"

# Targets
all: $(SKRIPSI) $(JOURNAL_IEEE)

$(SKRIPSI): $(SKRIPSI)/$(SKRIPSI).tex $(SOURCES) $(SKRIPSI)/istilah.tex
	@echo "Memulai kompilasi $(SKRIPSI).pdf ke direktori out ..." && \
	cd $(SKRIPSI) && \
	$(LATEXMK) $(BUILD_FLAGS) -jobname=$(OUTPUT_SKRIPSI_NAME) $(SKRIPSI) && \
	echo "Kompilasi selesai: $(SKRIPSI)"

$(JOURNAL_IEEE): $(JOURNAL_IEEE)/$(JOURNAL_IEEE).tex $(SOURCES)
	@echo "Memulai kompilasi $(JOURNAL_IEEE).pdf ke direktori out ..." && \
	cd $(JOURNAL_IEEE) && \
	$(LATEXMK) $(BUILD_FLAGS) -jobname=$(OUTPUT_JOURNAL_IEEE_NAME) $(JOURNAL_IEEE) && \
	echo "Kompilasi selesai: $(JOURNAL_IEEE)"

$(JOURNAL_UI_ANA): $(SOURCES)
	@echo "Memulai kompilasi $(JOURNAL_UI_ANA).pdf ke direktori out ..." && \
	cd $(JOURNAL_UI_ANA)/indonesia && \
	$(LATEXMK) $(BUILD_FLAGS) -jobname=$(OUTPUT_JOURNAL_UI_ANA_NAME)_indonesia $(JOURNAL_UI_ANA)_indonesia
	# cd ../indonesia && \
	# $(LATEXMK) $(BUILD_FLAGS) -jobname=$(OUTPUT_JOURNAL_UI_ANA_NAME)_indonesia $(JOURNAL_UI_ANA)_indonesia && \
	# echo "Kompilasi selesai: $(JOURNAL_UI_ANA)"

pvc_skripsi:
	@echo "Memulai mode Preview Continuously (PVC)... Tekan Ctrl+C untuk berhenti." && \
	cd skripsi && \
	$(LATEXMK) -pvc $(BUILD_FLAGS) $(SKRIPSI)

pvc_journal:
	@echo "Memulai mode Preview Continuously (PVC)... Tekan Ctrl+C untuk berhenti." && \
	cd journal && \
	$(LATEXMK) -pvc $(BUILD_FLAGS) $(JOURNAL_IEEE)

clean_skripsi:
	@echo "Membersihkan semua file hasil kompilasi $(SKRIPSI)..."
	$(RM) out/$(OUTPUT_SKRIPSI_NAME)*.pdf
	$(RM) out/$(OUTPUT_SKRIPSI_NAME)*.gz
	@echo "$(OUTPUT_SKRIPSI_NAME) telah dibersihkan"

clean_journal:
	@echo "Membersihkan semua file hasil kompilasi $(JOURNAL_IEEE)..."
	$(RM) out/$(OUTPUT_JOURNAL_IEEE_NAME)*.pdf
	$(RM) out/$(OUTPUT_JOURNAL_IEEE_NAME)*.gz
	@echo "$(OUTPUT_JOURNAL_IEEE_NAME) telah dibersihkan"

clean: clean_skripsi clean_journal

# Phony targets (targets that are not files)
.PHONY: all $(SKRIPSI) $(JOURNAL_IEEE) $(JOURNAL_UI_ANA) mostlyclean clean oof

# Suppress echoing of commands
#.SILENT:
