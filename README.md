# pgql-lang-c

## compile

```shell
 sudo apt-get install flex bison

bison -d ddl.y
flex ddl.l
gcc -o ddl_parser ddl.tab.c lex.yy.c -lfl
```