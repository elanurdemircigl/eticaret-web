package com.eticaret.dao;

import com.eticaret.model.Product;
import com.eticaret.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FavoriteDAO {

    //favoriye ekle
    public boolean addFavorite(int userId, int productId) {
        String query = "INSERT IGNORE INTO favorites (user_id, product_id) VALUES (?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(query)) {

            pst.setInt(1, userId);
            pst.setInt(2, productId);
            return pst.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    //favoriden çıkar
    public boolean removeFavorite(int userId, int productId) {
        String query = "DELETE FROM favorites WHERE user_id = ? AND product_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(query)) {

            pst.setInt(1, userId);
            pst.setInt(2, productId);
            return pst.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Product> getFavoritesByUserId(int userId) {
        List<Product> favoriteProducts = new ArrayList<>();
        String query = "SELECT p.*, c.name as category_name FROM favorites f " +
                "JOIN products p ON f.product_id = p.id " +
                "JOIN categories c ON p.category_id = c.id " +
                "WHERE f.user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(query)) {

            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setImageUrl(rs.getString("image_url"));
                p.setDescription(rs.getString("description"));
                p.setStock(rs.getInt("stock"));
                favoriteProducts.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return favoriteProducts;
    }
}