<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Information</title>
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
    <%
    String dbgender = "";
    int dbage = -1;
    String dbphone = "";
    String dbemail = "";
    String dbaddr = "";
    try{
        Class.forName(JDBC_DRIVER); 
        Connection con= DriverManager.getConnection(DB_URL,USER,PASS);

            String sql = "SELECT * FROM `user` WHERE `UID` = ?";
            PreparedStatement ps = con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
            ps.setString(1,id);
            ps.executeQuery();
            ResultSet rs = ps.executeQuery();
            while (rs.next() ){
                dbgender = rs.getString("gender");
                dbage = rs.getInt("age");
                dbphone = rs.getString("phone");
                dbemail = rs.getString("email");
                dbaddr = rs.getString("address");
                }
/*
            out.println(id);
            out.println(user);
            out.println(dbgender);
            out.println(dbage);
            out.println(dbphone);
            out.println(dbemail);
            out.println(dbaddr);
*/            
            rs.close();
            ps.close();
            con.close();
          }catch(Exception e){
            out.println("資料庫連結錯誤："+e.toString() );
          }    
    %>
    <input type="hidden" name="dbgender" id="dbgender" value="<%=dbgender %>">
    <input type="hidden" name="dbage" id="dbage" value="<%=dbage %>">
    <input type="hidden" name="dbphone" id="dbphone" value="<%=dbphone %>">
    <input type="hidden" name="dbemail" id="dbemail" value="<%=dbemail %>">
    <input type="hidden" name="dbaddr" id="dbaddr" value="<%=dbaddr %>">

    <!-- <br>
    <%=dbgender %>
    <%=dbage %>
    <%=dbphone %>
    <%=dbemail %>
    <%=dbaddr %> -->
    <div class="container">
        <h2 style="text-align: center;font-size: 48px;"><%=user %>編輯資訊</h2>
        <form action="info_ver.jsp" method="POST">
            <!-- <input type="hidden" name="id" id="id" value="<%=id %>"> -->
            <div>
                <label for="username">性別</label>
                <select name="gender" id="gender">
                    <option value="F" checked>女生</option>
                    <option value="M">男生</option>
                    <option value="N">不想說</option>
                </select> 
            </div>
            <div>
                <label for="username">年齡</label>
                <input type="text" id="age" name="age"/>
            </div>
            <div>
                <label for="username">電話</label>
                <input type="text" name="phone" id="phone">
            </div>
            <div>
                <label for="username">信箱</label>
                <input type="text" name="email" id="email">
            </div>
            <div>
                <label for="username">地址</label>
                <input type="text" name="addr" id="addr">
            </div>
    
        <p>
            <button type="submit">確定</button>
            <input type="reset" value="清除"/>
        </p>
        <%
        String mess = (String)session.getAttribute("MESS");
        if ( mess != null){
         out.println(mess);
         session.removeAttribute("MESS");
        }
         %>   
         </form>
         <img src="../static/images/img05.jpg" alt="" style="display:inline;max-width: 60%;max-height: 70%;position:relative;left:40%;top:0px;">
        </div>
</body>
<script>
    var gender = document.getElementById("dbgender").value;
    document.getElementById("gender").value = gender;
    var age = document.getElementById("dbage").value;
    document.getElementById("age").value = age;
    var phone = document.getElementById("dbphone").value;
    document.getElementById("phone").value = phone;
    var email = document.getElementById("dbemail").value;
    document.getElementById("email").value = email;
    var addr = document.getElementById("dbaddr").value;
    document.getElementById("addr").value = addr;
</script>
</html>