<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="header.jsp" />

<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-5">
      <div class="card shadow-sm">
        <div class="card-body">
          <h3 class="card-title text-center mb-4">Giriş Yap</h3>

          <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
          </c:if>

          <c:if test="${param.success == 'true'}">
            <div class="alert alert-success">Kayıt başarılı! Şimdi giriş yapabilirsiniz.</div>
          </c:if>

          <form action="login" method="post">
            <div class="mb-3">
              <label class="form-label">E-posta</label>
              <input type="email" name="email" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Şifre</label>
              <input type="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Giriş Yap</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>