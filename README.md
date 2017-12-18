# Financial stock Check

 - You can calculate the stock generated for an stock symbol in a time range.
 - By informing a date(2017-11-12) and a stock symbol('AAPL').
 - All of ours prices are base on https://www.quandl.com/databases/WIKIP

 ### How to use
  - First you should install docker, instructions here(https://docs.docker.com/manuals/), it is really simple to install.
  - Then clone the project to your computer.
  - Enter on the project directory using a command line applications such as `bash`.
  - Run the follow command: `docker-compose build .`
  - Now you can start to use the application

### Using the application
- To start run the follow two commands:
 - First `docker-compose run web bash` 
 - Then `rake check_stock_return:list_symbols`
- The application will request some inputs for you, just follow the instructions.


### Get support

- To get support or inform some problem contact me via email or open an issue.
email: mandakeru@gmail.com
