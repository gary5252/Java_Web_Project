<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify</title>
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
    String user = request.getParameter("user");
    String key=request.getParameter("password");
    String remain= request.getParameter("keep");
    try{
        Class.forName(JDBC_DRIVER); 
        Connection con= DriverManager.getConnection(DB_URL,USER,PASS);
      
         Statement st = con.createStatement();
      
        String sql = "SELECT * FROM `user` WHERE username=? and password=?";
        PreparedStatement ps = con.prepareStatement(sql);
                 
        ps.setString(1,user);
        ps.setString(2,key);
        ps.executeQuery();
        ResultSet rs = ps.executeQuery();
      
        if(rs.next())  // 有抓到DB資料(有帳號) > 成功登入
        {
           // 通過欄位檢索
           String id  = rs.getString("UID");
           String username = rs.getString("username");
           String password = rs.getString("password");
           
           rs.close();
           st.close();
           con.close();
           session.setAttribute("ID",id);
           session.setAttribute("USER",username);
           String err = (String)session.getAttribute("ERROR");
           if ( err != null){
            session.removeAttribute("ERROR");
           }
           if ( remain !=null ){
               Cookie ck = new Cookie("ACCOUNT", id);
               ck.setMaxAge(99999); //設立大一點的生命週期
               response.addCookie(ck);
           }    
           response.sendRedirect("home.jsp");  
         }else{
               // out.print("你的帳號密碼錯誤，請重新輸入 ");
               rs.close();
               st.close();
               con.close();
               session.setAttribute("ERROR","帳號密碼錯誤");
               response.sendRedirect("login.jsp");  
         }
        }catch(Exception e){
          //out.println("資料庫連結錯誤："+e.toString() );
          session.setAttribute("ERROR","帳號密碼錯誤");
          response.sendRedirect("login.jsp");  
        }      
%>

</body>
</html>