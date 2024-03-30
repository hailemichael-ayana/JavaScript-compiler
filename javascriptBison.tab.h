/* A Bison parser, made by GNU Bison 2.7.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_JAVASCRIPTBISON_TAB_H_INCLUDED
# define YY_YY_JAVASCRIPTBISON_TAB_H_INCLUDED
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     BOOLEAN_LITERAL = 258,
     IDENTIFIER = 259,
     NUMBER = 260,
     STRING = 261,
     ARRAY = 262,
     IF = 263,
     ELSE = 264,
     WHILE = 265,
     FOR = 266,
     DO = 267,
     FUNCTION = 268,
     RETURN = 269,
     BREAK = 270,
     CONTINUE = 271,
     SWITCH = 272,
     CASE = 273,
     DEFAULT = 274,
     TRY = 275,
     CATCH = 276,
     FINALLY = 277,
     THROW = 278,
     TYPEOF = 279,
     INSTANCEOF = 280,
     NEW = 281,
     DELETE = 282,
     IN = 283,
     WITH = 284,
     CLASS = 285,
     EXTENDS = 286,
     VAR = 287,
     LET = 288,
     CONST = 289,
     LEFT_PAREN = 290,
     RIGHT_PAREN = 291,
     LEFT_CURLY = 292,
     RIGHT_CURLY = 293,
     LEFT_SQUARE = 294,
     RIGHT_SQUARE = 295,
     SEMICOLON = 296,
     COMMA = 297,
     PERIOD = 298,
     COLON = 299,
     QUESTION_MARK = 300,
     ASSIGNMENT_OPERATOR = 301,
     STRICT_EQUAL = 302,
     STRICT_NOT_EQUAL = 303,
     EQUAL = 304,
     NOT_EQUAL = 305,
     OPERATOR = 306,
     BINARY_OPERATOR = 307,
     REGEX_TEMPLATE_LITERAL = 308,
     TEMPLATE_LITERAL = 309,
     OTHER_CHARACTER = 310,
     IMPORT = 311,
     EXPORT = 312,
     FROM = 313,
     AS = 314
   };
#endif


#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_YY_JAVASCRIPTBISON_TAB_H_INCLUDED  */
