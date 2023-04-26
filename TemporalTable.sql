use Northwind

--Temporal(System Based) Tablolar,verilerin belirli aralýklarda raporlanmasýný kolaylaþtýran bir tablo yapýsýdýr.
--Fiziksel tablonun yanýnda ekstradan oluþturulurlar.Aktif edildiklerinde fiziksel tablo üzerindeki deðiþiklikleri tutarlar.


--Temporal tablo oluþturmak için fiziksel tablonun içersinide 'startdate' ve 'enddate' adýnda veritipi 'datetime ' olmak üzere 2 kolon daha oluþturmak gerekir.
--Not:Temporal tablo oluþturmak için fiziksel tabloda 'Primary Key' bulunmak zorundadýr.
create table TemporalTabloOrnek(
Id smallint Primary Key Identity(1,1),
Ad varchar(20),
Soyad varchar(20),

--Temporal tablonun aralýklarla raporlanabilmesi için
StartDate Datetime2 GENERATED ALWAYS AS ROW START NOT NULL,
EndDate Datetime2 GENERATED ALWAYS AS ROW END NOT NULL,

--Verilerin sistem üzerinde belirli aralýklarla takibi için
PERIOD FOR SYSTEM_TIME(StartDate, EndDate)
)
--Sistem üzerinde Temporal tablo özelliðini aktifleþtirmek ve history tablosuna isim vermek için
WITH(SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.TemporalTabloHistory))


--Tablo üzerinde iþlemler
insert into TemporalTabloOrnek(Ad,Soyad) values ('Ad1','Soyad1'),('Ad2','Soyad2')
select * from TemporalTabloOrnek

update TemporalTabloOrnek set Ad='YeniAd1' where Id=1
select * from TemporalTabloHistory

update TemporalTabloOrnek set Ad='SonAd1' where Id=1
select * from TemporalTabloHistory

--Temporal tablolar üzerinde drop ve truncate iþlemleri gerçekleþtirilemez.Bu iþlemleri yapmak için bu tablonun temporal table(system_versioning) özelliðini pasifleþtirmek gerekir.
--System Verisoning özelliðini pasifleþtirmek
ALTER TABLE TemporalTabloOrnek SET ( SYSTEM_VERSIONING = OFF )
--System Verisoning özelliðini aktifleþtirmek
ALTER TABLE TemporalTabloOrnek SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.TemporalTabloHistory))

--Temporal tablo üzerinde belirli aralýktaki verileri listeleme
SELECT * FROM TemporalTabloOrnek
FOR SYSTEM_TIME FROM '2023-04-26 00:00:00' TO '2023-04-26 23:59:59'


--Sistem üzerindeki temporal tablolarý listelemek
SELECT NAME as AnaTablo, TEMPORAL_TYPE_DESC, HISTORY_TABLE_ID as HistoryTabloId, OBJECT_NAME(HISTORY_TABLE_ID) as [HistoryTabloAdý]
FROM SYS.TABLES WHERE TEMPORAL_TYPE_DESC = 'SYSTEM_VERSIONED_TEMPORAL_TABLE'