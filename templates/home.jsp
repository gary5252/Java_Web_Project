<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="300"> <!-- 每 300 秒刷新頁面 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
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
    <nav>
        <%
        if (user.equals("admin"))
            out.println("<a class=\"navitem\" href=\"./user.jsp\">用戶資訊</a>");
        %>
        <a class="navitem" href="./insert.jsp">新增記帳</a>
        <a class="navitem" href="./info.jsp">編輯資訊</a>
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
    <center><h3>Hint &nbsp; : &nbsp; 記帳分類 &nbsp; *收入 &nbsp; 以外的類別都歸類為 &nbsp; 支出</h3></center>
    <%
    String mess = (String)session.getAttribute("MESS");
    if ( mess != null){
        out.println("<center><h4 style=\"color:crimson;\">" + mess + "</h4></center>");
        session.removeAttribute("MESS");
    }
     %> 
    <center><table border="1">
    <%
    String sql = "";
    int rid = -1;
    try{
        Class.forName(JDBC_DRIVER); 
        Connection con= DriverManager.getConnection(DB_URL,USER,PASS);
      
        if (user.equals("admin")){
            Statement st = con.createStatement();
            sql = "SELECT * FROM `record`,`user` WHERE record.uid = user.UID ORDER BY `year` DESC,`month` DESC,`date` DESC";
            ResultSet rs = st.executeQuery(sql);
            
            out.println("<tr><th>用戶</th><th>序號</th><th>年</th><th>月</th><th>日</th><th>類別</th><th>金額</th><th>描述</th><th>編輯</th></tr>");
            
            while (rs.next() ){
                rid = rs.getInt("RID");
                out.println("<tr><td>"+rs.getObject("username")+"</td>>");
                out.println("<td>"+rs.getObject("RID")+"</td>");   
                out.println("<td>"+rs.getObject("year")+"</td>");         
                out.println("<td>"+rs.getObject("month")+"</td>");      
                out.println("<td>"+rs.getObject("date")+"</td>");  
                out.println("<td>"+rs.getObject("category")+"</td>");      
                out.println("<td>"+rs.getObject("amount")+"</td>");
                out.println("<td>"+rs.getObject("description")+"</td>");   
                %>   
                <td><form action="update.jsp" method="get">
                <input type="hidden" name="RID" value="<%=rid %>" />
                <input type="submit" value="修改" />
                </form></td></tr>
                <%
                }
              rs.close();
              st.close();
              con.close();
        }else{
        sql = "SELECT * FROM `record` WHERE uid = ? ORDER BY `year` DESC,`month` DESC,`date` DESC";
        PreparedStatement ps = con.prepareStatement(sql);
                 
        ps.setString(1,id);
        
        ps.executeQuery();
        ResultSet rs = ps.executeQuery();
        out.println("<tr><th>序號</th><th>年</th><th>月</th><th>日</th><th>類別</th><th>金額</th><th>描述</th><th>編輯</th></tr>");

            while (rs.next() ){
              rid = rs.getInt("RID");
              out.println("<tr><td>"+rs.getObject("RID")+"</td>");  
              out.println("<td>"+rs.getObject("year")+"</td>");  
              out.println("<td>"+rs.getObject("month")+"</td>");      
              out.println("<td>"+rs.getObject("date")+"</td>");  
              out.println("<td>"+rs.getObject("category")+"</td>");      
              out.println("<td>"+rs.getObject("amount")+"</td>");      
              out.println("<td>"+rs.getObject("description")+"</td>");    
              %>   
              <td><form action="update.jsp" method="get">
              <input type="hidden" name="RID" value="<%=rid %>" />
              <input type="submit" value="修改" />
              </form></td></>
              <%
            }
            rs.close();
            ps.close();
            con.close();
        }
          }catch(Exception e){
            out.println("資料庫連結錯誤："+e.toString() );
          }      
         %>   
          </table></center>  

</body>
</html>