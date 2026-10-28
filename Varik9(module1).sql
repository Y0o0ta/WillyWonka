create table Material_Types(
id int identity(1,1) not null primary key,
type_material nvarchar(100),
loss_percentage decimal(3,2)
);

create table Materials(
id int identity(1,1) not null primary key,
name_material nvarchar(100),
type_material int references Material_Types(id),
price_unit decimal(10,2),
stock_qty decimal(10,2),
min_qty decimal(10,2),
pack_qty decimal(10,2),
unit_measur nvarchar(10)
);

create table Product_Types(
id int identity(1,1) not null primary key,
type_product nvarchar(100),
cost_coefficient decimal(5,2)
);

create table Products(
sku nvarchar(20) primary key,
type_product int references Product_Types(id),
name_product nvarchar(100),
min_price_partner decimal(10,2)
);


create table Material_Products(
id int identity(1,1) primary key,
name_material int references Materials(id),
name_products nvarchar(20) references Products(sku),
amount_material_unit decimal(4,3)
);

create table Suppliers(
id int identity(1,1) not null primary key,
type_suppliers nvarchar(10),
name_suppliers nvarchar(100),
INN int,
rating decimal(10,0),
date_first_work date
);

create table Material_Suppliers(
id int identity(1,1) not null primary key,   
name_material int references Materials(id),
name_suppliers int references Suppliers(id),
price decimal(10,2),
delivery_time int
);

create table Roles(
id int primary key,
name_role nvarchar(100),
description_right nvarchar(255)
);

create table Users(
login nvarchar(100) primary key,
full_name nvarchar(100),
role int references Roles(id),
email nvarchar(100),
status nvarchar(10)
);


--ЗАПРОСЫ НА ПЕРЕНОС ДАННЫХ
--insert into ChocolateFactory.dbo.Material_Types(type_material, loss_percentage)
--SELECT [Тип материала], 
--TRY_CAST(REPLACE(REPLACE(REPLACE([Процент потери сырья], '%', ''), ',', '.'), ' ', '')as decimal(5,2)) as loss_percentage
--FROM ChocolateFactory.dbo.CA_MaterialTypes
--WHERE TRY_CAST(REPLACE(REPLACE(REPLACE([Процент потери сырья], '%', ''), ',', '.'), ' ', '')
--AS decimal(5,2)) IS Not NULL;

--insert into ChocolateFactory.dbo.Materials(name_material, type_material, price_unit, stock_qty, min_qty, pack_qty, unit_measur)
--select [Наименование материала], mt.id,[Цена единицы],[Количество на складе],[Минимальное количество], [Количество в упаковке], [Единица измерения]
--from ChocolateFactory.dbo.CA_Materials as ca
--join ChocolateFactory.dbo.Material_Types as mt on ca.[Тип материала]=mt.type_material

--insert into ChocolateFactory.dbo.Product_Types(type_product, cost_coefficient)
--select [Тип продукции], [Коэффициент типа продукции]
--from ChocolateFactory.dbo.CA_ProductTypes

--insert into ChocolateFactory.dbo.Products(sku, type_product, name_product, min_price_partner)
--select [Артикул], pt.id, [Наименование продукции], [Минимальная стоимость для партнера]
--from ChocolateFactory.dbo.CA_Products as ca
--join ChocolateFactory.dbo.Product_Types as pt on ca.[Тип продукции]=pt.type_product


--insert into ChocolateFactory.dbo.Material_Products(name_material, name_products, amount_material_unit)
--select m.id, p.sku, [Количество материала на единицу продукции]
--from ChocolateFactory.dbo.CA_MaterialProducts as ca
--join ChocolateFactory.dbo.Materials as m on ca.[Наименование материала]=m.name_material
--join ChocolateFactory.dbo.Products as p on ca.[Наименование продукции]=p.name_product


--insert into ChocolateFactory.dbo.Suppliers(type_suppliers, name_suppliers, INN, rating, date_first_work)
--select [Тип поставщика], [Наименование поставщика], [ИНН], [Рейтинг], [Дата начала работы]
--from ChocolateFactory.dbo.CA_Suppliers

--insert into ChocolateFactory.dbo.Material_Suppliers(name_material, name_suppliers, price, delivery_time)
--select m.id, s.id, [Закупочная цена],[Срок поставки (дней)]
--from ChocolateFactory.dbo.CA_MaterialSuppliers as ca
--join ChocolateFactory.dbo.Materials m on ca.[Наименование материала]=m.name_material
--join ChocolateFactory.dbo.Suppliers s on ca.[Поставщик]=s.name_suppliers

--insert into ChocolateFactory.dbo.Roles(id, name_role, description_right)
--select [ID роли], [Наименование роли], [Описание прав]
--from ChocolateFactory.dbo.CA_Roles

insert into ChocolateFactory.dbo.Users(login, full_name, role, email, status)
select [Логин], [ФИО], r.id, [Email], [Активен]
from ChocolateFactory.dbo.CA_Users as ca
join ChocolateFactory.dbo.Roles as r on ca.[Роль]=r.name_role

