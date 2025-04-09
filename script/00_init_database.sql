/*
-------------------------------------------------------------
Create Database and Schemas
-------------------------------------------------------------
Script Purpose:
    This script creates a new database named 'ProjectsAnalytics2'. Additionally, this script creates a schema called E_Commerce
*/

--- Create the 'ProjectsAnalytics2' database ---

CREATE DATABASE ProjectsAnalytics2

--- Create Schema ---

CREATE SCHEMA E_Commerce

CREATE TABLE details(
	Order_ID varchar (100) ,
	Amount integer ,
	Profit integer ,
	Quantity integer ,
	Category varchar (100) ,
	Sub_category varchar (100) ,
	Payment_mode varchar (100)
);

CREATE TABLE orders(
	Order_ID varchar (100) ,
	Order_date date ,
	Customer_name varchar (100) ,
	State varchar (100) ,
	City varchar (100) 
);


BEGIN;
LOCK TABLE details IN EXCLUSIVE MODE;
COPY details FROM 'C:/temp/contoso/details.csv'
WITH CSV HEADER;
COMMIT;

BEGIN;
LOCK TABLE orders IN EXCLUSIVE MODE;
COPY orders FROM 'C:/temp/contoso/orders.csv'
WITH CSV HEADER;
COMMIT;

ROLLBACK; --- USE ROLLBACK WHEN INPUT 'BEGIN ... COMMIT' IS failed AND find OUT the mistake, this query ONLY FOR rollback EXECUTE SQL query ---