%{
#include <stdio.h>
extern int yylex();
extern int yyparse();
extern int yyerror(const char *);
%}

%token NUMBER
%left '+' '-'
%left '*' '/'

%%
expression : expression '+' expression 
           { printf("Parser: Addition\n"); }
           | expression '-' expression 
           { printf("Parser: Subtraction\n"); }
           | expression '*' expression 
           { printf("Parser: Multiplication\n"); }
           | expression '/' expression 
           { printf("Parser: Division\n"); }
           | '(' expression ')' 
           { printf("Parser: Parentheses\n"); }
           | NUMBER
           { printf("Parser: Number\n"); }
           ;
%%

int main() {
    printf("Enter an arithmetic expression: ");
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    printf("Error: %s\n", s);
    return 0;
}
