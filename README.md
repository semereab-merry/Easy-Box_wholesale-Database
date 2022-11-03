# Easy-Box_wholesale-Database

## Description
Easy Box is a wholesale company that buys stock and sells them to customers. The company has established a database that maintains the details of stock id, name, quantity and price. It also maintains the details of buyers from which the manager has to buy a stock like a buyer id, name, address, email, and phone number, stock id to be bought, also details of customers name, address, id, email and phone number. The database includes the defaulters list of customers who have not paid their pending amount and list of payments that are not paid yet.  The database puts a stock in stock to buy list if quantity goes less than a particular amount. The database also calculates the profit for each month. For every purchase the quantity of stock is updated, and stock cannot be sold to a customer if the required amount is not present in stock. 

## Business Rules and ERD
* Business Rule 1 The company needs to record data about its Stock.
*	Business Rule 2 The company needs to record data about its Buyers.
*	Business Rule 3 The company needs to record data about its Customers.
*	Business Rule 4 The company needs to record data about Payment made.
*	Business Rule 5 The company needs to record data about the Customers who DO NOT PAY during purchase.
*	Business Rule 6 The company needs to record data about the Stock that are bought from Buyers.
*	Business Rule 7 The company needs to record data about the Payments that are not paid yet.

## ERD diagram 
<img width="1008" alt="image" src="https://user-images.githubusercontent.com/59441158/199797493-08f33ee7-bb97-4033-8ff6-49fcc30c07ea.png">

## Data Dictionary
<img width="1154" alt="image" src="https://user-images.githubusercontent.com/59441158/199797695-9bba024d-031a-4550-b59d-b5f8903b5fdf.png">

## Logical Relational Database Schema
<img width="685" alt="image" src="https://user-images.githubusercontent.com/59441158/199797859-ee92043c-32e2-4668-978a-f459c47d3c6e.png">

## Function, Procedure and Trigger 
#### Triggers 
This trigger is activated when a transaction is made, and the payment status is NP (no pay). After this trigger is pulled the record automatically inserted into the ‘CustomerNoPay’ table, a table which consists of customers who don’t pay their due, also to ‘NoPay’ table, a table which is list of payments that are not paid yet. This trigger was created before data insertion to ensure the integrity of the database. 
<img width="835" alt="image" src="https://user-images.githubusercontent.com/59441158/199798117-9d4f3516-1567-4a4c-8b62-203273dcfaa6.png">

This trigger is activated when a the stock quantity is below 40, it informs the user of the database to replace the inventory. 
<img width="1067" alt="image" src="https://user-images.githubusercontent.com/59441158/199798437-942670a6-f7aa-4073-9f9c-2f0dd6748dca.png">

#### Procedure 
This procedure is called purchase procedure. It is called whenever there is purchase in the system. It updates the stock quantity and insert the inputs into the payment table. However, the purchase procedure does not control if there is enough stock to purchase, so it must be controlled by a trigger, named before purchase. 
<img width="956" alt="image" src="https://user-images.githubusercontent.com/59441158/199798898-c6ee1ab9-6339-45e0-948a-e617a1e12b0f.png">

Since the previous procedure updates the table Stock, we have to control the stock quantity by creating a trigger that stops the transaction when there is no stock available to be sold.
<img width="916" alt="image" src="https://user-images.githubusercontent.com/59441158/199799012-bd3719d7-2232-4935-baa9-5b2e2c00ae8a.png">

#### Function 
For this function we have to create a view that has the list of dates and each transaction.
<img width="754" alt="image" src="https://user-images.githubusercontent.com/59441158/199799383-ee2a0da6-7cb5-4d1e-a8c1-925aeee03f83.png">

This function is used to calculate the profit of each month. To use this function the input must be in ‘MON-YYYY’ format, and the function first adds all the cost/ expenses of the month together and then adds all the selling of the same month together to calculate the final output, i.e., the total profit of the month. 
<img width="854" alt="image" src="https://user-images.githubusercontent.com/59441158/199799528-cc378f4d-9229-4904-8240-f23426470cc1.png">

## Schema With All Database Objects 
<img width="1067" alt="image" src="https://user-images.githubusercontent.com/59441158/199799610-7f708385-865f-432a-85e5-d3759c98a71a.png">
