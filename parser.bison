// Tokens
%token
  INT
  PLUS
  MINUS
  MULT
  DIV
  MOD
  EQUAL
  DIFF
  LESS
  GREATER
  LESSOREQ
  GREATEROREQ

// Operator associativity & precedence
%left PLUS MINUS
%left DIV MULT
%left MOD

// Root-level grammar symbol
%start program;

// Types/values in association to grammar symbols.
%union {
  int intValue;
  Expr* exprValue;
}

%type <intValue> INT
%type <exprValue> expr

// Use "%code requires" to make declarations go
// into both parser.c and parser.h
%code requires {
#include <stdio.h>
#include <stdlib.h>
#include "ast.h"

extern int yylex();
extern int yyline;
extern char* yytext;
extern FILE* yyin;
extern void yyerror(const char* msg);
Expr* root;
}

%%
program: expr { root = $1; }

expr:
  INT {
    $$ = ast_integer($1);
  }
  |
  expr PLUS expr {
    $$ = ast_operation(PLUS, $1, $3);
  }
  ;
  |
  expr MINUS expr {
  $$ = ast_operation(MINUS, $1, $3);
  }
  ;
  |
  expr MULT expr {
  $$ = ast_operation(MULT, $1, $3);
  }
  ;
  |
  expr DIV expr{
  $$ = ast_operation(DIV, $1, $3);
  }
  ;
  |
  expr MOD expr {
  $$ = ast_operation(MOD, $1, $3);
  }
  ;
  |
  expr EQUAL expr {
  $$ = ast_operation(EQUAL, $1, $3);
  }
  ;
  |
  expr DIFF expr {
  $$ = ast_operation(DIFF, $1, $3);
  }
  ;
  |
  expr LESS expr {
  $$ = ast_operation(LESS, $1, $3);
  }
  ;
  |
  expr GREATER expr {
  $$ = ast_operation(GREATER, $1, $3);
  }
  ;
  |
  expr LESSOREQ expr {
  $$ = ast_operation(LESSOREQ, $1, $3);
  }
  ;
  |
  expr GREATEROREQ expr {
  $$ = ast_operation(GREATEROREQ, $1, $3);
  }
  ;
  %%

void yyerror(const char* err) {
  printf("Line %d: %s - '%s'\n", yyline, err, yytext  );
}
