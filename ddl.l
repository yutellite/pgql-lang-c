%{
#include "ddl.tab.h"
%}

%%

CREATE           { return CREATE; }
PROPERTY         { return PROPERTY; }
GRAPH            { return GRAPH; }
OPTIONS          { return OPTIONS; }
VERTEX           { return VERTEX; }
TABLES           { return TABLES; }
EDGE             { return EDGE; }
AS               { return AS; }
KEY              { return KEY; }
LABEL            { return LABEL; }
PROPERTIES       { return PROPERTIES; }
REFERENCES       { return REFERENCES; }
SOURCE           { return SOURCE; }
DESTINATION      { return DESTINATION; }
DROP             { return DROP; }
BASE             { return BASE; }
ELEMENT          { return ELEMENT; }
ALL              { return ALL; }
EXCEPT           { return EXCEPT; }
CALL             { return CALL; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return IDENTIFIER; }
[0-9]+           { yylval.num = atoi(yytext); return NUMBER; }
","              { return ','; }
"("              { return '('; }
")"              { return ')'; }
"->"             { return ARROW; }
[ \t\n\r]+       { /* Ignore whitespace */ }
.                { return yytext[0]; }

%%
