<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="/calculator/styles.css">
<!-- <script type="text/javascript" src="/calculator/keyBindings.js"></script> -->
<script type="text/javascript" src="/calculator/calculator.js"></script>
<title>Web Calculator</title>
<c:choose>
	<c:when test="${param.numNumbers != null}">
		<c:set var="numNumbers" scope="session" value="${param.numNumbers}"></c:set>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${numNumbers != null}">
				<c:set var="numNumbers" scope="session" value="${numNumbers}"></c:set>
			</c:when>
			<c:otherwise>
				<c:set var="numNumbers" scope="session" value="10"></c:set>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${param.numCol != null}">
		<c:set var="numCol" scope="session" value="${param.numCol}"></c:set>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${numCol != null}">
				<c:set var="numCol" scope="session" value="${numCol}"></c:set>
			</c:when>
			<c:otherwise>
				<c:set var="numCol" scope="session" value="3"></c:set>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>
<style>
.digit {
	width: <c:out value="${ ((100-(numCol-1)*2))/numCol }"/>%;
}
</style>
</head>
<body>
	<div id="settings">
		<form id="settingsForm" action="/calculator/" method="post">
			<p class="settingsLabel"># num</p>
			<input id="numNumbers" class="settingsInput" type="number" name="numNumbers" min="1" value="<c:out value="${ sessionScope.numNumbers }"/>" step="1">
			<p class="settingsLabel"># col num</p>
			<input id="numCol" class="settingsInput" type="number" name="numCol" min="1" value="<c:out value="${ sessionScope.numCol }"/>" step="1">
			<div id="settingsSubmitWrapper">
				<input id="settingsSubmit" type="submit" name="settingsSubmit" value="Imposta">
			</div>
		</form>
	</div>
	<div id="calculator">
		<form id="calculatorForm" action="/calculator/calculate/" method="post">
<%-- 			<input id="display" type="text" name="display" readonly="readonly" value="<c:out value="${ display }"/>"> --%>
			<input id="display" type="text" name="display" readonly="readonly" value="<c:out value="${ applicationScope.display }"/>">
			<input id="touched" type="hidden" name="touched" value="false">
			<input id="operator" type="hidden" name="operator">
			<input id="prevOperator" type="hidden" name="prevOperator" value="<c:out value="${ prevOperator }"/>">
			<input id="prevOperand" type="hidden" name="prevOperand" value="<c:out value="${ applicationScope.prevOperand }"/>">
			<div id="digits">
				<c:forEach var="i" begin="1" end="${ numNumbers - 1 }">
					<button class="digit<c:if test="${ (i % numCol) == 1 }"> firstCol</c:if><c:if test="${ (i % numCol) == 0 }"> lastCol</c:if>" type="button" onclick="digitPress(${i})">${i}</button>
				</c:forEach>
				<button class="digit<c:if test="${ (numNumbers % numCol) == 1 }"> firstCol</c:if><c:if test="${ (numNumbers % numCol) == 0 }"> lastCol</c:if>" type="button" onclick="digitPress(0)">0</button>
				<button class="digit<c:if test="${ ((numNumbers+1) % numCol) == 1 }"> firstCol</c:if><c:if test="${ ((numNumbers+1) % numCol) == 0 }"> lastCol</c:if>" type="button" onclick="dotPress()">.</button>
			</div>
			<div id="operators">
				<button class="operatorsButton" type="button" onclick="operatorPress('+')">+</button><br />
				<button class="operatorsButton" type="button" onclick="operatorPress('-')">-</button><br />
				<button class="operatorsButton" type="button" onclick="operatorPress('*')">x</button><br />
				<button class="operatorsButton" type="button" onclick="operatorPress('/')">:</button><br />
			</div>
			<div id="lastRow">
				<button id="equal" name="equalInput" type="button" onclick="submitForm('=')">=</button>
				<button id="reset" type="button" onclick="resetCalculator()">C</button>
			</div>
		</form>
	</div>
	<c:if test="${ prevOperator != null }">
	<b id="prevOperatorLabel"><c:out value="${ prevOperator }"></c:out></b>
	</c:if>
	<c:if test="${ msg != null }">
	<h1 id="msg"><c:out value="${ msg }"/></h1>
	</c:if>
</body>
</html>