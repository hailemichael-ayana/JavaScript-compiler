%{
#include <stdio.h>
%}

%option noyywrap


digit           [0-9]
letter          [a-zA-Z]
identifier      {letter}({letter}|{digit})*
number          {digit}+(\.{digit}+)?(e[+-]?{digit}+)?
string          \"([^\"\\]|\\.)*\"
comment         (\/\/.*\n|\/\*([^*]|\*[^\/])*\*\/)
operator        (\+\+|\-\-|\=|\+|\-|\*|\/|\%|\&\&|\|\||\!\=|\=\=|\>|\<|\>=|\<=|\!|\~|\&|\^|\|)

%%
"true"|"false"|"null"  { printf("Boolean Literal: %s\n", yytext); }
"undefined"     { printf("Undefined Literal\n"); }
"if"|"else"|"while"|"for"|"do"|"function"|"var"|"let"|"const"|"return"|"break"|"continue"|"switch"|"case"|"default"|"try"|"catch"|"finally"|"throw"|"typeof"|"instanceof"|"new"|"delete"|"in"|"with"|"class"|"extends"   { printf("Keyword: %s\n", yytext); }
{identifier}    { printf("Identifier: %s\n", yytext); }
{number}        { printf("Number: %s\n", yytext); }
{string}        { printf("String: %s\n", yytext); }
{comment}       ; /* Ignore comments */
"("             { printf("Left Parenthesis\n"); }
")"             { printf("Right Parenthesis\n"); }
"{"             { printf("Left Curly Brace\n"); }
"}"             { printf("Right Curly Brace\n"); }
"["             { printf("Left Square Bracket\n"); }
"]"             { printf("Right Square Bracket\n"); }
";"             { printf("Semicolon\n"); }
","             { printf("Comma\n"); }
"."             { printf("Period\n"); }
":"             { printf("Colon\n"); }
"?"             { printf("Question Mark\n"); }
"="             { printf("Assignment Operator\n"); }
"==="           { printf("Strict Equal Operator\n"); }
"!=="           { printf("Strict not Equal Operator\n"); }
"=="            { printf("Equal Operator\n"); }
"!="            { printf("not Equal Operator\n"); }
{operator}      { printf("Operator: %s\n", yytext); }
"=>>"|"<<="|"|="|"^="|"&="|">>="|">>>="|"+="|"-="|"*="|"/="|"%"|"<<"|">>"|"," { printf("Binary Operator: %s\n", yytext); }
\/{string}\/    { printf("Regular Expression: %s\n", yytext); }
`[^`]*`         { printf("Template Literal: %s\n", yytext); }
[ \t\n]         ; /* Ignore whitespace and newline */
.               { printf("other character: %s\n", yytext); }

%%

int main() {
    yylex();
    return 0;
}
