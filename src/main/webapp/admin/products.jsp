<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="admin-header.jsp" />

<div class="container mt-4">
  <h2 class="mb-4">Ürün Yönetimi</h2>

  <div class="card shadow mb-5 ${not empty editProduct ? 'border-warning' : 'border-danger'}">
    <div class="card-header ${not empty editProduct ? 'bg-warning text-dark' : 'bg-danger text-white'} fw-bold">
      ${not empty editProduct ? 'Ürünü Güncelle' : 'Yeni Ürün Ekle'}
    </div>
    <div class="card-body">
      <form action="${pageContext.request.contextPath}/admin-products" method="post">
        <input type="hidden" name="action" value="${not empty editProduct ? 'update' : 'add'}">
        <input type="hidden" name="id" value="${editProduct.id}">
        <div class="row">
          <div class="col-md-4 mb-3">
            <label class="form-label">Ürün Adı</label>
            <input type="text" name="name" class="form-control" value="${editProduct.name}" required>
          </div>
          <div class="col-md-4 mb-3">
            <label class="form-label">Kategori</label>
            <select name="categoryId" class="form-select">
              <c:forEach var="cat" items="${categories}">
                <option value="${cat.id}" ${editProduct.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
              </c:forEach>
            </select>
          </div>
          <div class="col-md-4 mb-3">
            <label class="form-label">Fiyat (₺)</label>
            <input type="number" step="0.01" name="price" class="form-control" value="${editProduct.price}" required>
          </div>
          <div class="col-md-4 mb-3">
            <label class="form-label">Stok Adedi</label>
            <input type="number" name="stock" class="form-control" value="${editProduct.stock}" required>
          </div>
          <div class="col-md-8 mb-3">
            <label class="form-label">Resim Linki</label>
            <input type="text" name="imageUrl" class="form-control" value="${editProduct.imageUrl}" required>
          </div>
          <div class="col-md-12 mb-3">
            <label class="form-label">Ürün Açıklaması</label>
            <textarea name="description" class="form-control" rows="2">${editProduct.description}</textarea>
          </div>
        </div>
        <button type="submit" class="btn ${not empty editProduct ? 'btn-warning' : 'btn-danger'}">
          ${not empty editProduct ? 'Güncelle' : 'Kaydet'}
        </button>
        <c:if test="${not empty editProduct}">
          <a href="${pageContext.request.contextPath}/admin-products" class="btn btn-outline-secondary ms-2">İptal</a>
        </c:if>
      </form>
    </div>
  </div>

  <h4 class="mb-3">Sistemdeki Ürünler</h4>
  <div class="table-responsive">
    <table class="table table-bordered table-hover bg-white shadow-sm align-middle">
      <thead class="table-dark">
      <tr>
        <th>ID</th>
        <th>Görsel</th>
        <th>Ürün Adı</th>
        <th>Kategori</th>
        <th>Fiyat</th>
        <th>Stok</th>
        <th class="text-center">Durum</th>
        <th style="width: 250px;">İşlem</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="p" items="${products}">
        <tr class="${!p.active ? 'bg-light text-muted' : ''}">
          <td class="fw-bold">${p.id}</td>
          <td><img src="${pageContext.request.contextPath}/${p.imageUrl}" width="40" height="40" class="rounded" style="object-fit:cover;"></td>
          <td class="fw-bold text-primary">${p.name}</td>
          <td>${p.categoryName}</td>
          <td class="fw-bold"><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₺"/></td>
          <td>
            <span class="badge ${p.stock > 0 ? 'bg-primary' : 'bg-danger'}">${p.stock}</span>
          </td>

          <td class="text-center">
             <span class="badge ${p.active ? 'bg-success' : 'bg-danger'}">
                 ${p.active ? 'Aktif' : 'Pasif'}
             </span>
          </td>

          <td>
            <a href="${pageContext.request.contextPath}/admin-products?action=edit&id=${p.id}" class="btn btn-sm btn-warning mb-1">
              <i class="bi bi-pencil"></i> Düzenle
            </a>

            <a href="${pageContext.request.contextPath}/admin-products?action=toggleStatus&id=${p.id}" class="btn btn-sm ${p.active ? 'btn-secondary' : 'btn-success'} mb-1">
              <i class="bi ${p.active ? 'bi-eye-slash' : 'bi-eye'}"></i> ${p.active ? 'Pasif Yap' : 'Aktif Yap'}
            </a>

            <a href="${pageContext.request.contextPath}/admin-products?action=delete&id=${p.id}" class="btn btn-sm btn-danger mb-1" onclick="return confirm('ürünü silmek istediğinizden emin misiniz');">
              <i class="bi bi-trash"></i> Sil
            </a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>
</body>
</html>