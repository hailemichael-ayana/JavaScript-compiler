%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
struct Symbol {
    char name[100];
    char type[100];
};
%}

%token  IDENTIFIER
%token  BOOLEAN_LITERAL NUMBER STRING ARRAY
%token IF ELSE WHILE FOR DO FUNCTION RETURN BREAK CONTINUE SWITCH CASE DEFAULT TRY CATCH FINALLY THROW TYPEOF INSTANCEOF NEW DELETE IN WITH CLASS EXTENDS
%token VAR LET CONST
%token LEFT_PAREN RIGHT_PAREN LEFT_CURLY RIGHT_CURLY LEFT_SQUARE RIGHT_SQUARE SEMICOLON COMMA PERIOD COLON QUESTION_MARK ASSIGNMENT_OPERATOR
%token STRICT_EQUAL STRICT_NOT_EQUAL EQUAL NOT_EQUAL
%token OPERATOR BINARY_OPERATOR REGEX_TEMPLATE_LITERAL TEMPLATE_LITERAL
%token AS FROM IMPORT
%token OTHER_CHARACTER

%%

program             : import_statements statement_list
                    ;

statement_list      : statement statement_list
                    | statement
                    | 
                    ;

statement           : expression_statement
                    | keyword_statement
                    | assignment optional_semicolon
                    | declaration optional_semicolon
                    | class_declaration
                    | return_statement 
                    ;

block               : LEFT_CURLY statement_list RIGHT_CURLY
                    ;

expression_statement : expression optional_semicolon
                      ;
initialization_statement : declaration SEMICOLON
                            | assignment SEMICOLON

expression          :  expression OPERATOR expression
                    |IDENTIFIER
                    | NUMBER
                    | STRING
                    | BOOLEAN_LITERAL
                    | LEFT_PAREN expression RIGHT_PAREN
                    ;

assignment : IDENTIFIER ASSIGNMENT_OPERATOR expression 

if_statement     : IF expression block
                    ;
while_statement : WHILE expression block

declaration       : VAR assignment
                    | LET assignment
                    | LET IDENTIFIER  
                    | VAR IDENTIFIER  
                    | CONST IDENTIFIER  
                    | CONST assignment
                    ;

class_declaration  : CLASS IDENTIFIER class_body
                   | CLASS IDENTIFIER EXTENDS IDENTIFIER class_body
                   ;

class_body         : LEFT_CURLY class_element_list RIGHT_CURLY
                   ;

class_element_list : class_element
                   | class_element_list class_element
                   ;

class_element      : method_definition
                   | property_assignment
                   |
                   ;

method_definition : IDENTIFIER LEFT_PAREN RIGHT_PAREN block 
                  | IDENTIFIER LEFT_PAREN identifier_list RIGHT_PAREN block
                  ;

keyword_statement   : if_statement
                   | while_statement
                   | FOR LEFT_PAREN initialization_statement expression SEMICOLON expression RIGHT_PAREN block
                   | DO block WHILE LEFT_PAREN expression RIGHT_PAREN SEMICOLON
                   | function_block
                   | BREAK optional_semicolon
                   | CONTINUE optional_semicolon
                   | SWITCH LEFT_PAREN expression RIGHT_PAREN LEFT_CURLY case_lists RIGHT_CURLY
                   | TRY block catch_finally
                   | THROW expression optional_semicolon
                   ;
case_lists : case_list case_lists DEFAULT COLON BREAK
            | case_list case_lists DEFAULT COLON statement_list
            | case_list case_lists DEFAULT COLON block
            | case_list case_lists DEFAULT COLON
            | case_list case_lists
            |
            ;
case_list : CASE case_expression COLON statement_list BREAK optional_semicolon
             | CASE case_expression COLON statement_list 
             | CASE case_expression COLON 
             | CASE case_expression COLON block
             |
             ;
case_expression:    IDENTIFIER
                    | NUMBER
                    | STRING
                    | BOOLEAN_LITERAL
                    | LEFT_PAREN expression RIGHT_PAREN
                    ;
function_block :  FUNCTION IDENTIFIER LEFT_PAREN RIGHT_PAREN block 
                | FUNCTION IDENTIFIER LEFT_PAREN  identifier_list RIGHT_PAREN block
                ;
return_statement : RETURN  expression optional_semicolon; 

catch_finally : CATCH LEFT_PAREN IDENTIFIER RIGHT_PAREN block
                   | FINALLY block
                   | /* empty */
                   ;

property_assignment : IDENTIFIER ASSIGNMENT_OPERATOR expression optional_semicolon
                    ;

import_statements : import_statement import_statements
                    |import_statement
                    |/* empty */
                    ; 
import_statement   : IMPORT import_clause FROM STRING optional_semicolon
                   | IMPORT import_clause FROM STRING AS IDENTIFIER optional_semicolon
                   ;

import_clause      : IDENTIFIER
                  | LEFT_CURLY import_specifier_list RIGHT_CURLY
                  ;

import_specifier_list : import_specifier
                      | import_specifier_list COMMA import_specifier
                      ;

import_specifier  : IDENTIFIER
                  | IDENTIFIER AS IDENTIFIER
                  ;
identifier_list : IDENTIFIER COMMA identifier_list
                | IDENTIFIER
                ;

optional_semicolon : SEMICOLON
                   | /* empty */
                   ;

%%

#include <stdio.h>
#include "javascriptBison.tab.h"
 struct Symbol symbol_table[1000];
extern int num_symbols;
extern int num_symbol;
int yyerror(const char *msg) {
    fprintf(stderr, "syntax Error at line: %d\n", num_symbol);
    return 1;
}
extern FILE* yyin; 

int main(int argc, char *argv[]) {
    FILE *input_file;
    

    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    input_file = fopen(argv[1], "r");
    if (!input_file) {
        fprintf(stderr, "Error: Cannot open input file '%s'\n", argv[1]);
        return 1;
    }

    yyin = input_file; 

    if (yyparse() == 0) {
        printf("Valid JavaScript code\n");
        int i;
        printf("  +-----------------------------------------------------+\n");
        printf("\tLexeme \t\t Token \t\t\tLine \n");
        printf("   -----------------------------------------------------\n");
    for ( i = 0; i < num_symbols; i++) {
        
        printf(" %s" " %d \t %s \t\t %s \t\t %d \t %s\n", "|", i+1, symbol_table[i].name,symbol_table[i].type ,num_symbol, "|");
    }
     printf("   +----------------------------------------------------+\n");
    }

    fclose(input_file);
    return 0;
}
