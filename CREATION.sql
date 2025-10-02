CREATE TABLE Position (
  ID_Position bigserial NOT NULL PRIMARY KEY,
  Title varchar(50) NOT NULL UNIQUE,
  Salary decimal NOT NULL CHECK (Salary > 0),
  Access_level varchar(10) NOT NULL CHECK (Access_level IN ('low', 'medium', 'high'))
);

CREATE TABLE Employee (
  ID_Employee bigserial NOT NULL PRIMARY KEY,
  ID_Position bigint NOT NULL,
  Name varchar(20) NOT NULL,
  Surname varchar(20) NOT NULL,
  Second_name varchar(20),
  Phone varchar(10) NOT NULL CHECK (Phone ~ '^[0-9]{10}$'),
  Registration_address varchar(50) NOT NULL,
  Employment_date date NOT NULL,
  Contract_due_date date NOT NULL CHECK (Contract_due_date > Employment_date)
);

CREATE TABLE Client (
  ID_Client bigserial NOT NULL PRIMARY KEY,
  Surname varchar(20) NOT NULL,
  Name varchar(20) NOT NULL,
  Second_name varchar(20),
  Phone varchar(10) NOT NULL CHECK (Phone ~ '^[0-9]{10}$')
);

CREATE TABLE Access_data (
  ID_Access_data bigserial NOT NULL PRIMARY KEY,
  ID_Client bigint NOT NULL UNIQUE,
  Login varchar(50) NOT NULL,
  Password varchar(50) NOT NULL
);

CREATE TABLE Address (
  ID_Address bigserial NOT NULL PRIMARY KEY,
  ID_Client bigint NOT NULL,
  Delivery_address varchar(50) NOT NULL
);

CREATE TABLE Discount_level (
  ID_Discount_level bigserial NOT NULL PRIMARY KEY,
  Title varchar(50) NOT NULL UNIQUE,
  Discount integer NOT NULL CHECK (Discount BETWEEN 1 AND 50)
);

CREATE TABLE Discount_card (
  ID_Discount_card bigserial NOT NULL PRIMARY KEY,
  ID_Discount_level bigint NOT NULL,
  ID_Client bigint NOT NULL UNIQUE
);

CREATE TABLE Store (
  ID_Store bigserial NOT NULL PRIMARY KEY,
  Phone varchar(10) NOT NULL CHECK (Phone ~ '^[0-9]{10}$'),
  Address varchar(50) NOT NULL UNIQUE
);

CREATE TABLE Supplier (
  ID_Supplier bigserial NOT NULL PRIMARY KEY,
  Organization_name varchar(50) NOT NULL UNIQUE,
  Phone varchar(10) NOT NULL CHECK (Phone ~ '^[0-9]{10}$'),
  Address varchar(50) NOT NULL
);

CREATE TABLE Bouquet (
  ID_Bouquet bigserial NOT NULL PRIMARY KEY,
  Title varchar(50) NOT NULL,
  ID_Supplier bigint NOT NULL,
  ID_Store bigint NOT NULL,
  Description text NOT NULL,
  Expiration_date date NOT NULL CHECK (Expiration_date >= CURRENT_DATE),
  Certificate varchar(500) NOT NULL,
  Price decimal NOT NULL CHECK (Price > 0)
);

CREATE TABLE Review (
  ID_Review bigserial NOT NULL PRIMARY KEY,
  ID_Client bigint NOT NULL,
  ID_Bouquet bigint NOT NULL,
  Contents text,
  Rating smallint NOT NULL CHECK (Rating BETWEEN 1 AND 5)
);

CREATE TABLE Ordering (
  ID_Ordering bigserial NOT NULL PRIMARY KEY,
  ID_Employee bigint NOT NULL,
  ID_Address bigint NOT NULL,
  ID_Discount_card bigint,
  ID_Client bigint NOT NULL,
  Total_price decimal NOT NULL CHECK (Total_price > 0),
  Ordering_date date NOT NULL DEFAULT CURRENT_DATE,
  Status varchar(20) NOT NULL CHECK (Status IN ('pending', 'confirmed', 'preparing', 'shipped', 'delivered', 'cancelled')),
  Delivery_method varchar(30) NOT NULL CHECK (Delivery_method IN ('pickup', 'courier', 'post'))
);

CREATE TABLE Order_Bouquet (
  ID_Order_Bouquet bigserial NOT NULL PRIMARY KEY,
  ID_Ordering bigint NOT NULL,
  ID_Bouquet bigint NOT NULL,
  Quantity integer NOT NULL CHECK (Quantity > 0)
);

