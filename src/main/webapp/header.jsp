<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Elanur-Ticaret</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="home">E-Ticaret</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="home">Ana Sayfa</a>
                </li>
            </ul>
            <form action="home" method="get" class="d-flex mx-auto col-md-5">
                <div class="input-group">
                    <input class="form-control" type="search" name="search"
                           placeholder="Ürün arayınız"
                           aria-label="Search" value="${param.search}">
                    <button class="btn btn-primary" type="submit">
                        <i class="bi bi-search"></i> Ara
                    </button>
                </div>
            </form>

            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="cart">
                        <i class="bi bi-cart3"></i> Sepetim
                        <c:if test="${not empty sessionScope.cart}">
                            <span class="badge bg-danger rounded-pill">${sessionScope.cart.size()}</span>
                        </c:if>
                    </a>
                </li>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item"><a class="nav-link" href="my-orders">Siparişlerim</a></li>
                        <li class="nav-item"><a class="nav-link" href="favorites"><i class="bi bi-heart"></i> Favorilerim</a></li>
                        <li class="nav-item">
                            <span class="nav-link text-warning fw-bold small">
                                <i class="bi bi-person-circle"></i> ${sessionScope.user.fullName}
                            </span>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="logout.jsp">Çıkış Yap</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="login">Giriş Yap</a></li>
                        <li class="nav-item"><a class="nav-link" href="register">Kayıt Ol</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>