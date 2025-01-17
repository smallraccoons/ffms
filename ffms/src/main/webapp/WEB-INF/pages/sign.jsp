<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/Head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>家庭理财管理系统登录</title>
	<link rel="stylesheet" type="text/css" href="${basePath}bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${basePath}bootstrap/css/bootstrap-reset.css">
	<link rel="stylesheet" type="text/css" href="${basePath}bootstrap/css/jquery-ui-1.10.3.css">
	<link rel="stylesheet" type="text/css" href="${basePath}bootstrap/css/font-awesome.css">
	<link rel="stylesheet" type="text/css" href="${basePath}resource/css/style.css" />
</head>
<body class="login-body">
    <div class="container">
		<form class="form-signin">
		    <div class="form-signin-heading text-center">
		        <h2 style="color:#008CBA;">家庭理财收支系统</h2>
		    </div>
		    <div class="login-wrap">
		        <input type="text" name="username" id="inputUsername" class="form-control" placeholder="请输入用户名" autofocus>
           		<input type="password" name="password" id="inputPassword" class="form-control" placeholder="请输入密码">
		        <input type="password" id="surePassword" class="form-control" placeholder="请再次输入密码">
		        <button id="submitbtn" class="btn btn-lg btn-login btn-block" type="button">
		            <i class="fa fa-check"></i> <span style="font-size:25px;">注册</span>
		        </button>
		        <h4 style="text-align:center;line-height:40px;">已有账号？<a href="${basePath}index.do">返回登录</a></h4>
		    </div>
		</form>
	</div>
		
	<!-- Modal -->
        <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">提示您</h4>
                    </div>
                    <div class="modal-body">
                        <h4 id="messageshow"></h4>
                    </div>
                    <div class="modal-footer">
                        <button data-dismiss="modal" class="btn btn-success" type="button">确定</button>
                    </div>
                </div>
            </div>
        </div>
    <!-- modal -->
		
	<script type="text/javascript" src="${basePath}jquery-easyui-1.3.3/jquery.min.js"></script>
	<script src="${basePath}bootstrap/js/bootstrap.min.js"></script>
	<script src="${basePath}bootstrap/js/modernizr.min.js"></script>
		<script>
			$(function(){
				$("#submitbtn").click(function(){
		    		var inputUsername = $("#inputUsername").val();
		    		var inputPassword = $("#inputPassword").val();
		    		var surePassword = $("#surePassword").val();
					if(inputUsername==null||inputUsername==""){
		    			$("#messageshow").html("请输入用户名！");
		    			$("#myModal").modal("show");
						$("#myModal").on("hidden.bs.modal", function (e) {
						  	$("#inputUsername").focus();
						});
						return false;
		    		}else if(inputPassword==null||inputPassword==""){
		    			$("#messageshow").html("请输入密码！");
		    			$("#myModal").modal("show");
						$('#myModal').on("hidden.bs.modal", function (e) {
						  	$("#inputPassword").focus();
						});
						return false;
		    		}else if(surePassword!=inputPassword){
		    			$("#messageshow").html("两次密码输入不一致！");
		    			$("#myModal").modal("show");
						$('#myModal').on("hidden.bs.modal", function (e) {
						  	$("#surePassword").focus();
						});
						return false;
		    		}else{
		    			$.ajax({
							url:"${basePath}gosign.do",
							type:"post",
							dataType:"text",
							data:{"username":inputUsername,"password":inputPassword,"roleid":2},
							success:function(data){
								var result=eval('('+data+')');
								if(result.errres){
									$("#messageshow").html(result.errmsg);
					    			$("#myModal").modal("show");
					    			$("#myModal").on("hidden.bs.modal", function (e) {
					    				window.location.href="${basePath}index.do";
									});
								}else{
				            		$("#messageshow").html(result.errmsg);
					    			$("#myModal").modal("show");
					    			$("#myModal").on("hidden.bs.modal", function (e) {
									  	$("#"+result.inputfocus).focus();
									});
								}
							}
		    			});
				    }
		    	});
		    	
				$(document).keydown(function(event){ 
					if(event.keyCode == 13){
						event.preventDefault();
						$("#submitbtn").click();
					}
				});
			});
	    </script>
</body>
</html>