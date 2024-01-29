-- Создание таблицы СОТРУДНИК
CREATE TABLE STAFF (
    Staff_no SERIAL PRIMARY KEY,
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    SName VARCHAR(50),
    DOB DATE,
    Sex VARCHAR(10) CHECK (Sex IN ('Мужской', 'Женский', 'Иное')),
    City VARCHAR(50),
    Street VARCHAR(50),
    House VARCHAR(10),
    Flat VARCHAR(10),
    Stel_no VARCHAR(20) CHECK (Stel_no ~ '^\+(375(17|29|33|25|44))\d{7}$'),
    ID_Pass VARCHAR(14) CHECK (ID_Pass ~ '^\d{7}[A-Z0-9]{1}\d{3}[A-Z0-9]{1}\d{2}$') NOT NULL UNIQUE,
    Date_of_Issue DATE,
    Validity DATE,
    Pass_series VARCHAR(10),
    Pass_no VARCHAR(20),
    Gov_no VARCHAR(20),
    Government VARCHAR(50),
    Date_Joined DATE,
    Position VARCHAR(50),
    Salary NUMERIC(10, 2)
);

-- Создание таблицы АВТОМОБИЛЬ
CREATE TABLE AUTO (
    Code_auto SERIAL PRIMARY KEY,
    Code_mark INT,
    NCar VARCHAR(50),
    Engine VARCHAR(255),
    Transmission VARCHAR(50) CHECK (Transmission IN ('Механическая', 'Автомат', 'Робот', 'Иное')),
    Сapacity NUMERIC(5, 2),
    Fuel_consumption NUMERIC(5, 2),
    Car_text TEXT,
    Code_car VARCHAR(20) UNIQUE,
    Reg_no VARCHAR(20) CHECK (Reg_no ~ '^[А-Я]{1}\d{3}\s[А-Я]{2}\s\d{3}$') UNIQUE,
    Car_body_no VARCHAR(20),
    Engine_no VARCHAR(20),
    IYear INT,
    Mileage INT,
    Car_price NUMERIC(10, 2),
    Rental_price NUMERIC(10, 2),
    Date_maintenance DATE
);

-- Создание таблицы КОМПАНИЯ
CREATE TABLE COMPANY (
    Company_no VARCHAR(9) CHECK (Company_no ~ '^\d{9}$') PRIMARY KEY,
    Postcode VARCHAR(6) CHECK (Postcode ~ '^\d{6}$'),
    Street VARCHAR(50),
    City VARCHAR(50),
    House VARCHAR(10),
    Btel_no VARCHAR(20) CHECK (Btel_no ~ '^\+(375(17|29|33|25|44))\d{7}$'),
    Fax_no VARCHAR(20)
);

-- Создание таблицы КЛИЕНТ
CREATE TABLE CUSTOMER (
    Customer_no SERIAL PRIMARY KEY,
    Age INT DEFAULT 18 CHECK (Age >= 18),
    Pass_data VARCHAR(255),
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    Branch_no INT,
    SName VARCHAR(50),
    City VARCHAR(50),
    Street VARCHAR(50),
    ID_Pass VARCHAR(14) CHECK (ID_Pass ~ '^\d{7}[A-Z0-9]{1}\d{3}[A-Z0-9]{1}\d{2}$') NOT NULL UNIQUE,
    Date_of_Issue DATE,
    Validity DATE,
    Pass_series VARCHAR(10),
    Pass_no VARCHAR(20),
    Gov_no VARCHAR(20),
    Government VARCHAR(50),
    House VARCHAR(10),
    Flat VARCHAR(10),
    Tell_no VARCHAR(20) CHECK (Tell_no ~ '^\+(375(17|29|33|25|44))\d{7}$'),
    Regular_customer BOOLEAN DEFAULT FALSE,
    Fine BOOLEAN DEFAULT FALSE
);

-- Создание таблицы ДОГОВОР АРЕНДЫ
CREATE TABLE RENTAL_CONTRACT (
    RContract_no SERIAL PRIMARY KEY,
    Date_contact DATE NOT NULL,
    Subject_contact VARCHAR(50) NOT NULL,
    Code_auto INT,
    Company_no VARCHAR(20),
    Customer_no INT,
    Rental_price NUMERIC(10, 2) NOT NULL,
    CONSTRAINT rental_contract_fk_auto FOREIGN KEY (Code_auto) REFERENCES AUTO(Code_auto) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT rental_contract_fk_company FOREIGN KEY (Company_no) REFERENCES COMPANY(Company_no) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT rental_contract_fk_customer FOREIGN KEY (Customer_no) REFERENCES CUSTOMER(Customer_no) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Создание таблицы АКТ ПРИЕМА-ПЕРЕДАЧИ
CREATE TABLE ACCEPTANCE_CERTIFICATE (
    ACertificate_no SERIAL PRIMARY KEY,
    Staff_no INT,
    Date_a_cettificate DATE NOT NULL,
    Code_auto INT,
    Rental_price NUMERIC(10, 2) NOT NULL,
    Code_mechanic INT,
    Spec_marks VARCHAR(255),
    Return_stamp BOOLEAN,
    Cade_client INT,
    Date_of_issue DATE,
    Time_of_issue TIME,
    Return_date DATE,
    Return_time TIME,
    Rental_hours INT,
    Overdue_hours INT,
    Fine_amount NUMERIC(10, 2),
    CONSTRAINT acceptance_certificate_fk_staff FOREIGN KEY (Staff_no) REFERENCES STAFF(Staff_no) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT acceptance_certificate_fk_auto FOREIGN KEY (Code_auto) REFERENCES AUTO(Code_auto) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT acceptance_certificate_fk_mechanic FOREIGN KEY (Code_mechanic) REFERENCES STAFF(Staff_no) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT acceptance_certificate_fk_customer FOREIGN KEY (Cade_client) REFERENCES CUSTOMER(Customer_no) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Создание таблицы ОСМОТР
CREATE TABLE VIEWING (
    Viewing_no SERIAL PRIMARY KEY,
    RContract_no INT,
    Date_View DATE,
    Comments TEXT,
    Customer_no INT,
    Code_auto INT,
    Staff_no_agent INT,
    Staff_no_mechanic INT,
    Result_viewing VARCHAR(255),
    CONSTRAINT viewing_fk_rental_contract FOREIGN KEY (RContract_no) REFERENCES RENTAL_CONTRACT(RContract_no) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT viewing_fk_customer FOREIGN KEY (Customer_no) REFERENCES CUSTOMER(Customer_no) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT viewing_fk_auto FOREIGN KEY (Code_auto) REFERENCES AUTO(Code_auto) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT viewing_fk_agent FOREIGN KEY (Staff_no_agent) REFERENCES STAFF(Staff_no) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT viewing_fk_mechanic FOREIGN KEY (Staff_no_mechanic) REFERENCES STAFF(Staff_no) ON DELETE CASCADE ON UPDATE CASCADE
);

