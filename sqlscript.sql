## Creating tables 
CREATE TABLE Stock (   
    stock_id varchar2(5) not null,   
    stock_name varchar2(10),   
    stock_price number not null,   
    stock_quantity number not null,  
    CONSTRAINT StockPK PRIMARY KEY (stock_id)  
) ;

CREATE TABLE Buyer (   
    buyer_id varchar2(5) not null,   
    buyer_fname varchar2(10) not null,   
    buyer_lname varchar2(10) not null,   
    buyer_email varchar2(20),   
    buyer_address varchar2(10) not null,   
    buyer_pnum number not null,   
    CONSTRAINT BuyerPK PRIMARY KEY (buyer_id)   
) ;

CREATE TABLE StockToBuy (    
    buy_quantity number not null,    
    buy_date date not null,  
    buy_price number not null, 
    stock_id varchar2(5) not null,  
    buyer_id varchar2(5) not null,   
    CONSTRAINT stocktobuyFK1 FOREIGN KEY (stock_id) REFERENCES Stock(stock_id),  
    CONSTRAINT stocktobuyFk2 FOREIGN KEY (buyer_id) REFERENCES Buyer(buyer_id)   
) ;

CREATE TABLE Customer (   
    customer_id varchar2(5) not null,   
    customer_fname varchar2(10) not null,   
    customer_lname varchar2(10) not null,   
    customer_email varchar2(20),   
    customer_address varchar2(10) not null,   
    customer_pnum number not null,    
    CONSTRAINT customerPK PRIMARY KEY (customer_id)   
) ;

CREATE TABLE Payment (    
    pay_id varchar2(5) not null,    
    pay_price number not null,    
pay_quantity number not null, 
    pay_cardnum varchar2(16) not null,    
    pay_state varchar2(2) not null,    
    pay_date date not null,  
    stock_id varchar2(5) not null,   
    customer_id varchar2(5) not null,   
    CONSTRAINT PayPK PRIMARY KEY (pay_id),    
    FOREIGN KEY (stock_id) REFERENCES Stock(stock_id),    
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)   
) ;

CREATE TABLE CustomerNoPay (   
    due number not null,   
    expire_time date not null,  
    pay_id varchar2(5) not null,  
    customer_id varchar2(5) not null,  
    CONSTRAINT NpayFK1 FOREIGN KEY (pay_id) REFERENCES Payment(pay_id),   
    CONSTRAINT NpayFk2 FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)   
) ;

 CREATE TABLE NoPay (      
    pay_id varchar2(5) not null,   
    pay_state varchar2(2) not null,       
    CONSTRAINT NopayFK1 FOREIGN KEY (pay_id) REFERENCES Payment(pay_id)     
) ;

CREATE or replace TABLE StockToBuy (     
    buy_quantity number not null,     
    buy_date date not null,   
    buy_price number not null,  
    stock_id varchar2(5) not null,   
    buyer_id varchar2(5) not null,    
    CONSTRAINT stocktobuyFK1 FOREIGN KEY (stock_id) REFERENCES Stock(stock_id),   
    CONSTRAINT stocktobuyFk2 FOREIGN KEY (buyer_id) REFERENCES Buyer(buyer_id)    
) ;


# We are creating procedures and triggers before data insertion in order to maintain the integrity of data 

## First trigger with the table Payment 
CREATE OR REPLACE TRIGGER no_pay  
AFTER INSERT ON PAYMENT  
FOR each row  
When (new.pay_state= 'NP')  
BEGIN  
    Insert into CustomerNoPay 
    values (:new.pay_price, ADD_MONTHS(:new.pay_date, 3), :new.pay_id, :new.customer_id);  
    Insert into NoPay 
    values (:new.pay_id, :new.pay_state);  
    DBMS_OUTPUT.PUT_LINE ('customer did not pay: added to no pay table');  
END; 
/

## First Procedure that saves the value to Payment table 
CREATE OR REPLACE procedure PURCHASE (pay in VARCHAR2, price IN NUMBER, quan in NUMBER, card in VARCHAR2, state in VARCHAR2,  stock IN VARCHAR2, cust IN VARCHAR2)   
AS   
  
BEGIN   
    UPDATE Stock SET stock_quantity=stock_quantity - quan WHERE stock_id=stock;  
    INSERT INTO Payment values (pay, price, quan, card, state, sysdate, stock, cust);    
END; 
/

## Data Insertion 
### Stock table 

