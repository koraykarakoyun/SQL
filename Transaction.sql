use Northwind

--Transaction,veritabaný üzerinde yapýlan iþlemler default olarak transaction eþliðinde yürütülür.
--Veritabaný ile ilgili iþlemler baþlatýlýrken 'begin transaction' keywordü ile baþlatýlýr.
--Ýþlem sonucunda baþarýlý olma durumunda 'commit transaction' keywordü ile transaction sonlandýrýlýr.
--Ýþlem esnasýnda herhangi bir sorun oluþma durumunda ise 'rollback' keywordü kullanýlarak yapýlan iþlemler geri alýnarak eski durumuna getirilir ve transaction sonlandýrlýr.

begin transaction
select * from Personeller
declare @rowcount tinyint=@@rowcount
if(@rowcount=10)
begin
	insert into Personeller (Adi,SoyAdi) values ('11.Adi','11.Soyadi')
	set @rowcount=@@ROWCOUNT
	if(@rowcount=1)
		begin
			print('rowcount:'+CAST(@rowcount as varchar(20)))
			commit transaction
		end
	else
	begin
		print('rowcount:'+CAST(@rowcount as varchar(20)))
		rollback transaction
	end
end
else
begin
	print(@rowcount)
	commit transaction
end
