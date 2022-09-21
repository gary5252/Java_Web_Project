<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert</title>
    <link rel="stylesheet" href="../static/css/main.css">
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
    String id = (String)session.getAttribute("ID");
    String user = (String)session.getAttribute("USER");
    if ( id == null)
        //尚未登入，直接進入網頁頁面
        response.sendRedirect("login.jsp");

    String mess = (String)session.getAttribute("MESS");
    if ( mess != null){
     session.removeAttribute("MESS");
    }
    int amount = 0;
    
    String[] date = request.getParameter("date").split("-");
    String year = date[0];
    String month = date[1];
    String dt = date[2];
    String category = request.getParameter("category");
    try{
        amount = Integer.parseInt((request.getParameter("amount")).trim());
    }catch(Exception e){
        //out.println(e.toString());
      }
    String desc = request.getParameter("desc");
    
    try{
      Class.forName(JDBC_DRIVER); 
      Connection con= DriverManager.getConnection(DB_URL,USER,PASS);
      
      String sql= "INSERT INTO `record`(`uid`,`year`,`month`,`date`,`category`,`amount`,`description`) VALUES(?,?,?,?,?,?,?);";
      PreparedStatement ps = con.prepareStatement(sql);
      ps.setString(1,id);
      ps.setString(2,year);
      ps.setString(3,month);
      ps.setString(4,dt);
      ps.setString(5,category);
      ps.setInt(6,amount);
      ps.setString(7,desc);
      int cnt = ps.executeUpdate();
      if(cnt != 0){
       session.setAttribute("MESS","記帳新增成功");
       ps.clearParameters();
       ps.close();
       con.close();
       response.sendRedirect("insert.jsp");  
      }
      }catch(Exception e){
        // out.println("資料庫連結錯誤："+e.toString() );
        session.setAttribute("MESS","欄位內容有誤，新增失敗"+e.toString());
        response.sendRedirect("insert.jsp");  
      }      

     %>   
</body>
</html>