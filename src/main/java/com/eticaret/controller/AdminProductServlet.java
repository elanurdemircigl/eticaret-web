package com.eticaret.controller;

import com.eticaret.dao.CategoryDAO;
import com.eticaret.dao.ProductDAO;
import com.eticaret.model.Product;
import com.eticaret.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin-products")
public class AdminProductServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));
            productDAO.deleteProduct(productId);
            response.sendRedirect("admin-products");
            return;
        } else if ("edit".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("editProduct", productDAO.getProductById(productId));
        }
        else if ("toggleStatus".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            productDAO.toggleProductStatus(id);
            response.sendRedirect("admin-products");
            return;
        }

        request.setAttribute("products", productDAO.getAllProducts());
        request.setAttribute("categories", categoryDAO.getAllActiveCategories());
        request.getRequestDispatcher("admin/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String imageUrl = request.getParameter("imageUrl");

        if (name == null || name.trim().isEmpty() ||
                priceStr == null || priceStr.trim().isEmpty() ||
                stockStr == null || stockStr.trim().isEmpty()) {
            response.sendRedirect("admin-products");
            return;
        }

        try {
            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);
            if (price < 0 || stock < 0) {
                response.sendRedirect("admin-products");
                return;
            }

            Product p = new Product();
            p.setName(name);
            p.setDescription(request.getParameter("description"));
            p.setPrice(price);
            p.setStock(stock);
            p.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            p.setImageUrl(imageUrl);

            String action = request.getParameter("action");
            if ("update".equals(action)) {
                p.setId(Integer.parseInt(request.getParameter("id")));
                productDAO.updateProduct(p);
            } else {
                productDAO.addProduct(p);
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        response.sendRedirect("admin-products");
    }
}