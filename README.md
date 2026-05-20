# 🛒 E-Ticaret Web Uygulaması

Java Server Pages (JSP) ve DAO (Data Access Object) tasarım deseni kullanılarak geliştirilmiş, dinamik ve responsive bir e-ticaret web uygulamasıdır. Proje, web programlama prensiplerini ve ilişkisel veritabanı yönetimini uygulamak amacıyla geliştirilmiştir.

---

## 🛠️ Kullanılan Teknolojiler ve Mimari

* **Backend:** Java (Servlet & JSP)
* **Mimari Yapı:** DAO (Data Access Object) Tasarım Deseni
* **Veritabanı:** MySQL
* **Bağımlılık Yönetimi:** Maven
* **Sunucu:** Apache Tomcat (v10.1.x)
* **Frontend:** HTML5, CSS3, JavaScript (Responsive tasarım altyapısı)

---

## 🚀 Özellikler

* **Ürün Listeleme & Detayları:** Dinamik olarak veritabanından çekilen ürünlerin kategorize edilerek sergilenmesi.
* **Gelişmiş Sipariş ve Durum Takibi:** Siparişlerin durumuna göre (Örn: Hazırlanıyor, Kargoda, Tamamlandı) dinamik arayüz renklendirmeleri.
* **Favori Sistemi:** Kullanıcıların beğendikleri ürünleri favorilerine ekleyebilmesi.
* **Dosya/Görsel Yükleme:** Ürün yönetim paneli üzerinden sisteme dinamik ürün görsellerinin yüklenebilmesi.
* **Veritabanı Entegrasyonu:** Güvenli ve optimize edilmiş JDBC bağlantı yönetimi (`DBConnection`).

---

## 💻 Projeyi Yerelde Çalıştırma

### Gereksinimler
* JDK 17 veya üzeri
* Apache Tomcat 10.1+
* MySQL Server

### Kurulum Adımları
1. Projeyi bilgisayarınıza klonlayın:
   ```bash
   git clone [https://github.com/elanurdemirciql/eticaret-web.git](https://github.com/elanurdemirciql/eticaret-web.git)
