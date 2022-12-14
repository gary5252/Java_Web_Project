<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update</title>
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

    String sql = "";
    String mess = (String)session.getAttribute("MESS");
    if ( mess != null){
     session.removeAttribute("MESS");
    }
    
    String rid = request.getParameter("rid");   
    String[] date = request.getParameter("date").split("-");
    String year = date[0];
    String month = date[1];
    String dt = date[2];
    String category = request.getParameter("category");
	int amount = request.getParameter("amount")!=null?Integer.parseInt(request.getParameter("amount")):null;  //三元運算以防空值報錯
    String desc = request.getParameter("desc");
    try{
        Class.forName(JDBC_DRIVER); 
        Connection con= DriverManager.getConnection(DB_URL,USER,PASS);

            sql = "UPDATE `record` SET `year` = ?, `month` = ?, `date` = ?, `category` = ?, `amount` = ?, `description` = ? WHERE `RID` = ?";
            PreparedStatement ps = con.prepareStatement(sql);
                     
            ps.setString(1,year);
            ps.setString(2,month);
            ps.setString(3,dt);
            ps.setString(4,category);
            ps.setInt(5,amount);
            ps.setString(6,desc);
            ps.setString(7,rid);
            
            int cnt = ps.executeUpdate();
            if(cnt != 0){
                session.setAttribute("MESS","序號"+ rid + "紀錄修改成功");
                ps.clearParameters();
                ps.close();
                con.close();
                response.sendRedirect("home.jsp");  
            }
        }catch(Exception e){
          // out.println("資料庫連結錯誤："+e.toString() );
            session.setAttribute("MESS","欄位內容有誤，修改失敗"+e.toString());
            response.sendRedirect("update.jsp");  
        }   
             %>      
          </table></center>  
</body>
</html>