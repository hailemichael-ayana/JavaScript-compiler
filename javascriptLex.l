%{
#include <stdio.h>
#include "javascriptBison.tab.h"
#include <stdlib.h>
%}

%option noyywrap

digit           [0-9]
letter          [a-zA-Z]
identifier      {letter}({letter}|{digit})*
number          {digit}+(\.{digit}+)?(e[+-]?{digit}+)?
double_string   \"([^\"\\]|\\.)*\"
single_string   '([^'\\]|\\.)*'
comment         (\/\/.*|\/\*([^*]|\*[^\/])*\*\/)
operator        (\+\+|\-\-|\=|\+|\-|\*|\/|\%|\&\&|\|\||\!\=|\=\=|\>|\<|\>=|\<=|\!|\~|\&|\^|\|)

array           \[[^\[\]]*\]

%%

"true"|"false"|"null"  { return BOOLEAN_LITERAL; }
"if" {return IF;}
"else" {return ELSE;}
"while" {return WHILE;}
"function" {return FUNCTION;}
"return" {return RETURN;}
"break" {return BREAK;}
"continue" {return CONTINUE;}
"switch" {return SWITCH;}
"case" {return CASE;}
"default" {return DEFAULT;}
"try" {return TRY;}
"catch" {return CATCH;}
"finally" {return FINALLY;}
"throw" {return THROW;}
"typeof" {return TYPEOF;}
"instanceof" {return INSTANCEOF;}
"new" {return NEW;}
"delete" {return DELETE;}
"in" {return IN;}
"with" {return WITH;}
"class" {return CLASS;}
"extends" {return EXTENDS;}
"var" {return VAR;}
"let" {return LET;}
"const" {return CONST;}
{array}          { return ARRAY; }
{identifier}    { return IDENTIFIER; }
{number}        { return NUMBER; }
{double_string} { return STRING; }
{single_string} { return STRING; }
{comment}       ;
"("             { return LEFT_PAREN; }
")"             { return RIGHT_PAREN; }
"{"             { return LEFT_CURLY; }
"}"             { return RIGHT_PAREN; }
"["             { return LEFT_SQUARE; }
"]"             { return RIGHT_SQUARE; }
";"             { return SEMICOLON; }
","             { return COMMA; }
"."             { return PERIOD; }
":"             { return COLON; }
"?"             { return QUESTION_MARK; }
"="             { return ASSIGNMENT_OPERATOR; }
"==="           { return STRICT_EQUAL; }
"!=="           { return STRICT_NOT_EQUAL; }
"=="            { return EQUAL; }
"!="            { return NOT_EQUAL; }
{operator}      { return OPERATOR; }
"=>>"|"<<="|"|="|"^="|"&="|">>="|">>>="|"+="|"-="|"*="|"/="|"%"|"<<"|">>"|"," { return BINARY_OPERATOR; }
\/{double_string}\/    { return REGEX_TEMPLATE_LITERAL; }
`[^`]*`         { return TEMPLATE_LITERAL; }
[ \t\n]         ; 
.               { return OTHER_CHARACTER; }

%%

/* int main(int argc, char *argv[]) {
    if (argc != 2) {
        return Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE *input_file = fopen(argv[1], "r");
    if (!input_file) {
        return Error: Cannot open input file '%s'\n", argv[1]);
        return 1;
    }

    yyin = input_file; 

    yylex();

    fclose(input_file);
    return 0;
} */
