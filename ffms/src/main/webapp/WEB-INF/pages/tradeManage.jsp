<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/Head.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body style="margin: 1px;">
	<script type="text/javascript" src="${basePath}scripts/boot.js"></script>
	<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
		<table>
			<tr>
				<td style="width: 15%;"><a class="mini-button"
					iconCls="icon-add" onclick="openTradeAddDialog()" plain="true">添加</a>
					<a class="mini-button" iconCls="icon-edit"
					onclick="openTradeModifyDialog()" plain="true">修改</a> <a
					class="mini-button" iconCls="icon-remove" onclick="removeRow()"
					plain="true">删除</a></td>
			</tr>
			<tr>
				<td style="width: 85%;" style="white-space: nowrap;">
					<div id="form">
						股票名称： <select id="sharesname_search" name="sharesname_search"
						emptyText="请选择" class="mini-combobox" value=''>
							<option value=""></option>
							<c:forEach items="${allShares }" var="allShare">
								<option value="${allShare.sharesname }">${allShare.sharesname}</option>
							</c:forEach>
						</select> 交易类型：<input showNullItem="true" class="mini-combobox"
							emptyText="请选择" url="data/tradeType.txt" textField="text"
							valueField="id" id="dataid_search" />交易起止时间：<input
							id="starttime_search" class="mini-datepicker"
							dateformat=" yyyy-MM-dd HH:mm:ss" /> ~<input id="endtime_search"
							class="mini-datepicker" dateformat="yyyy-MM-dd HH:mm:ss" /> <a
							class="mini-button" onclick="search()">搜索</a>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<div id="datagrid" class="mini-datagrid"
		url="${basePath}tradelist.do?roleid=${currentUser.roleid}&userid=${currentUser.id}"
		pageSize=40 sizeList=[10,20,30,40] idField="id" multiSelect="true">
		<div property="columns">
			<div type="checkcolumn"></div>
			<div field="id" width="50" align="center" sortable="true">编号</div>
			<div field="username" width="100" align="center" sortable="true">记录人</div>
			<div field="sharesname" width="100" align="center" sortable="true">股票名称</div>
			<div field="price" width="100" align="center" sortable="true">单价</div>
			<div field="number" width="100" align="center" sortable="true">数量</div>
			<div field="money" width="100" align="center" sortable="true">金额</div>
			<div field="datadicvalue" width="100" align="center" sortable="true">交易类型</div>
			<div field="content" width="100" align="center" sortable="true">备注</div>
			<div field="time" width="100" align="center" sortable="true">交易时间</div>
			<!-- <th field="createtime" width="100" align="center" sortable="true">创建时间</th>
				<th field="updatetime" width="100" align="center" sortable="true">修改时间</th> -->
			<!-- 				<div name="action" headerAlign="center">查看</div> -->
		</div>
	</div>
	</div>
	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("datagrid");
		grid.load({
			"sharesname" : mini.get("sharesname_search").value,
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
				"sharesname" : mini.get("sharesname_search").value,
				"dataid" : mini.get("dataid_search").value,
				"starttime" : mini.get("starttime_search").getFormValue(),
				"endtime" : mini.get("endtime_search").getFormValue()
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
					$
							.ajax({
								type : 'post',
								url : 'tradedelete.do',
								dataType : 'json',
								data : {
									ids : ids
								},
								success : function(text) {
									grid
											.reload({
												"sharesname" : mini
														.get("sharesname_search").value,
												"dataid" : mini
														.get("dataid_search").value,
												"starttime" : mini.get(
														"starttime_search")
														.getFormValue(),
												"endtime" : mini.get(
														"endtime_search")
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
		function openTradeAddDialog() {
			mini.open({
				targetWindow : window,
				url : "${basePath}tradeadd.do",
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

		function openTradeModifyDialog() {
			var rows = mini.get("datagrid").getSelecteds();
			if (rows.length != 1) {
				mini.alert("请选择一条要编辑的数据！");
				return;
			}
			var row = rows[0];
			mini.open({
				targetWindow : window,
				url : "${basePath}tradeedit.do",
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
						sharesid : row.sharesid,
						dataid : row.dataid,
						price : row.price,
						securitypassward : row.securitypassward,
						number : row.number,
						time : row.time,
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
	</script>
</body>
</html>