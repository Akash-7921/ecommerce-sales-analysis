CREATE DATABASE IF NOT EXISTS onlinestore;
USE onlinestore;

CREATE TABLE customer (
  cust_id VARCHAR(5) PRIMARY KEY, f_name VARCHAR(50), l_name VARCHAR(50),
  area VARCHAR(30), phone_no VARCHAR(10)
);
CREATE TABLE category (
  category_id VARCHAR(5) PRIMARY KEY, category_name VARCHAR(30)
);
CREATE TABLE product (
  product_id VARCHAR(5) PRIMARY KEY, product_name VARCHAR(50),
  category_id VARCHAR(5), price DECIMAL(8,2), stock INT,
  FOREIGN KEY (category_id) REFERENCES category(category_id)
);
CREATE TABLE orders (
  order_id VARCHAR(5) PRIMARY KEY, cust_id VARCHAR(5), order_date DATE,
  total_amount DECIMAL(10,2), FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
);
CREATE TABLE order_items (
  order_item_id INT AUTO_INCREMENT PRIMARY KEY, order_id VARCHAR(5),
  product_id VARCHAR(5), quantity INT, price DECIMAL(8,2),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES product(product_id)
);
CREATE TABLE invoice (
  inv_no VARCHAR(5) PRIMARY KEY, order_id VARCHAR(5), inv_date DATE,
  amount DECIMAL(10,2), FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
CREATE TABLE payment (
  payment_id VARCHAR(5) PRIMARY KEY, inv_no VARCHAR(5), payment_date DATE,
  payment_mode VARCHAR(20), payment_status VARCHAR(15),
  FOREIGN KEY (inv_no) REFERENCES invoice(inv_no)
);

INSERT INTO category VALUES
('CAT01','Mobiles'),('CAT02','Laptops'),('CAT03','Fashion'),
('CAT04','Books'),('CAT05','Furniture'),('CAT06','Sports');
INSERT INTO customer VALUES
('CUS11','Arjun','Malhotra','Pune','9811111111'),
('CUS12','Kavya','Reddy','Mumbai','9822222222'),
('CUS13','Sahil','Mishra','Delhi','9833333333'),
('CUS14','Isha','Kapoor','Pune','9844444444'),
('CUS15','Manish','Yadav','Nagpur','9855555555'),
('CUS16','Riya','Sharma','Nashik','9866666666'),
('CUS17','Aditya','Patil','Mumbai','9877777777'),
('CUS18','Simran','Kaur','Delhi','9888888888'),
('CUS19','Varun','Joshi','Pune','9899999999'),
('CUS20','Meera','Nair','Thane','9800000000');
INSERT INTO product VALUES
('PRD11','Samsung Galaxy S25','CAT01',74999,25),
('PRD12','OnePlus 13','CAT01',64999,30),
('PRD13','HP Pavilion 15','CAT02',68999,15),
('PRD14','Dell Inspiron 14','CAT02',57999,20),
('PRD15','Formal Shirt','CAT03',1499,75),
('PRD16','Running Shoes','CAT03',2999,50),
('PRD17','Data Analytics Book','CAT04',899,40),
('PRD18','Computer Networks Book','CAT04',699,35),
('PRD19','Study Table','CAT05',5999,12),
('PRD20','Football','CAT06',1299,45);
INSERT INTO orders VALUES
('ORD11','CUS11','2026-10-01',74999),('ORD12','CUS12','2026-10-02',2999),
('ORD13','CUS13','2026-10-03',68999),('ORD14','CUS14','2026-10-04',2398),
('ORD15','CUS15','2026-10-05',5999),('ORD16','CUS16','2026-10-06',64999),
('ORD17','CUS17','2026-10-07',1997),('ORD18','CUS18','2026-10-08',1299),
('ORD19','CUS19','2026-10-09',7498),('ORD20','CUS20','2026-10-10',2999);
INSERT INTO order_items (order_id,product_id,quantity,price) VALUES
('ORD11','PRD11',1,74999),('ORD12','PRD16',1,2999),('ORD13','PRD13',1,68999),
('ORD14','PRD15',1,1499),('ORD14','PRD18',1,699),('ORD14','PRD17',1,200),
('ORD15','PRD19',1,5999),('ORD16','PRD12',1,64999),('ORD17','PRD17',1,899),
('ORD17','PRD18',1,699),('ORD17','PRD15',1,399),('ORD18','PRD20',1,1299),
('ORD19','PRD19',1,5999),('ORD19','PRD20',1,1299),('ORD19','PRD15',1,200),
('ORD20','PRD16',1,2999);
INSERT INTO invoice VALUES
('INV11','ORD11','2026-10-01',74999),('INV12','ORD12','2026-10-02',2999),
('INV13','ORD13','2026-10-03',68999),('INV14','ORD14','2026-10-04',2398),
('INV15','ORD15','2026-10-05',5999),('INV16','ORD16','2026-10-06',64999),
('INV17','ORD17','2026-10-07',1997),('INV18','ORD18','2026-10-08',1299),
('INV19','ORD19','2026-10-09',7498),('INV20','ORD20','2026-10-10',2999);
INSERT INTO payment VALUES
('PAY11','INV11','2026-10-01','UPI','Paid'),('PAY12','INV12','2026-10-02','Credit Card','Paid'),
('PAY13','INV13','2026-10-03','Debit Card','Paid'),('PAY14','INV14','2026-10-04','UPI','Paid'),
('PAY15','INV15','2026-10-05','Cash','Paid'),('PAY16','INV16','2026-10-06','Credit Card','Paid'),
('PAY17','INV17','2026-10-07','UPI','Pending'),('PAY18','INV18','2026-10-08','Cash','Paid'),
('PAY19','INV19','2026-10-09','Debit Card','Pending'),('PAY20','INV20','2026-10-10','UPI','Paid');

-- Basic verification queries
SELECT * FROM category;
SELECT * FROM customer;
SELECT * FROM product;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM invoice;
SELECT * FROM payment;
