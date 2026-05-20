package com.eticaret.controller;

import com.eticaret.dao.CategoryDAO;
import com.eticaret.dao.ProductDAO;
import com.eticaret.dao.FavoriteDAO;
import com.eticaret.model.Product;
import com.eticaret.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private FavoriteDAO favoriteDAO = new FavoriteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setAttribute("categories", categoryDAO.getAllActiveCategories());

        String categoryParam = request.getParameter("category");
        String keyword = request.getParameter("search");
        List<Product> productList;

        if (keyword != null && !keyword.trim().isEmpty()) {
            productList = productDAO.searchProducts(keyword);
        } else if (categoryParam != null && !categoryParam.isEmpty()) {
            int categoryId = Integer.parseInt(categoryParam);
            productList = productDAO.getProductsByCategory(categoryId);
        } else {
            productList = productDAO.getAllActiveProducts();
        }

        request.setAttribute("products", productList);

        List<Integer> favoriteIds = new ArrayList<>();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            List<Product> favs = favoriteDAO.getFavoritesByUserId(user.getId());
            for (Product fav : favs) {
                favoriteIds.add(fav.getId());
            }
        }
        request.setAttribute("favoriteIds", favoriteIds);

        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}