## Researchbase 
### A tool to notify and manage scholars

#### How to install this application?
    1. Install node.js 
    2. Install postgresql, make sure postgresql is running on port 5432
    3. git clone https://github.com/tlynx538/researchbase
    4. cd researchbase/sql-dumps
    5. psql -f <the sql dump file name>
    6. cd .. 
    7. Rename sample.env to .env OR mv sample.env .env   
    7. npm install    
    7. npm run test // use this to actually run the application
    8. Go to http://localhost:8000 to view the application

### Current API routes:
##### GET Requests:
[```GET```] http://<localhost:8000>/api/v1/guides - Shows the list of guides

[```GET```] http://<localhost:8000>/api/v1/guides/type-any-number  - Shows a guide by id

Example: <br> 
http://<localhost:8000>/api/v1/guides/1 <br>
http://<localhost:8000>/api/v1/guides/2   
##### POST Requests:
[```POST```] http://<localhost:8000>/api/v1/guides  - Adds a guide 

##### DELETE Requests:
[```DELETE```] http://<localhost:8000>/api/v1/guides/type-any-number - Delete a guide by id
<br>

Example: <br> 
http://<localhost:8000>/api/v1/guides/1 <br>
http://<localhost:8000>/api/v1/guides/2   

#### Note: Use Postman to interact with the API requests
#### Future Upgrades: The database connection will be done remotely. 
