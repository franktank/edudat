# Edudat

This was built for UF CIS4301
This application is connected to UF's CISE Oracle

To connect, do the following:
## Download corresponding Oracle Instant Client files for Basic Client, SDK, and SQLPlus
http://www.oracle.com/technetwork/topics/linux-amd64-093390.html

## Make directory /opt/oracle
     cd /opt
     mkdir oracle

Unzip the downloaded files into /opt/oracle
unzip /home/user/Downloads/instantclient-sql...
unzip /home/user/Downloads/instantclient-sdk...
unzip /home/user/Downloads/instantclient-basic…
ln -s libclntsh.so.12.1 libclntsh.so
ln -s libocci.so.12.1 libocci.so

## Then inside /opt/oracle/instantclient...

## Run:
export ORACLE_HOME=$(pwd)
export LD_LIBRARY_PATH=$(pwd)

## Use the following gem:
https://github.com/rsim/oracle-enhanced 

## How to execute the SQL commands:
http://api.rubyonrails.org/classes/ActiveRecord/Result.html


## Finally, change database.yml to have

default: &default
 adapter: oracle_enhanced
 database: orcl
 host: oracle.cise.ufl.edu
 username: ?
 password: ?
 port: 1521

## Functionality
The following functionality is complete:

