package com.eticaret.controller;

import com.eticaret.dao.UserDAO;
import com.eticaret.model.User;
import com.eticaret.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Lütfen e-posta ve şifre alanlarını boş bırakmayınız!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        String hashedPassword = PasswordUtil.hashPassword(password);

        User loggedInUser = userDAO.loginUser(email, hashedPassword);

        if (loggedInUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", loggedInUser);
            if("ADMIN".equals(loggedInUser.getRole())) {
                response.sendRedirect("admin-dashboard");
            } else {
                response.sendRedirect("home");
            }
        } else {
            request.setAttribute("errorMessage", "E-posta veya şifre hatalı!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}