%{
#include <stdio.h>
#include <stdlib.h>

/* Variáveis globais para contagem */
int num_linhas = 1;
int num_tokens = 0;
int num_erros = 0;

/* Função auxiliar para imprimir tokens válidos */
void print_token(const char* categoria, const char* lexema) {
    printf("%d %s\n%s\n", num_linhas, categoria, lexema);
    num_tokens++;
}

/* Função auxiliar para imprimir erros e recuperar */
void print_erro(const char* lexema) {
    printf("Linha %d: Erro lexical no candidato '%s'\n", num_linhas, lexema);
    num_erros++;
}
%}

%option noyywrap

/* 
 * DEFINIÇÃO DE MACROS (Conceito da Ficha 3)
 */
ALGARISMO   [0-9]
LETRA_MAIUS [A-Z]
ALFANUM_EXT [a-zA-Z0-9_-]

%%

 /* 1. Tratamento de Espaços e Mudanças de Linha */
\r?\n                   { num_linhas++; }
[ \t]+                  { /* Ignora espaços e tabulações */ }

 /* 2. Comentários */
#.*                     { /* Ignora tudo até ao fim da linha */ }

 /* 3. Palavras Reservadas */
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

 /* 4. Identificador de Estufa usando as macros definidas acima */
EST-{LETRA_MAIUS}{2}{ALGARISMO}{2} { print_token("ID_ESTUFA", yytext); }

 /* 5. Inteiros usando a macro de algarismos */
0|[1-9]{ALGARISMO}*     { print_token("INTEIRO", yytext); }

 /* 6. Delimitadores */
"("                     { print_token("ABRE_PAR", yytext); }
")"                     { print_token("FECHA_PAR", yytext); }
"{"                     { print_token("ABRE_CHAVETA", yytext); }
"}"                     { print_token("FECHA_CHAVETA", yytext); }
","                     { print_token("VIRGULA", yytext); }
";"                     { print_token("PONTO_VIRG", yytext); }

 /* 7. Operadores Relacionais */
"<="                    { print_token("MENOR_IGUAL", yytext); }
">="                    { print_token("MAIOR_IGUAL", yytext); }
"=="                    { print_token("IGUAL", yytext); }
"!="                    { print_token("DIFERENTE", yytext); }
"<"                     { print_token("MENOR", yytext); }
">"                     { print_token("MAIOR", yytext); }

 /* 8. Tratamento de erros utilizando a macro abrangente */
{ALFANUM_EXT}+          { print_erro(yytext); }

 /* Qualquer outro carácter isolado */
.                       { print_erro(yytext); }

%%

/* 
 * ROTINAS EM C DE SUPORTE
 */
int main(int argc, char **argv) {
    /* Permite ler de um ficheiro passado por argumento ou do standard input */
    if (argc > 1) {
        FILE *ficheiro = fopen(argv[1], "r");
        if (!ficheiro) {
            perror("Erro ao abrir ficheiro de entrada");
            return 1;
        }
        yyin = ficheiro;
    }

    yylex();

    printf("Tokens: %d Erros lexicais: %d\n", num_tokens, num_erros);

    if (argc > 1) {
        fclose(yyin);
    }

    return 0;
}