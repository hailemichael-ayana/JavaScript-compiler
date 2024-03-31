%{
#include <stdio.h>
#include "javascriptBison.tab.h"
#include <stdlib.h>
int newLine =0;
struct Symbol {
    char name[100];
    char type[100];
};

struct Symbol symbol_table[1000];
int num_symbols = 0;
int num_symbol = 1;

void add_symbol(const char* name,const char* type) {
    strcpy(symbol_table[num_symbols].name, name);
    strcpy(symbol_table[num_symbols].type, type);
    num_symbols++;
}
%}

%option noyywrap
digit           [0-9]
letter          [a-zA-Z]
identifier      {letter}({letter}|{digit})*
number          {digit}+(\.{digit}+)?(e[+-]?{digit}+)?
double_string   \"([^\"\\]|\\.)*\"
single_string   '([^'\\]|\\.)*'
comment         (\/\/.*|\/\*([^*]|\*[^\/])*\*\/)
operator        (\+\+|\-\-|\+|\-|\*|\/|\%|\&\&|\|\||\!\=|\=\=|\>|\<|\>=|\<=|\!|\~|\&|\^|\|)

array           \[[^\[\]]*\]

%%

"true"|"false"|"null"  { return BOOLEAN_LITERAL; }
"if" {add_symbol(yytext,"Keyword");return IF;}
"else" {add_symbol(yytext,"Keyword");return ELSE;}
"while" {add_symbol(yytext,"Keyword");return WHILE;}
"for" {add_symbol(yytext,"Keyword");return FOR;}
"do" {add_symbol(yytext,"Keyword");return DO;}
"function" {add_symbol(yytext,"Keyword");return FUNCTION;}
"import" {add_symbol(yytext,"Keyword");return IMPORT;}
"from" {add_symbol(yytext,"Keyword");return FROM;}
"as" {add_symbol(yytext,"Keyword");return AS;}
"return" {add_symbol(yytext,"Keyword");return RETURN;}
"break" {add_symbol(yytext,"Keyword");return BREAK;}
"continue" {add_symbol(yytext,"Keyword");return CONTINUE;}
"switch" add_symbol(yytext,"Keyword");{return SWITCH;}
"case" {add_symbol(yytext,"Keyword");return CASE;}
"default" {add_symbol(yytext,"Keyword");return DEFAULT;}
"try" {add_symbol(yytext,"Keyword");return TRY;}
"catch" {add_symbol(yytext,"Keyword");return CATCH;}
"finally" {add_symbol(yytext,"Keyword");return FINALLY;}
"throw" {add_symbol(yytext,"Keyword");return THROW;}
"typeof" {add_symbol(yytext,"Keyword");return TYPEOF;}
"instanceof" {add_symbol(yytext,"Keyword");return INSTANCEOF;}
"new" {add_symbol(yytext,"Keyword");return NEW;}
"delete" {add_symbol(yytext,"Keyword");return DELETE;}
"in" {add_symbol(yytext,"Keyword");return IN;}
"with" {add_symbol(yytext,"Keyword");return WITH;}
"class" {add_symbol(yytext,"Keyword");return CLASS;}
"extends" {add_symbol(yytext,"Keyword");return EXTENDS;}
"var" {add_symbol(yytext,"Keyword");return VAR;}
"let" {add_symbol(yytext,"Keyword");return LET;}
"const" {add_symbol(yytext,"Keyword");return CONST;}
{array}          { return ARRAY; }
{identifier}    { add_symbol(yytext,"Identifier"); return IDENTIFIER; }
{number}        { add_symbol(yytext,"Number"); return NUMBER; }
{single_string} { add_symbol(yytext,"String"); return STRING; }
{double_string} { add_symbol(yytext,"String");  return STRING; }
{comment}       ;
"("             { return LEFT_PAREN; }
")"             { return RIGHT_PAREN; }
"{"             { return LEFT_CURLY; }
"}"             { return RIGHT_CURLY; }
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
{operator}      { return OPERATOR; }
"=>>"|"<<="|"|="|"^="|"&="|">>="|">>>="|"+="|"-="|"*="|"/="|"%"|"<<"|">>"|"," { return BINARY_OPERATOR; }
`[\s\S]*`         { return TEMPLATE_LITERAL; }
[ \t]         ; 
[\n]        {  num_symbol++; }
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
