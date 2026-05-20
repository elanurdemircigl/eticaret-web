<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="admin-header.jsp" />

<div class="container mt-4">
  <h2 class="mb-4">Kategori Yönetimi</h2>

  <div class="card shadow mb-4 ${not empty editCategory ? 'border-warning' : 'border-primary'}">
    <div class="card-header ${not empty editCategory ? 'bg-warning text-dark' : 'bg-primary text-white'} fw-bold">
      ${not empty editCategory ? 'Kategoriyi Güncelle' : 'Yeni Kategori Ekle'}
    </div>
    <div class="card-body">
      <form action="admin-categories" method="post">
        <input type="hidden" name="action" value="${not empty editCategory ? 'update' : 'add'}">
        <input type="hidden" name="id" value="${editCategory.id}">

        <div class="row align-items-end">
          <div class="col-md-4 mb-3">
            <label class="form-label fw-bold">Kategori Adı</label>
            <input type="text" name="name" class="form-control" value="${editCategory.name}" required>
          </div>
          <div class="col-md-6 mb-3">
            <label class="form-label fw-bold">Kategori Açıklaması</label>
            <input type="text" name="description" class="form-control" value="${editCategory.description}">
          </div>
          <div class="col-md-2 mb-3 d-grid">
            <button type="submit" class="btn ${not empty editCategory ? 'btn-warning' : 'btn-primary'}">
              ${not empty editCategory ? 'Güncelle' : 'Kaydet'}
            </button>
          </div>
        </div>
      </form>
      <c:if test="${not empty editCategory}">
        <a href="admin-categories" class="btn btn-sm btn-outline-secondary mt-2">Güncellemeyi İptal Et</a>
      </c:if>
    </div>
  </div>

  <h4 class="mb-3">Sistemdeki Kategoriler</h4>
  <div class="table-responsive">
    <table class="table table-bordered table-hover shadow-sm align-middle bg-white">
      <thead class="table-dark">
      <tr>
        <th style="width: 50px;">ID</th>
        <th>Kategori Adı</th>
        <th>Açıklama</th>
        <th style="width: 150px;">İşlem</th>
      </tr>
      </thead>
      <tbody>
      <c:choose>
        <c:when test="${empty categories}">
          <tr>
            <td colspan="4" class="text-center py-3">Henüz aktif bir kategori bulunmamaktadır.</td>
          </tr>
        </c:when>
        <c:otherwise>
          <c:forEach var="c" items="${categories}">
            <tr>
              <td>${c.id}</td>
              <td class="fw-bold text-primary">${c.name}</td>
              <td class="text-muted">${c.description}</td>
              <td>
              <td>
                <a href="${pageContext.request.contextPath}/admin-categories?action=edit&id=${c.id}" class="btn btn-sm btn-warning mb-1">
                  <i class="bi bi-pencil"></i> Düzenle
                </a>
                <a href="${pageContext.request.contextPath}/admin-categories?action=toggleStatus&id=${c.id}" class="btn btn-sm ${c.active ? 'btn-secondary' : 'btn-success'} mb-1">
                  <i class="bi ${c.active ? 'bi-eye-slash' : 'bi-eye'}"></i> ${c.active ? 'Pasif Yap' : 'Aktif Yap'}
                </a>
                <a href="${pageContext.request.contextPath}/admin-categories?action=delete&id=${c.id}" class="btn btn-sm btn-danger mb-1" onclick="return confirm('kategoriyi silmek istediğinizden emin misiniz?');">
                  <i class="bi bi-trash"></i> Sil
                </a>
              </td>
              </td>
            </tr>
          </c:forEach>
        </c:otherwise>
      </c:choose>
      </tbody>
    </table>
  </div>
</div>
</body>
</html>