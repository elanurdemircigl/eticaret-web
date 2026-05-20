package com.eticaret.controller;

import com.eticaret.dao.ProductDAO;
import com.eticaret.model.CartItem;
import com.eticaret.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        if (action == null) {
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        int productId = 0;

        try {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.trim().isEmpty()) {
                productId = Integer.parseInt(idParam);
            } else if (!"view".equals(action)) {
                response.sendRedirect("cart");
                return;
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("cart");
            return;
        }

        switch (action) {
            case "add":
                addToCart(productId, cart, request, response);
                break;
            case "remove":
                removeFromCart(productId, cart);
                response.sendRedirect("cart");
                break;
            case "increase":
                updateQuantity(productId, cart, 1, request);
                response.sendRedirect("cart");
                break;
            case "decrease":
                updateQuantity(productId, cart, -1, request);
                response.sendRedirect("cart");
                break;
            default:
                request.getRequestDispatcher("cart.jsp").forward(request, response);
        }
    }

    private void addToCart(int productId, List<CartItem> cart, HttpServletRequest request, HttpServletResponse response) throws IOException {
        Product product = productDAO.getProductById(productId);

        if (product != null && product.getStock() > 0) {
            boolean itemExists = false;
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    if (item.getQuantity() < product.getStock()) {
                        item.setQuantity(item.getQuantity() + 1);
                    } else {
                        request.getSession().setAttribute("cartError", "Stok limitine ulaştınız!");
                    }
                    itemExists = true;
                    break;
                }
            }

            if (!itemExists) {
                cart.add(new CartItem(product, 1));
            }
        }
        response.sendRedirect("cart");
    }

    private void removeFromCart(int productId, List<CartItem> cart) {
        cart.removeIf(item -> item.getProduct().getId() == productId);
    }

    private void updateQuantity(int productId, List<CartItem> cart, int change, HttpServletRequest request) {
        for (CartItem item : cart) {
            if (item.getProduct().getId() == productId) {
                int newQuantity = item.getQuantity() + change;

                if (newQuantity < 1) {
                    request.getSession().setAttribute("cartError", "Ürün adedi en az 1 olmalıdır");
                } else if (newQuantity > item.getProduct().getStock()) {
                    request.getSession().setAttribute("cartError", "Stok yetersiz! Mevcut stok: " + item.getProduct().getStock());
                } else {
                    item.setQuantity(newQuantity);
                }
                break;
            }
        }
    }
}