package com.eticaret.controller;

import com.eticaret.dao.UserDAO;
import com.eticaret.model.User;
import com.eticaret.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (fullName == null || fullName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Lütfen Ad Soyad, E-posta ve Şifre alanlarını boş bırakmayınız!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("errorMessage", "Şifreniz güvenliğiniz için en az 6 karakter olmalıdır!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        if (userDAO.checkEmailExists(email)) {
            request.setAttribute("errorMessage", "Bu e-posta adresi sistemde zaten kayıtlı!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User newUser = new User();
        newUser.setFullName(fullName);
        newUser.setEmail(email);
        String hashedPassword = com.eticaret.util.PasswordUtil.hashPassword(password);
        newUser.setPassword(hashedPassword);
        newUser.setPhone(phone);
        newUser.setAddress(address);

        boolean isRegistered = userDAO.registerUser(newUser);

        if (isRegistered) {
            response.sendRedirect("login.jsp?success=true");
        } else {
            request.setAttribute("errorMessage", "Kayıt işlemi sırasında sistemsel bir hata oluştu.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}