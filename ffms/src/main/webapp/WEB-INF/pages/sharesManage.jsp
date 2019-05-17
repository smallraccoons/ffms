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
					iconCls="icon-add" onclick="openSharesAddDialog()" plain="true">添加</a>
					<a class="mini-button" iconCls="icon-edit"
					onclick="openSharesModifyDialog()" plain="true">修改</a> <a
					class="mini-button" iconCls="icon-remove" onclick="removeRow()"
					plain="true">删除</a></td>
			</tr>
			<tr>
				<td style="width: 85%;" style="white-space: nowrap;">
					<div id="form">
						股票名称： <input class="mini-textbox" id="sharesname_search" />持股人：<select
							class="mini-combobox" id="holder_search">
							<option value=""></option>
							<c:forEach items="${allUsers }" var="alluser">
								<option value="${alluser.username }">${alluser.username }</option>
							</c:forEach>
						</select>证券账号：<select class="mini-combobox" id="securityname_search">
							<option value=""></option>
							<c:forEach items="${allSecuritys }" var="allSecurity">
								<option value="${allSecurity.securityname }">${allSecurity.securityname }</option>
							</c:forEach>
						</select><a class="mini-button" onclick="search()">搜索</a>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<div id="datagrid" class="mini-datagrid"
		url="${basePath}shareslist.do?roleid=${currentUser.roleid}&userid=${currentUser.id}"
		pageSize=40 sizeList=[10,20,30,40] idField="id" multiSelect="true">
		<div property="columns">
			<div type="checkcolumn"></div>
			<div field="id" width="50" align="center" sortable="true">编号</div>
			<div field="username" width="100" align="center" sortable="true">记录人</div>
			<div field="sharesname" width="100" align="center" sortable="true">股票名称</div>
			<div field="holder" width="100" align="center" sortable="true">持股人</div>
			<div field="securityname" width="100" align="center" sortable="true">证券账号</div>
			<div field="createtime" width="100" align="center" sortable="true" dateFormat="yyyy-MM-dd">创建时间</div>
			<div field="updatetime" width="100" align="center" sortable="true" dateFormat="yyyy-MM-dd">修改时间</div>
<!-- 							<div name="action" headerAlign="center">查看</div>  -->
		</div>
	</div>
	</div>
	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("datagrid");
		grid.load({
			"sharesname" : mini.get("sharesname_search").value,
			"holder" : mini.get("holder_search").value,
			"securityname" : mini.get("securityname_search").value
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
			grid.load({
				"sharesname" : mini.get("sharesname_search").value,
				"holder" : mini.get("holder_search").value,
				"securityname" : mini.get("securityname_search").value
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
								url : 'sharesdelete.do',
								dataType : 'json',
								data : {
									ids : ids
								},
								success : function(text) {
									grid
											.reload({
												"sharesname" : mini.get("sharesname_search").value,
												"holder" : mini.get("holder_search").value,
												"securityname" : mini.get("securityname_search").value
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
		function openSharesAddDialog() {
			mini.open({
				targetWindow : window,
				url : "${basePath}sharesadd.do",
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

		function openSharesModifyDialog() {
			var rows = mini.get("datagrid").getSelecteds();
			if (rows.length != 1) {
				mini.alert("请选择一条要编辑的数据！");
				return;
			}
			var row = rows[0];
			mini.open({
				targetWindow : window,
				url : "${basePath}sharesedit.do",
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
						holder : row.holder,
						sharesname : row.sharesname,
						securityid : row.securityid,
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