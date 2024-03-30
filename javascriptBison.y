%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Define a structure to represent a symbol
typedef struct {
    char name[256]; // Assuming maximum identifier length is 255 characters
    int type;       // Type of the symbol (you may need to define types)
    // Add more fields as needed, such as scope, value, etc.
} Symbol;

#define MAX_SYMBOLS 1000 // Maximum number of symbols, adjust as needed

Symbol symbol_table[MAX_SYMBOLS]; // Symbol table array
int num_symbols = 0;              // Current number of symbols in the table

// Function to add a symbol to the symbol table
void add_symbol(const char* name, int type) {
    if (num_symbols >= MAX_SYMBOLS) {
        fprintf(stderr, "Error: Symbol table full\n");
        exit(1);
    }
    strncpy(symbol_table[num_symbols].name, name, sizeof(symbol_table[num_symbols].name));
    symbol_table[num_symbols].type = type;
    num_symbols++;
}

// Function to search for a symbol in the symbol table
int find_symbol(const char* name) {
    int i;
    for (i = 0; i < num_symbols; i++) {
        if (strcmp(symbol_table[i].name, name) == 0) {
            return i; // Return index if found
        }
    }
    return -1; // Return -1 if not found
}

// Function to print the symbol table (for debugging)
void print_symbol_table() {
    int i;
    printf("Symbol Table:\n");
    for (i = 0; i < num_symbols; i++) {
        printf("%s - Type: %d\n", symbol_table[i].name, symbol_table[i].type);
    }
}
%}

%token BOOLEAN_LITERAL IDENTIFIER NUMBER STRING ARRAY
%token IF ELSE WHILE FOR DO FUNCTION RETURN BREAK CONTINUE SWITCH CASE DEFAULT TRY CATCH FINALLY THROW TYPEOF INSTANCEOF NEW DELETE IN WITH CLASS EXTENDS
%token VAR LET CONST
%token LEFT_PAREN RIGHT_PAREN LEFT_CURLY RIGHT_CURLY LEFT_SQUARE RIGHT_SQUARE SEMICOLON COMMA PERIOD COLON QUESTION_MARK ASSIGNMENT_OPERATOR
%token STRICT_EQUAL STRICT_NOT_EQUAL EQUAL NOT_EQUAL
%token OPERATOR BINARY_OPERATOR REGEX_TEMPLATE_LITERAL TEMPLATE_LITERAL
%token OTHER_CHARACTER
%token IMPORT EXPORT FROM AS 

%left ELSE

%%

program             : statement_list
                    ;

statement_list      : statement
                    | statement_list statement
                    ;

statement           : expression_statement
                    | keyword_statement
                    | var_statement
                    | class_declaration
                    | import_statement
                    | block
                    ;

block               : LEFT_CURLY statement_list RIGHT_CURLY
                    ;

expression_statement : expression SEMICOLON
                      ;

expression          : IDENTIFIER ASSIGNMENT_OPERATOR expression
                    | primary_expression
                    ;

primary_expression  : IDENTIFIER
                    | NUMBER
                    | STRING
                    | BOOLEAN_LITERAL
                    | LEFT_PAREN expression RIGHT_PAREN
                    ;

keyword_statement   : if_statement
                    | WHILE LEFT_PAREN expression RIGHT_PAREN statement
                    | FOR LEFT_PAREN expression SEMICOLON expression SEMICOLON expression RIGHT_PAREN statement
                    | DO statement WHILE LEFT_PAREN expression RIGHT_PAREN SEMICOLON
                    | FUNCTION IDENTIFIER LEFT_PAREN RIGHT_PAREN block
                    | RETURN expression optional_semicolon
                    | BREAK optional_semicolon
                    | CONTINUE optional_semicolon
                    | SWITCH LEFT_PAREN expression RIGHT_PAREN LEFT_CURLY statement_list RIGHT_CURLY
                    | TRY block catch_finally
                    | THROW expression optional_semicolon
                    ;

if_statement        : IF LEFT_PAREN expression EQUAL expression RIGHT_PAREN statement
                    | IF LEFT_PAREN expression NOT_EQUAL expression RIGHT_PAREN statement
                    | IF LEFT_PAREN expression STRICT_EQUAL expression RIGHT_PAREN statement
                    | IF LEFT_PAREN expression STRICT_NOT_EQUAL expression RIGHT_PAREN statement
                    ;


catch_finally       : CATCH LEFT_PAREN IDENTIFIER RIGHT_PAREN block FINALLY block
                    | CATCH LEFT_PAREN IDENTIFIER RIGHT_PAREN block
                    | FINALLY block
                    ;

var_statement       : VAR IDENTIFIER ASSIGNMENT_OPERATOR expression optional_semicolon
                    | LET IDENTIFIER ASSIGNMENT_OPERATOR expression optional_semicolon
                    | CONST IDENTIFIER ASSIGNMENT_OPERATOR expression optional_semicolon
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
                   ;

method_definition : FUNCTION IDENTIFIER LEFT_PAREN RIGHT_PAREN block
                  ;

property_assignment : IDENTIFIER ASSIGNMENT_OPERATOR expression optional_semicolon
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

optional_semicolon : SEMICOLON
                   | /* empty */
                   ;

%%

int yyerror(const char *msg) {
    fprintf(stderr, "Parser Error: %s\n", msg);
    return 1;
}

#include <stdio.h>

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
        print_symbol_table(); 
    }

    fclose(input_file);
    return 0;
}
