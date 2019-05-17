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
				<td>持有人:</td>
				<td>
					<select
							class="mini-combobox" id="userid">
							<option value=""></option>
							<c:forEach items="${allUsers }" var="alluser">
								<option value="${alluser.username }">${alluser.username }</option>
							</c:forEach>
						</select></td>
				<td>证券类型:</td>
				<td><input id="dataid" name="dataid"
					url="data/securityType.txt" textField="text" valueField="id"
					class="mini-combobox" required="true" /></td>

			</tr>
			<tr>
				<td>证券帐号：</td>
				<td><input id="securityname" name="securityname"
					class="mini-textbox" required="true" /></td>
				<td>证券密码：</td>
				<td><input id="securitypassward" name="securitypassward"
					class="mini-password" required="true" /></td>

			</tr>
			<tr>
				<td>证券有效开始时间</td>
				<td><input id="starttime" name="starttime"
					class="mini-datepicker" required="true" style="width: 175px"></td>
				<td>证券有效结束时间</td>
				<td><input id="endtime" name="endtime" class="mini-datepicker"
					required="true" style="width: 175px"></td>

			</tr>
			<tr>
				<td>证券公司：</td>
				<td><input id="company" name="company" class="mini-textbox"
					required="true" /></td>
				<td colspan="2"><a class="mini-button" onclick="submitForm">添加</a></td>
			</tr>
		</table>
	</div>
	<script type="text/javascript">
		mini.parse();
		function submitForm() {
			if (check()&&check2()) { 
			$.ajax({
				type : 'post',
				url : '${basePath}securitysave.do?userid=${currentUser.id}',
				dataType : 'json',
				data : {
					userid : mini.get("userid").value,
					dataid : mini.get("dataid").value,
					securityname : mini.get("securityname").value,
					securitypassward : mini.get("securitypassward").value,
					starttime : mini.get("starttime").getFormValue(),
					endtime : mini.get("endtime").getFormValue(),
					company : mini.get("company").value
					
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
			if (mini.get("userid").value && mini.get("dataid").value
					&& mini.get("securityname").value && mini.get("securitypassward").value
					&& mini.get("starttime").value&& mini.get("endtime").value&& mini.get("company").value) {
				return true;
			}
			mini.alert("请输入完整信息");
			return false;
		}
		function check2()
		{
			var s_starttime = mini.get("starttime").getFormValue();
			var s_endtime = mini.get("endtime").getFormValue();
			if ((s_starttime != "") && (s_endtime != "")
					&& (s_starttime > s_endtime)) {
				mini.alert("起始时间不能大于截止时间！");
				return false;
			}
			return true;
		}
	</script>
</body>
</html>