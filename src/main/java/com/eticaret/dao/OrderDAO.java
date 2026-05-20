package com.eticaret.dao;
import com.eticaret.model.CartItem;
import com.eticaret.model.Order;
import com.eticaret.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
public class OrderDAO {
    public boolean createOrder(Order order, List<CartItem> cart) {
        boolean result = false;
        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            String orderQuery = "INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, ?)";
            PreparedStatement pstOrder = con.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS);
            pstOrder.setInt(1, order.getUserId());
            pstOrder.setDouble(2, order.getTotalAmount());
            pstOrder.setString(3, "Beklemede");
            pstOrder.executeUpdate();

            ResultSet rs = pstOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            String itemQuery = "INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstItem = con.prepareStatement(itemQuery);

            String stockQuery = "UPDATE products SET stock = stock - ? WHERE id = ?";
            PreparedStatement pstStock = con.prepareStatement(stockQuery);

            for (CartItem item : cart) {
                pstItem.setInt(1, orderId);
                pstItem.setInt(2, item.getProduct().getId());
                pstItem.setInt(3, item.getQuantity());
                pstItem.setDouble(4, item.getProduct().getPrice());
                pstItem.setDouble(5, item.getSubtotal());
                pstItem.addBatch();


                pstStock.setInt(1, item.getQuantity());
                pstStock.setInt(2, item.getProduct().getId());
                pstStock.addBatch();
            }


            pstItem.executeBatch();
            pstStock.executeBatch();

            con.commit();
            result = true;

        } catch (SQLException e) {
            try {
                if (con != null) con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    con.setAutoCommit(true);
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(query)) {

            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // admin kısmı
    public List<Order> getAllOrders() {
        List<Order> orders = new java.util.ArrayList<>();
        String query = "SELECT o.*, u.full_name FROM orders o JOIN users u ON o.user_id = u.id ORDER BY o.order_date DESC";

        try (java.sql.Connection con = com.eticaret.util.DBConnection.getConnection();
             java.sql.PreparedStatement pst = con.prepareStatement(query);
             java.sql.ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setCustomerName(rs.getString("full_name"));

                orders.add(order);
            }
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public boolean updateOrderStatus(int orderId, String newStatus) {
        String query = "UPDATE orders SET status = ? WHERE id = ?";
        try (java.sql.Connection con = com.eticaret.util.DBConnection.getConnection();
             java.sql.PreparedStatement pst = con.prepareStatement(query)) {

            pst.setString(1, newStatus);
            pst.setInt(2, orderId);
            return pst.executeUpdate() > 0;
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<com.eticaret.model.OrderItem> getOrderItems(int orderId) {
        List<com.eticaret.model.OrderItem> items = new ArrayList<>();
        String query = "SELECT oi.*, p.name AS product_name FROM order_items oi " +
                "JOIN products p ON oi.product_id = p.id WHERE oi.order_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(query)) {
            pst.setInt(1, orderId);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                com.eticaret.model.OrderItem item = new com.eticaret.model.OrderItem();
                item.setProductName(rs.getString("product_name")); // Modelinde bu alanın olduğundan emin ol
                item.setQuantity(rs.getInt("quantity"));
                item.setUnitPrice(rs.getDouble("unit_price"));
                item.setSubtotal(rs.getDouble("subtotal"));
                items.add(item);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return items;
    }

}
