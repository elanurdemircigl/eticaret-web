<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="header.jsp" />

<div class="container mt-4">
  <h2 class="mb-4">Alışveriş Sepetim</h2>

  <c:if test="${not empty sessionScope.cartError}">
    <div class="alert alert-warning alert-dismissible fade show" role="alert">
        ${sessionScope.cartError}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>

    <c:remove var="cartError" scope="session" />
  </c:if>

  <c:choose>
    <c:when test="${empty sessionScope.cart}">
      <div class="alert alert-info text-center py-5">
        <h4>Sepetiniz şu an boş.</h4>
        <p>Hemen alışverişe başlayıp sepetinizi doldurabilirsiniz!</p>
        <a href="home" class="btn btn-primary mt-2">Alışverişe Başla</a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="row">
        <div class="col-md-8">
          <div class="card shadow-sm">
            <div class="card-body">
              <table class="table align-middle">
                <thead>
                <tr>
                  <th>Ürün</th>
                  <th>Fiyat</th>
                  <th class="text-center">Adet</th>
                  <th>Ara Toplam</th>
                  <th></th>
                </tr>
                </thead>
                <tbody>
                <c:set var="totalAmount" value="0" />
                <c:forEach var="item" items="${sessionScope.cart}">
                  <tr>
                    <td>
                      <div class="d-flex align-items-center">
                        <img src="${item.product.imageUrl}" alt="..." style="width: 50px; height: 50px; object-fit: cover;" class="me-3 rounded">
                        <span class="fw-bold">${item.product.name}</span>
                      </div>
                    </td>
                    <td><fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₺" maxFractionDigits="2"/></td>
                    <td>
                      <div class="d-flex justify-content-center align-items-center">
                        <a href="cart?action=decrease&id=${item.product.id}" class="btn btn-sm btn-outline-secondary">-</a>
                        <span class="mx-3 fw-bold">${item.quantity}</span>
                        <a href="cart?action=increase&id=${item.product.id}" class="btn btn-sm btn-outline-secondary">+</a>
                      </div>
                    </td>
                    <td class="fw-bold text-primary">
                      <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₺" maxFractionDigits="2"/>
                    </td>
                    <td class="text-end">
                      <a href="cart?action=remove&id=${item.product.id}" class="btn btn-sm btn-danger">Sil</a>
                    </td>
                  </tr>
                  <c:set var="totalAmount" value="${totalAmount + item.subtotal}" />
                </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <div class="col-md-4">
          <div class="card shadow-sm border-primary">
            <div class="card-body">
              <h5 class="card-title mb-4">Sipariş Özeti</h5>
              <div class="d-flex justify-content-between mb-3">
                <span>Toplam Tutar:</span>
                <span class="fw-bold fs-5 text-primary">
                                    <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₺" maxFractionDigits="2"/>
                                </span>
              </div>
              <hr>
              <c:choose>
                <c:when test="${not empty sessionScope.user}">
                  <a href="order-checkout" class="btn btn-success w-100 btn-lg">Siparişi Tamamla</a>
                </c:when>
                <c:otherwise>
                  <div class="alert alert-warning small text-center">
                    Siparişi tamamlamak için giriş yapmalısınız.
                  </div>
                  <a href="login" class="btn btn-primary w-100">Giriş Yap</a>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>
      </div>
    </c:otherwise>
  </c:choose>
</div>
</body>
</html>