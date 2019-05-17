<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/Head.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.findtable {
	border-width: 1px;
	border-color: #666666;
	border-collapse: collapse;
}

.findtable td {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	background-color: #ffffff;
}
</style>
</head>
<body style="margin: 1px;">
<script type="text/javascript" src="${basePath}scripts/boot.js"></script>
	<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
		<table>
			<tr>
				<td style="width: 15%;"><a class="mini-button"
					iconCls="icon-add" onclick="openSecurityAddDialog()" plain="true">添加</a>
					<a class="mini-button" iconCls="icon-edit"
					onclick="openSecurityModifyDialog()" plain="true">修改</a> <a
					class="mini-button" iconCls="icon-remove" onclick="removeRow()"
					plain="true">删除</a></td>
			</tr>
			<tr>
				<td style="width: 85%;" style="white-space: nowrap;">
					<div id="form">
						持有人：<input id="username_search" class="mini-textbox" /> 证券公司：<input
							id="company_search" class="mini-textbox" /> 证券类型：<input
							showNullItem="true" class="mini-combobox" emptyText="请选择"
							url="data/securityType.txt" textField="text" valueField="id"
							id="dataid_search" />证券有效期：<input id="starttime_search"
							class="mini-datepicker" dateformat="yyyy-MM-dd" /> ~<input
							id="endtime_search" class="mini-datepicker"
							dateformat="yyyy-MM-dd" /> <a class="mini-button"
							onclick="search()">搜索</a>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<div id="datagrid" class="mini-datagrid"
		url="${basePath}securitylist.do?roleid=${currentUser.roleid}&userid=${currentUser.id}"
		pageSize=40 sizeList=[10,20,30,40] idField="id" multiSelect="true">
		<div property="columns">
			<div type="checkcolumn"></div>
			<div field="id" headerAlign="center">编号</div>
			<div field="username" width="100" align="center" sortable="true">持有人</div>
			<div field="securityname" width="100" align="center" sortable="true">证券账号</div>
			<div field="securitypassward" width="100" align="center"
				sortable="true">证券密码</div>
			<div field="company" width="100" align="center" sortable="true">证券公司</div>
			<div field="datadicvalue" width="100" align="center" sortable="true">证券类型</div>
			<div field="starttime" width="100" align="center" sortable="true"
				dateformat="yyyy-MM-dd">证券有效开始时间</div>
			<div field="endtime" width="100" align="center" sortable="true"
				dateformat="yyyy-MM-dd">证券有效截止时间</div>
			<!-- 				<div name="action" headerAlign="center">查看</div> -->
		</div>
	</div>
	</div>
	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("datagrid");
		var dataid = 13
		grid.load({
			"username" : mini.get("username_search").value,
			"company" : mini.get("company_search").value,
			"dataid" : mini.get("dataid_search").value,
			"starttime" : mini.get("starttime_search").getFormValue(),
			"endtime" : mini.get("endtime_search").getFormValue()
		});
		grid
				.on(
						"drawcell",
						function(e) {
							var record = e.record, column = e.column, field = e.field, value = e.value;
							if (column.name == "action") {
								e.cellStyle = "text-align:center";
								e.cellHtml = '<a  href="javascript:openIncomeFindDialog(\''
										+ record.id + '\')">查看</a>&nbsp; '
							}
						});
		function search() {
			var s_starttime = mini.get("starttime_search").getFormValue();
			var s_endtime = mini.get("endtime_search").getFormValue();
			if ((s_starttime != "") && (s_endtime != "")
					&& (s_starttime > s_endtime)) {
				mini.alert("起始时间不能大于截止时间！");
				return;
			}
			grid.load({
				"username" : mini.get("username_search").value,
				"company" : mini.get("company_search").value,
				"dataid" : mini.get("dataid_search").value,
				"starttime" : s_starttime,
				"endtime" : s_endtime
			});
		}
		function removeRow() {
			var rows = mini.get("datagrid").getSelecteds();
			if (rows.length > 0) {
				if (confirm("确定删除选中记录？")) {
					var strIds = [];
					for (var i = 0; i < rows.length; i++) {
						strIds.push(rows[i].id);
					}
					var ids = strIds.join(',');
					grid.loading("操作中，请稍后......");
					$.ajax({
						type : 'post',
						url : 'securitydelete.do',
						dataType : 'json',
						data : {
							ids : ids
						},
						success : function(text) {
							grid.reload({
								"username" : mini.get("username_search").value,
								"company" : mini.get("company_search").value,
								"dataid" : mini.get("dataid_search").value,
								"starttime" : mini.get("starttime_search")
										.getFormValue(),
								"endtime" : mini.get("endtime_search")
										.getFormValue()
							});
						},
						error : function() {
						}
					});
				}
			} else {
				alert("请选中一条记录");
			}
		}
		function openSecurityAddDialog() {
			mini.open({
				targetWindow : window,
				url : "${basePath}securityadd.do",
				title : "新增记录",
				width : 600,
				height : 450,
				showMaxButton : false,
				showCloseButton : true,
				loadOnRefresh : false,
				onload : function() {
				},
				ondestroy : function(action) {
					grid.reload();
				}
			});
		}

		function openSecurityModifyDialog() {
			var rows = mini.get("datagrid").getSelecteds();
			if (rows.length != 1) {
				mini.alert("请选择一条要编辑的数据！");
				return;
			}
			var row = rows[0];
			mini.open({
				targetWindow : window,
				url : "${basePath}securityedit.do",
				title : "修改记录",
				width : 600,
				height : 450,
				showMaxButton : false,
				showCloseButton : true,
				loadOnRefresh : false,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {
						action : "edit",
						userid : row.username,
						dataid : row.dataid,
						securityname : row.securityname,
						securitypassward : row.securitypassward,
						starttime : row.starttime,
						endtime : row.endtime,
						company : row.company,
						id : row.id
					};
					iframe.contentWindow.SetData(data);
				},
				ondestroy : function(action) {
					grid.reload();
				}
			});
		}
	</script>
</body>
</html>