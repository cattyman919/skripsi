# Tools
LATEXMK = latexmk
# Gunakan 'rm -rf' untuk Linux/macOS atau 'rd /s /q' (rmdir) untuk Windows jika perlu menghapus direktori
# Gunakan 'rm -f' untuk Linux/macOS atau 'del /Q' untuk Windows jika perlu menghapus file
# Kita akan utamakan menggunakan fitur cleanup dari latexmk
RM = rd /s /q 

# Project-specific settings
DOCNAME = thesis
OUTDIR = out

# Targets
# Target default 'all' sekarang bergantung pada target 'pdf_only'
all: pdf_only

# Target ini memastikan PDF dibuat DAN file auxiliary dibersihkan
pdf_only: $(OUTDIR)/$(DOCNAME).pdf
	@echo "Pembersihan file auxiliary di direktori $(OUTDIR)..."
	$(LATEXMK) -silent -outdir=$(OUTDIR) -c
	@echo "Proses selesai. Hanya $(OUTDIR)/$(DOCNAME).pdf yang tersisa."

# Rules
# Rule utama untuk membuat PDF. Pembersihan dipindahkan ke target 'pdf_only'.
$(OUTDIR)/$(DOCNAME).pdf: $(DOCNAME).tex
	@echo "Memulai kompilasi $(DOCNAME).pdf ke direktori $(OUTDIR)..."
	$(LATEXMK) -synctex=1 -pdf -shell-escape -outdir=$(OUTDIR) -file-line-error $(DOCNAME)

# Target manual untuk membersihkan file (opsional, tapi baik untuk dimiliki)
mostlyclean:
	@echo "Membersihkan file auxiliary (mostlyclean)..."
	-$(LATEXMK) -silent -outdir=$(OUTDIR) -c

clean:
	@echo "Membersihkan semua file hasil kompilasi (clean)..."
	-$(LATEXMK) -silent -outdir=$(OUTDIR) -C
	-del /Q $(OUTDIR)\$(DOCNAME).pdf > nul 2>&1 
	-if exist $(OUTDIR) $(RM) $(OUTDIR) 

# Menandai target yang bukan file
.PHONY: all pdf_only mostlyclean clean

# Sertakan dependensi yang dibuat otomatis (jika ada)
# Pastikan pathnya benar jika file .d ada di dalam OUTDIR
# -include $(OUTDIR)/*.d