INSERT INTO STOCK VALUES ('S1020', 'aaaa', 4500, 100);
INSERT INTO STOCK VALUES ('S1004', 'bbbb', 1000, 300);
INSERT INTO STOCK VALUES ('S3005', 'cccc', 4000, 250);
INSERT INTO STOCK VALUES ('S1010', 'dddd', 5000, 150);
INSERT INTO STOCK VALUES ('S6005', 'eeee', 1000, 400);
INSERT INTO STOCK VALUES ('S7001', 'ffff', 100, 200);
INSERT INTO STOCK VALUES ('S2014', 'gggg', 4000, 250);
INSERT INTO STOCK VALUES ('S5023', 'hhhh', 1000, 300);
INSERT INTO STOCK VALUES ('S2010', 'iiii', 3600, 100);
INSERT INTO STOCK VALUES ('S2007', 'jjjj', 2000, 400);

SELECT * FROM STOCK;

## Data Insertion 
### Buyer table 

INSERT INTO Buyer VALUES ('B2300', 'John', 'Beck', 'beckJ21@gmail.com', 'Dubai', 0545151678);
INSERT INTO Buyer VALUES ('B4008', 'Arthur', 'Luke', 'arthur@gmail.com', 'Abu Dhabi', 0545678976);
INSERT INTO Buyer VALUES ('B6020', 'Lily', 'Morphy', 'lilMe@gmail.com', 'Shurjah', 0545123456);
INSERT INTO Buyer VALUES ('B1001', 'Ellen', 'Daniel', 'ellenDan34@gmail.com', 'Fujairah', 0545673451);
INSERT INTO Buyer VALUES ('B3009', 'Eden', 'John', 'edenJ@gmail.com', 'AlAin', 0545789101);
INSERT INTO Buyer VALUES ('B2040', 'Mark', 'Ziller', 'mZiller@gmail.com', 'Ajman', 0545234578);
INSERT INTO Buyer VALUES ('B7080', 'Elinor', 'Matthew', 'eliMat2@gmail.com', 'Abu Dhabi', 0545670987);
INSERT INTO Buyer VALUES ('B9000', 'Rose', 'Lowell', 'roselin@gmail.com', 'Dubai', 0545654321);
INSERT INTO Buyer VALUES ('B5600', 'Kosta', 'Sammer', 'kostame89@gmail.com', 'Fujairah', 0545697535);
INSERT INTO Buyer VALUES ('B2100', 'Adrian', 'Napoleon', 'adiNap5@gmail.com', 'AlAin', 0545789200);

SELECT * FROM BUYER;

## Data Insertion 
### Customer table 

INSERT INTO Customer VALUES ( 'C1002', 'Maqsood', 'Vasko', 'maqsudV@gmail.com', 'Abu Dhabi', 0546798345);
INSERT INTO Customer VALUES ( 'C3030', 'Aelita ', 'Josefin', 'aJose@gmail.com', 'Dubai', 0543465987);
INSERT INTO Customer VALUES ( 'C2057', 'Adolf ' , 'Christos', 'aldchris@gmail.com', 'AlAin', 0546750628);
INSERT INTO Customer VALUES ( 'C4065', 'Asal' , 'Rein', 'asliRain@gmail.com', 'Fujairah', 05467505152);
INSERT INTO Customer VALUES ( 'C5023', 'Ryann ' , 'Lowell', 'ririL23@gmail.com', 'Dubai', 05467506162);
INSERT INTO Customer VALUES ( 'C5602', 'Pascal', 'Eziz', 'mepascal@gmail.com', 'Dubai', 054674567);
INSERT INTO Customer VALUES ( 'C2000', 'Anna ', 'Josh', 'annJosh@gmail.com', 'Ajman', 0543098765);
INSERT INTO Customer VALUES ( 'C8098', 'Abdulla' , 'Modred', 'abdullaMod@gmail.com', 'Abu Dhabi', 054579307);
INSERT INTO Customer VALUES ( 'C7654', 'Frea' , 'Acke', 'frealove@gmail.com', 'Fujairah', 0546738746);
INSERT INTO Customer VALUES ( 'C6090', 'Ilias ' , 'Eddy', 'iliiEd7@gmail.com', 'AlAin', 05467224765);

SELECT * FROM CUSTOMER;

## Data Insertion 
### Stock table 

