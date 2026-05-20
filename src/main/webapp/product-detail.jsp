<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="header.jsp" />

<div class="container mt-5">
    <div class="row">
        <div class="col-md-5 mb-4">
            <div class="card shadow-sm border-0">
                <img src="${product.imageUrl}" class="card-img-top rounded p-3" alt="${product.name}" style="object-fit: contain; max-height: 400px;">
            </div>
        </div>

        <div class="col-md-7">
            <h2 class="fw-bold">${product.name}</h2>
            <p class="text-muted mb-2">Kategori: <span class="badge bg-secondary">${product.categoryName}</span></p>

            <h3 class="text-primary fw-bold my-4">
                <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₺" maxFractionDigits="2"/>
            </h3>

            <h5 class="fw-bold">Ürün Açıklaması</h5>
            <p class="fs-5">${product.description}</p>

            <hr class="my-4">

            <div class="d-flex align-items-center bg-light p-3 rounded">
                <c:choose>
                    <c:when test="${product.stock > 0}">
                        <div class="me-4">
                            <span class="fs-5 text-success fw-bold"><i class="bi bi-check-circle-fill"></i> Stokta Var</span>
                            <br>
                            <small class="text-muted">Mevcut: ${product.stock} adet</small>
                        </div>

                        <form action="cart" method="post" class="d-flex align-items-center ms-auto">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="id" value="${product.id}">
                            <button type="submit" class="btn btn-primary btn-lg px-4 shadow">Sepete Ekle</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div>
                            <span class="fs-5 text-danger fw-bold"><i class="bi bi-x-circle-fill"></i> Tükendi</span>
                            <br>
                            <small class="text-muted">Bu ürün şu an stoklarımızda bulunmamaktadır.</small>
                        </div>
                        <button class="btn btn-secondary btn-lg ms-auto px-4" disabled>Sepete Ekle</button>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="mt-4">
                <a href="home" class="btn btn-outline-secondary">&larr; Alışverişe Geri Dön</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>