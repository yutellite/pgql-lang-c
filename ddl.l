%{
#include "ddl.tab.h"
%}

%option noyywrap
%option yylineno

%%
CREATE           { yylloc.first_line = yylloc.last_line = yylineno; return CREATE; }
PROPERTY         { yylloc.first_line = yylloc.last_line = yylineno; return PROPERTY; }
GRAPH            { yylloc.first_line = yylloc.last_line = yylineno; return GRAPH; }
OPTIONS          { yylloc.first_line = yylloc.last_line = yylineno; return OPTIONS; }
VERTEX           { yylloc.first_line = yylloc.last_line = yylineno; return VERTEX; }
TABLES           { yylloc.first_line = yylloc.last_line = yylineno; return TABLES; }
EDGE             { yylloc.first_line = yylloc.last_line = yylineno; return EDGE; }
AS               { yylloc.first_line = yylloc.last_line = yylineno; return AS; }
KEY              { yylloc.first_line = yylloc.last_line = yylineno; return KEY; }
LABEL            { yylloc.first_line = yylloc.last_line = yylineno; return LABEL; }
PROPERTIES       { yylloc.first_line = yylloc.last_line = yylineno; return PROPERTIES; }
REFERENCES       { yylloc.first_line = yylloc.last_line = yylineno; return REFERENCES; }
SOURCE           { yylloc.first_line = yylloc.last_line = yylineno; return SOURCE; }
DESTINATION      { yylloc.first_line = yylloc.last_line = yylineno; return DESTINATION; }
DROP             { yylloc.first_line = yylloc.last_line = yylineno; return DROP; }
BASE             { yylloc.first_line = yylloc.last_line = yylineno; return BASE; }
ELEMENT          { yylloc.first_line = yylloc.last_line = yylineno; return ELEMENT; }
ALL              { yylloc.first_line = yylloc.last_line = yylineno; return ALL; }
EXCEPT           { yylloc.first_line = yylloc.last_line = yylineno; return EXCEPT; }
CALL             { yylloc.first_line = yylloc.last_line = yylineno; return CALL; }
NO               { yylloc.first_line = yylloc.last_line = yylineno; return NO; }
ARE              { yylloc.first_line = yylloc.last_line = yylineno; return ARE; }
COLUMNS          { yylloc.first_line = yylloc.last_line = yylineno; return COLUMNS; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); yylloc.first_line = yylloc.last_line = yylineno; return IDENTIFIER; }
[0-9]+           { yylval.num = atoi(yytext); yylloc.first_line = yylloc.last_line = yylineno; return NUMBER; }
","              { yylloc.first_line = yylloc.last_line = yylineno; return ','; }
"("              { yylloc.first_line = yylloc.last_line = yylineno; return '('; }
")"              { yylloc.first_line = yylloc.last_line = yylineno; return ')'; }
"->"             { yylloc.first_line = yylloc.last_line = yylineno; return ARROW; }
[ \t\n\r]+       { /* Ignore whitespace */ }
.                { yylloc.first_line = yylloc.last_line = yylineno; return yytext[0]; }

%%
