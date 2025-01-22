
--1. SORGU verilerin görüntülenmesi
select * from got


-- 2. SORGU yönetmen ve yönettikleri bölüm sayıları
select Directed_by, COUNT(*) as toplam
from got
group by Directed_by
order by toplam desc

-- 3. SORGU her sezon kaç bölümden oluştuğunun bulunması 
select Season ,count(*) [bölüm sayısı]
from got
group by Season

-- 4. SORGU dizinin toplam kaç bölümden oluştuğunun bulunması
select COUNT(*)
from got

-- 5. SORGU sezonlara göre ortalama bölüm süresi
select Season, cast(AVG(Running_Time_Minutes) as decimal(4,2))
from got
group by Season

--6. SORGU bölümlerde kullanılan romanların bulunması
select Novel_s_Adapted, COUNT(*) as bölüm_sayısı
from got
group by Novel_s_Adapted
order by bölüm_sayısı desc

--6. SORGU kullanılan romanların yüzdeliklerinin bulunması 
select Novel_s_Adapted,
cast((COUNT(*) * 100.0 / (select COUNT(*) from got) ) as decimal(4,2)) as yüzdelik
from got
group by Novel_s_Adapted
order by yüzdelik desc

--7. SORGU sezonlara göre kullanılan romanlar
select Novel_s_Adapted, Season, COUNT(*)
from got
group by Novel_s_Adapted, Season


-- 8. SORGU imdb puanı en yüksek bölümlerin bulunması
select Title_of_the_Episode, 
cast(Season as varchar) + ' - ' + cast(No_of_Episode_Overall as varchar) as season_episode, 
round(IMDb_Rating, 2) as oylama
from got
order by oylama desc


-- 9.SORGU her sezona göre imdb puanı en yüksek bölümlerin bulunması
select g.Season, g.No_of_Episode_Season, cast(g.IMDb_Rating as decimal(4,2)) as imdb_oylama
from got g
left join got t
on g.Season = t.Season and g.IMDb_Rating < t.IMDb_Rating
where t.IMDb_Rating is null

-- 10.SORGU en yüksek imdb puanına sahip sezonların belirlenmesi
select Season, round(AVG(IMDb_Rating),2) as oylama
from got
group by Season
order by oylama desc

--11. SORGU sezonlara göre ortalama rotten_tomatoes_oylarının bulunması
select Season, cast(AVG(Rotten_Tomatoes_Rating_Percentage) as decimal(4,2)) as rotten_tomatoes_oylama
from got
group by Season
order by rotten_tomatoes_oylama desc

-- 12.SORGU sezonlara göre ortalama metacritic_oylarının bulunması
select Season, ROUND(AVG(Metacritic_Ratings),2) as metacritic_oylama
from got
group by Season
order by metacritic_oylama desc

--13. SORGU dizi süresinin bir aralık haline getirilip hangi aralıkta toplamda kaç bölüm olduğunun bulunması
select aralık, COUNT(*) as toplam 
from
(select 
case  when Running_Time_Minutes between 45 and 54 then '44-54'
when Running_Time_Minutes between 55 and 64 then '55-64'
when Running_Time_Minutes between 65 and 74 then '65-74'
when Running_Time_Minutes between 75 and 84 then '75-84'
end as aralık
from got) 
as tablo
group by aralık 

--14. SORGU her sezon için maksimum bölüm süresinin bulunması
select g.Season, g.No_of_Episode_Season,g.Running_Time_Minutes
from got g
left join got o
on g.season = o.season and g.Running_Time_Minutes < o.running_time_minutes
where o.running_time_minutes is null
order by Running_Time_Minutes desc


--15.SORGU en uzun bölüm süresinin bulunması
select Season, No_of_Episode_Season, Running_Time_Minutes
from got
order by Running_Time_Minutes desc


--16. SORGU her sezon için maksimum metacritic_oylarının Bulunması
select g.Season, g.No_of_Episode_Season, round(g.Metacritic_Ratings, 2) as metacritic_oylama
from got g
left join got t
on g.Season = t.Season and g.Metacritic_Ratings < t.Metacritic_Ratings
where t.Metacritic_Ratings is null

--17.SORGU her sezon için Ortalama izleyici sayısının bulunması
select Season, round(avg(U_S_Viewers_Millions), 2) as izleyen_sayısı
from got 
group by Season

--18.SORGU her sezon için maksimum izleyici sayısının bulunması
select g.Season, g.No_of_Episode_Season, round(g.U_S_Viewers_Millions,2) as izleyen_sayısı
from got g
left join got t
on g.Season = t.Season and g.U_S_Viewers_Millions < t.U_S_Viewers_Millions 
where t.U_S_Viewers_Millions is null
order by izleyen_sayısı desc

--19.SORGU bölüm yazarlarının bulunması
select Written_by, COUNT(*) as toplam
from got
group by Written_by
order by toplam desc

--20. SORGU müzik yazarının bulunması
select Music_by, COUNT(*) toplam
from got
group by Music_by
order by toplam 


--21.SORGU sinematografi yapımcılarının bulunması
select Cinematography_by, count(*) as toplam
from got
group by Cinematography_by
order by toplam desc


--22.SORGU editcilerin bulunması
select Editing_by, COUNT(*) as toplam 
from got
group by Editing_by
order by toplam desc

--23.SORGU çekim yıllarıın bulunması
select year(Ordered) çekim_yılı, COUNT(*) as toplam
from got
group by year(Ordered)

-- 24.SORGU  yayın yıllarının bulunması
select YEAR(Original_Air_Date) yayın_yılı, COUNT(*) as toplam
from got
group by YEAR(Original_Air_Date)

-- 25. SORGU yayın günlerinin bulunması
select Datename(dw, Original_Air_Date) as yayın_günü, COUNT(*) as toplam
from got
group by  Datename(dw, Original_Air_Date) 

--26.SORGU çekim günlerinin bulunması 
select Datename(dw, Ordered) as çekim_günleri, COUNT(*) as toplam
from got
group by  Datename(dw, Ordered) 