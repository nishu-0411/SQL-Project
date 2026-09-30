CREATE DATABASE NTA_Travel_Agency;
USE NTA_Travel_Agency;

CREATE TABLE Customers(
    Customer_ID varchar(10) primary key,
    First_Name varchar(50) not null,
    Gender varchar(1),
    Email varchar(100) unique,
    Phone_No varchar(15) unique,
    Address varchar(255),
    Loyalty_Points int default 0,
    Created_At datetime default current_timestamp
);

CREATE TABLE Destination(
    Destination_ID varchar(10) primary key,
    Destination_Name varchar(100) not null,
    Country varchar(50),
    D_Description varchar(500),
    Rating decimal(3,2) default 0.00
);

CREATE TABLE Hotels(
    Hotel_ID varchar(10) primary key,
    Destination_ID varchar(10),
    Hotel_Name varchar(100) not null,
    Star_Rating int,
    Contact_Number varchar(15),
    foreign key (Destination_ID) references Destination(Destination_ID)
);

CREATE TABLE Transport(
    Transport_ID varchar(10) primary key,
    T_Mode enum('Flight','Train','Bus','Car') default 'Flight',
    T_Company varchar(100),
    Capacity int,
    Transport_Contact_Number varchar(15)
);

CREATE TABLE Packages(
    Package_ID varchar(10) primary key,
    Destination_ID varchar(10),
    Hotel_ID varchar(10),
    Transport_ID varchar(10),
    Package_Name varchar(100) not null unique,
    Duration_Days int,
    Price decimal(10,2),
    Package_Type varchar(50) default 'Family',
    foreign key (Destination_ID) references Destination(Destination_ID),
    foreign key (Hotel_ID) references Hotels(Hotel_ID),
    foreign key (Transport_ID) references Transport(Transport_ID)
);

CREATE TABLE Bookings(
    Booking_ID varchar(10) primary key,
    Customer_ID varchar(10),
    Package_ID varchar(10),
    Booking_Date date,
    Travel_Date date,
    Total_Amount decimal(10,2),
    Booking_Status enum('pending','confirmed','cancelled','completed') default 'pending',
    Booking_Channel enum('online','in_person') default 'online',
    foreign key (Customer_ID) references Customers(Customer_ID),
    foreign key (Package_ID) references Packages(Package_ID)
);

CREATE TABLE Payments(
    Payment_ID varchar(10) primary key,
    Booking_ID varchar(10),
    Payment_Date date,
    Payment_Amount decimal(10,2),
    Payment_Method enum('Cash','Card','UPI','Netbanking') default 'UPI',
    Payment_Status enum('Success','Failed','Refunded') default 'Success',
    foreign key (Booking_ID) references Bookings(Booking_ID)
);

CREATE TABLE Feedback(
    Feedback_ID varchar(10) primary key,
    Customer_ID varchar(10),
    Package_ID varchar(10),
    Rating int,
    Comments text,
    Feedback_Date datetime,
    foreign key (Customer_ID) references Customers(Customer_ID),
    foreign key (Package_ID) references Packages(Package_ID)
);

CREATE TABLE Employees(
    Emp_ID varchar(10) primary key,
    Emp_Name varchar(100) not null,
    Emp_Role enum('admin','agent','guide') default 'agent',
    Emp_Email varchar(100) unique,
    Emp_Phone varchar(15) unique,
    Emp_Hire_Date date
);

CREATE TABLE Countries(
    Country_ID varchar(10) primary key,
    Country_Name varchar(50) unique,
    Continent varchar(50)
);

CREATE TABLE Room_Types(
    RoomType_ID varchar(10) primary key,
    Type_Name varchar(50),
    Price_Per_Night decimal(10,2)
);

CREATE TABLE Offers(
    Offer_ID varchar(10) primary key,
    Package_ID varchar(10),
    Discount_Percent decimal(5,2),
    Valid_Till date,
    foreign key (Package_ID) references Packages(Package_ID)
);

CREATE TABLE Guides(
    Guide_ID varchar(10) primary key,
    Destination_ID varchar(10),
    Guide_Name varchar(100),
    Language varchar(50),
    Experience_Years int,
    foreign key (Destination_ID) references Destination(Destination_ID)
);

CREATE TABLE Travel_Insurance(
    Insurance_ID varchar(10) primary key,
    Booking_ID varchar(10),
    Insurance_Provider varchar(100),
    Policy_Number varchar(50),
    Coverage_Amount decimal(10,2),
    Valid_Till date,
    foreign key (Booking_ID) references Bookings(Booking_ID)
);

