<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="header.jsp" />

<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow-sm">
        <div class="card-body">
          <h3 class="card-title text-center mb-4">Kayıt Ol</h3>


          <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
          </c:if>

          <form action="register" method="post">
            <div class="mb-3">
              <label class="form-label">Ad Soyad</label>
              <input type="text" name="fullName" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">E-posta</label>
              <input type="email" name="email" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Şifre</label>
              <input type="password" name="password" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Telefon</label>
              <input type="text" name="phone" class="form-control">
            </div>
            <div class="mb-3">
              <label class="form-label">Adres</label>
              <textarea name="address" class="form-control" rows="3"></textarea>
            </div>
            <button type="submit" class="btn btn-primary w-100">Kayıt Ol</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>