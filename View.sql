use VeriBilimi

--View,kompleks sorgular�n bir kere yaz�l�p veritaban� nesnesi olarak kaydedilmesini,
--daha sonra bu nesnelerin �zerinde CRUD i�lemleri yap�labilmesini sa�lar;

--View Olu�turma
select * from Personeller;
select * from Adresler;
create view ornek_view
as
select Personeller.Id,Personeller.Ad,Personeller.Soyad,Personeller.Yas,Personeller.Maas,Adresler.Il,Adresler.Ilce from Personeller inner join Adresler on Personeller.AdresId=Adresler.Id 

--View kullan�m�

--view �zerinde yap�lan i�lemler ger�ek fiziksel tablolara da yans�t�l�r.
select * from ornek_view order by Ad asc
--insert into Personeller values ('View Deneme Ad','View Deneme Soyad',12345.22,4,10);
--insert into Adresler values (4,'View Il','View Ilce')

--Not:Viewler olu�turulurken order by kullanmak i�in top komutunu kullanmak gerekir

--View'i sifreleyerek olusturmak icin 'with encryption' komutu kullan�l�r
create view sifreli_view
with encryption
as 
select Personeller.Id,Personeller.Ad,Personeller.Soyad,Personeller.Yas,Personeller.Maas,Adresler.Il,Adresler.Ilce from Personeller inner join Adresler on Personeller.AdresId=Adresler.Id 

--'with schemabinding' komutu ile view'in kulland��� tablolar �zerinde de�i�iklik yap�laca�� zaman uyar� verilmesini sa�lar.
--Kullan�rken dikkat edilmesi gereken nokta tablo adlar� '�ema ad�' ile birlikte kullan�lmal�d�r.
create view ornek_view_2
with schemabinding
as
select dbo.Personeller.Id,dbo.Personeller.Ad,dbo.Personeller.Soyad,dbo.Personeller.Yas,dbo.Personeller.Maas,dbo.Adresler.Il,dbo.Adresler.Ilce from dbo.Personeller inner join dbo.Adresler on dbo.Personeller.AdresId=dbo.Adresler.Id 

--Bu sorgu hata mesaj� f�rlat�r
alter table personeller
alter column ad varchar(100)

--with check option,view i�erisine where �artlar�na uymayan de�erlerin eklenmesini �nler.

create view ornek_view_3
as
select * from Personeller where Ad like 'a%'
with check option

select * from ornek_view_3
insert into ornek_view_3 values ('B_ad','c_soyad',123.12,5,33)
--burada view sorgusundaki adi a harfi ile ba�layanlar filtresine uygun olmad��� i�in veri eklenemez