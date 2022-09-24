<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.3.3/echarts.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="../static/css/main.css">
    <%@ page contentType="text/html;charset=utf-8" %>
</head>
<body>
    <%
      //先判斷Cookie是否已有登入的使用者紀錄
      Cookie[] cks = request.getCookies();
      if (cks !=null){
          boolean flagCookie=false;  //true表示有登入帳號
          for (int i=0; i<cks.length; i++){
                if (cks[i].getName().equals("ACCOUNT")){
                         flagCookie=true;
                         session.setAttribute("ID",cks[i].getValue() );
                         break;
                }
            }

           if ( flagCookie ) 
                //已經有登入紀錄，直接導向至首頁
                response.sendRedirect("home.jsp");
        }
    %>
    <div class="container">
    <div id="main" style="width: 100%;height:150px;"></div>
    <!-- <h1>Login</h1> -->
    <form action="verify.jsp" method="post" style="display:inline">
        <div>
            <label for="username">帳號</label>
            <!--     name 給後端辨識   id 給前端(CSS,JS)辨識   -->
            <input type="text" name="user" id="user" placeholder="請輸入帳號">
        </div>
        <div>
            <label for="username">密碼</label>
            <input type="password" name="password" id="password" placeholder="請輸入密碼">
        </div>
        <p>
            <button type="submit">登入</button>
            <input type="reset" value="清除"/>
            <input type="checkbox" name="keep" value="YES" />記住我
            <br>
            若無會員登入
            <a href="./register.jsp">註冊</a>
        </p>
    </form>
    <%
    String err = (String)session.getAttribute("ERROR");
    if ( err != null){
        out.println(err);
       }
       String mess = (String)session.getAttribute("MESS");
       if ( mess != null){
        out.println(mess + "<br>");
        session.removeAttribute("MESS");
       }
    %>
    <img src="../static/images/img03.jpg" alt="" style="display:inline;max-width: 60%;max-height: 70%;position:relative;left:40%;top:0px;">
</div>

<script src="../static/js/login.js"></script>
</body>
</html>