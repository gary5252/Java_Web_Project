<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <%@ page contentType="text/html;charset=utf-8" import="java.sql.*"%>
    <%! // MySQL 8.0 以上版本 - JDBC 驅動名及資料庫 URL
       static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";  
       static final String DB_URL = "jdbc:mysql://localhost:3306/project_account?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

       static final String USER = "root";
       static final String PASS = "rootroot";
    %>
</head>
<body>
    <%
    String mess = (String)session.getAttribute("MESS");
    if ( mess != null){
     session.removeAttribute("MESS");
    }
    String err = (String)session.getAttribute("ERROR");
    if ( err != null){
     session.removeAttribute("ERROR");
    }
    int age = 0;

    String user = request.getParameter("user");
    String pwd  = request.getParameter("password");
    String phone = request.getParameter("phone");
    String addr = request.getParameter("addr");
    try{
    age = Integer.parseInt((request.getParameter("age")).trim());  //.trim()消字串空白
}catch(Exception e){
    out.println(e.toString());
  }  
    String gender = request.getParameter("gender");
    String email = request.getParameter("email");
    
    //int userage = Integer.valueOf(age);
    try{
      Class.forName(JDBC_DRIVER); 
      Connection con= DriverManager.getConnection(DB_URL,USER,PASS);
      
      String sql= "INSERT INTO `user`(`username`,`password`,`gender`,`age`,`phone`,`email`,`address`) VALUES(?,?,?,?,?,?,?);";
      PreparedStatement ps = con.prepareStatement(sql);
      ps.setString(1,user);
      ps.setString(2,pwd);
      ps.setString(3,gender);
      ps.setInt(4,age);
      ps.setString(5,phone);
      ps.setString(6,email);
      ps.setString(7,addr);
      int cnt = ps.executeUpdate();
      if(cnt != 0){
       // out.println("<h3>帳號註冊成功</h3>");
       session.setAttribute("MESS","帳號註冊成功");
       ps.clearParameters();
       con.close();
       response.sendRedirect("login.jsp");  
      }
      }catch(Exception e){
        out.println("資料庫連結錯誤："+e.toString() );
        session.setAttribute("MESS","帳號密碼錯誤，註冊失敗"+e.toString());
        response.sendRedirect("register.jsp");
      }      
     %>   
</body>
</html>