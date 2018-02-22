CREATE TABLE YOLCU(
	Yolcu_TC INT PRIMARY KEY,
    Yolcu_Ad VARCHAR(30),
    Yolcu_Soyad VARCHAR(30),
    Yolcu_Cinsiyet VARCHAR(10)NOT NULL
  );
  
  CREATE TABLE BILET(
   Bilet_ID INT PRIMARY KEY,
   Fiyat MONEY,
   Koltuk_NO INT NOT NULL   
  );
  
  CREATE TABLE ALIS(
     Alis_Tarihi DATE,
     Bilet_ID INT,
     Yolcu_TC INT,
     FOREIGN KEY (Bilet_ID)REFERENCES BILET(Bilet_ID),
     FOREIGN KEY (Yolcu_TC)REFERENCES YOLCU(Yolcu_TC)
  );
  
  CREATE TABLE REZERVASYON(
      Yolcu_TC INT,
      Bilet_ID INT,
      Rezerv_Tarih DATE,
      Rezerv_BitTarih DATE,
     FOREIGN KEY (Bilet_ID)REFERENCES BILET(Bilet_ID),
     FOREIGN KEY (Yolcu_TC)REFERENCES YOLCU(Yolcu_TC)
  
  );
 
  CREATE TABLE SIRKET_PERSONEL(
      Personel_TC INT PRIMARY KEY,
      Personel_Ad VARCHAR(30),
      Personel_Soyad VARCHAR(30),
      Personel_Yas INT      
  
  );
   CREATE TABLE SATIS(
     Satis_ID INT PRIMARY KEY,
     Personel_TC INT,
     Bilet_ID INT,
    
     CONSTRAINT fk_sirketPersonel FOREIGN KEY(Personel_TC) REFERENCES SIRKET_PERSONEL(Personel_TC),
     CONSTRAINT fk_b FOREIGN KEY(Bilet_ID) REFERENCES BILET(Bilet_ID)
  );
  CREATE TABLE OTOBUS(
    Oto_ID INT PRIMARY KEY,
    Oto_Model VARCHAR(20),
    Oto_Kapasite INT NOT NULL,
    Oto_Plaka VARCHAR(20)UNIQUE,
    Oto_Telefon VARCHAR(20) UNIQUE
  
  );
  
  CREATE TABLE SOFOR(
     Sofor_TC INT PRIMARY KEY,
     Sofor_Ad VARCHAR(30),
     Sofor_Soyad VARCHAR(30),
     Sofor_Yas INT,
     Sofor_Ehliyet_No INT NOT NULL,
     Sofor_Tel VARCHAR(30) UNIQUE
     
  );
  CREATE TABLE GUZERGAH(
     Guzergah_No INT PRIMARY KEY,
     Kalkis_Yeri VARCHAR(30),
     Varis_Yeri VARCHAR(30),
     Ortalama_Varis_Suresi INT
  );
  CREATE TABLE MUAVIN(
     Muavin_TC INT PRIMARY KEY,
     Muavin_Ad VARCHAR(30),
     Muavin_Soyad VARCHAR(30),
     Muavin_Yas Int
  );
  CREATE TABLE MOLA_YERI(
     Mola_ID INT PRIMARY KEY,
     Mola_Yeri VARCHAR(30)NOT NULL,
     Mola_Adres VARCHAR(30),
     Mola_Tel VARCHAR(20) UNIQUE
  
  );
  
  CREATE TABLE SEFER(
      Kalkis_Saati TIME NOT NULL,
      Varis_Saati TIME NOT NULL,
      Sefer_Tarihi DATE,
      Sefer_ID INT,
      Bilet_ID INT,
      Guzergah_No INT,
      Muavin_TC INT,
      Sofor_TC INT,
      Oto_ID INT,
      Mola_ID INT,
    
      PRIMARY KEY(Sefer_ID,Bilet_ID),
      CONSTRAINT fk_sofor FOREIGN KEY(Sofor_TC) REFERENCES SOFOR(Sofor_TC),
      CONSTRAINT fk_otobus FOREIGN KEY(Oto_ID) REFERENCES OTOBUS(Oto_ID),
      CONSTRAINT fk_mola_yeri FOREIGN KEY(Mola_ID) REFERENCES MOLA_YERI(Mola_ID),
      CONSTRAINT fk_muavin FOREIGN KEY(Muavin_TC) REFERENCES MUAVIN(Muavin_TC),
      CONSTRAINT fk_guzergah FOREIGN KEY(Guzergah_No) REFERENCES GUZERGAH(Guzergah_No),
      CONSTRAINT fk_bilet FOREIGN KEY(Bilet_ID) REFERENCES BILET(Bilet_ID)
  );
  


  
												