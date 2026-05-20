<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="admin-header.jsp" />

<div class="container mt-4">
    <h2 class="mb-4">Sipariş Yönetimi</h2>

    <div class="card shadow border-danger">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover align-middle bg-white">
                    <thead class="table-dark">
                    <tr>
                        <th>Sipariş No</th>
                        <th>Müşteri Adı</th> <th>Tarih</th>
                        <th>Toplam Tutar</th>
                        <th>Mevcut Durum</th>
                        <th>İşlem</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty orders}">
                            <tr>
                                <td colspan="6" class="text-center py-4 text-muted">Sistemde henüz hiç sipariş bulunmamaktadır.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td><strong>#100${order.id}</strong></td>

                                    <td class="fw-bold">${order.customerName}</td>

                                    <td><fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm"/></td>
                                    <td class="fw-bold text-success"><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺"/></td>
                                    <td>
                                        <c:set var="statusClass" value="${order.status == 'Beklemede' ? 'bg-warning text-dark' :
                                                                       (order.status == 'Teslim edildi' ? 'bg-success' :
                                                                       (order.status == 'İptal Edildi' ? 'bg-danger' : 'bg-info'))}" />
                                        <span class="badge ${statusClass}">
                                                ${order.status}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <a href="${pageContext.request.contextPath}/order-detail?id=${order.id}" class="btn btn-sm btn-outline-primary me-2">
                                                <i class="bi bi-search"></i> Detay
                                            </a>

                                            <form action="${pageContext.request.contextPath}/admin-orders" method="post" class="d-flex align-items-center m-0">
                                                <input type="hidden" name="action" value="updateStatus">
                                                <input type="hidden" name="id" value="${order.id}">

                                                <select name="status" class="form-select form-select-sm me-2" style="width: auto;">
                                                    <option value="Beklemede" ${order.status == 'Beklemede' ? 'selected' : ''}>Beklemede</option>
                                                    <option value="Onaylandı" ${order.status == 'Onaylandı' ? 'selected' : ''}>Onaylandı</option>
                                                    <option value="Hazırlanıyor" ${order.status == 'Hazırlanıyor' ? 'selected' : ''}>Hazırlanıyor</option>
                                                    <option value="Kargoya Verildi" ${order.status == 'Kargoya Verildi' ? 'selected' : ''}>Kargoya Verildi</option>
                                                    <option value="Teslim edildi" ${order.status == 'Teslim edildi' ? 'selected' : ''}>Teslim edildi</option>
                                                    <option value="İptal Edildi" ${order.status == 'İptal Edildi' ? 'selected' : ''}>İptal Edildi</option>
                                                </select>

                                                <button type="submit" class="btn btn-sm btn-danger">Güncelle</button>
                                            </form>
                                        </div>
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
</div>
</body>
</html>