%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>  // 添加这个头文件

void yyerror(const YYLTYPE *yylloc, const char *s, ...) ;
int yylex(void);

%}

%locations

%union {
    char *str;
    int num;
}

%token <str> IDENTIFIER
%token <num> NUMBER
%token CREATE PROPERTY GRAPH OPTIONS VERTEX TABLES EDGE AS KEY LABEL PROPERTIES REFERENCES SOURCE DESTINATION DROP BASE ELEMENT ALL EXCEPT CALL NO ARE COLUMNS ARROW

%type <str> identifier_list exp_as_var exp_as_var_list option option_list label_clause properties_clause except_columns source_vertex_table destination_vertex_table as_table_alias

%%

input:
    statement_list
    ;

statement_list:
    statement
    | statement_list statement
    ;

statement:
    create_property_graph_statement
    | drop_property_graph_statement
    | call_statement
    ;

create_property_graph_statement:
    CREATE PROPERTY GRAPH IDENTIFIER vertex_tables edge_tables options_clause
    ;

vertex_tables:
    VERTEX TABLES '(' vertex_table_list ')'
    ;

vertex_table_list:
    vertex_table
    | vertex_table_list ',' vertex_table
    ;

vertex_table:
    IDENTIFIER as_table_alias key_clause label_and_properties_clause
    ;

edge_tables:
    EDGE TABLES '(' edge_table_list ')'
    ;

edge_table_list:
    edge_table
    | edge_table_list ',' edge_table
    ;

edge_table:
    IDENTIFIER as_table_alias key_clause source_vertex_table destination_vertex_table label_and_properties_clause
    ;

as_table_alias:
    /* empty */
    | AS IDENTIFIER { $$ = $2; }
    ;

key_clause:
    KEY '(' identifier_list ')'
    ;

identifier_list:
    IDENTIFIER
    | identifier_list ',' IDENTIFIER
    ;

label_and_properties_clause:
    label_clause properties_clause
    ;

label_clause:
    LABEL IDENTIFIER { $$ = $2; }
    ;

properties_clause:
    PROPERTIES '(' exp_as_var_list ')' { $$ = $3; }
    | NO PROPERTIES
    | PROPERTIES ARE ALL COLUMNS except_columns
    ;

exp_as_var_list:
    exp_as_var
    | exp_as_var_list ',' exp_as_var
    ;

exp_as_var:
    IDENTIFIER
    ;

except_columns:
    /* empty */
    | EXCEPT '(' identifier_list ')' { $$ = $3; }
    ;

source_vertex_table:
    SOURCE key_clause REFERENCES IDENTIFIER
    ;

destination_vertex_table:
    DESTINATION key_clause REFERENCES IDENTIFIER
    ;

options_clause:
    OPTIONS '(' option_list ')'
    ;

option_list:
    option
    | option_list ',' option
    ;

option:
    IDENTIFIER
    ;

drop_property_graph_statement:
    DROP PROPERTY GRAPH IDENTIFIER
    ;

call_statement:
    CALL IDENTIFIER '(' exp_list ')'
    ;

exp_list:
    /* empty */
    | exp
    | exp_list ',' exp
    ;

exp:
    IDENTIFIER
    | NUMBER
    ;

%%

// 更新 yyerror 函数以接受位置信息并打印错误所在的行号。
void yyerror(const YYLTYPE *yylloc, const char *s, ...) {
    va_list ap;
    va_start(ap, s);

    fprintf(stderr, "Error at line %d: ", yylloc->first_line);
    vfprintf(stderr, s, ap);
    fprintf(stderr, "\n");

    va_end(ap);
}


int main(void) {
    return yyparse();
}
