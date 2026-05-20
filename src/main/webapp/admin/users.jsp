<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="admin-header.jsp" />

<div class="container mt-4">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2><i class="bi bi-people-fill text-danger"></i> Kullanıcı Yönetimi</h2>
    <span class="badge bg-secondary">Toplam Kayıtlı Kullanıcı: ${users.size()}</span>
  </div>

  <div class="card shadow-sm border-0">
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
          <thead class="table-dark">
          <tr>
            <th class="ps-3">ID</th>
            <th>Ad Soyad</th>
            <th>E-posta</th>
            <th>Telefon</th>
            <th>Kayıt Tarihi</th>
            <th>Rol</th>
          </tr>
          </thead>
          <tbody>
          <c:choose>
            <c:when test="${empty users}">
              <tr>
                <td colspan="6" class="text-center py-4 text-muted">
                  Sistemde henüz kayıtlı kullanıcı bulunmamaktadır.
                </td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="u" items="${users}">
                <tr>
                  <td class="ps-3 fw-bold">#${u.id}</td>
                  <td>${u.fullName}</td>
                  <td><a href="mailto:${u.email}" class="text-decoration-none">${u.email}</a></td>
                  <td>${not empty u.phone ? u.phone : '<span class="text-muted small">Belirtilmemiş</span>'}</td>

                  <td>
                    <fmt:formatDate value="${u.createdAt}" pattern="dd.MM.yyyy HH:mm"/>
                  </td>

                  <td>
                    <span class="badge ${u.role == 'ADMIN' ? 'bg-danger' : 'bg-primary'}">
                        ${u.role}
                    </span>
                  </td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <div class="mt-3 text-muted small">
    <i class="bi bi-info-circle"></i> Kullanıcı silme yetkisi güvenlik gerekçesiyle bu panelde kısıtlanmıştır.
  </div>
</div>

</body>
</html>