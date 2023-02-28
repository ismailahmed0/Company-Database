CREATE DATABASE ABC_Company;

CREATE TABLE Person (
  Personal_ID CHAR(9) NOT NULL,
  Fname VARCHAR(30) NOT NULL,
  Lname VARCHAR(30) NOT NULL,
  Age INT NOT NULL,
  Gender CHAR(1) NOT NULL, --1 character M/F
  Address_line1 VARCHAR(30) NOT NULL,
  Address_line2 VARCHAR(30) NOT NULL,
  State CHAR(2) NOT NULL, --2 characters: TX
  City VARCHAR(50) NOT NULL, -- longest town name in the US is 48 chars
  Zipcode VARCHAR(10) NOT NULL, --normal or full sized w/ dash
  Email_address VARCHAR(50) NOT NULL,
  PRIMARY KEY(Personal_ID),
  CHECK (Age < 65 AND AGE > 18)
);

CREATE TABLE Person_phone (
  Person_ID CHAR(9) NOT NULL,
  Phone_number VARCHAR(17) NOT NULL,
  PRIMARY KEY(Person_ID, Phone_number),
  FOREIGN KEY(Person_ID) REFERENCES Person(Personal_ID)
);

CREATE TABLE Employee (
  Employee_ID CHAR(9) NOT NULL,
  Title VARCHAR(15) NOT NULL,
  Emp_rank VARCHAR(9) NOT NULL,
  App_ID CHAR(9),
  Candidate_ID CHAR(9),
  Super_ssn VARCHAR(11), -- can include dashes, CEO may not have supervisor
  PRIMARY KEY(Employee_ID),
  FOREIGN KEY(Employee_ID) REFERENCES Person(Personal_ID),
  FOREIGN KEY(App_ID) REFERENCES Applicant(Applicant_ID),
  FOREIGN KEY(Candidate_ID) REFERENCES Candidate(Candidate_ID)
);

CREATE TABLE Monthly_salary (
  Transaction_number CHAR(9) NOT NULL,
  Employee_ID CHAR(9) NOT NULL,
  Amount DOUBLE(11, 2) NOT NULL, --11 for those who made XX billion, is 11 max or has to contain 11
  Pay_date DATETIME NOT NULL,
  PRIMARY KEY(Transaction_number, Employee_ID),
  FOREIGN KEY(Employee_ID) REFERENCES Employee(Employee_ID)
);

CREATE TABLE Potential_employee (
  Potential_empID CHAR(9) NOT NULL,
  App_ID CHAR(9),
  Candidate_ID CHAR(9),
  Applying_position VARCHAR(30) NOT NULL,
  PRIMARY KEY(Potential_empID),
  FOREIGN KEY(Potential_empID) REFERENCES Person(Personal_ID),
  FOREIGN KEY(App_ID) REFERENCES Applicant(Applicant_ID),
  FOREIGN KEY(Candidate_ID) REFERENCES Candidate(Candidate_ID)
);

CREATE TABLE Customer (
  Customer_ID CHAR(9) NOT NULL,
  Preferred_salesperson VARCHAR(30) NOT NULL,
  PRIMARY KEY(Customer_ID),
  FOREIGN KEY(Customer_ID) REFERENCES Person(Personal_ID)
);

CREATE TABLE Applicant (
  Applicant_ID CHAR(9) NOT NULL,
  Job_ID CHAR(9) NOT NULL,
  PRIMARY KEY(Applicant_ID),
  FOREIGN KEY(Job_ID) REFERENCES Job_position(Job_ID)
);

CREATE TABLE Candidate (
  Candidate_ID CHAR(9) NOT NULL,
  Applicant_ID CHAR(9) NOT NULL,
  PRIMARY KEY(Candidate_ID, Applicant_ID),
  FOREIGN KEY(Applicant_ID) REFERENCES Applicant(Applicant_ID)
);

CREATE TABLE Works_for (
  Emp_ID CHAR(9) NOT NULL,
  Dept_ID CHAR(9) NOT NULL,
  Shift_start DATETIME NOT NULL,
  Shift_end DATETIME NOT NULL,
  PRIMARY KEY(Emp_ID, Dept_ID),
  FOREIGN KEY(Emp_ID) REFERENCES Employee(Employee_ID),
  FOREIGN KEY(Dept_ID) REFERENCES Department(Dept_ID)
);

CREATE TABLE Interview (
  Interview_time DATETIME NOT NULL,
  Job_ID CHAR(9) NOT NULL,
  Interviewer_ID CHAR(9) NOT NULL,
  Candidate_ID CHAR(9) NOT NULL,
  Interview_grade INT NOT NULL,
  Interview_round_count CHAR(1) NOT NULL, --should be ‘1’, but not limiting if dept wants to speed hire
  Candidate VARCHAR(30) NOT NULL,
  PRIMARY KEY(Interview_time),
  FOREIGN KEY(Job_ID) REFERENCES Job_position(Job_ID),
  CHECK(Interview_grade >= 0 AND Interview_grade <= 100)
);

