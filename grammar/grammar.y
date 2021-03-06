%{
#include <stdio.h>
void yyerror(const char* msg) {}
int yylex();
%}

%token T_NUM

%left '+' '-'
%left '*' '/'

%%

S   :   S E '\n'        { printf("\nans = %d\n", $2); }
    |   /* empty */     { /* empty */ }
    ;

E   :   E '+' E         { $$ = $1 + $3; printf("\n%d = %d + %d", $$, $1, $3);}
    |   E '-' E         { $$ = $1 - $3; printf("\n%d = %d - %d", $$, $1, $3);}
    |   E '*' E         { $$ = $1 * $3; printf("\n%d = %d * %d", $$, $1, $3);}
    |   E '/' E         { $$ = $1 / $3; printf("\n%d = %d / %d", $$, $1, $3);}
    |   T_NUM           { $$ = $1; }
    |   '(' E ')'       { $$ = $2; }
    ;

%%

int main() {
    return yyparse();
}