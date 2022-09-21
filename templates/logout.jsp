<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout</title>
    <%@ page contentType="text/html;charset=utf-8" %>
</head>
<body>
    <%
      //清除Cookie之帳號資料
      Cookie ck = new Cookie("ACCOUNT",null);
      ck.setMaxAge(0);  //指定存活0秒
      response.addCookie(ck);

      //清除session之帳號資料
      session.removeAttribute("ID");
      session.removeAttribute("USER");

      //回到登入畫面
      response.sendRedirect("login.jsp");
%>

</body>
</html>