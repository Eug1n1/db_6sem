-- use master
-- drop database sklad
-- create database sklad
-- use sklad

create table measure_units
(
    measure_unit_id int identity primary key,
    short_name      varchar(5) unique not null,
    description     varchar(20),
)
go

create table employees
(
    employee_id int identity primary key,
    name        varchar(100) not null,
    birthdate   date         not null,
    position    varchar(50)  not null,
    address     varchar(200) not null,
    phone       varchar(12)  not null,
    is_active   bit default 0,
)
go

create table employees_log
(
    employee_log_id int identity primary key,
    employee_id     int not null
        constraint employees_employee_id_fk references employees (employee_id),
    start_datetime  datetime,
    finish_datetime datetime,
)

create table providers
(
    provider_id    int identity primary key,
    name           varchar(50)  not null,
    address        varchar(200) not null,
    phone          varchar(12)  not null,
    contact_person varchar(50),
)
go

create table clients
(
    client_id      int identity primary key,
    name           varchar(50)  not null,
    address        varchar(200) not null,
    phone          varchar(12)  not null,
    contact_person varchar(50),
)
go

create table documents
(
    document_id     int identity primary key,
    document_type   varchar(20),
    document_number varchar(20),
)
go

create table items
(
    item_id         int identity primary key,
    name            varchar(100),
    amount          int,
    measure_unit_id int not null
        constraint items_measure_unit_fk foreign key references measure_units (measure_unit_id),
    expiration_date date,
)
go

create table deliveries
(
    id            int identity primary key,
    item_id       int   not null
        constraint deliveries_item_id_fk references items (item_id),
    amount        int check (amount > 0),
    price         money not null,
    provider_id   int   not null
        constraint deliveries_provider_id_fk references providers (provider_id),
    person        varchar(50),
    delivery_date date,
    employee_id   int   not null
        constraint deliveries_employee_id_fk references employees (employee_id),
    document_id   int   not null
        constraint deliveries_document_id_fk references documents (document_id),
)
go

create table purchases
(
    id            int identity primary key,
    item_id       int  not null
        constraint purchases_item_id_fk references items (item_id),
    amount        int check (amount > 0),
    price         money check (price > 0),
    client_id     int  not null
        constraint purchases_client_id_fk references clients (client_id),
    person        varchar(50),
    purchase_date date not null,
    employee_id   int  not null
        constraint purchases_employee_id_fk references employees (employee_id),
    document_id   int  not null
        constraint purchases_document_id_fk references documents (document_id),
)
go

create index items_expiration_date_index on items(expiration_date)
create index purchases_purchase_date_index on purchases(purchase_date)
create index deliveries_delivery_date_index on deliveries(delivery_date)

insert into employees (name, birthdate, position, address, phone)
values ('aboba', '12-24-1993', 'manager', 'Minsk city, Abobava st. 18', '+37535557612')
select *
from employees
go

insert into clients (name, address, phone, contact_person)
values ('aboba co.', 'Minsk city, Zelibobava st. 25', '+32498675414', 'Zherik')
select *
from clients
go

insert into providers (name, address, phone, contact_person)
values ('oao Zeliboba', 'Minsk city, Zelibobava st. 1', '+32498676414', 'Big boba')
select *
from providers
go

insert into measure_units (short_name, description)
values ('kg', 'kilogram')
select *
from measure_units
go

insert into items (name, amount, measure_unit_id, expiration_date)
values ('bober2', 100, 1, '01-24-2024')
select *
from items
go

insert into documents (document_type, document_number)
values ('nakladnaya', 'aboab2131')

insert into deliveries (item_id, amount, price, provider_id, person, delivery_date, employee_id, document_id)
values (1, 1, 123, 1, 'giga', getdate(), 1, 1)
select *
from items
go

insert into purchases (item_id, amount, price, client_id, person, purchase_date, employee_id, document_id)
values (1, 1, 123, 1, 'giga', getdate(), 1, 1)
select *
from items
go

insert into employees_log (employee_id, start_datetime, finish_datetime)
values (1, '05-19-2024', NULL)
select *
from employees_log