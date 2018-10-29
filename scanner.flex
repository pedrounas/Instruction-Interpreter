%{
// HEADERS
#include <stdlib.h>
#include "parser.h"

// variables maintained by the lexical analyser
int yyline = 1;
%}

%option noyywrap

%%
[ \t]+ {  }
#.*\n { yyline++; }
\n { yyline++; }

\-?[0-9]+ {
   yylval.intValue = atoi(yytext);
   return INT;
}
"+" { return PLUS; }
"-" { return MINUS; }
"*" { return MULT; }
"/" { return DIV; }
"%" { return MOD;}
"==" { return EQUAL;}
"!=" { return DIFF;}
"<" { return LESS;}
">" { return GREATER;}
"<=" { return LESSOREQ;}
">=" { return GREATEROREQ;}
.  { yyerror("unexpected character"); }
%%
