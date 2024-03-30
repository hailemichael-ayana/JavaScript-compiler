%{
#include "sample.tab.h"
%}

DIGIT   [0-9]
%%
{DIGIT}+    { yylval = atoi(yytext); printf("Lexer: Number: %d\n", yylval); return NUMBER; }
[ \t\n]     ;
[-+*/()]   { return *yytext; } // Recognize arithmetic operators and parentheses
.           { printf("Lexer: Unexpected character: %c\n", *yytext); return *yytext; }
%%
int yywrap() { return 1; }
