<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="header.jsp" />

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<div class="container mt-4">
  <h2 class="mb-4">Geçmiş Siparişlerim</h2>

  <c:if test="${not empty sessionScope.successMessage}">
    <div class="alert alert-success alert-dismissible fade show shadow-sm">
      <i class="bi bi-check-circle-fill me-2"></i> ${sessionScope.successMessage}
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <c:remove var="successMessage" scope="session" />
  </c:if>

  <c:choose>
    <c:when test="${empty orders}">
      <div class="alert alert-info text-center py-5 shadow-sm bg-white">
        <i class="bi bi-bag-x display-4 text-info mb-3 d-block"></i>
        <h5 class="mb-0">Henüz hiç siparişiniz bulunmamaktadır.</h5>
        <p class="text-muted mt-2">Alışverişe başlamak için ana sayfaya göz atın.</p>
        <a href="home" class="btn btn-primary mt-3">Alışverişe Başla</a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="table-responsive">
        <table class="table table-hover shadow-sm bg-white align-middle border">
          <thead class="table-dark">
          <tr>
            <th class="ps-3">Sipariş No</th>
            <th>Tarih</th>
            <th>Toplam Tutar</th>
            <th>Durum</th>
            <th class="text-center">İşlem</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="order" items="${orders}">
            <tr>
              <td class="ps-3"><strong>#100${order.id}</strong></td>
              <td><fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm"/></td>
              <td class="fw-bold text-primary">
                <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺"/>
              </td>
              <td>
                <c:set var="statusClass" value="${order.status == 'Beklemede' ? 'bg-warning text-dark' :
                                                               (order.status == 'Onaylandı' ? 'bg-success' :
                                                               (order.status == 'Tamamlandı' ? 'bg-secondary' : 'bg-info'))}" />
                <span class="badge ${statusClass}">
                    ${order.status}
                </span>
              </td>
              <td class="text-center">
                <a href="order-detail?id=${order.id}" class="btn btn-sm btn-outline-primary px-3">
                  <i class="bi bi-search me-1"></i> Detaylar
                </a>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>