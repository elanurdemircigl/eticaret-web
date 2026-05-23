-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 20 May 2026, 09:43:00
-- Sunucu sürümü: 10.4.32-MariaDB
-- PHP Sürümü: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `eticaret_db`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `is_active`) VALUES
(1, 'Telefon', 'Akıllı Telefonlar', 1),
(2, 'Bilgisayar', 'Dizüstü ve Masaüstü', 1),
(3, 'Kozmetik', 'Makyaj ve Kişisel Bakım Ürünleri', 1),
(4, 'Kulaklık', 'Kablolu ve kablosuz kulaklık modelleri', 1),
(5, 'Aksesuar', 'Kolye, küpe, bileklik ', 1);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `favorites`
--

CREATE TABLE `favorites` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `favorites`
--

INSERT INTO `favorites` (`id`, `user_id`, `product_id`, `created_at`) VALUES
(1, 7, 1, '2026-05-09 11:57:58'),
(5, 7, 5, '2026-05-09 11:58:05'),
(7, 8, 3, '2026-05-09 12:15:14'),
(8, 8, 6, '2026-05-09 12:16:28'),
(9, 8, 9, '2026-05-09 12:16:35');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `order_date`, `total_amount`, `status`) VALUES
(1, 2, '2026-05-06 16:43:31', 75000.00, 'Teslim edildi'),
(2, 2, '2026-05-06 17:43:58', 75450.00, 'Teslim edildi'),
(3, 2, '2026-05-06 18:14:16', 4650.00, 'Teslim edildi'),
(4, 3, '2026-05-06 18:17:09', 225000.00, 'Hazırlanıyor'),
(5, 2, '2026-05-06 18:39:24', 1170.00, 'İptal Edildi'),
(6, 3, '2026-05-06 18:46:37', 450.00, 'Onaylandı'),
(7, 4, '2026-05-06 19:21:46', 75000.00, 'İptal Edildi'),
(8, 5, '2026-05-08 16:13:48', 2330.00, 'Kargoya Verildi'),
(9, 7, '2026-05-09 11:45:03', 5140.00, 'Teslim edildi'),
(10, 8, '2026-05-09 12:24:01', 1160.00, 'Onaylandı');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES
(1, 1, 2, 1, 75000.00, 75000.00),
(2, 2, 3, 1, 450.00, 450.00),
(3, 2, 2, 1, 75000.00, 75000.00),
(4, 3, 3, 5, 450.00, 2250.00),
(5, 3, 8, 2, 1200.00, 2400.00),
(6, 4, 2, 3, 75000.00, 225000.00),
(7, 5, 3, 1, 450.00, 450.00),
(8, 5, 4, 4, 180.00, 720.00),
(9, 6, 3, 1, 450.00, 450.00),
(10, 7, 2, 1, 75000.00, 75000.00),
(11, 8, 7, 2, 290.00, 580.00),
(12, 8, 6, 1, 550.00, 550.00),
(13, 8, 8, 1, 1200.00, 1200.00),
(14, 9, 5, 2, 320.00, 640.00),
(15, 9, 9, 1, 4500.00, 4500.00),
(16, 10, 6, 1, 550.00, 550.00),
(17, 10, 7, 1, 290.00, 290.00),
(18, 10, 5, 1, 320.00, 320.00);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `image_url` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `description`, `price`, `stock`, `image_url`, `is_active`, `created_at`) VALUES
(1, 1, 'iPhone 15', '256 GB, Mavi Renk, Yeni Nesil Akıllı Telefon', 55000.00, 10, 'images/iphone.jpg', 1, '2026-05-05 19:20:38'),
(2, 2, 'MacBook Pro', 'M3 Çip, 16GB RAM, 512GB SSD', 75000.00, 14, 'images/macbook.jpg', 1, '2026-05-05 19:20:38'),
(3, 3, 'Kırmızı Ruj', 'Uzun süre kalıcı, yoğun renk veren ruj', 450.00, 42, 'images/ruj.jpg', 1, '2026-05-05 19:30:19'),
(4, 3, 'Dudak Kalemi', 'Suya dayanıklı, yumuşak uçlu kahverengi tonlu dudak kalemi', 180.00, 96, 'images/kalem.jpg', 1, '2026-05-05 19:30:19'),
(5, 3, 'Allık Fırçası', 'Yumuşak kıllı, homojen dağılım sağlayan makyaj fırçası', 320.00, 27, 'images/firca.jpg', 1, '2026-05-05 19:30:19'),
(6, 3, 'Şeftali Tonlu Allık', 'Doğal ve canlı bir görünüm veren ipeksi dokulu allık', 550.00, 43, 'images/sefallik.jpg', 1, '2026-05-05 19:30:19'),
(7, 3, 'Gloss', 'Yapışkan his bırakmayan, dolgunlaştırıcı etkili gloss', 290.00, 57, 'images/gloss.jpg', 1, '2026-05-05 19:30:19'),
(8, 3, 'Far Paleti', 'Kendi göz farı kombinasyonlarınızı karıştırın ve yaratın.', 1200.00, 5, 'images/far.jpg', 1, '2026-05-06 15:35:36'),
(9, 4, 'Bluetooth Kulaklık', 'Gelişmiş ses teknolojileri ve yenilikçi tasarımı ile mükemmel bir ses deneyimi', 4500.00, 39, 'images/bkulaklik.jpg', 0, '2026-05-06 19:19:28');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `role` enum('CUSTOMER','ADMIN') DEFAULT 'CUSTOMER',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `password`, `phone`, `address`, `role`, `created_at`) VALUES
(1, 'Sistem Yöneticisi', 'elanur@eticaret.com', 'ela123', NULL, NULL, 'ADMIN', '2026-05-05 15:03:01'),
(2, 'Elanur', 'e@eticaret.com', 'ela123', '', 'Yeşilli Sokak', 'CUSTOMER', '2026-05-06 16:43:17'),
(3, 'duru eken', 'dru@eticaret.com', 'ela123', '', '', 'CUSTOMER', '2026-05-06 18:16:54'),
(4, 'a', 'a@g.com', 'ela123', '', '', 'CUSTOMER', '2026-05-06 19:21:32'),
(5, 'beyza', 'bey@gmail.com', 'ela123', '5318459605', 'Atakum, Samsun', 'CUSTOMER', '2026-05-08 16:12:54'),
(6, 'Sistem Yöneticisi', 'elanur@e.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', '05854523641', 'yurt', 'ADMIN', '2026-05-09 11:43:33'),
(7, 'beyza', 'by@g.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', '', 'atakum', 'CUSTOMER', '2026-05-09 11:44:30'),
(8, 'Elanur', 'e@g.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', '', 'yurttt', 'CUSTOMER', '2026-05-09 12:14:59');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_fav` (`user_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Tablo için indeksler `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Tablo için indeksler `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Tablo için indeksler `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tablo için AUTO_INCREMENT değeri `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Tablo için AUTO_INCREMENT değeri `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Tablo için AUTO_INCREMENT değeri `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Tablo için AUTO_INCREMENT değeri `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Tablo kısıtlamaları `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
