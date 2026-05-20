<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="tr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Paneli - E-Ticaret</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <style>
    body { background-color: #f8f9fa; }
    .navbar-brand { font-weight: bold; letter-spacing: 1px; }
  </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-danger mb-4 shadow-sm">
  <div class="container">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/admin-dashboard">
      <i class="bi bi-shield-lock-fill"></i> YÖNETİCİ PANELİ
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="adminNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin-dashboard">Ana Sayfa</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin-categories">Kategori Yönetimi</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin-products">Ürün Yönetimi</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin-orders">Sipariş Yönetimi</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/admin-users">Kullanıcılar</a>
        </li>
      </ul>

      <ul class="navbar-nav ms-auto">
        <li class="nav-item d-flex align-items-center">
          <span class="navbar-text text-warning fw-bold me-3">
            <i class="bi bi-person-circle"></i> ${sessionScope.user.fullName}
          </span>
        </li>
        <li class="nav-item">
          <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/logout.jsp">
            <i class="bi bi-box-arrow-right"></i> Çıkış Yap
          </a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>