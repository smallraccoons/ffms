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
				<td><select class="mini-combobox" id="sharesid" name="sharesid"
					emptyText="请选择">
						<option value=""></option>
						<c:forEach items="${allShares }" var="allShare">
							<option value="${allShare.id }">${allShare.sharesname}</option>
						</c:forEach>
				</select></td>
				<td>交易类型：</td>
				<td><input showNullItem="true" class="mini-combobox"
					id="dataid" name="dataid" emptyText="请选择" url="data/tradeType.txt"
					textField="text" valueField="id"></td>
			</tr>
			<tr>
				<td>单价：</td>
				<td><input type="text" id="price" name="price"
					class="mini-textbox" required="true" /></td>
				<td>数量：</td>
				<td><input type="text" id="number" name="number"
					class="mini-textbox" required="true" /></td>
			</tr>
			<tr>
				<td>交易时间</td>
				<td><input id="time" name="time" class="mini-datepicker"
					required="true" style="width: 140px"></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>备注：</td>
				<td rowspan="3"><textarea id="content" name="content"
						class="mini-textarea"></textarea></td>
				<td><input id="userid" name="userid" class="mini-hidden" /></td>
				<td><a class="mini-button" onclick="submitForm">添加</a></td>
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
				url : '${basePath}tradesave.do?userid=${currentUser.id}',
				dataType : 'json',
				data : {
					sharesid : mini.get("sharesid").value,
					dataid : mini.get("dataid").value,
					price : mini.get("price").value,
					number : mini.get("number").value,
					time : mini.get("time").getFormValue(),
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
			if (mini.get("sharesid").value && mini.get("dataid").value
					&& mini.get("price").value && mini.get("number").value
					&& mini.get("time").value) {
				return true;
			}
			mini.alert("请输入完整信息");
			return false;
		}
		function check2()
		{
			var num=mini.get("price").value;
			var num2=mini.get("number").value;
			if (!(/(^[1-9]\d*$)/.test(num))) { 
			　　　　　　mini.alert('单价请输入正整数'); 
			　　　　　　return false; 
			　　　　}
			if(!(/(^[1-9]\d*$)/.test(num2))){
				mini.alert('数量请输入正整数'); 
			　　　　　　return false; 
			}
			return true;
		}
	</script>
</body>
</html>