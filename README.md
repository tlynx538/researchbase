## Researchbase 
### A tool to notify and manage scholars

#### How to run this application
    1. Install node.js 
    2. Install postgresql
    3. git clone https://github.com/tlynx538/researchbase
    4. cd researchbase/
    5. execute the sql dump present in the sql_dump folder using psql.
        To do this type psql -f <the sql dump file name>
    6. Change the db user and password in .env file
        The .env file used is shown below
    7. npm run test
    8. Go to http://localhost:8000 to view the application


#### Sample .env file 
``` 
                PORT=8090;
                PGHOST='localhost'
                PGUSER=postgres
                PGDATABASE=rbdb
                PGPASSWORD=postgres
                PGPORT=5432
```  
#### Future Upgrades: The database connection will be done remotely. 
