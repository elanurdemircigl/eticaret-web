package com.eticaret.controller;

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
import java.util.List;

@WebServlet("/favorites")
public class FavoriteServlet extends HttpServlet {

    private FavoriteDAO favoriteDAO = new FavoriteDAO();

    // Favorileri Listeleme (Sayfayı Görüntüleme)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Kullanıcı giriş yapmamışsa login sayfasına yönlendir
        if (user == null) {
            response.sendRedirect("login.jsp?error=Lutfen once giris yapin");
            return;
        }

        // Kullanıcının favori ürünlerini veritabanından çek ve JSP'ye gönder
        List<Product> favoriteProducts = favoriteDAO.getFavoritesByUserId(user.getId());
        request.setAttribute("favorites", favoriteProducts);
        request.getRequestDispatcher("favorites.jsp").forward(request, response);
    }

    // Favoriye Ekleme veya Çıkarma İşlemi
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));

        if ("add".equals(action)) {
            favoriteDAO.addFavorite(user.getId(), productId);
        } else if ("remove".equals(action)) {
            favoriteDAO.removeFavorite(user.getId(), productId);
        }

        // İşlem bitince kullanıcının geldiği sayfaya geri dönmesini sağla
        String referer = request.getHeader("Referer");
        response.sendRedirect(referer != null ? referer : "favorites");
    }
}