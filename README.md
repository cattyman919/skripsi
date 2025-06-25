# Requirements for building

- LateXMK
- Makefile
- All required LaTex packages (read the .sty files)
  - minted (code blocks)
  - tocbibind
  - fancyhdr
  - pdfpages
  - caption
  - float
  - tabularx
  - xcolor
  - hyperref
  - multirow
  - graphicx

if configured correctly, try running

```
make clean
make
```

the output files will be in the `out` folder

# Thesis Files

This LaTex project is already configured to output these files:

- Thesis
- Journal IEEE
- Journal UI ANA (English)
- Journal UI ANA (Indonesia)

# Github Actions for Releases (Optional)

Thesis files can be access in a google drive and release if github action is configured correctly. It uploads all \*.pdf files in the out folder everytime we make a release tag. Thesis can be accessed here: [Google Drive](https://drive.google.com/drive/folders/140Il7vJkaAsBiTb5aikSA64-WBHhvqav?usp=drive_link).

read the `.github/workflows/main.yaml`

# Converting to Docx

Just use [ILovePDF](https://www.ilovepdf.com/pdf_to_word), it translate pdf to docx good enough.

but you might also want to try

```
soffice --headless --convert-to pdf filename.doc
```

if you have libreoffice installed.

Note: using `pandoc` to convert to docx broke the layout of the pdf

# Tools

- use [Repomix](https://repomix.com/) cli and just copy paste the xml file to an LLM so it can understand this repo easily and help fill the content if you want.

# UI Style

LaTeX configuration for report/thesis/dissertation according to [University Indonesia](http://www.ui.ac.id/) standard. Originally made by Andreas Febrian and available for download [here](http://komunitas.ui.ac.id/pg/file/andreas.febrian/read/12945/template-latex-untuk-laporan-skripsithesisdisertasi)

## Original author & contributors

Author: Andreas Febrian

Contributors:

1. Lia Sadita
2. Andre Tampubolon
3. Erik Dominikus
4. Fahrurrozi Rahman
5. Ariq Pradipa Santoso

---

## Modifications

- Restructure project to handle multiple LaTex project
- Created Journal for IEEE and UI ANA
- Makefile is more structured
- Added github action for releases (optional)
