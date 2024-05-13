# Database Management System Using BASH Scripting

![image](https://user-images.githubusercontent.com/91686296/230939644-a5a24718-2698-4d7b-a7e7-919ea1d08e3e.png)

This is a project I made after finishing the `Linux` and the `Bash` command language courses in the ITI.
It is a menu based simulation of Database Management Systems and how they work.
- Each database is represented by a directory.
- Each table is represented by two files `table.idb` and `table.frm`
    - `table.idb`: where the data is stored.
    - `table.frm`: where the metadata of the table is stored.
- Different operations use the metadata to check for the validity of the input.
- To query and alter the data I used `AWK` and `SED` to find and alter table fields, and `output redirection` to reprocess it or save the results to the original files.
## How To Use:
```sh
$ ./DBMenu.sh
```

## Views:
    Menu Option |`Equal SQL Statement`
Databases Operations:
* Show Databases |`SHOW DATABASES`
* Create Database |`CREATE DATABASE 'DATABASE_NAME'`
* Use Database |`USE 'DATABASE_NAME'` | Tables Operations:
* Delete Database |`DROP DATABASE IF EXISTS 'DATABASE_NAME'`

Tables Operations:
* Show Tables |`SHOW TABLES`
* Create New Table | `
CREATE TABLE table_name(
  	id INT PRIMARY KEY,  
  	name VARCHAR(255),
  	salary INT
)
`
* Use Table | Individual Table Operatins
* Delete Table |`DROP TABLE table_name`

Individual Table Operatins:
* Display Table Content |`SELECT * FROM table_name`
* Insert |`INSERT INTO table_name (column1, column2) VALUES (value1, value2)`
* Select
    * All |`SELECT * FROM table_name`
    * Column |`SELECT column1 FROM table_name`
    * By column |`SELECT column1 FROM table_name WHERE column2 = value`
* Update
    * Column |`UPDATE table_name SET column1 = value1`
    * By column |`UPDATE table_name SET column1 = value1 WHERE column2 = value`
* Delete
    * By column |`DELETE FROM table_name WHERE column2 = value`

## Features:
### Supported Datatypes:
* String
* Number

### Key Points:
* PK validation in all operations (create, select, update, delete)
* Datatypes Validation
* Naming Conventions
* Existance: each database, table or a record is checked for existance before altering it
* No Dublication: in databases, tables or primary key values

## Author:
Zaur Gouliev


