use Northwind

--Triggerlar,veritabaný veya tablo üzerinde bir iþlem yapýlýrken o iþlem sürecinde tetiklenen ve istenilen baþka iþlemlerin yapýlmasýný saðlayan yapýlardýr.

--Triggerlar DDL ve DML trigger olarak ikiye ayrýlýr.
--DDL triggerlar veritabaný üzerinde create,alter,drop iþlemler yapýldýðý zaman tetiklenir.
--DML triggerlar,tablolar üzerinde insert,update,delete iþlemleri yapýldýðý zaman tetiklenir.

--DML trigger tanýmlama
--Trigger oluþturulurken ilgili tablo veya veritabaný ile iliþkisi belirtilir.

create trigger PersonelEklendigindeTrigger
on Personeller
after insert
as
begin
print('personeller tablosuna kayýt eklendi')
end

insert into Personeller(Adi,SoyAdi) values('Koray','Karakoyun')

--Triggerlar tetiklenirken insert iþleminden sonra iþlem fiziksel tabloya yansýtýlmadan 'inserted' tablosunda veri geçici olarak saklanýr.
--Yani yeni eklenen veriye inserted tablosu üzerinden eriþilebilir.

drop trigger PersonelEklendigindeTrigger

create trigger PersonelEklendigindeTrigger
on Personeller
after insert
as
begin
declare @adi varchar(30),@soyadi varchar(30);
select @adi=Adi,@soyadi=SoyAdi from inserted --Eklenecek olan veriye eriþim
print(@adi+' '+@soyadi)
end
--insert into Personeller(Adi,SoyAdi) values('Kaan','Karakoyun')

--Triggerlar tetiklenirken delete iþleminden sonra iþlem fiziksel tabloya yansýtýlmadan 'deleted' tablosunda veri geçici olarak saklanýr.
--Yani silinecek veriye deleted tablosu üzerinden eriþilebilir.
create trigger PersonelSilindigindeTrigger
on Personeller
after delete
as
begin
declare @adi varchar(30),@soyadi varchar(30);
select @adi=Adi,@soyadi=SoyAdi from deleted --Silinecek olan veriye eriþim
print(@adi+' '+@soyadi)
end
--delete from Personeller where Adi='Kaan'
--select * from Personeller


--Triggerlar tetiklenirken update iþleminden sonra iþlem fiziksel tabloya yansýtýlmadan inserted ve deleted tablosunda veri geçici olarak saklanýr.
--Yani yeni eklenen veriye inserted tablosu üzerinden,silinecek veriye deleted tablosu üzerinden  eriþilebilir.

create trigger PersonelGuncellendiginde
on Personeller
after update
as
begin

declare @eskiadi varchar(30),@eskisoyadi varchar(30), @yeniadi varchar(30), @yenisoyadi varchar(30);
select @yeniadi=Adi,@yenisoyadi=SoyAdi from inserted
select @eskiadi=Adi,@eskisoyadi=SoyAdi from deleted 
print(@eskiadi+' '+@eskisoyadi+' olan veri '+@yeniadi+' '+@yenisoyadi+' olarak '+SUSER_SNAME()+' tarafýndan'+CAST(GETDATE() as varchar(30))+ ' tarihinde degistirildi.')
end

select * from Personeller where Adi='Kaan'
update Personeller set Adi='Koray',SoyAdi='Karakoyun' where Adi='Kaan'


--DDL trigger tanýmlama

create table LogTablosu(
id smallint primary key identity(1,1),
aciklama varchar(500)
)

create trigger TabloeklendiðindeTrigger
on Database
for create_table --alter_table,drop_table,create_procedure,drop_procedure,create_function,drop_funciton...
as
begin
insert into LogTablosu values(SUSER_SNAME()+' tarafýndan '+CAST(GETDATE() as varchar(30))+' tarihinde yeni bir tablo olusturuldu')
end

create table Ornektablo3(
ad varchar(20),
soyad varchar(20)
)

select  * from LogTablosu

--'Instead of' keywordü bir iþlem yapýlacaðý zaman o iþlem yerine baþka bir iþlemi yaptýrmak için kullanýlýr.

create trigger InsteadOfTrigger
on Personeller
instead of delete --Delete iþlemi yerine
as
begin
print('Bu tablodan veri silinemez')
rollback --Yapýlan iþlemleri geri almak için kullanýlýr.
end

select * from Personeller

delete from Personeller where PersonelID='13'

--Trigger enadble-disable iþlemi

disable trigger InsteadOfTrigger on Personeller

enable trigger InsteadOfTrigger on Personeller

-----

disable trigger TabloeklendiðindeTrigger on database

enable trigger TabloeklendiðindeTrigger on database