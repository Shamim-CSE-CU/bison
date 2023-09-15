%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
void yyerror(char *s);
%}

%token INT FLOAT GT ASSIGN EQUAL LPAREN RPAREN LBRACE RBRACE IF WHILE ADD SUB MUL DIV SEMI ID NUM

%nonassoc UMINUS  // Define unary minus

%start start

%%
start: statement | ;

statement: statement expression
         | if_statement
         | while_statement
         | func_statement
         | expression SEMI
         ;

func_statement: type ID LPAREN expression RPAREN LBRACE statement RBRACE;

while_statement: WHILE LPAREN expression RPAREN LBRACE statement RBRACE;

if_statement: statement IF LPAREN expression RPAREN LBRACE statement RBRACE;

expression:type ID SEMI
          | type ID ASSIGN NUM SEMI
          | type ID ASSIGN ID OP ID SEMI
          | type ID ASSIGN ID OP NUM SEMI
          | ID EQUAL expression
          | ID GT expression
          | LPAREN expression RPAREN
          | expression ADD expression
          | expression SUB expression
          | expression MUL expression
          | expression DIV expression
          | SUB expression %prec UMINUS
          | NUM
          | LPAREN ID OP ID RPAREN OP ID
          |
          ;

type: INT | FLOAT;

OP: ADD | SUB | MUL | DIV;

%%

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    printf("\nParser is Finished\n");
    return 0;
}
