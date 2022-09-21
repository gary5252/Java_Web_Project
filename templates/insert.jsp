<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert</title>
    <link rel="stylesheet" href="../static/css/main.css">
    <%@ page contentType="text/html;charset=utf-8" import="java.sql.*"%>
 
</head>
<body>
    <header>
        <div><a href="home.jsp"  class="index">
    <%
    String id = (String)session.getAttribute("ID");
    String user = (String)session.getAttribute("USER");
    if ( id == null)
        //尚未登入，直接進入網頁頁面
        response.sendRedirect("login.jsp");
    else{
        out.print(user);
    %>
    </a> 歡迎光臨</div>
    <nav>
        <%
        if (user.equals("admin"))
            out.println("<a class=\"navitem\" href=\"./user.jsp\">用戶資訊</a>");
        %>
        <a class="navitem" href="./insert.jsp">新增記帳</a>
        <a class="navitem" href="./update.jsp">修改紀錄</a>
        <a class="navitem" href="./select.jsp">收支分析</a>
        <a class="navitem" href="./pay.html">氪金支持</a>
        <form action="logout.jsp" method="POST" class="navitem">
            <input type="submit" value="登出" />
        </form>
    </nav>
</header>
<hr class="hr-shadow">
    <%
        }
    %>
    <div class="container">
    <h2 style="text-align: center;font-size: 48px;">新增記帳</h2>
    <center><h3>Hint &nbsp; : &nbsp; 記帳分類 &nbsp; *收入 &nbsp; 以外的類別都歸類為 &nbsp; 支出</h3></center>
    <form action="insert_ver.jsp" method="GET">
    <div>
        <label for="record">日期</label>
        <input type="date" name="date" id="date">
    </div>
    <div>
        <label for="record">類別</label>
        <select name="category">
            <option value="收入" checked>收入</option>
            <option value="食">食</option>
            <option value="衣">衣</option>
            <option value="住">住</option>
            <option value="行">行</option>
            <option value="育">育</option>
            <option value="樂">樂</option>
            <option value="其他">其他</option>
        </select> 
    </div>
    <div>
        <label for="record">金額</label>
        <input type="number" id="amount" name="amount"/>
    </div>
    <div>
        <label for="record">描述</label>
        <input type="text" id="desc" name="desc"/>
    </div>

    <p>
        <button type="submit">新增</button>
        <input type="reset" value="清除"/>
    </p>
    </form>
    <img src="../static/images/img02.jpg" alt="" style="display:inline;max-width: 60%;max-height: 70%;position:relative;left:40%;top:0px;">
    <%
    String mess = (String)session.getAttribute("MESS");
    if ( mess != null){
     out.println(mess);
     session.removeAttribute("MESS");
    }
     %>   
    </div>
</body>
</html>