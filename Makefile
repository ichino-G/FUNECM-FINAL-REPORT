#!/bin/sh

# �O���[�v�񍐏�
FILE	=report
# �l�񍐏�
ABST	=abst
# ��������A�C���N���[�h����Ă���t�@�C��
SRC	=#chap1.tex chap2.tex,..., chap<n>.tex
#�X�^�C���t�@�C����N���X�t�@�C���Ȃ�
OHTERS	=funpro.sty funpro.dvi funpro.dtx funpro.ins url.sty \
	okumacro.sty jsbook.cls nkf.c config.h utf8tbl.c
# �摜�Ȃǂ̃o�C�i���t�@�C��
IMG	=#hoge.eps capture1.jpg
#�����f�[�^�x�[�X
REF	=#biblio.bib
#�X�^�C���t�@�C��
STY	=funpro
#�N���X�t�@�C��
CLS	=jsbook.cls

# GNU Linux �̏ꍇ
#DVIPS	=dvips -Ppdf 
#XDVI	=xdvik
# Red Hat�̏ꍇ
#DVIPS	=pdvips -Ppdf
#XDVI	=pxdvi
# Windows+Cygwin+�p��pTeX�̏ꍇ
DVIPS	=dvipsk -Ppdf -t a4
XDVI	=dviout 

# dvipdfm�͔��ɌÂ��̂�dvipdfmx���g���悤�ɂ��Ă��������B
DVIPDF	=dvipdfm
REFGREP	=grep "^LaTeX Warning: Label(s) may have changed."
# cc�g���Ă���l����ł��傤��
CC	=gcc
CFLAGS	=-O
TEX	=platex
RM	=rm -f
RMR	=rm -fr

all:	nkf $(STY).sty $(STY).pdf $(FILE).pdf #$(ABST).pdf

#�X�^�C���t�@�C���p�̈ˑ��֌W
$(STY).sty:	$(STY).dtx $(STY).ins
	$(TEX) $(STY).ins
$(STY).pdf:	$(STY).dvi
	$(DVIPDF) $(STY)
$(STY).ps:	$(STY).dvi
	$(DVIPS)  $(STY)
$(STY).dvi:	$(STY).dtx
	$(TEX) $(STY).dtx && $(TEX) $(STY).dtx
	$(RM) $(STY).aux $(STY).idx $(STY).ilg $(STY).ind $(STY).log

#�O���[�v�񍐏��p�̈ˑ��֌W
$(FILE).pdf: $(FILE).dvi
	$(DVIPDF) -o $(FILE).pdf $(FILE)
$(FILE).ps: $(FILE).dvi
	$(DVIPS) -o $(FILE).ps $(FILE)
$(FILE).dvi: $(FILE).aux $(FILE).toc
#�����f�[�^�x�[�X�����Ȃ��
#$(FILE).dvi: $(FILE).bbl $(FILE).aux
	$(TEX) $(FILE) 
	(while $(REFGREP) $(FILE).log; do $(TEX) $(FILE); done)
$(FILE).bbl: $(FILE).aux $(REFFILE) 
	$(BIBTEX) $(FILE)
$(FILE).toc: $(FILE).aux
	$(TEX) $(FILE)
$(FILE).aux: $(FILE).tex
	$(TEX) $(FILE)

#�l�񍐏��̈ˑ��֌W
$(ABST).pdf: $(ABST).dvi
	$(DVIPDF) -o $(ABST).pdf $(ABST)
$(ABST).ps: $(ABST).dvi
	$(DVIPS) -o $(ABST).ps $(ABST)
$(ABST).dvi: $(ABST).aux 
	$(TEX) $(ABST) 
	(while $(REFGREP) $(ABST).log; do $(TEX) $(ABST); done)
$(ABST).aux: $(ABST).tex
	$(TEX) $(ABST)
#�|���p
clean:
	$(RM) $(FILE).aux $(FILE).log $(FILE).toc $(FILE).lof $(FILE).lot
	$(RM) $(ABST).aux $(ABST).log utf8tbl.o *~

#�A�[�J�C�u�쐬�p
tar:	$(SRC) $(REF) $(FILE).tex Makefile $(FILE).pdf $(STY).pdf \
	$(FILE).ps $(STY).ps
	mkdir -p $(FILE)src
	cp $(SRC) $(OHTERS) $(REF) $(IMG) $(FILE).tex Makefile  \
	$(FILE).pdf $(STY).pdf $(FILE).ps $(STY).ps $(FILE)src/
	zip -r $(FILE)src.zip $(FILE)src/
	$(RMR) $(FILE)src/
unzip:
	unzip -o $(FILE)src.zip

NKFE=./nkf -e -Lu
NKFS=./nkf -s -Lw
nkf:	nkf.c config.h utf8tbl.o
	$(CC) $(CFLAGS) -o nkf nkf.c utf8tbl.o
utf8tbl.o:	utf8tbl.c config.h
	$(CC) $(CFLAGS) -c utf8tbl.c

euc:	nkf
	$(NKFE) <$(STY).dtx >$(STY).dtx.e && mv $(STY).dtx.e $(STY).dtx
	$(NKFE) <$(STY).sty >$(STY).sty.e && mv $(STY).sty.e $(STY).sty
	$(NKFE) <$(CLS) >$(CLS).e && mv $(CLS).e $(CLS)
	$(NKFE) <$(FILE).tex >$(FILE).tex.e && mv $(FILE).tex.e $(FILE).tex
	$(NKFE) <$(ABST).tex >$(ABST).tex.e && mv $(ABST).tex.e $(ABST).tex
sjis:	nkf
	$(NKFS) <$(STY).dtx >$(STY).dtx.s && mv $(STY).dtx.s $(STY).dtx
	$(NKFS) <$(STY).sty >$(STY).sty.s && mv $(STY).sty.s $(STY).sty
	$(NKFS) <$(CLS) >$(CLS).s && mv $(CLS).s $(CLS)
	$(NKFS) <$(FILE).tex >$(FILE).tex.s && mv $(FILE).tex.s $(FILE).tex
	$(NKFS) <$(ABST).tex >$(ABST).tex.s && mv $(ABST).tex.s $(ABST).tex