CREATE TABLE Transaction (
  ID_Transaction bigserial NOT NULL PRIMARY KEY,
  ID_Ordering bigint NOT NULL UNIQUE,
  Amount decimal NOT NULL CHECK (Amount > 0),
  Transaction_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Document (
  ID_Document bigserial NOT NULL PRIMARY KEY,
  ID_Ordering bigint NOT NULL,
  ID_Employee bigint NOT NULL,
  Creation_date date NOT NULL DEFAULT CURRENT_DATE,
  Link varchar(50) NOT NULL
);

CREATE TABLE Support_chat (
  ID_Support_chat bigserial NOT NULL PRIMARY KEY,
  ID_Employee bigint NOT NULL,
  ID_Client bigint NOT NULL,
  Status varchar(20) NOT NULL CHECK (Status IN ('open', 'in_progress', 'resolved', 'closed')),
  Created_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Message (
  ID_Message bigserial NOT NULL PRIMARY KEY,
  ID_Support_chat bigint NOT NULL,
  Contents text NOT NULL,
  Send_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  Sender_type varchar(20) NOT NULL CHECK (Sender_type IN ('client', 'employee'))
);

ALTER TABLE Employee ADD CONSTRAINT Employee_ID_Position_fk FOREIGN KEY (ID_Position) REFERENCES Position (ID_Position);
ALTER TABLE Access_data ADD CONSTRAINT Access_data_ID_Client_fk FOREIGN KEY (ID_Client) REFERENCES Client (ID_Client) ON DELETE CASCADE;
ALTER TABLE Address ADD CONSTRAINT Address_ID_Client_fk FOREIGN KEY (ID_Client) REFERENCES Client (ID_Client) ON DELETE CASCADE;
ALTER TABLE Discount_card ADD CONSTRAINT Discount_card_ID_Client_fk FOREIGN KEY (ID_Client) REFERENCES Client (ID_Client) ON DELETE CASCADE;
ALTER TABLE Discount_card ADD CONSTRAINT Discount_card_ID_Discount_level_fk FOREIGN KEY (ID_Discount_level) REFERENCES Discount_level (ID_Discount_level);
ALTER TABLE Bouquet ADD CONSTRAINT Bouquet_ID_Supplier_fk FOREIGN KEY (ID_Supplier) REFERENCES Supplier (ID_Supplier);
ALTER TABLE Bouquet ADD CONSTRAINT Bouquet_ID_Store_fk FOREIGN KEY (ID_Store) REFERENCES Store (ID_Store);
ALTER TABLE Review ADD CONSTRAINT Review_ID_Client_fk FOREIGN KEY (ID_Client) REFERENCES Client (ID_Client) ON DELETE CASCADE;
ALTER TABLE Review ADD CONSTRAINT Review_ID_Bouquet_fk FOREIGN KEY (ID_Bouquet) REFERENCES Bouquet (ID_Bouquet) ON DELETE CASCADE;
ALTER TABLE Ordering ADD CONSTRAINT Ordering_ID_Employee_fk FOREIGN KEY (ID_Employee) REFERENCES Employee (ID_Employee);
ALTER TABLE Ordering ADD CONSTRAINT Ordering_ID_Address_fk FOREIGN KEY (ID_Address) REFERENCES Address (ID_Address);
ALTER TABLE Ordering ADD CONSTRAINT Ordering_ID_Discount_card_fk FOREIGN KEY (ID_Discount_card) REFERENCES Discount_card (ID_Discount_card) ON DELETE SET NULL;
ALTER TABLE Ordering ADD CONSTRAINT Ordering_ID_Client_fk FOREIGN KEY (ID_Client) REFERENCES Client (ID_Client);
ALTER TABLE Order_Bouquet ADD CONSTRAINT Order_Bouquet_ID_Ordering_fk FOREIGN KEY (ID_Ordering) REFERENCES Ordering (ID_Ordering) ON DELETE CASCADE;
ALTER TABLE Order_Bouquet ADD CONSTRAINT Order_Bouquet_ID_Bouquet_fk FOREIGN KEY (ID_Bouquet) REFERENCES Bouquet (ID_Bouquet);
ALTER TABLE Transaction ADD CONSTRAINT Transaction_ID_Ordering_fk FOREIGN KEY (ID_Ordering) REFERENCES Ordering (ID_Ordering);
ALTER TABLE Document ADD CONSTRAINT Document_ID_Ordering_fk FOREIGN KEY (ID_Ordering) REFERENCES Ordering (ID_Ordering) ON DELETE CASCADE;
ALTER TABLE Document ADD CONSTRAINT Document_ID_Employee_fk FOREIGN KEY (ID_Employee) REFERENCES Employee (ID_Employee);
ALTER TABLE Support_chat ADD CONSTRAINT Support_chat_ID_Employee_fk FOREIGN KEY (ID_Employee) REFERENCES Employee (ID_Employee);
ALTER TABLE Support_chat ADD CONSTRAINT Support_chat_ID_Client_fk FOREIGN KEY (ID_Client) REFERENCES Client (ID_Client) ON DELETE CASCADE;
ALTER TABLE Message ADD CONSTRAINT Message_ID_Support_chat_fk FOREIGN KEY (ID_Support_chat) REFERENCES Support_chat (ID_Support_chat) ON DELETE CASCADE;
