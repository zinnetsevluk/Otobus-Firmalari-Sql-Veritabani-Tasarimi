 
 --1) Isuzu modelindeki otobüsleri kullanan soforler,gittigi guzergahlar ve toplam yolcu sayýlarý nelerdir?
	
	select s.Sofor_Ad,s.Sofor_Soyad,g.Varis_Yeri,o.Oto_Plaka,COUNT(y.Yolcu_TC) AS Toplam_Yolcu
	from OTOBUS o,SEFER se,GUZERGAH g,YOLCU y,ALIS a,SOFOR s,BILET b
	where o.Oto_ID=se.Oto_ID
			and se.Guzergah_No=g.Guzergah_No
			and se.Sofor_TC=s.Sofor_TC
			and b.Bilet_ID=se.Bilet_ID
			and b.Bilet_ID=a.Bilet_ID 
			and a.Yolcu_TC=y.Yolcu_TC and o.Oto_Model='Isuzu'
	group by s.Sofor_Ad,s.Sofor_Soyad,g.Varis_Yeri,o.Oto_Plaka
  
 --2)Her bir kiþinin ödeyeceði toplam ücreti çoktan aza sýrala?
	
	 select Y.Yolcu_Ad,y.Yolcu_Soyad,sum(B.Fiyat)Toplam_Ödenen
	 from YOLCU Y,BILET B,ALIS A
	 Where  B.Bilet_ID=A.Bilet_ID and A.Yolcu_TC=Y.Yolcu_TC
	 Group by Y.Yolcu_Ad,y.Yolcu_Soyad
	 Order by sum(B.Fiyat) DESC
	 
 
--3Bursa ya giden bayan yolcularýn ad , soyad, yolcu tc ve sefer tarihi?
	 
	 select  y.Yolcu_Ad,y.Yolcu_Soyad,y.Yolcu_TC,s.Sefer_Tarihi
	 from YOLCU y,ALIS a,BILET b,GUZERGAH g,SEFER s
	 where y.Yolcu_TC=a.Yolcu_TC
			and a.Bilet_ID=b.Bilet_ID
			and b.Bilet_ID=s.Bilet_ID
			and s.Guzergah_No=g.Guzergah_No
			and g.Varis_Yeri='Bursa' and y.Yolcu_Cinsiyet='Bayan'
	 
 
-- 4)En cok satýs yapan þirket personeli kimdir,ve sattýgý toplam bilet sayýsý?
	  
	  select top(1) p.Personel_Ad,p.Personel_Soyad,p.Personel_TC,COUNT(b.Bilet_ID)As Toplm_Bilet
	  from SIRKET_PERSONEL p,SATIS s,BILET b
	  where b.Bilet_ID=s.Bilet_ID and s.Personel_TC=p.Personel_TC 
	  GROUP by p.Personel_Ad,p.Personel_Soyad,p.Personel_TC
	  order by COUNT(b.Bilet_ID)desc
	  
  --5)09-10-2014 tarihinde sefer yapan otobüslerin plakasý,markasý ve taþýdýðý toplam yolcu sayýsý?
	   
	   select  o.Oto_Plaka,o.Oto_Model,COUNT(y.Yolcu_TC) AS Toplm_Yolcu
	   from SEFER s,OTOBUS o,BILET b,ALIS a,YOLCU y
	   where s.Bilet_ID=b.Bilet_ID
			and b.Bilet_ID=a.Bilet_ID 
			and a.Yolcu_TC=y.Yolcu_TC
			and s.Oto_ID=o.Oto_ID
			and s.Sefer_Tarihi='09-10-2014'
	   group by o.Oto_Plaka,o.Oto_Model
	   order by COUNT(y.Yolcu_TC) desc
	  
  --6)HÝc sefere cýkmayan muavýnler kimlerdir?
	   
	   select m.Muavin_TC,m.Muavin_Ad,m.Muavin_Soyad,m.Muavin_Yas
	   from MUAVIN m
	   except
	   select m.Muavin_TC,m.Muavin_Ad,m.Muavin_Soyad,m.Muavin_Yas
	   from MUAVIN m,SEFER s
	   where s.Muavin_TC=m.Muavin_TC 

  --7)09-10-2014 tarihinde sefere cýkan soforlerden en genc 2.sofor kimdir?

	   select top(1)so.Sofor_Ad,so.Sofor_Soyad,so.Sofor_Yas
	   from SOFOR so,SEFER s
	   where so.Sofor_TC=s.Sofor_TC and s.Sefer_Tarihi='09-10-2014' 
				and so.Sofor_Yas NOT IN (select MIN(so1.Sofor_Yas)
													from SOFOR so1,SEFER s1
													where so1.Sofor_TC=s1.Sofor_TC and s1.Sefer_Tarihi='09-10-2014' )
	  order by so.Sofor_Yas 

--8)Yasi 30 dan büyük olan soforler, yapmýþ olduðu seferler ve mola yerlerý ve ortalama varis süreleri ?

    select DISTINCT SO.Sofor_Ad,SO.Sofor_Soyad,SO.Sofor_Yas,G.Varis_Yeri,M.Mola_Yeri,G.Ortalama_Varis_Suresi
	from GUZERGAH G INNER JOIN SEFER S ON G.GUZERGAH_NO=S.GUZERGAH_NO 
		            INNER JOIN MOLA_YERI M ON S.Mola_ID=M.Mola_ID
				    INNER JOIN SOFOR SO ON S.Sofor_TC=SO.Sofor_TC
	 where SO.Sofor_Yas>30
 
--9)Son Gün(Yani 2. Gün) Satýlan biletlerin Ortalama Fiyatlarý,ve kaç tane satýldýðý?
	
	select top(1) S.Sefer_Tarihi,AVG(B.Fiyat)AS Ortalama_Fiyat,Count(B.Bilet_ID)AS Bilet_Sayýsý
	from SEFER S,BILET B,SATIS SE,SIRKET_PERSONEL P
	Where S.Bilet_ID=B.Bilet_ID 
			And S.Bilet_ID=SE.Bilet_ID
			And SE.Personel_TC=P.Personel_TC
	GROUP BY S.Sefer_Tarihi
	Order by S.Sefer_Tarihi DESC

 --10)Manisa ya gidip yolcu adý a harfini iceren kisiler?
  
	  select Yolcu_Ad,y.Yolcu_Soyad,y.Yolcu_TC
	  from YOLCU y,ALIS a,BILET b,SEFER s,GUZERGAH g
	  where  y.Yolcu_TC=a.Yolcu_TC 
			and a.Bilet_ID=b.Bilet_ID 
			and s.Bilet_ID=b.Bilet_ID 
			and g.Guzergah_No=s.Guzergah_No 
			and  y.Yolcu_Ad LIKE '%a%' and g.Varis_Yeri='Manisa' 
