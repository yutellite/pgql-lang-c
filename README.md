# pgql-lang-c

## compile

```shell
 sudo apt-get install flex bison

bison -d ddl.y
flex ddl.l
gcc -o ddl_parser ddl.tab.c lex.yy.c -lfl
```

## test
```sql
CREATE PROPERTY GRAPH ywx
  VERTEX TABLES (
    Persons LABEL Person PROPERTIES ( name )
  )
  EDGE TABLES (
    Transactions
      SOURCE KEY ( from_account ) REFERENCES Accounts ( number )
      DESTINATION KEY ( to_account ) REFERENCES Accounts ( number )
      LABEL transaction PROPERTIES ( amount )
  )
```