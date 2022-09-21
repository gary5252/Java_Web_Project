<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User</title>
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
    <%
    if (!user.equals("admin"))
        response.sendRedirect("home.jsp");
    %>
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
    <center><table border="1">
    <%
    String sql = "";
    try{
        Class.forName(JDBC_DRIVER); 
        Connection con= DriverManager.getConnection(DB_URL,USER,PASS);

            Statement st = con.createStatement();
            sql = "SELECT * FROM `user` WHERE 1 = 1 ORDER BY `UID`";
            ResultSet rs = st.executeQuery(sql);
            out.println("<tr><th>UID</th><th>username</th><th>password</th><th>gender</th><th>age</th>");
            out.println("<th>phone</th><th>email</th><th>address</th></tr>");
            
            while (rs.next() ){
                out.println("<tr><td>"+rs.getObject("UID")+"</td>");   
                out.println("<td>"+rs.getObject("username")+"</td>");         
                out.println("<td>"+rs.getObject("password")+"</td>");      
                out.println("<td>"+rs.getObject("gender")+"</td>");  
                out.println("<td>"+rs.getObject("age")+"</td>");      
                out.println("<td>"+rs.getObject("phone")+"</td>"); 
                out.println("<td>"+rs.getObject("email")+"</td>");      
                out.println("<td>"+rs.getObject("address")+"</td></tr>");      
              }
              rs.close();
              st.close();
              con.close();
          }catch(Exception e){
            out.println("資料庫連結錯誤："+e.toString() );
          }      
         %>   
          </table></center>  
</body>
</html>