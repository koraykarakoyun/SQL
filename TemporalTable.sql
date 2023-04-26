use Northwind

--Temporal(System Based) Tablolar,verilerin belirli aral�klarda raporlanmas�n� kolayla�t�ran bir tablo yap�s�d�r.
--Fiziksel tablonun yan�nda ekstradan olu�turulurlar.Aktif edildiklerinde fiziksel tablo �zerindeki de�i�iklikleri tutarlar.


--Temporal tablo olu�turmak i�in fiziksel tablonun i�ersinide 'startdate' ve 'enddate' ad�nda veritipi 'datetime ' olmak �zere 2 kolon daha olu�turmak gerekir.
--Not:Temporal tablo olu�turmak i�in fiziksel tabloda 'Primary Key' bulunmak zorundad�r.
create table TemporalTabloOrnek(
Id smallint Primary Key Identity(1,1),
Ad varchar(20),
Soyad varchar(20),

--Temporal tablonun aral�klarla raporlanabilmesi i�in
StartDate Datetime2 GENERATED ALWAYS AS ROW START NOT NULL,
EndDate Datetime2 GENERATED ALWAYS AS ROW END NOT NULL,

--Verilerin sistem �zerinde belirli aral�klarla takibi i�in
PERIOD FOR SYSTEM_TIME(StartDate, EndDate)
)
--Sistem �zerinde Temporal tablo �zelli�ini aktifle�tirmek ve history tablosuna isim vermek i�in
WITH(SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.TemporalTabloHistory))


--Tablo �zerinde i�lemler
insert into TemporalTabloOrnek(Ad,Soyad) values ('Ad1','Soyad1'),('Ad2','Soyad2')
select * from TemporalTabloOrnek

update TemporalTabloOrnek set Ad='YeniAd1' where Id=1
select * from TemporalTabloHistory

update TemporalTabloOrnek set Ad='SonAd1' where Id=1
select * from TemporalTabloHistory

--Temporal tablolar �zerinde drop ve truncate i�lemleri ger�ekle�tirilemez.Bu i�lemleri yapmak i�in bu tablonun temporal table(system_versioning) �zelli�ini pasifle�tirmek gerekir.
--System Verisoning �zelli�ini pasifle�tirmek
ALTER TABLE TemporalTabloOrnek SET ( SYSTEM_VERSIONING = OFF )
--System Verisoning �zelli�ini aktifle�tirmek
ALTER TABLE TemporalTabloOrnek SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.TemporalTabloHistory))

--Temporal tablo �zerinde belirli aral�ktaki verileri listeleme
SELECT * FROM TemporalTabloOrnek
FOR SYSTEM_TIME FROM '2023-04-26 00:00:00' TO '2023-04-26 23:59:59'


--Sistem �zerindeki temporal tablolar� listelemek
SELECT NAME as AnaTablo, TEMPORAL_TYPE_DESC, HISTORY_TABLE_ID as HistoryTabloId, OBJECT_NAME(HISTORY_TABLE_ID) as [HistoryTabloAd�]
FROM SYS.TABLES WHERE TEMPORAL_TYPE_DESC = 'SYSTEM_VERSIONED_TEMPORAL_TABLE'