<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.3.3/echarts.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="../static/css/main.css">
    <%@ page contentType="text/html;charset=utf-8" import="java.sql.*"%>
</head>
<body>
    <div class="container">
        <div id="main" style="width: 100%;height:150px;"></div>
    <!-- <h1>Resgister</h1> -->
    <form action="./reg_verify.jsp" method="POST">
    <div>
        <label for="username">帳號</label>
        <!--     name 給後端辨識   id 給前端( CSS )辨識   -->
        <input type="text" name="user" id="user" placeholder="請輸入帳號">
    </div>
    <div>
        <label for="username">密碼</label>
        <input type="password" name="password" id="password" placeholder="請輸入密碼">
    </div>
    <div>
        <label for="username">性別</label>
        <select name="gender">
            <option value="F" checked>女生</option>
            <option value="M">男生</option>
            <option value="N">不想說</option>
        </select> 
    </div>
    <div>
        <label for="username">年齡</label>
        <input type="text" id="age" name="age"/>
    </div>
    <div>
        <label for="username">電話</label>
        <input type="text" name="phone" id="phone" placeholder="請輸入電話">
    </div>
    <div>
        <label for="username">信箱</label>
        <input type="text" name="email" id="email" placeholder="請輸入信箱">
    </div>
    <div>
        <label for="username">地址</label>
        <input type="text" name="addr" id="addr" placeholder="請輸入地址">
    </div>
    <p>
        <button type="submit">註冊</button>
        <input type="reset" value="清除"/>
        <a href="./login.jsp">登入</a>
    </p>
    </form>
    <img src="../static/images/img04.jpg" alt="" style="display:inline;max-width: 60%;max-height: 70%;position:relative;left:40%;top:0px;">
</div>
    <%
    String mess = (String)session.getAttribute("MESS");
    if ( mess != null){
        out.println(mess);
       }
    %>
    <script src="../static/js/register.js"></script>
</body>
</html>