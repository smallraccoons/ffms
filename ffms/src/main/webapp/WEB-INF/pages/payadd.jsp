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
				<td>支出人:</td>
				<td><select class="mini-combobox" id="payer" name="payer">
						<option value=""></option>
						<c:forEach items="${allUsers }" var="alluser">
							<option value="${alluser.username }">${alluser.username }</option>
						</c:forEach>
				</select></td>
				<td>收入来源：</td>
				<td><input id="tword" name="tword" class="mini-textbox"
					required="true" /></td>
			</tr>
			<tr>
				<td>金额：</td>
				<td><input id="money" name="money" class="mini-textbox"
					required="true" /></td>
				<td>支出类型：</td>
				<td><input id="datadicvalue" name="datadicvalue"
					class="mini-combobox" class="mini-combobox"
					url="data/payType.txt" textField="text" valueField="id"
					required="true" /></td>
			</tr>
			<tr>
				<td>支出时间:</td>
				<td><input id="paytime" name="paytime"
					class="mini-datepicker" required="true" /></td>
				<td>备注:</td>
				<td><input id="content" name="content" class="mini-textarea" /></td>
			</tr>
			<tr>
				<td colspan="2"></td>
				<td colspan="2"><a class="mini-button" onclick="submitForm">添加</a></td>
			</tr>
		</table>
	</div>
	<script type="text/javascript">
		mini.parse();
		function submitForm() {
			if (check()&&check2()) { 
			var form = new mini.Form("#form");
			var data = form.getData();
			var json = mini.encode(data);
			$.ajax({
				type : 'post',
				url : '${basePath}paysave.do?userid=${currentUser.id}',
				dataType : 'json',
				data : {
					payer : mini.get("payer").value,
					tword : mini.get("tword").value,
					money : mini.get("money").value,
					dataid : mini.get("datadicvalue").value,
					paytime : mini.get("paytime").getFormValue(),
					content : mini.get("content").value
					
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
			if (mini.get("payer").value && mini.get("tword").value
					&& mini.get("money").value && mini.get("datadicvalue").value
					&& mini.get("paytime").value) {
				return true;
			}
			mini.alert("请输入完整信息");
			return false;
		}
		function check2()
		{
			var num=mini.get("money").value;
			if (!(/(^[1-9]\d*$)/.test(num))) { 
			　　　　　　mini.alert('金额请输入正整数'); 
			　　　　　　return false; 
			　　　　}
			return true;
		}
	</script>
</body>
</html>