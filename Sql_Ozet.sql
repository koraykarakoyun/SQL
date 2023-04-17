create database VeriBilimi;

use VeriBilimi;


create table Personeller
(
Id tinyint Identity(1,1),
Ad varchar(20),
Soyad varchar(20),
Maas decimal(8,2),
AdresId tinyint
)

select * from Personeller

insert into Personeller (Soyad,Ad,Maas,AdresId) values('Karakoyun','Koray',19500.50,1);

insert into Personeller values('Kaan','Karakoyun',18000.70,2),('A','B',15000.45,3);

alter table Personeller add Yas varchar(3);

insert into Personeller values('C','D',10000,4,35);

update Personeller SET Yas=37 where Yas=35; 

update Personeller SET Yas=30 where Yas is Null;

update Personeller Set Yas=22 where Ad='Koray'

update Personeller Set Yas=16 where Ad='Kaan' and Soyad='Karakoyun'

alter table Personeller add constraint AdressIdUnique Unique (AdresId);

UPDATE Personeller set AdresId=5 where AdresId=4

select * from Personeller where AdresId=5

delete from Personeller where AdresId=5

alter table Personeller add constraint PK_PersonelId Primary Key (Id);


create Table Adresler (
Id tinyint Primary Key,
Il varchar(10) not null,
Ilce varchar(10),
)

select * from Adresler

alter table Adresler add constraint Unique_Ilce Unique(Ilce);

insert into Adresler values(1,'Ýstanbul','Pendik');

insert into Adresler (Ilce,Il,Id) values ('Kartal23','Istanbul',2),('Pendik22','Istanbul',3);

select Ad,Soyad,Yas,Maas,Il,Ilce from Personeller inner join Adresler on Personeller.AdresId=Adresler.Id;

select * from Adresler where Ilce='Pendik22'

update Adresler set Ilce='Kartal'  where Ilce='Kartal23'

update Adresler set Ilce='Pendik' where Ilce='Pendik22';

delete from Adresler where Ilce='Pendik22'

insert into Adresler values (3,'Istanbul','Pendik')

alter table Adresler drop constraint Unique_Ilce