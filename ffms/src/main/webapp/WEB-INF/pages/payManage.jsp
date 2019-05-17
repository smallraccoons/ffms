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
	<div >
		<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
			<table>
				<tr>
					<td style="width: 15%;"><a class="mini-button"
						iconCls="icon-add" onclick="openPayAddDialog()" plain="true">添加</a>
						<a class="mini-button" iconCls="icon-edit"
						onclick="openPayModifyDialog()" plain="true">修改</a> <a
						class="mini-button" iconCls="icon-remove" onclick="removeRow()"
						plain="true">删除</a></td>
				</tr>
				<tr>
					<td style="width: 85%;" style="white-space: nowrap;">
						<div id="form">
							支出人：<input id="payer_search" class="mini-textbox" /> 支出用途：<input
								id="tword_search" class="mini-textbox" /> 支出类型：<input
								showNullItem="true" class="mini-combobox" emptyText="请选择"
								url="data/payType.txt" textField="text" valueField="id"
								id="dataid_search" />支出起止时间<input id="starttime_search"
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
			url="${basePath}paylist.do?roleid=${currentUser.roleid}&userid=${currentUser.id}"
			pageSize=40 sizeList=[10,20,30,40] idField="id" multiSelect="true">
			<div property="columns">
				<div type="checkcolumn"></div>
				<div field="id" width="50" align="center" sortable="true">编号</div>
				<div field="username" width="100" align="center" sortable="true">记录人</div>
				<div field="payer" width="100" align="center" sortable="true">支出人</div>
				<div field="tword" width="100" align="center" sortable="true">支出用途</div>
				<div field="money" width="100" align="center" sortable="true">金额</div>
				<div field="datadicvalue" width="100" align="center" sortable="true">支出类型</div>
				<div field="content" width="100" align="center" sortable="true">备注</div>
				<div field="paytime" width="100" align="center" sortable="true"
					dateFormat="yyyy-MM-dd">支出时间</div>
				<div field="createtime" width="100" align="center" sortable="true"
					dateFormat="yyyy-MM-dd">创建时间</div>
				<div field="updatetime" width="100" align="center" sortable="true"
					dateFormat="yyyy-MM-dd">修改时间</div>

				<!-- 				<div name="action" headerAlign="center">查看</div> -->
			</div>
		</div>
	</div>
	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("datagrid");
		grid.load({
			"payer" : mini.get("payer_search").value,
			"tword" : mini.get("tword_search").value,
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
				"payer" : mini.get("payer_search").value,
				"tword" : mini.get("tword_search").value,
				"dataid" : mini.get("dataid_search").value,
				"starttime" : s_starttime,
				"endtime" : s_endtime
			});
		}
		function resetSearch() {
			mini.get("payer_search").setValue("");
			mini.get("tword_search").setValue("");
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
						url : 'paydelete.do',
						dataType : 'json',
						data : {
							ids : ids
						},
						success : function(text) {
							grid.reload({
								"payer" : mini.get("payer_search").value,
								"tword" : mini.get("tword_search").value,
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
		function openPayAddDialog() {
			mini.open({
				targetWindow : window,
				url : "${basePath}payadd.do",
				title : "新增支出记录",
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

		function openPayModifyDialog() {
			var rows = mini.get("datagrid").getSelecteds();
			if (rows.length != 1) {
				mini.alert("请选择一条要编辑的数据！");
				return;
			}
			var row = rows[0];
			mini.open({
				targetWindow : window,
				url : "${basePath}payedit.do",
				title : "修改支出记录",
				width : 600,
				height : 450,
				showMaxButton : false,
				showCloseButton : true,
				loadOnRefresh : false,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {
						action : "edit",
						payer : row.payer,
						tword : row.tword,
						money : row.money,
						dataid : row.dataid,
						paytime : row.paytime,
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