CREATE TABLE ApplyTo (
  Applicant_ID CHAR(9) NOT NULL,
  Job_ID CHAR(9) NOT NULL,
  PRIMARY KEY(Applicant_ID, Job_ID),
  FOREIGN KEY(Applicant_ID) REFERENCES Applicant(Applicant_ID),
  FOREIGN KEY(Job_ID) REFERENCES Job_position(Job_ID)
);

CREATE TABLE Undergoes (
  Candidate_ID CHAR(9) NOT NULL,
  Interview_times DATETIME NOT NULL,
  PRIMARY KEY(Candidate_ID, Interview_times)
  FOREIGN KEY(Candidate_ID) REFERENCES Candidate(Candidate_ID),
  FOREIGN KEY(Interview_times) REFERENCES Interview(Interview_times)
);

CREATE TABLE Works_on (
  Personal_ID CHAR(9) NOT NULL,
  Site_ID CHAR(9) NOT NULL,
  PRIMARY KEY(Personal_ID, Site_ID),
  FOREIGN KEY(Personal_ID) REFERENCES Person(Personal_ID),
  FOREIGN KEY(Site_ID) REFERENCES Marketing_Site(Site_ID)
);

CREATE TABLE Department (
  Dept_ID CHAR(9) NOT NULL,
  Dept_name VARCHAR(30) NOT NULL,
  PRIMARY KEY(Dept_ID)
);

CREATE TABLE Job_position (
  Job_ID CHAR(9) NOT NULL,
  Job_description VARCHAR(500) NOT NULL,
  Posted_date DATETIME NOT NULL,
  Dept_ID CHAR(9) NOT NULL,
  PRIMARY KEY(Job_ID),
  FOREIGN KEY(Dept_ID) REFERENCES Department(Dept_ID)
);

CREATE TABLE Marketing_Site (
  Site_ID CHAR(9) NOT NULL,
  Site_name VARCHAR(30) NOT NULL,
  PRIMARY KEY(Site_ID)
);

CREATE TABLE MS_locations (
  Ms_location VARCHAR(30) NOT NULL,
  Site_ID CHAR(9) NOT NULL,
  PRIMARY KEY(Ms_location, Site_ID),
  FOREIGN KEY(Site_ID) REFERENCES Marketing_Site(Site_ID)
);

Create TABLE Sells (
  Site_ID CHAR(9) NOT NULL,
  Product_ID CHAR(9) NOT NULL,
  Sale_time DATETIME NOT NULL,
  Sites VARCHAR(30) NOT NULL, 
  Product VARCHAR(30) NOT NULL,
  Customers VARCHAR(30) NOT NULL,
  Salespeople VARCHAR(30) NOT NULL,
  PRIMARY KEY(Site_ID, Product_ID),
  FOREIGN KEY(Site_ID) REFERENCES Marketing_Site(Site_ID),
  FOREIGN KEY(Product_ID) REFERENCES Product(Product_ID)
);

CREATE TABLE Supply1 (
   Product_ID CHAR(9) NOT NULL,
   Part_number CHAR(9) NOT NULL,
   Product_part_types VARCHAR(30) NOT NULL,
   Num_product_parts INT NOT NULL, -- quantity
   PRIMARY KEY (Product_ID, Part_number), 
   FOREIGN KEY(Product_ID) REFERENCES Product(Product_ID),
   FOREIGN KEY(Part_number) REFERENCES Part(Part_number)
);

CREATE TABLE Supply2 (
   Part_number CHAR(9) NOT NULL,
   Vendor_ID CHAR(9) NOT NULL,
   Part_price DOUBLE(4, 2) NOT NULL,
   PRIMARY KEY(Part_number, Vendor_ID),
   FOREIGN KEY (Part_number) REFERENCES Part(Part_number),
   FOREIGN KEY (Vendor_ID) REFERENCES Vendor(Vendor_ID)
);

CREATE TABLE Vendor (
  Vendor_ID CHAR(9) NOT NULL,
  Account_number VARCHAR(30) NOT NULL,
  Web_service_URL VARCHAR(30) NOT NULL,
  Credit_rating VARCHAR(3) NOT NULL,
  Name VARCHAR(30) NOT NULL,
  Address_line1 VARCHAR(30) NOT NULL,
  Address_line2 VARCHAR(30) NOT NULL,
  State CHAR(2) NOT NULL,
  City VARCHAR(50) NOT NULL,
  Zipcode VARCHAR(10) NOT NULL,
  PRIMARY KEY(Vendor_ID)
);

CREATE TABLE Product (
  Product_ID CHAR(9) NOT NULL,
  Size VARCHAR(9) NOT NULL, 
  Weight VARCHAR(9) NOT NULL,
  Product_type VARCHAR(30) NOT NULL,
  Style VARCHAR(30) NOT NULL,
  List_price DOUBLE(4, 2) NOT NULL, --price of product can be max of thousands
  PRIMARY KEY(Product_ID)
);

CREATE TABLE Part (
  Part_number CHAR(9) NOT NULL,
  Price DOUBLE(4, 2) NOT NULL, -- can be off market
  Part_type VARCHAR(30) NOT NULL,
  PRIMARY KEY(Part_number)
);
