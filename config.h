#ifndef _CONFIG_H_
#define _CONFIG_H_

/* UTF8 $BF~=PNO(B */
#define UTF8_INPUT_ENABLE
#define UTF8_OUTPUT_ENABLE

/* Shift_JIS $BHO0O30$NJ8;z$r!"(BCP932 $B$GF1CM$JJ8;z$KFI$_49$($k(B */
#define SHIFTJIS_CP932

/* $B%*%W%7%g%s$GF~NO$r;XDj$7$?;~$K!"J8;z%3!<%I$r8GDj$9$k(B */
#define INPUT_CODE_FIX

/* -OW $B%*%W%7%g%s(B */
/* by Satoru Takabayashi <ccsatoru@vega.aichi-u.ac.jp> */
#define OVERWRITE

/* --cap-input, --url-input, --numchar-input $B%*%W%7%g%s(B */
#define INPUT_OPTION

/* --debug, --no-output $B%*%W%7%g%s(B */
#define CHECK_OPTION

/* SunOS $B$N(B cc $B$r;H$&$H$-$O(B undef $B$K$7$F$/$@$5$$(B */
#define ANSI_C_PROTOTYPE

/******************************/
/* $B%G%U%)%k%H$N=PNO%3!<%IA*Br(B */
/* Select DEFAULT_CODE */
#define DEFAULT_CODE_JIS
/* #define DEFAULT_CODE_SJIS */
/* #define DEFAULT_CODE_EUC */
/* #define DEFAULT_CODE_UTF8 */
/******************************/

#endif /* _CONFIG_H_ */
