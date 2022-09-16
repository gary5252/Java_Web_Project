<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <%@ page contentType="text/html;charset=utf-8" import="java.sql.*" %>
    <%! // MySQL 8.0 以上版本 - JDBC 驅動名及資料庫 URL
       static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";  
       static final String DB_URL = "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

       static final String USER = "root";
       static final String PASS = "rootroot";
    %>
</head>
<body>
    <h1>Resgister</h1>
    <form action="./register.jsp" method="POST">
    <!-- form表單如果是用POST 記得加入 CSRF 跨域安全請求 -->
    <!-- {% csrf_token %} -->
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
        <label for="username">電話</label>
        <input type="text" name="phone" id="phone" placeholder="請輸入電話">
    </div>
    <p>
        <button type="submit">註冊</button>
        <input type="reset" value="清除"/>
        <a href="./login.html">登入</a>
    </p>

    <%
    Connection conn = null;
    Statement stmt = null;
    String user = request.getParameter("user");
    String pwd  = request.getParameter("password");
    String phone = request.getParameter("phone");
    // out.println("帳號:"+user+", 密碼:"+pwd);
    if (phone.matches("\\d{10}")){
    try{
      Class.forName(JDBC_DRIVER); 
      Connection con= DriverManager.getConnection(DB_URL,USER,PASS);
    
      Statement st = con.createStatement();
      
      String sql= "INSERT INTO `user`(`username`,`password`,`phone`,`height`,`weight`,`money`) VALUES(?,?,?,100,20,500);";
      PreparedStatement ps = con.prepareStatement(sql);
      ps.setString(1,user);
      ps.setString(2,pwd);
      ps.setString(3,phone);
      ps.executeUpdate();
     st.close();
     con.close();
     out.println("<h3>帳號註冊成功</h3>");
      }catch(Exception e){
        out.println("資料庫連結錯誤："+e.toString() );
      }      
    }
    else{
        out.println("電話格式錯誤!");
    }
     %>   
</body>
</html>