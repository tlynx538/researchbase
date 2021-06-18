## Researchbase 
### A tool to notify and manage scholars

#### How to run this application
    1. Install node.js 
    2. Install postgresql, make sure postgresql is running on port 5432
    3. git clone https://github.com/tlynx538/researchbase
    4. cd researchbase/sql-dumps
    5. psql -f <the sql dump file name>
    6. cd .. 
    7. Rename sample.env to .env OR run mv sample.env .env   
    7. npm install    
    7. npm run test
    8. Go to http://localhost:8000 to view the application

### Current API routes:
##### GET Requests:
http://<localhost:8000>/api/v1/guides [```GET```] - Shows the list of guides

http://<localhost:8000>/api/v1/guides/<type-any-number> [```GET```] - Shows a guide by id

##### POST Requests:
http://<localhost:8000>/api/v1/guides [```POST```] - Adds a guide 

##### DELETE Requests:
http://<localhost:8000>/api/v1/guides/<type-any-number> [```DELETE```] - Delete a guide by id
#### Future Upgrades: The database connection will be done remotely. 