CREATE TABLE Tour_Schedules(
    Schedule_ID varchar(10) primary key,
    Package_ID varchar(10),
    Day_Number int,
    Activity_Description varchar(255),
    Start_Time time,
    End_Time time,
    foreign key (Package_ID) references Packages(Package_ID)
);

USE NTA_Travel_Agency;

SET GLOBAL local_infile = 1;

SET FOREIGN_KEY_CHECKS = 0;

LOAD DATA LOCAL INFILE 'C:/Users/Nisarg_0411/Desktop/CODES/SQL/Countries.csv'
INTO TABLE Countries
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Nisarg_0411/Desktop/CODES/SQL/Destination.csv'
INTO TABLE Destination
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Nisarg_0411/Desktop/CODES/SQL/Customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Nisarg_0411/Desktop/CODES/SQL/Employees.csv'
INTO TABLE Employees
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Nisarg_0411/Desktop/CODES/SQL/Room_Types.csv'
INTO TABLE Room_Types
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Nisarg_0411/Desktop/CODES/SQL/Hotels.csv'
INTO TABLE Hotels
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Nisarg_0411/Desktop/CODES/SQL/Transport.csv'
INTO TABLE Transport
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Nisarg_0411/Desktop/CODES/SQL/Packages.csv'
INTO TABLE Packages
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Nisarg_0411/Desktop/CODES/SQL/Bookings.csv'
INTO TABLE Bookings
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Nisarg_0411/Desktop/CODES/SQL/Payments.csv'
INTO TABLE Payments
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Nisarg_0411/Desktop/CODES/SQL/Offers.csv'
INTO TABLE Offers
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Nisarg_0411/Desktop/CODES/SQL/Guides.csv'
INTO TABLE Guides
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Nisarg_0411/Desktop/CODES/SQL/Travel_Insurance.csv'
INTO TABLE Travel_Insurance
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Nisarg_0411/Desktop/CODES/SQL/Feedback.csv'
INTO TABLE Feedback
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Nisarg_0411/Desktop/CODES/SQL/Tour_Schedules.csv'
INTO TABLE Tour_Schedules
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;


SET FOREIGN_KEY_CHECKS = 1;

SELECT * FROM Customers;
SELECT * FROM Destination;
SELECT * FROM Hotels;
SELECT * FROM Transport;
SELECT * FROM Packages;
SELECT * FROM Bookings;
SELECT * FROM Payments;
SELECT * FROM Feedback;
SELECT * FROM Employees;
SELECT * FROM Countries;
SELECT * FROM Room_Types;
SELECT * FROM Offers;
SELECT * FROM Guides;
SELECT * FROM Travel_Insurance;
SELECT * FROM Tour_Schedules;

insert into customers (customer_id, first_name, gender, email, phone_no, address, loyalty_points) 
values ('C900001','alex','m','alex.smith900001@gmail.com','+91-987-654-32','12 main st, india',0);   -- add new customer 

update customers 
set email = 'alex.updated900001@gmail.com', phone_no = '+91-999-888-77' 
where customer_id = 'C900001';           -- update existing customer info 

-- delete from customers 
-- where customer_id = 'C900001';            delete customer if needed 

-- employee insert/update/delete
insert into employees (emp_id, emp_name, emp_role, emp_email, emp_phone, emp_hire_date) 
values ('E0091','mike brown','agent','mikebrown91@gmail.com','+91-987-111-2222','2023-08-01'); -- add new employee

update employees set emp_role = 'admin' where emp_id = 'E0091'; -- promote to admin

-- delete from employees where emp_id = 'E0091'; -- remove employee record

-- Full booking
select b.booking_id, b.booking_date, b.travel_date, c.first_name, p.package_name, b.total_amount, b.booking_status, pa.payment_status
from bookings b
join customers c on b.customer_id = c.customer_id
join packages p on b.package_id = p.package_id
left join payments pa on b.booking_id = pa.booking_id; 

select customer_id, first_name, email, loyalty_points
from customers
where loyalty_points > 1000
order by loyalty_points desc; -- most loyal customers

select destination_id, destination_name, country, rating
from destination
order by rating desc
limit 10; -- top 10 popular destinations


select d.destination_id, d.destination_name, d.country, sum(b.total_amount) as total_revenue
from bookings b
join packages p on b.package_id = p.package_id
join destination d on p.destination_id = d.destination_id
where b.booking_status in ('confirmed','completed')
group by d.destination_id, d.destination_name, d.country
order by total_revenue desc; -- destinations bringing most revenue


