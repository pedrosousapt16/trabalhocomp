Analisador Léxico — Linguagem GreenScript

Este projeto implementa um analisador léxico (scanner) para a linguagem textual GreenScript, desenvolvido no âmbito da unidade curricular de Compiladores (Licenciatura em Engenharia Informática, UTAD).

O analisador recebe um ficheiro de texto contendo código GreenScript e produz a sequência de componentes léxicos (tokens) reconhecidos, assinalando eventuais erros léxicos com a respetiva linha de ocorrência e apresentando um resumo estatístico no final do processamento.


Ferramentas Utilizadas

FLEX (Fast Lexical Analyzer Generator): Ferramenta utilizada para gerar o código-fonte em C (lex.yy.c) a partir da especificação de regras léxicas (src/greenscript.l).

GCC / CC (GNU Compiler Collection): Compilador de linguagem C utilizado para compilar o código gerado pelo FLEX no executável final.

Draw.io: Ferramenta utilizada para a modelação visual do Autómato Finito Determinístico (DFA) referente aos identificadores de estufa.

Ambiente Unix/Linux (POSIX): Sistema operativo ou ambiente de terminal compatível (Linux nativo, macOS ou WSL no Windows) necessário para a execução das ferramentas de compilação.

Compilação

Todos os comandos abaixo devem ser executados num terminal posicionado na diretoria raiz do projeto (trabalhocomp-main/), onde se encontram as pastas src/ e testes/.

1. Gerar o analisador em C

Executar o FLEX sobre o ficheiro de especificação léxica para gerar o ficheiro lex.yy.c na diretoria atual:

flex src/greenscript.l


2. Compilar o executável

Compilar o ficheiro lex.yy.c para criar o binário greenscript, ligando a biblioteca padrão do FLEX (-ll)

gcc lex.yy.c -o greenscript -ll

Execução e Utilização

O programa greenscript recebe obrigatoriamente como argumento na linha de comandos o caminho relativo ou absoluto para o ficheiro de entrada a analisar.

Sintaxe Geral

./greenscript <caminho_para_o_ficheiro>


Exemplos de Utilização

Analisar um ficheiro qualquer localizado no sistema:

./greenscript caminho/para/o/meu_ficheiro.txt


Executar com os ficheiros incluídos na pasta testes/:

./greenscript testes/teste_comandos_simples.txt
./greenscript testes/teste_operadores.txt
./greenscript testes/teste_incorreto1.txt


Redirecionar o resultado da análise para um ficheiro de saída:

./greenscript testes/teste_comandos_simples.txt > output.txt


Formato da Saída

Para cada elemento identificado no ficheiro de entrada, o programa imprime uma linha no formato:

<linha> <token> <lexema>


No final da análise, apresenta o contabilizador global:

Tokens: <total_tokens> Erros lexicais: <total_erros>
