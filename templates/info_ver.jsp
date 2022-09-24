<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Information</title>
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

    String sql = "";
    String mess = (String)session.getAttribute("MESS");
    if ( mess != null){
     session.removeAttribute("MESS");
    }
    String phone = request.getParameter("phone");
    String addr = request.getParameter("addr");
    String gender = request.getParameter("gender");
    String email = request.getParameter("email");
	int age = request.getParameter("age")!=null?Integer.parseInt(request.getParameter("age")):null;  //三元運算以防空值報錯
    try{
        Class.forName(JDBC_DRIVER); 
        Connection con= DriverManager.getConnection(DB_URL,USER,PASS);

            sql = "UPDATE `user` SET `gender` = ?, `age` = ?, `phone` = ?, `email` = ?, `address` = ? WHERE `UID` = ?";
            PreparedStatement ps = con.prepareStatement(sql);
                     
            ps.setString(1,gender);
            ps.setInt(2,age);
            ps.setString(3,phone);
            ps.setString(4,email);
            ps.setString(5,addr);
            ps.setString(6,id);
            
            int cnt = ps.executeUpdate();
            if(cnt != 0){
                session.setAttribute("MESS","帳號 : "+ user + " 資訊編輯成功");
                ps.clearParameters();
                ps.close();
                con.close();
                response.sendRedirect("info.jsp");  
            }
        }catch(Exception e){
          // out.println("資料庫連結錯誤："+e.toString() );
            session.setAttribute("MESS","欄位內容有誤，編輯失敗"+e.toString());
            response.sendRedirect("info.jsp");  
        }   
             %>      
          </table></center>  
</body>
</html>