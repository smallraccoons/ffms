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
				<td>收入人:</td>
				<td><select class="mini-combobox" id="incomer" name="incomer">
						<option value=""></option>
						<c:forEach items="${allUsers }" var="alluser">
							<option value="${alluser.username }">${alluser.username }</option>
						</c:forEach>
				</select></td>
				<td>收入来源：</td>
				<td><input id="source" name="source" class="mini-textbox"
					required="true" /></td>
			</tr>
			<tr>
				<td>金额：</td>
				<td><input id="money" name="money"
					class="mini-textbox" required="true" /></td>
				<td>收入类型：</td>
				<td><input id="datadicvalue" name="datadicvalue" class="mini-combobox"
					class="mini-combobox" url="data/incomeType.txt" textField="text"
					valueField="id" required="true"/></td>
			</tr>
			<tr>
				<td>收入时间:</td>
				<td><input id="incometime" name="incometime"
					class="mini-datepicker" required="true" /></td>
				<td>备注:</td>
				<td><input id="content" name="content" class="mini-textarea" /></td>
			</tr>		
			<tr>
				<td colspan="2"><input id="id" name="id" class="mini-hidden" /></td>
				<td colspan="2" ><a class="mini-button" onclick="submitForm">修改</a></td>
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
				url : '${basePath}incomesave.do?userid=${currentUser.id}',
				dataType : 'json',
				data : {
					incomer : mini.get("incomer").value,
					source : mini.get("source").value,
					money : mini.get("money").value,
					dataid : mini.get("datadicvalue").value,
					incometime : mini.get("incometime").getFormValue(),
					content : mini.get("content").value,
					id : mini.get("id").value
					
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
				if (alert("修改成功!")) {
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
			if (mini.get("incomer").value && mini.get("source").value
					&& mini.get("money").value && mini.get("datadicvalue").value
					&& mini.get("incometime").value) {
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
		function SetData(data) {
			if (data.action == "edit") {
				data = mini.clone(data);
				mini.get("incomer").setValue(data.incomer),
				mini.get("source").setValue(data.source),
				mini.get("money").setValue(data.money),
				mini.get("datadicvalue").setValue(data.dataid),
				mini.get("incometime").setValue(data.incometime),
				mini.get("content").setValue(data.content),
				mini.get("id").setValue(data.id)
				
			}
		}
	</script>
</body>
</html>