## change the datetime format
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY' 
INSERT INTO PAYMENT VALUES ('P9001', 5000, 3, '0923346543212345', 'NP', '09/JUL/2021', 'S7001', 'C5602'); 
INSERT INTO PAYMENT VALUES ('P6700', 200, 3, '6723890987654321', 'P', '30/OCT/2021', 'S6005', 'C5023');
INSERT INTO PAYMENT VALUES ('P8009', 1500, 1, '8935687654321345', 'P', '25/JUN/2021', 'S1010', 'C4065'); 
INSERT INTO PAYMENT VALUES ('P9001', 5000, 3, '0923346543212345', 'NP', '09/JUL/2021', 'S7001', 'C5602');
INSERT INTO PAYMENT VALUES ('P6700', 200, 3, '6723890987654321', 'P', '30/OCT/2021', 'S6005', 'C5023');
INSERT INTO PAYMENT VALUES ('P8009', 1500, 1, '8935687654321345', 'P', '25/JUN/2021', 'S1010', 'C4065');

SELECT * FROM PAYMENT;

/* Since we previously created a trigger that adds not paid purchases to 2 tables, the records with payment status of no payment are transferred into list of NOPAY and CustomerNoPay, 2 tables that stores the data of unpaid transactions. */

# check if trigger no_pay works
SELECT * FROM CUSTOMERNOPAY;
SELECT * FROM NOPAY;

## Data Insertion 
### Stock table 

INSERT INTO STOCKTOBUY VALUES ( 1, '20/JUL/2021', 2000, 'S2007', 'B2300');
INSERT INTO STOCKTOBUY VALUES (2, '18/MAR/2021', 7200,  'S2010', 'B4008');
INSERT INTO STOCKTOBUY VALUES (4, '04/JUN/2021', 4000,  'S5023', 'B6020');
INSERT INTO STOCKTOBUY VALUES (4, '12/MAR/2021', 12000,  'S2014', 'B1001');
INSERT INTO STOCKTOBUY VALUES (5, '09/JAN/2021', 500,  'S7001', 'B3009');
INSERT INTO STOCKTOBUY VALUES (2, '25/FEB/2021', 10000,  'S1010', 'B2040');
INSERT INTO STOCKTOBUY VALUES (3, '30/APR/2021', 3000,  'S6005', 'B7080');
INSERT INTO STOCKTOBUY VALUES (3, '09/AUG/2021', 5000,  'S7001', 'B9000');
INSERT INTO STOCKTOBUY VALUES (3, '30/JUN/2021', 200,  'S6005', 'B5600');
INSERT INTO STOCKTOBUY VALUES (1, '25/NOV/2021', 1500,  'S1010', 'B2100');

SELECT * FROM STOCKTOBUY;


## Creating function that calculates the profit of the month given by the user 
### first we create the 
CREATE VIEW PROFIT_LEGEND AS	 
    SELECT 	P.PAY_PRICE*P.PAY_QUANTITY AS SELL, P.PAY_DATE, S.BUY_DATE, S.BUY_QUANTITY*BUY_PRICE AS COST  
    FROM	PAYMENT P,   STOCKTOBUY S 
    WHERE P.PAY_DATE = S.BUY_DATE(+)


CREATE OR REPLACE Function Profit(p_month IN VARCHAR2)   
    RETURN NUMBER   
IS   
    total_profit NUMBER;   
    total_cost NUMBER;  
    total_sell NUMBER;  
    cursor cost_m is   
        SELECT cost FROM PROFIT_LEGEND WHERE TO_CHAR(buy_date, 'MON-YYYY') = p_month;   
    cursor sell_m is   
        SELECT sell FROM PROFIT_LEGEND WHERE TO_CHAR(pay_date, 'MON-YYYY') = p_month;  
BEGIN   
    total_profit := 0;   
    total_cost := 0;  
    total_sell := 0;  
      
    FOR cloop in cost_m   
    LOOP   
        total_cost := total_cost + cloop.costp;   
    END LOOP;   
    FOR sloop in sell_m   
    LOOP   
        total_sell := total_sell + sloop.sellp;   
    END LOOP;   
    total_profit:= total_sell - total_cost;   
    RETURN total_profit;  
END;  
/ 

## creating a trigger that checks the inventory and sends a message when it is below 40 
CREATE OR REPLACE TRIGGER REPLACE_STOCK   
AFTER UPDATE OF STOCK_QUANTITY ON STOCK   
FOR each row   
 
BEGIN   
    IF  :NEW.STOCK_QUANTITY < 40 THEN  
        DBMS_OUTPUT.PUT_LINE ('Stock is below the optimum point, please replace');   
    END IF; 
END;  
/ 