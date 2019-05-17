<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/Head.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${basePath}scripts/boot.js"></script>
</head>
<body style="margin: 1px;">
	<div class=mini-fit">
		<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
			<table>
				<tr>
					<td style="width: 15%;"><a class="mini-button"
						iconCls="icon-add" onclick="openIncomeAddDialog()" plain="true">添加</a>
						<a class="mini-button" iconCls="icon-edit"
						onclick="openIncomeModifyDialog()" plain="true">修改</a> <a
						class="mini-button" iconCls="icon-remove" onclick="removeRow()"
						plain="true">删除</a></td>
				</tr>
				<tr>
					<td style="width: 85%;" style="white-space: nowrap;">
						<div id="form">
							收入人：<input id="incomer_search" class="mini-textbox" /> 收入来源：<input
								id="source_search" class="mini-textbox" /> 收入类型：<input
								showNullItem="true" class="mini-combobox" emptyText="请选择"
								url="data/incomeType.txt" textField="text" valueField="id"
								id="dataid_search" />收入起止时间<input id="starttime_search"
								class="mini-datepicker" dateformat="yyyy-MM-dd" /> ~<input
								id="endtime_search" class="mini-datepicker"
								dateformat="yyyy-MM-dd" /> <a class="mini-button"
								onclick="search()">查询</a><a class="mini-button"
								onclick="resetSearch()">清除</a>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div id="datagrid" class="mini-datagrid"
			url="${basePath}incomelist.do?roleid=${currentUser.roleid}&userid=${currentUser.id}"
			pageSize=40 sizeList=[10,20,30,40] idField="id" multiSelect="true">
			<div property="columns">
				<div type="checkcolumn"></div>
				<div field="id" headerAlign="center">编号</div>
				<div field="username" headerAlign="center">记录人</div>
				<div field="incomer" headerAlign="center">收入人</div>
				<div field="source" headerAlign="center">收入来源</div>
				<div field="money" headerAlign="center">金额</div>
				<div field="datadicvalue" headerAlign="center">收入类型</div>
				<div field="content" headerAlign="center">备注</div>
				<div field="incometime" headerAlign="center" dateFormat="yyyy-MM-dd">收入时间</div>
				<div field="createtime" headerAlign="center" dateFormat="yyyy-MM-dd">创建时间</div>
				<div field="updatetime" headerAlign="center" dateFormat="yyyy-MM-dd">修改时间</div>
				<!-- 				<div name="action" headerAlign="center">查看</div> -->
			</div>
		</div>
	</div>
	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("datagrid");
		var dataid = 13
		grid.load({
			"incomer" : mini.get("incomer_search").value,
			"source" : mini.get("source_search").value,
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
				"incomer" : mini.get("incomer_search").value,
				"source" : mini.get("source_search").value,
				"dataid" : mini.get("dataid_search").value,
				"starttime" : s_starttime,
				"endtime" : s_endtime
			});
		}
		function resetSearch() {
			mini.get("incomer_search").setValue("");
			mini.get("source_search").setValue("");
			mini.get("dataid_search").setValue("");
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
						url : 'incomedelete.do',
						dataType : 'json',
						data : {
							ids : ids
						},
						success : function(text) {
							grid.reload({
								"incomer" : mini.get("incomer_search").value,
								"source" : mini.get("source_search").value,
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
		function openIncomeAddDialog() {
			mini.open({
				targetWindow : window,
				url : "${basePath}incomeadd.do",
				title : "新增收入记录",
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

		function openIncomeModifyDialog() {
			var rows = mini.get("datagrid").getSelecteds();
			if (rows.length != 1) {
				mini.alert("请选择一条要编辑的数据！");
				return;
			}
			var row = rows[0];
			mini.open({
				targetWindow : window,
				url : "${basePath}incomeedit.do",
				title : "修改收入记录",
				width : 600,
				height : 450,
				showMaxButton : false,
				showCloseButton : true,
				loadOnRefresh : false,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {
						action : "edit",
						incomer : row.incomer,
						source : row.source,
						money : row.money,
						dataid : row.dataid,
						incometime : row.incometime,
						content : row.content,
						id : row.id
					};
					iframe.contentWindow.SetData(data);
				},
				ondestroy : function(action) {
					grid.reload();
				}
			});
		}
		function openIncomeFindDialog(id) {
			var selectedRows = $("#dg").datagrid('getSelections');
			if (selectedRows.length != 1) {
				$.messager.alert("系统提示", "请选择一条要查看的数据！");
				return;
			}
			var row = selectedRows[0];
			$("#finddlg").dialog("open").dialog("setTitle", "查看收入信息");
			$("#fusername").text(row.username);
			$("#fincomer").text(row.incomer);
			$("#fsource").text(row.source);
			$("#fmoney").text(row.money);
			$("#fdatadicvalue").text(row.datadicvalue);
			$("#fcontent").text(row.content);
			$("#fincometime").text(row.incometime);
			$("#fcreatetime").text(row.createtime);
			$("#fupdatetime").text(row.updatetime);
		}
	</script>


</body>
</html>