select o.offer_id, o.package_id, p.package_name, p.price as original_price, o.discount_percent, 
round(p.price * (1 - o.discount_percent/100),2) as discounted_price, o.valid_till
from offers o
join packages p on o.package_id = p.package_id
where o.valid_till >= curdate()
order by o.valid_till asc; -- currently valid offers


select b.booking_id, c.first_name, p.package_name, b.travel_date, b.booking_status
from bookings b
join customers c on b.customer_id = c.customer_id
join packages p on b.package_id = p.package_id
where b.travel_date between curdate() and date_add(curdate(), interval 30 day)
order by b.travel_date; -- upcoming tours soon


select ts.schedule_id, ts.package_id, p.package_name, ts.day_number, ts.activity_description, 
b.travel_date, date_add(b.travel_date, interval ts.day_number - 1 day) as activity_date
from tour_schedules ts
join packages p on ts.package_id = p.package_id
join bookings b on b.package_id = p.package_id
where b.travel_date between curdate() and date_add(curdate(), interval 30 day)
and b.booking_status in ('confirmed','completed')
order by activity_date, ts.package_id; -- tour plan day-by-day

start transaction;
insert into bookings (booking_id, customer_id, package_id, booking_date, travel_date, total_amount, booking_status, booking_channel) 
values ('B2000001','C000001','P000100','2025-11-09','2026-02-10','1200.00','confirmed','online');
insert into payments (payment_id, booking_id, payment_date, payment_amount, payment_method, payment_status)
values ('PY2000001','B2000001','2025-11-09','1200.00','Card','Success');
commit; -- ensures both booking and payment go together


-- delete from offers where valid_till < curdate();
-- delete from bookings where booking_status = 'cancelled' and booking_date < date_sub(curdate(), interval 60 day); -- delete old offers or cancelled booking

select year(b.booking_date) as year, month(b.booking_date) as month, 
count(*) as total_bookings, 
sum(case when pa.payment_status='Success' then pa.payment_amount else 0 end) as total_revenue
from bookings b
left join payments pa on b.booking_id = pa.booking_id
where b.booking_status in ('confirmed','completed')
group by year(b.booking_date), month(b.booking_date)
order by year, month; -- monthly rev stats

select payment_method, count(*) as count, sum(payment_amount) as total
from payments
where payment_date >= date_sub(curdate(), interval 12 month) and payment_status = 'Success'
group by payment_method
order by total desc; -- see most used payment mode


select c.customer_id, c.first_name, c.email
from customers c
left join bookings b on c.customer_id = b.customer_id
where b.booking_id is null;  -- customers who never booked


select p.package_id, p.package_name, round(avg(f.rating),2) as avg_rating, count(f.feedback_id) as feedback_count
from packages p
left join feedback f on p.package_id = f.package_id
group by p.package_id, p.package_name
having feedback_count >= 5
order by avg_rating desc; -- top rated packages


select guide_id, guide_name, destination_id, experience_years
from guides
order by experience_years desc
limit 5; -- most experienced tour guides


select c.customer_id, c.first_name, count(b.booking_id) as bookings_count, sum(b.total_amount) as total_spent
from customers c
join bookings b on c.customer_id = b.customer_id
where b.booking_status in ('confirmed','completed')
group by c.customer_id, c.first_name
having bookings_count > 1 -- more than 1 booking
order by total_spent desc; -- spend

select t.transport_id, t.t_company, t.t_mode, t.capacity, count(b.booking_id) as used_capacity
from transport t
join packages p on t.transport_id = p.transport_id
join bookings b on p.package_id = b.package_id
where b.booking_status in ('confirmed','completed')
group by t.transport_id, t.t_company, t.t_mode, t.capacity
having used_capacity >= t.capacity; -- check overbooked transport


select b.booking_id, b.total_amount, coalesce(sum(pa.payment_amount),0) as paid_sum
from bookings b
left join payments pa on b.booking_id = pa.booking_id
group by b.booking_id, b.total_amount
having round(b.total_amount,2) != round(coalesce(sum(pa.payment_amount),0),2); -- find mismatches

-- monthly revenue summary table creation
create table monthly_revenue_summary (
  year int,
  month int,
  bookings_count int,
  total_collected decimal(15,2),
  primary key (year, month)
);

-- insert into monthly_revenue_summary (year, month, bookings_count, total_collected)
-- select year(b.booking_date), month(b.booking_date), count(distinct b.booking_id), 
-- sum(case when pa.payment_status='Success' then pa.payment_amount else 0 end)
-- from bookings b
-- left join payments pa on b.booking_id = pa.booking_id
-- where b.booking_status in ('confirmed','completed')
-- group by year(b.booking_date), month(b.booking_date);