package com.eticaret.controller;

import com.eticaret.dao.OrderDAO;
import com.eticaret.model.OrderItem;
import com.eticaret.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/order-detail")
public class OrderDetailServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int orderId = Integer.parseInt(request.getParameter("id"));

            List<OrderItem> items = orderDAO.getOrderItems(orderId);

            request.setAttribute("items", items);
            request.setAttribute("orderId", orderId);

            request.getRequestDispatcher("order-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("my-orders");
        }
    }
}