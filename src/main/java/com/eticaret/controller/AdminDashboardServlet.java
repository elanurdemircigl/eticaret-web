package com.eticaret.controller;

import com.eticaret.model.User;
import com.eticaret.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        Map<String, Integer> stats = new HashMap<>();

        try (Connection con = DBConnection.getConnection()) {
            stats.put("totalProducts", getCount(con, "SELECT COUNT(*) FROM products"));
            stats.put("totalCategories", getCount(con, "SELECT COUNT(*) FROM categories WHERE is_active = true"));
            stats.put("totalUsers", getCount(con, "SELECT COUNT(*) FROM users WHERE role = 'CUSTOMER'"));
            stats.put("totalOrders", getCount(con, "SELECT COUNT(*) FROM orders"));
            stats.put("pendingOrders", getCount(con, "SELECT COUNT(*) FROM orders WHERE status = 'Beklemede'"));
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("stats", stats);
        request.getRequestDispatcher("admin/dashboard.jsp").forward(request, response);
    }

    private int getCount(Connection con, String query) {
        try (PreparedStatement pst = con.prepareStatement(query);
             ResultSet rs = pst.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}