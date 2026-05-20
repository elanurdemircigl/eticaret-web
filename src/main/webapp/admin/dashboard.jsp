<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:if test="${sessionScope.user.role != 'ADMIN'}">
  <c:redirect url="../home" />
</c:if>

<jsp:include page="admin-header.jsp" />

<div class="container mt-4">
  <h2>Yönetim Paneline Hoş Geldiniz</h2>

  <div class="row mt-4">

    <div class="col-md-4 mb-4">
      <div class="card shadow-sm border-primary text-center h-100">
        <div class="card-body py-4">
          <h5 class="card-title text-muted mb-3">Toplam Ürün</h5>
          <h2 class="display-4 fw-bold text-primary m-0">${stats.totalProducts}</h2>
        </div>
      </div>
    </div>

    <div class="col-md-4 mb-4">
      <div class="card shadow-sm border-success text-center h-100">
        <div class="card-body py-4">
          <h5 class="card-title text-muted mb-3">Toplam Kategori</h5>
          <h2 class="display-4 fw-bold text-success m-0">${stats.totalCategories}</h2>
        </div>
      </div>
    </div>

    <div class="col-md-4 mb-4">
      <div class="card shadow-sm border-info text-center h-100">
        <div class="card-body py-4">
          <h5 class="card-title text-muted mb-3">Toplam Kullanıcı</h5>
          <h2 class="display-4 fw-bold text-info m-0">${stats.totalUsers}</h2>
        </div>
      </div>
    </div>
    <div class="col-md-6 mb-4">
      <div class="card shadow-sm border-secondary text-center h-100">
        <div class="card-body py-4">
          <h5 class="card-title text-muted mb-3">Toplam Sipariş</h5>
          <h2 class="display-4 fw-bold text-secondary m-0">${stats.totalOrders}</h2>
        </div>
      </div>
    </div>

    <div class="col-md-6 mb-4">
      <div class="card shadow-sm border-warning text-center h-100">
        <div class="card-body py-4">
          <h5 class="card-title text-muted mb-3">Bekleyen Sipariş</h5>
          <h2 class="display-4 fw-bold text-warning m-0">${stats.pendingOrders}</h2>
        </div>
      </div>
    </div>

  </div>
</div>
</body>
</html>