<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="header.jsp" />

<div class="container mt-4">
  <h3>Sipariş Detayı (#100${orderId})</h3>
  <table class="table mt-3 bg-white shadow-sm">
    <thead class="table-light">
    <tr>
      <th>Ürün Adı</th>
      <th>Birim Fiyat</th>
      <th>Adet</th>
      <th>Ara Toplam</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="item" items="${items}">
      <tr>
        <td>${item.productName}</td>
        <td><fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₺"/></td>
        <td>${item.quantity}</td>
        <td class="fw-bold"><fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₺"/></td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>