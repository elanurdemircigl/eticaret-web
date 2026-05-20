<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="header.jsp" />

<div class="container mt-4">
  <h3 class="mb-4"><i class="bi bi-heart-fill text-danger"></i> Favori Ürünlerim</h3>

  <div class="row row-cols-1 row-cols-md-4 g-4">
    <c:choose>
      <c:when test="${empty favorites}">
        <div class="col-12">
          <div class="alert alert-info">Favori listenizde henüz ürün bulunmamaktadır.</div>
        </div>
      </c:when>
      <c:otherwise>
        <c:forEach var="p" items="${favorites}">
          <div class="col">
            <div class="card h-100 shadow-sm border-0">
              <img src="${p.imageUrl}" class="card-img-top p-3" alt="${p.name}" style="height: 200px; object-fit: contain;">
              <div class="card-body d-flex flex-column">
                <h6 class="card-title fw-bold">${p.name}</h6>
                <p class="card-text text-primary fw-bold mb-3">
                  <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₺" maxFractionDigits="2"/>
                </p>
                <div class="mt-auto d-grid gap-2">
                  <form action="cart" method="post">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="id" value="${p.id}">
                    <button type="submit" class="btn btn-primary btn-sm w-100">Sepete Ekle</button>
                  </form>
                  <form action="favorites" method="post">
                    <input type="hidden" name="action" value="remove">
                    <input type="hidden" name="productId" value="${p.id}">
                    <button type="submit" class="btn btn-outline-danger btn-sm w-100"><i class="bi bi-trash"></i> Kaldır</button>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </c:forEach>
      </c:otherwise>
    </c:choose>
  </div>
</div>
</body>
</html>