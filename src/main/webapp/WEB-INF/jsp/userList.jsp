<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户列表</title>
</head>
<body>
<form>
    <table border="1px" width="1200px" height="50px">
        <tr>
            <td colspan="8" align="center"><button type="button" onclick="editOrAddUser(0)">新增用户</button></td>
        </tr>
        <tr>
            <td>
                用户姓名：
            </td>
            <td>
                <input type="text" id="userName"/>
            </td>
            <td>
                性别：
            </td>
            <td>
                <select id="gender" name="gender">
                    <option value="2">------</option>
                    <option value="0">男</option>
                    <option value="1">女</option>
                </select>
            </td>
            <td>
                用户类型：
            </td>
            <td>
                <select id="userType" name="userType">
                    <option value="3">------</option>
                    <option value="1">普通用户</option>
                    <option value="0">系统管理员</option>
                </select>
            </td>
            <td>
                <button type="button" onclick="query()">查询</button>
            </td>
        </tr>
        <tr>
            <td align="center">用户ID</td>
            <td align="center">姓名</td>
            <td align="center">性别</td>
            <td align="center">生日</td>
            <td align="center">用户类型</td>
            <td align="center">喜好</td>
            <td colspan="2" align="center" valign="middle">操作</td>
        </tr>
        <c:forEach items="${requestScope.userList.lists}" var="user">
            <tr>
                <td align="center">${user.userId}</td>
                <td align="center">${user.userName}</td>
                <td align="center">
                    <c:if test="${user.gender == 0}">
                        <input type="radio" disabled="true" name="man${user.userId}" class="radio" value="0" checked="checked"/> 男
                        <input type="radio" disabled="true" name="woman${user.userId}" class="radio" value="1"/> 女
                    </c:if>
                    <c:if test="${user.gender != 0}">
                        <input type="radio" disabled="true" name="man${user.userId}" class="radio" value="0"/> 男
                        <input type="radio" disabled="true" name="woman${user.userId}" class="radio" value="1" checked="checked"/> 女
                    </c:if>
                </td>
                <td align="center">${user.birthdayString}</td>
                <td align="center">
                    <c:if test="${user.userType == 0}">
                        系统管理员
                    </c:if>
                    <c:if test="${user.userType == 1}">
                        普通用户
                    </c:if>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${fn:contains(user.favorite,';1;')}">
                            <input type="checkbox" disabled="disabled" name="favorite" value="music" checked> 音乐 &nbsp;
                        </c:when>
                        <c:otherwise>
                            <input type="checkbox" disabled="disabled" name="favorite" value="music"> 音乐 &nbsp;
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${fn:contains(user.favorite,';2;')}">
                            <input type="checkbox" disabled="disabled" name="favorite" value="movie" checked> 电影 &nbsp;
                        </c:when>
                        <c:otherwise>
                            <input type="checkbox" disabled="disabled" name="favorite" value="movie" > 电影 &nbsp;
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${fn:contains(user.favorite,';3;')}">
                            <input type="checkbox" disabled="disabled" name="favorite" value="internet" checked> 上网 &nbsp;
                        </c:when>
                        <c:otherwise>
                            <input type="checkbox" disabled="disabled" name="favorite" value="internet"> 上网 &nbsp;
                        </c:otherwise>
                    </c:choose>
                </td>
                <td align="center"><button type="button" onclick="editOrAddUser(${user.userId})">编辑</button></td>
                <td align="center"><button type="button" onclick="deleteUser(${user.userId})">删除</button></td>
            </tr>
        </c:forEach>
        <tr>
            <td align="center" colspan="8">
                <span>第${requestScope.userList.currPage }/ ${requestScope.userList.totalPage}页</span>
                <span>总记录数：${requestScope.userList.totalCount }  每页显示:${requestScope.userList.pageSize}</span>
                <span>
                   <c:if test="${requestScope.userList.currPage != 1}">
                       <a href="${pageContext.request.contextPath }/user/listAllUsers.do?currentPage=1">[首页]</a>
                       <a href="${pageContext.request.contextPath }/user/listAllUsers.do?currentPage=${requestScope.userList.currPage-1}">[上一页]</a>
                   </c:if>

                   <c:if test="${requestScope.userList.currPage != requestScope.pagemsg.totalPage}">
                       <a href="${pageContext.request.contextPath }/user/listAllUsers.do?currentPage=${requestScope.userList.currPage+1}">[下一页]</a>
                       <a href="${pageContext.request.contextPath }/user/listAllUsers.do?currentPage=${requestScope.userList.totalPage}">[尾页]</a>
                   </c:if>
                </span>
            </td>
        </tr>
    </table>

</form>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<script>
    function editOrAddUser(userId) {
        window.open('${pageContext.request.contextPath}/user/editOrAddUser.do?userId='+userId,'_blank');
    }
    function deleteUser(userId) {
        $.ajax({
            url: '${pageContext.request.contextPath}/user/deleteUser.do?userId='+userId,
            type: 'POST',   // 请求方式
            dataType: 'json', // 返回数据的格式, 通常为JSON
            contentType: 'application/json',
            success: function (result) {
                alert("删除成功！");
                window.location.reload();
                console.log("ok"); // 请求成功后的回调函数, result 为响应内容
            },
            error: function () {
                console.log('Send Request Fail..'); // 请求失败时的回调函数
            }
        });
    }
    function query(){
        var userName = document.getElementById("userName").value;
       // userName = encodeURI(encodeURI(userName));
        var gender = $("#gender").val();
        var userType = $("#userType").val();
        var url = '${pageContext.request.contextPath }/user/listAllUsers.do?currentPage=1';
        if(userName != ''){
            url += '&userName=' +userName;
        }
        if(gender != 2){
            url += "&gender="+gender ;
        }
        if(userType != 3){
            url  +="&userType="+userType;
        }

        alert(url);
        window.location.href = url;
    }
</script>

</body>
</html>