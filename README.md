# Edudat

This was built for UF CIS4301 <br>
This application is connected to UF's CISE Oracle <br>

To connect, do the following:
## Download corresponding Oracle Instant Client files for Basic Client, SDK, and SQLPlus
http://www.oracle.com/technetwork/topics/linux-amd64-093390.html

## Make directory /opt/oracle
     cd /opt
     mkdir oracle

Unzip the downloaded files into /opt/oracle <br>
unzip /home/user/Downloads/instantclient-sql... <br>
unzip /home/user/Downloads/instantclient-sdk... <br>
unzip /home/user/Downloads/instantclient-basic… <br>
ln -s libclntsh.so.12.1 libclntsh.so <br>
ln -s libocci.so.12.1 libocci.so <br>

## Then inside /opt/oracle/instantclient...

## Run:
export ORACLE_HOME=$(pwd) <br>
export LD_LIBRARY_PATH=$(pwd) <br>

## Use the following gem:
https://github.com/rsim/oracle-enhanced 

## How to execute the SQL commands:
http://api.rubyonrails.org/classes/ActiveRecord/Result.html


## Finally, change database.yml to have

default: &default <br>
 adapter: oracle_enhanced <br>
 database: orcl <br>
 host: oracle.cise.ufl.edu <br>
 username: ? <br>
 password: ? <br>
 port: 1521 <br>

## Functionality
The following functionality is complete:

