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
    <title>编辑用户</title>
</head>
<body>
<form>
    <table>
        <tr>
            <td>
                用户姓名：
            </td>
            <td>
                <input type="text" name="userName" id="userName" value="${userModel.userName}"/>
            </td>
        </tr>
        <tr>
            <td>
                性别：
            </td>
            <td>
                <input type="radio" value= "0" name="gender" id="man"/>男
                <input type="radio" value= "1" name="gender" id="woman"/>女
            </td>
        </tr>
        <tr>
            <td>
                生日：
            </td>
            <td>
                <input class="Wdate" type="text" name="birthday" id="birthday" value="${userModel.birthdayString}"/>
                <span>格式：年-月-日</span>
            </td>
        </tr>
        <tr>
            <td>
                用户类型：
            </td>
            <td>
                <select id="userType" name="userType">
                    <option value="1">普通用户</option>
                    <option value="0">系统管理员</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>喜好：</td>
            <td>
                <input type="checkbox" name="favorite" value="1" id="music"> 音乐 &nbsp;
                <input type="checkbox" name="favorite" value="2" id="movie"> 电影 &nbsp;
                <input type="checkbox" name="favorite" value="3" id="internet"> 上网 &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <button type="button" onclick="saveUser()">保存</button>
            </td>
        </tr>
    </table>

</form>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
    $(function () {
        var gender = '${userModel.gender}';
        if(gender == 0){
            $("input:radio[value='0']").attr('checked','true');
        }else{
            $("input:radio[value='1']").attr('checked','true');
        }
        var userType = '${userModel.userType}';
        $("#userType").val(userType);
        <c:if test="${fn:contains(userModel.favorite,';1;')}">
            $("#music").attr("checked", true);
        </c:if>
        <c:if test="${fn:contains(userModel.favorite,';2;')}">
            $("#movie").attr("checked", true);
        </c:if>
        <c:if test="${fn:contains(userModel.favorite,';3;')}">
            $("#internet").attr("checked", true);
        </c:if>
    });
    function saveUser(){
        var userId = '${userModel.userId}';
        if(userId == ''){
            userId = 0;
        }
        var userName = document.getElementById("userName").value;
        userName = encodeURI(encodeURI(userName));
        var gender = $("input[name='gender']:checked").val();
        var birthdayString = document.getElementById("birthday").value;
        var userType = $("#userType").val();
        var objects = document.getElementsByName("favorite");
        var favorite = ';';
        for (i=0;i<objects.length;i++){
            if(objects[i].checked == true){
                favorite += objects[i].value;
                favorite += ';';
            }
        }
        if(userName==null || userName==""){
            alert("请填写用户名称!");
            return;
        }

        var url = "${pageContext.request.contextPath}/user/saveUser.do";
        url += "?userId=" + userId;
        url +="&userName=" + userName;
        url +="&gender=" + gender;
        url +="&birthdayString=" + birthdayString;
        url +="&userType=" + userType;
        url +="&favorite=" + favorite;
        $.ajax({
            url: url,
            type: 'POST',   // 请求方式
            dataType: 'json', // 返回数据的格式, 通常为JSON
            contentType: 'application/json',
            success: function (result) {
                alert("保存成功！");
                window.open('${pageContext.request.contextPath}/user/listAllUsers.do','_blank');
                window.close();
            },
            error: function () {
                console.log('Send Request Fail..'); // 请求失败时的回调函数
            }
        });
    }
</script>

</body>
</html>