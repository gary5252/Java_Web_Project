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
    // rid = Integer.parseInt((request.getParameter("RID")).trim());
    String rid = request.getParameter("RID");
    String dbyear = "";
    String dbmonth = "";
    String dbdate = "";
    String dbcategory = "";
    int dbamount = -1;
    String dbdesc = "";
    String date = "";
    try{
        Class.forName(JDBC_DRIVER); 
        Connection con= DriverManager.getConnection(DB_URL,USER,PASS);

            String sql = "SELECT * FROM `record` WHERE `RID` = ?";
            PreparedStatement ps = con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
            ps.setString(1,rid);
            ps.executeQuery();
            ResultSet rs = ps.executeQuery();
            while (rs.next() ){
                dbyear = rs.getString("year");
                dbmonth = rs.getString("month");
                dbdate = rs.getString("date");
                dbcategory = rs.getString("category");
                dbamount = rs.getInt("amount");
                dbdesc = rs.getString("description");
                }
            date += dbyear + "-";
            date += dbmonth + "-";
            date += dbdate;
            /*
            out.println(date);
            out.println(dbyear + "<br>");
            out.println(dbmonth + "<br>");
            out.println(dbdate + "<br>");
            out.println(dbcategory + "<br>");
            out.println(dbamount + "<br>");
            out.println(dbdesc + "<br>");
            */
            
            rs.close();
            ps.close();
            con.close();
          }catch(Exception e){
            out.println("資料庫連結錯誤："+e.toString() );
          }    
    %>
    <input type="hidden" name="dbdate" id="dbdate" value="<%=date %>">
    <input type="hidden" name="dbcategory" id="dbcategory" value="<%=dbcategory %>">
    <input type="hidden" name="dbamount" id="dbamount" value="<%=dbamount %>">
    <input type="hidden" name="dbdesc" id="dbdesc" value="<%=dbdesc %>">

    <div class="container">
        <h2 style="text-align: center;font-size: 48px;">修改紀錄</h2>
        <form action="update_ver.jsp" method="GET">
            <input type="hidden" name="rid" id="rid" value="<%=rid %>">
        <div>
            <label for="record">日期</label>
            <input type="date" name="date" id="date">
        </div>
        <div>
            <label for="record">類別</label>
            <select name="category" id="category">
                <option value="收入" checked>收入</option>
                <option value="食">食</option>
                <option value="衣">衣</option>
                <option value="住">住</option>
                <option value="行">行</option>
                <option value="育">育</option>
                <option value="樂">樂</option>
                <option value="其他">其他</option>
            </select> 
        </div>
        <div>
            <label for="record">金額</label>
            <input type="number" id="amount" name="amount"/>
        </div>
        <div>
            <label for="record">描述</label>
            <input type="text" id="desc" name="desc"/>
        </div>
    
        <p>
            <button type="submit">修改</button>
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
         <img src="../static/images/img01.jpg" alt="" style="display:inline;max-width: 60%;max-height: 70%;position:relative;left:20%;top:0px;">
        </div>
</body>
<script>
    var date = document.getElementById("dbdate").value;
    document.getElementById("date").value = date;
    var category = document.getElementById("dbcategory").value;
    document.getElementById("category").value = category;
    var amount = document.getElementById("dbamount").value;
    document.getElementById("amount").value = amount;
    var desc = document.getElementById("dbdesc").value;
    document.getElementById("desc").value = desc;
</script>
</html>