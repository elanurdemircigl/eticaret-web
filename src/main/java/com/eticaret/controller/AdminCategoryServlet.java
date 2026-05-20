package com.eticaret.controller;

import com.eticaret.dao.CategoryDAO;
import com.eticaret.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin-categories")
public class AdminCategoryServlet extends HttpServlet {

    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            categoryDAO.deleteCategory(id);
            response.sendRedirect("admin-categories");
            return;
        }
        else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("editCategory", categoryDAO.getCategoryById(id));
        }
        else if ("toggleStatus".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            categoryDAO.toggleCategoryStatus(id);
            response.sendRedirect("admin-categories");
            return;
        }

        request.setAttribute("categories", categoryDAO.getAllCategories());
        request.getRequestDispatcher("admin/categories.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (name == null || name.trim().isEmpty()) {
            response.sendRedirect("admin-categories");
            return;
        }

        if ("add".equals(action)) {
            categoryDAO.addCategory(name, description);
        }
        else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            categoryDAO.updateCategory(id, name, description);
        }

        response.sendRedirect("admin-categories");
    }
}