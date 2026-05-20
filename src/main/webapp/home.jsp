<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="header.jsp" />

<div class="container mt-4">
    <div class="row">
        <div class="col-md-3 mb-4">
            <h5 class="fw-bold mb-3">Kategoriler</h5>
            <div class="list-group shadow-sm">
                <a href="home" class="list-group-item list-group-item-action ${empty param.category ? 'active bg-primary' : ''}">
                    Tüm Ürünler
                </a>

                <c:forEach var="c" items="${categories}">
                    <a href="home?category=${c.id}" class="list-group-item list-group-item-action ${param.category == c.id ? 'active bg-primary' : ''}">
                            ${c.name}
                    </a>
                </c:forEach>
            </div>
        </div>

        <div class="col-md-9">

            <c:choose>
                <c:when test="${not empty param.search}">
                    <h3 class="mb-4 text-primary">"${param.search}" için arama sonuçları</h3>
                </c:when>
                <c:otherwise>
                    <h3 class="mb-4">Öne Çıkan Ürünler</h3>
                </c:otherwise>
            </c:choose>

            <div class="row row-cols-1 row-cols-md-3 g-4">
                <c:choose>
                    <c:when test="${empty products}">
                        <div class="col-12">
                            <div class="alert alert-warning shadow-sm">
                                <c:choose>
                                    <c:when test="${not empty param.search}">
                                        Aradığınız kritere uygun ürün bulunamadı.
                                    </c:when>
                                    <c:otherwise>
                                        Bu kategoride henüz ürün bulunmamaktadır.
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <c:forEach var="p" items="${products}">
                            <div class="col">
                                <div class="card h-100 shadow-sm border-0">
                                    <img src="${p.imageUrl}" class="card-img-top p-3" alt="${p.name}" style="height: 250px; object-fit: contain;">
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title fw-bold">${p.name}</h5>
                                        <p class="card-text text-primary fw-bold fs-5 mb-2">
                                            <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₺" maxFractionDigits="2"/>
                                        </p>
                                        <p class="text-muted small mb-3" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                                ${p.description}
                                        </p>

                                        <div class="mt-auto">
                                            <c:choose>
                                                <c:when test="${p.stock > 0}">
                                                    <span class="text-success small fw-bold"><i class="bi bi-check-circle"></i> Stokta Var (${p.stock})</span>
                                                    <form action="cart" method="post" class="d-grid gap-2 mt-2">
                                                        <input type="hidden" name="action" value="add">
                                                        <input type="hidden" name="id" value="${p.id}">
                                                        <button type="submit" class="btn btn-primary">Sepete Ekle</button>
                                                        <a href="product-detail?id=${p.id}" class="btn btn-outline-secondary btn-sm">Detayları Gör</a>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-danger small fw-bold"><i class="bi bi-x-circle"></i> Tükendi</span>
                                                    <div class="d-grid gap-2 mt-2">
                                                        <button class="btn btn-secondary" disabled>Sepete Ekle</button>
                                                        <a href="product-detail?id=${p.id}" class="btn btn-outline-secondary btn-sm">Detayları Gör</a>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>

                                            <c:if test="${not empty sessionScope.user}">
                                                <c:choose>
                                                    <c:when test="${favoriteIds.contains(p.id)}">
                                                        <form action="favorites" method="post" class="mt-2">
                                                            <input type="hidden" name="action" value="remove">
                                                            <input type="hidden" name="productId" value="${p.id}">
                                                            <button type="submit" class="btn btn-danger btn-sm w-100 fw-bold">
                                                                <i class="bi bi-heartbreak"></i>  Favorilerden çıkar
                                                            </button>
                                                        </form>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <form action="favorites" method="post" class="mt-2">
                                                            <input type="hidden" name="action" value="add">
                                                            <input type="hidden" name="productId" value="${p.id}">
                                                            <button type="submit" class="btn btn-outline-danger btn-sm w-100">
                                                                <i class="bi bi-heart"></i> Favorilere Ekle
                                                            </button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>
</div>
</body>
</html>