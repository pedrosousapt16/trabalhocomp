%{
#include <stdio.h>
#include <stdlib.h>

int num_linhas = 1;
int num_tokens = 0;
int num_erros = 0;

void print_token(const char* categoria, const char* lexema) {
    printf("%d %s %s\n", num_linhas, categoria, lexema);
    num_tokens++;
}

void print_erro(const char* lexema) {
    printf("Linha %d: Erro lexical no candidato '%s'\n", num_linhas, lexema);
    num_erros++;
}
%}

%option noyywrap


ALGARISMO   [0-9]
LETRA_MAIUS [A-Z]
ALFANUM_EXT [a-zA-Z0-9\_\-]

%%


\r?\n                   { num_linhas++; }
[ \t]+                  { /* Ignora espaços e tabulações */ }

#.*                     { /* Ignora tudo até ao fim da linha */ }


"LIGAR"                 { print_token("LIGAR", yytext); }
"DESLIGAR"              { print_token("DESLIGAR", yytext); }
"ABRIR"                 { print_token("ABRIR", yytext); }
"FECHAR"                { print_token("FECHAR", yytext); }
"AQUECER"               { print_token("AQUECER", yytext); }
"PARAR"                 { print_token("PARAR", yytext); }
"REGAR"                 { print_token("REGAR", yytext); }
"ESPERAR"               { print_token("ESPERAR", yytext); }
"SE"                    { print_token("SE", yytext); }
"SENAO"                 { print_token("SENAO", yytext); }
"HUMIDADE"              { print_token("HUMIDADE", yytext); }
"REPETIR"               { print_token("REPETIR", yytext); }


EST-{LETRA_MAIUS}{2}{ALGARISMO}{2} { print_token("ID_ESTUFA", yytext); }


0|[1-9]{ALGARISMO}*     { print_token("INTEIRO", yytext); }

"("                     { print_token("ABRE_PAR", yytext); }
")"                     { print_token("FECHA_PAR", yytext); }
"{"                     { print_token("ABRE_CHAVETA", yytext); }
"}"                     { print_token("FECHA_CHAVETA", yytext); }
","                     { print_token("VIRGULA", yytext); }
";"                     { print_token("PONTO_VIRG", yytext); }


"<="                    { print_token("MENOR_IGUAL", yytext); }
">="                    { print_token("MAIOR_IGUAL", yytext); }
"=="                    { print_token("IGUAL", yytext); }
"!="                    { print_token("DIFERENTE", yytext); }
"<"                     { print_token("MENOR", yytext); }
">"                     { print_token("MAIOR", yytext); }

{ALFANUM_EXT}+          { print_erro(yytext); }

.                       { print_erro(yytext); }

%%


int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *ficheiro = fopen(argv[1], "r");
        if (!ficheiro) {
            perror("Erro ao abrir ficheiro de entrada");
            return 1;
        }
        yyin = ficheiro;
    }

    yylex();

    printf("Tokens: %d | Erros lexicais: %d\n", num_tokens, num_erros);

    if (argc > 1) {
        fclose(yyin);
    }

    return 0;
}