<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Index</title>
    <%@ page contentType="text/html;charset=utf-8" import="java.sql.*" %>
    <%! // MySQL 8.0 以上版本 - JDBC 驅動名及資料庫 URL
       static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";  
       static final String DB_URL = "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

       static final String USER = "root";
       static final String PASS = "rootroot";
    %>
</head>
<body>
    網站接收到你輸入的訊息:
  <%
    Connection conn = null;
    Statement stmt = null;
    String user = request.getParameter("user");
    String pwd  = request.getParameter("password");
    out.println("帳號:"+user+", 密碼:"+pwd);
    try{
      Class.forName(JDBC_DRIVER); 
      Connection con= DriverManager.getConnection(DB_URL,USER,PASS);
    
      Statement st = con.createStatement();
    
      String sql= "SELECT * FROM user WHERE username = 'admin'";
      ResultSet rs = st.executeQuery(sql);
    
    %>
      <center><table border="1">
        <tr><th>UID</th><th>姓名</th><th>密碼</th><th>身高</th><th>體重</th><th>摳摳</th>
        </tr>
    <%
        while (rs.next() ){
          out.println("<tr><td>"+rs.getObject("UID")+"</td>");         //帳號
          out.println("<td>"+rs.getObject("username")+"</td>");      //姓名
          out.println("<td>"+rs.getObject("password")+"</td>");  //密碼
          out.println("<td>"+rs.getObject("height")+"</td>");      //身高
          out.println("<td>"+rs.getObject("weight")+"</td>");      //體重
          out.println("<td>"+rs.getObject("money")+"</td></tr>");      //摳摳
          int hp  = rs.getInt("height");
        int ap  = rs.getInt("weight");
        out.println(hp);
        out.println(ap);
        out.println(hp - ap);
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