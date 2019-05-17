<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/common/Head.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>家庭理财管理系统主页</title>
<link class="uiTheme" rel="stylesheet" type="text/css"
	href="${basePath}jquery-easyui-1.3.3/themes/<%=themeName %>/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${basePath}jquery-easyui-1.3.3/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="${basePath}resource/css/main.css">
<script type="text/javascript"
	src="${basePath}jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript"
	src="${basePath}jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${basePath}jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript"
	src="${basePath}jquery-easyui-1.3.3/jquery.cookie.js"></script>
<script type="text/javascript">
	$(function() {
		$("#ith").combobox(
				{
					panelHeight : 200,
					onChange : function(newVal, oldVal) {
						var oldHref = $('.uiTheme').attr('href');
						var newHref = oldHref.substring(0, oldHref
								.indexOf('themes'))
								+ 'themes/' + newVal + '/easyui.css';
						//console.log(newHref);
						$('.uiTheme').attr('href', newHref);
						//设置cookie值，并设置7天有效时间
						$.cookie('themeName', newVal, {
							expires : 7
						});
					}
				});
		$.post("${basePath}moneyAnalysis.do", {}, function(result) {
			$.messager.show({
				title : '金额提醒',
				msg : '您目前的消费金额情况如下：<br/>总收入金额：' + result.totalIncomeMoney
						+ "元。<br/>总支出金额：" + result.totalPayMoney
						+ "元。<br/>您的余额为：" + result.totalLostMoney + "元。",
				timeout : 30000,
				showType : 'show',
				height : '100%'
			});
		}, "json");
		setMoneyTime();
		function setMoneyTime() {
			setTimeout(function() {
				$.post("${basePath}moneyAnalysis.do", {}, function(result) {
					setMoneyTime();
					if (result.totalLostMoney < 2000) {
						$.messager.show({
							title : '金额提醒',
							msg : '您的余额已不足2000元。<br/>您目前的消费金额情况如下：<br/>总收入金额：'
									+ result.totalIncomeMoney + "元。<br/>总支出金额："
									+ result.totalPayMoney + "元。<br/>您的余额为："
									+ result.totalLostMoney + "元。",
							timeout : 20000,
							showType : 'show',
							height : '100%'
						});
					}
				}, "json");
			}, 60000);
		}
	});

	var url;

	function openTab(text, url, iconCls) {
		if ($("#tabs").tabs("exists", text)) {
			$("#tabs").tabs("select", text);
		} else {
			var content = "<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='${basePath}"
					+ url + "'></iframe>";
			$("#tabs").tabs("add", {
				title : text,
				iconCls : iconCls,
				closable : true,
				content : content
			});
		}
	}

	function openPasswordModifyDialog() {
		$("#dlg").dialog("open").dialog("setTitle", "修改密码");
		url = "${basePath}modifyPassword.do?id=${currentUser.id}";
	}

	function closePasswordModifyDialog() {
		$("#dlg").dialog("close");
		$("#oldPassword").val("");
		$("#newPassword").val("");
		$("#newPassword2").val("");
	}

	function modifyPassword() {
		$("#fm").form("submit", {
			url : url,
			onSubmit : function() {
				var oldPassword = $("#oldPassword").val();
				var newPassword = $("#newPassword").val();
				var newPassword2 = $("#newPassword2").val();
				if (!$(this).form("validate")) {
					return false;
				}
				if (oldPassword != '${currentUser.password}') {
					$.messager.alert("系统提示", "用户原密码输入错误！");
					return false;
				}
				if (newPassword != newPassword2) {
					$.messager.alert("系统提示", "确认密码输入错误！");
					return false;
				}
				return true;
			},
			success : function(result) {
				var result = eval('(' + result + ')');
				if (result.success) {
					$.messager.alert("系统提示", "密码修改成功，下一次登录生效！");
					closePasswordModifyDialog();
				} else {
					$.messager.alert("系统提示", "密码修改失败");
					return;
				}
			}
		});
	}

	function openMessageModifyDialog() {
		$("#mdlg").dialog("open").dialog("setTitle", "修改用户信息");
		url = "${basePath}usersave.do?id=${currentUser.id}";
	}

	function modifyMessage() {
		$("#mfm").form(
				"submit",
				{
					url : url,
					onSubmit : function() {
						if ($("#roleid").combobox("getValue") == ""
								|| $("#roleid").combobox("getValue") == null) {
							$.messager.alert("系统提示", "请选择用户角色！");
							return false;
						}
						if ($("#sex").combobox("getValue") == ""
								|| $("#sex").combobox("getValue") == null) {
							$.messager.alert("系统提示", "请选择性别！");
							return false;
						}
						return $(this).form("validate");
					},
					success : function(result) {
						var result = eval('(' + result + ')');
						if (result.errres) {
							$.messager.alert("系统提示", result.errmsg);
							$("#mdlg").dialog("close");
						} else {
							$.messager.alert("系统提示", result.errmsg);
							return;
						}
					}
				});
	}

	function closeMessageModifyDialog() {
		$("#mdlg").dialog("close");
	}

	function logout() {
		$.messager.confirm("系统提示", "您确定要退出系统吗", function(r) {
			if (r) {
				window.location.href = "${basePath}logout.do";
			}
		});
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" style="height: 78px;">
		<table style="padding: 5px" width="100%">
			<tr>
				<td width="20%"><img
					src="${basePath}resource/images/bglogo.png" /></td>
				<td valign="bottom" align="right" width="80%"><font size="2">&nbsp;&nbsp;欢迎：${currentUser.username }&nbsp;&nbsp;&nbsp;&nbsp;</font>
					<a href="javascript:openPasswordModifyDialog()"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-xgmm'" style="width: 80px;">修改密码</a>
					&nbsp;&nbsp;&nbsp;&nbsp;主题风格： <select id="ith"
					class="easyui-combobox" name="theme">
						<option value="default">default</option>
						<option value="black">black</option>
						<option value="gray">gray</option>
						<option value="bootstrap">bootstrap</option>
						<option value="metro">metro</option>
						<option value="metro-blue">metro-blue</option>
						<option value="metro-gray">metro-gray</option>
						<option value="metro-green">metro-green</option>
						<option value="metro-orange">metro-orange</option>
						<option value="metro-red">metro-red</option>
						<option value="ui-cupertino">ui-cupertino</option>
						<option value="ui-dark-hive">ui-dark-hive</option>
						<option value="ui-pepper-grinder">ui-pepper-grinder</option>
						<option value="ui-sunny">ui-sunny</option>
				</select>&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:logout()"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-aqtc'" style="width: 80px;">安全退出</a>
				</td>
			</tr>
		</table>
	</div>

	<%-- 	<script type="text/javascript" src="${basePath}scripts/boot.js"></script> --%>
	<!-- 	<div id="layout1" class="mini-layout" -->
	<!-- 		style="width: 100%; height: 100%;"> -->
	<!-- 		<div class="app-header" region="north" height="70" showSplit="false" -->
	<!-- 			showHeader="false"> -->
	<!-- 			<h1 -->
	<!-- 				style="margin: 0; padding: 15px; cursor: default; font-family: 'Trebuchet MS', Arial, sans-serif;">折叠菜单（左侧）</h1> -->
	<!-- 		</div> -->
	<!-- 		<div title="south" region="south" showSplit="false" showHeader="false" -->
	<!-- 			height="30"> -->
	<!-- 			<div style="line-height: 28px; text-align: center; cursor: default">Copyright -->
	<!-- 				© XXXX版权所有</div> -->
	<!-- 		</div> -->
	<!-- 		<div showHeader="false" region="west" width="180" maxWidth="250" -->
	<!-- 			minWidth="100"> -->
	<!-- 			<!--OutlookMenu -->
	<!-- 			<div id="leftTree" class="mini-outlookmenu" -->
	<!-- 				url="data/outlookmenu.txt" onitemselect="onItemSelect" -->
	<!-- 				idField="id" parentField="pid" textField="text" -->
	<!-- 				borderStyle="border:0" expandOnLoad="false"></div> -->

	<!-- 		</div> -->
	<!-- 		<div title="center" region="center" bodyStyle="overflow:hidden;"> -->
	<!-- 			<iframe id="mainframe" frameborder="0" name="main" -->
	<!-- 				style="width: 100%; height: 100%;" border="0"></iframe> -->
	<!-- 		</div> -->
	<!-- 	</div> -->

	<script type="text/javascript">
		// 		mini.parse();

		// 		//init iframe src
		// 		var iframe = document.getElementById("mainframe");
		// 		iframe.src = "incomeManage.do"

		// 		function onItemSelect(e) {
		// 			var item = e.item;
		// 			iframe.src = item.url;
		// 		}

		//        //自动选中id
		//        var tree = mini.get("leftTree");
		//        
		//        tree.selectNode("addRight");
	</script>
	<div region="center">
		<div class="easyui-tabs" fit="true" border="false" id="tabs">
			<div title="首页" data-options="iconCls:'icon-index'">
				<div align="center">
					<link type="text/css" rel="Stylesheet"
						href="${basePath}resource/css/imageflow.css" />
					<script type="text/javascript"
						src="${basePath}resource/js/imageflow.js"></script>
					<div id="LoopDiv">
						<input id="S_Num" type="hidden" value="8" />
						<div id="starsIF" class="imageflow">
							<img src="${basePath}resource/images/1.png" longdesc="#"
								alt="Picture" /> <img src="${basePath}resource/images/2.png"
								longdesc="#" alt="Picture" /> <img
								src="${basePath}resource/images/3.jpg" longdesc="#"
								alt="Picture" /> <img src="${basePath}resource/images/4.jpg"
								longdesc="#" alt="Picture" />
							<!-- 								<img -->
							<%-- 								src="${basePath}resource/images/1.png" longdesc="#" width="635" --%>
							<!-- 								height="360" alt="Picture" /> <img -->
							<%-- 								src="${basePath}resource/images/2.png" longdesc="#" width="635" --%>
							<!-- 								height="360" alt="Picture" /> <img -->
							<%-- 								src="${basePath}resource/images/1.png" longdesc="#" width="635" --%>
							<!-- 								height="360" alt="Picture" /> <img -->
							<%-- 								src="${basePath}resource/images/2.png" longdesc="#" width="635" --%>
							<!-- 								height="360" alt="Picture" /> <img -->
							<%-- 								src="${basePath}resource/images/1.png" longdesc="#" width="635" --%>
							<!-- 								height="360" alt="Picture" /> <img -->
							<%-- 								src="${basePath}resource/images/2.png" longdesc="#" width="635" --%>
							<!-- 								height="360" alt="Picture" /> <img -->
							<%-- 								src="${basePath}resource/images/1.png" longdesc="#" width="635" --%>
							<!-- 								height="360" alt="Picture" /> <img -->
							<%-- 								src="${basePath}resource/images/2.png" longdesc="#" width="635" --%>
							<!-- 								height="360" alt="Picture" /> -->
						</div>
					</div>

					<div class="body-advantage">
						<div class="inndex-regions">
							<div class="region1">
								<div class="regionInner">
									<div class="regionInner1"></div>
									<h1>提高您的理财效率</h1>
									<div class="regionInner-box">
										<div class="regionInner-text">真正的多面手，股票交易记录与分析，投资管理与分析等等无所不能。真正的安全，超强加密，全面保护个人隐私。功能强大，国内第一，满足长期使用。真正的免费，不搞突然收费，用的放心。</div>
									</div>
								</div>
							</div>
							<div class="region2">
								<div class="regionInner">
									<div class="regionInner2"></div>
									<h1>安全保密</h1>
									<div class="regionInner-box">
										<div class="regionInner-text">采用Des加密技术安全管理行业领先！通过严密的安全管理措施，确保数据
											永久保存。所有数据支持一键导出至本地备份，双重安全保障，数据安心无忧！</div>
									</div>
								</div>
							</div>
							<div class="region3">
								<div class="regionInner">
									<div class="regionInner3"></div>
									<h1>人性化操作</h1>
									<div class="regionInner-box">
										<div class="regionInner-text">图表自动生成，个人财务状况清晰可见。收入支出，一览无忧；
											饼图线图，多样呈现； 月度年度，综合评估。</div>
									</div>
								</div>
							</div>
							<div class="region4">
								<div class="regionInner">
									<div class="regionInner4"></div>
									<h1>快速便捷统计数据</h1>
									<div class="regionInner-box">
										<div class="regionInner-text">直观的界面、出色的计算功能和图表工具，再加上成功的市场营销，我们系统是流行的个人计算机数据处理软件。</div>
									</div>
								</div>
							</div>
							<div style="clear: both;"></div>
						</div>
					</div>
					<div class="footer">
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>

	<div region="west" style="width: 200px" title="导航菜单" split="true">
		<div class="easyui-accordion" data-options="fit:true,border:false">
			<div title="收支管理" data-options="selected:true,iconCls:'icon-szgl'"
				style="padding: 10px">
				<a
					href="javascript:openTab('收入信息维护','incomeManage.do','icon-srxxwh')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-srxxwh'"
					style="width: 150px;">收入信息维护</a> <a
					href="javascript:openTab('支出信息维护','payManage.do','icon-srxxwh')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-srxxwh'"
					style="width: 150px;">支出信息维护</a>
			</div>
			<div title="财务管理" data-options="iconCls:'icon-cwgl'"
				style="padding: 10px;">
				<a
					href="javascript:openTab('证券帐户管理','securityManage.do','icon-zqzhgl')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-zqzhgl'"
					style="width: 150px;">证券帐户管理</a> <a
					href="javascript:openTab('持股管理','sharesManage.do','icon-cggl')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-cggl'" style="width: 150px;">持股管理</a>
				<a
					href="javascript:openTab('证券流水账管理','tradeManage.do','icon-zqlsgl')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-zqlsgl'"
					style="width: 150px;">证券流水账管理</a>
			</div>
			<div title="报表管理" data-options="iconCls:'icon-bbgl'"
				style="padding: 10px">
				<a
					href="javascript:openTab('按时间收入报表','incomeTimeManage.do','icon-asjbb')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-asjbb'"
					style="width: 150px;">按时间收入报表</a> <a
					href="javascript:openTab('按时间支出报表','payTimeManage.do','icon-asjbb')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-asjbb'"
					style="width: 150px;">按时间支出报表</a> <a
					href="javascript:openTab('按类型报表','typePieManage.do','icon-alxbb')"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-alxbb'"
					style="width: 150px;">按类型报表</a>
			</div>
			<c:if test="${currentUser.roleid==1 }">
				<div title="数据库管理" data-options="iconCls:'icon-sjkgl'"
					style="padding: 10px">
					<a
						href="javascript:openTab('数据库备份','databackManage.do','icon-sjk')"
						class="easyui-linkbutton"
						data-options="plain:true,iconCls:'icon-sjk'" style="width: 150px;">数据库备份</a>
					<a
						href="javascript:openTab('数据库恢复','datarecoverManage.do','icon-sjk')"
						class="easyui-linkbutton"
						data-options="plain:true,iconCls:'icon-sjk'" style="width: 150px;">数据库恢复</a>
					<a
						href="javascript:openTab('数据库初始化','datainitManage.do','icon-sjk')"
						class="easyui-linkbutton"
						data-options="plain:true,iconCls:'icon-sjk'" style="width: 150px;">数据库初始化</a>
					<a
						href="javascript:openTab('数据库整理','dataorderManage.do','icon-sjk')"
						class="easyui-linkbutton"
						data-options="plain:true,iconCls:'icon-sjk'" style="width: 150px;">数据库整理</a>
				</div>
			</c:if>
			<div title="用户管理" data-options="iconCls:'icon-yhgl'"
				style="padding: 10px">
				<c:if test="${currentUser.roleid==1 }">
					<a
						href="javascript:openTab('用户信息管理','userManage.do','icon-yhxxgl')"
						class="easyui-linkbutton"
						data-options="plain:true,iconCls:'icon-yhxxgl'"
						style="width: 150px;">用户信息管理</a>
					<a href="javascript:openTab('角色管理','roleManage.do','icon-jsgl')"
						class="easyui-linkbutton"
						data-options="plain:true,iconCls:'icon-jsgl'"
						style="width: 150px;">角色管理</a>
					<a
						href="javascript:openTab('数据字典管理','datadicManage.do','icon-sjzdgl')"
						class="easyui-linkbutton"
						data-options="plain:true,iconCls:'icon-sjzdgl'"
						style="width: 150px;">数据字典管理</a>
				</c:if>
				<a href="javascript:openMessageModifyDialog()"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-xgyhxx'"
					style="width: 150px;">修改用户信息</a> <a
					href="javascript:openPasswordModifyDialog()"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-xgmm'" style="width: 150px;">修改密码</a>
				<a href="javascript:logout()" class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-aqtc'" style="width: 150px;">安全退出</a>
			</div>
		</div>
	</div>


	<div id="dlg" class="easyui-dialog"
		style="width: 400px; height: 250px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table cellspacing="8px">
				<tr>
					<td>用户名：</td>
					<td><input type="text" id="username" name="username"
						value="${currentUser.username }" readonly="readonly"
						style="width: 200px" /></td>
				</tr>
				<tr>
					<td>原密码：</td>
					<td><input type="password" id="oldPassword"
						class="easyui-validatebox" required="true" style="width: 200px" /></td>
				</tr>
				<tr>
					<td>新密码：</td>
					<td><input type="password" id="newPassword" name="password"
						class="easyui-validatebox" required="true" style="width: 200px" /></td>
				</tr>
				<tr>
					<td>确认新密码：</td>
					<td><input type="password" id="newPassword2"
						class="easyui-validatebox" required="true" style="width: 200px" /></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:modifyPassword()" class="easyui-linkbutton">保存</a>
		<a href="javascript:closePasswordModifyDialog()"
			class="easyui-linkbutton">关闭</a>
	</div>


	<div id="mdlg" class="easyui-dialog"
		style="width: 670px; height: 300px; padding: 10px 20px" closed="true"
		buttons="#mdlg-buttons">
		<form id="mfm" method="post">
			<table cellspacing="8px">
				<tr>
					<td>用户名：</td>
					<td><input type="text" id="m_username" name="username"
						class="easyui-validatebox easyui-textbox" required="true"
						value="${usermessage.username }" />&nbsp;<font color="red">*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>真实姓名：</td>
					<td><input type="text" id="truename" name="truename"
						class="easyui-validatebox easyui-textbox" required="true"
						value="${usermessage.truename }" />&nbsp;<font color="red">*</font></td>
				</tr>
				<tr>
					<td>性别：</td>
					<td><select class="easyui-combobox" id="sex" name="sex"
						editable="false" style="width: 175px;">
							<option value="">请选择...</option>
							<option value="1"
								<c:if test="${usermessage.sex==1 }"> selected="selected" </c:if>>男</option>
							<option value="2"
								<c:if test="${usermessage.sex==2 }"> selected="selected" </c:if>>女</option>
					</select>&nbsp;<font color="red">*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>年龄：</td>
					<td><input type="text" id="age" name="age"
						class="easyui-validatebox easyui-numberbox" required="true"
						value="${usermessage.age }" />&nbsp;<font color="red">*</font></td>
				</tr>
				<tr>
					<td>联系电话：</td>
					<td><input type="text" id="phone" name="phone"
						class="easyui-validatebox easyui-textbox" required="true"
						value="${usermessage.phone }" />&nbsp;<font color="red">*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>邮箱：</td>
					<td><input type="text" id="email" name="email"
						class="easyui-validatebox easyui-textbox" validType="email"
						required="true" value="${usermessage.email }" />&nbsp;<font
						color="red">*</font></td>
				</tr>
				<tr>
					<td>家庭称谓：</td>
					<td><input type="text" id="appellation" name="appellation"
						class="easyui-validatebox easyui-textbox" required="true"
						value="${usermessage.appellation }" />&nbsp;<font color="red">*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>住址：</td>
					<td><input type="text" id="address" name="address"
						class="easyui-validatebox easyui-textbox" required="true"
						value="${usermessage.address }" />&nbsp;<font color="red">*</font></td>
				</tr>
				<tr>
					<td>银行卡号：</td>
					<td><input type="text" id="card" name="card"
						class="easyui-validatebox easyui-textbox" required="true"
						value="${usermessage.card }" />&nbsp;<font color="red">*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>工资：</td>
					<td><input type="text" id="salary" name="salary"
						class="easyui-validatebox easyui-numberbox" required="true"
						value="${usermessage.salary }" />&nbsp;<font color="red">*</font></td>
				</tr>
				<tr>
					<td>用户角色：</td>
					<td><select class="easyui-combobox" id="roleid" name="roleid"
						editable="false" readonly="readonly" style="width: 175px;">
							<option value="">请选择角色...</option>
							<c:forEach items="${roles }" var="role">
								<option value="${role.id }"
									<c:if test="${usermessage.roleid==role.id }"> selected="selected" </c:if>>${role.rolename }</option>
							</c:forEach>
					</select>&nbsp;<font color="red">*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td></td>
					<td><input type="hidden" id="password" name="password"
						class="easyui-validatebox easyui-textbox" required="true"
						value="${usermessage.password }" />&nbsp;<font color="red">*</font></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="mdlg-buttons">
		<a href="javascript:modifyMessage()" class="easyui-linkbutton">保存</a>
		<a href="javascript:closeMessageModifyDialog()"
			class="easyui-linkbutton">关闭</a>
	</div>
</body>
</html>