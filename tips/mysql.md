# Useful commands

* Describe all tables in mysql in table format
```bash
mysql -uUSER -pPASSWORD DATABASE -e 'show tables' | \
    while read;
    do
        printf "\n\n%s\n" "$REPLY";
        mysql -uUSER -pPASSWORD DATABASE -t -e "describe $REPLY" 2>&1 | \
            grep -v "Using a password";
    done
```
