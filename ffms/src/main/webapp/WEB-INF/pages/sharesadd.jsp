<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/Head.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="scripts/boot.js"></script>
</head>
<body>
	<div id="form">
		<table>
			<tr>
				<td>股票名称：</td>
				<td><input type="text" id="sharesname" name="sharesname"
					class="mini-textbox" required="true" /></td>
				<td>持股人：</td>
				<td><select class="mini-combobox" id="holder" name="holder">
						<option value=""></option>
						<c:forEach items="${allUsers }" var="alluser">
							<option value="${alluser.username }">${alluser.username }</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>证券账号：</td>
				<td><select class="mini-combobox" id="securityid"
					name="securityid">
						<option value=""></option>
						<c:forEach items="${allSecuritys }" var="allSecurity">
							<option value="${allSecurity.id }">${allSecurity.securityname }</option>
						</c:forEach>
				</select></td>
				<td colspan="2"><a class="mini-button" onclick="submitForm">添加</a></td>
			</tr>
		</table>
	</div>
	<script type="text/javascript">
		mini.parse();
		function submitForm() {
			if (check()) {
				$.ajax({
					type : 'post',
					url : '${basePath}sharessave.do?userid=${currentUser.id}',
					dataType : 'json',
					data : {
						sharesname : mini.get("sharesname").value,
						holder : mini.get("holder").value,
						securityid : mini.get("securityid").value
					},
					success : function(data) {
						closewindow("save");
					},

					error : function(data) {
						mini.alert("错误信息:" + data);
					}
				});
			}
		}
		function closewindow(action) {
			if (action == "save") {
				if (alert("添加成功!")) {
					window.close();
				}
			}
			if (window.CloseOwnerWindow) {
				return window.CloseOwnerWindow(action);
			}

			else {
				window.close();
			}
		}
		function check() {
			if (mini.get("sharesname").value && mini.get("holder").value
					&& mini.get("securityid").value) {
				return true;
			}
			mini.alert("请输入完整信息");
			return false;
		}
	</script>
</body>
</html>