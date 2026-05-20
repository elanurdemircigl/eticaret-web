package com.eticaret.controller;

import com.eticaret.dao.OrderDAO;
import com.eticaret.model.CartItem;
import com.eticaret.model.Order;
import com.eticaret.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/order-checkout", "/my-orders"})
public class OrderServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");

        if (loggedInUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("/my-orders".equals(path)) {
            List<Order> myOrders = orderDAO.getOrdersByUserId(loggedInUser.getId());
            request.setAttribute("orders", myOrders);
            request.getRequestDispatcher("my-orders.jsp").forward(request, response);
        }

        else if ("/order-checkout".equals(path)) {
            @SuppressWarnings("unchecked")
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            if (cart == null || cart.isEmpty()) {
                response.sendRedirect("cart");
                return;
            }

            double totalAmount = 0;
            for (CartItem item : cart) {
                totalAmount += item.getSubtotal();
            }

            Order newOrder = new Order();
            newOrder.setUserId(loggedInUser.getId());
            newOrder.setTotalAmount(totalAmount);

            boolean isSuccess = orderDAO.createOrder(newOrder, cart);

            if (isSuccess) {
                session.removeAttribute("cart");
                session.setAttribute("successMessage", "Siparişiniz başarıyla alındıı");
                response.sendRedirect("my-orders");
            } else {
                session.setAttribute("cartError", "Sipariş oluşturulurken bir hata meydana geldi.");
                response.sendRedirect("cart");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}