<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.3.3/echarts.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
    <h2>圖表搜尋</h2>
    <a href="select.jsp">收支檢視</a>
    <form action="" method="GET">
    <div>
        <label for="year">年份</label>
        <select name="year">
            <option value="2025">2025</option>
            <option value="2024">2024</option>
            <option value="2023">2023</option>
            <option value="2022" checked>2022</option>
            <option value="2021">2021</option>
            <option value="2020">2020</option>
            <option value="2019">2019</option>
            <option value="2018">2018</option>
            <option value="2017">2017</option>
            <option value="2016">2016</option>
        </select> 
    </div>
    <div>
        <label for="month">月份</label>
        <select name="month">
            <option value="1" checked>1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
            <option value="10">10</option>
            <option value="11">11</option>
            <option value="12">12</option>
        </select> 
    </div>
    <p>
        <button type="submit">查詢</button>
        <input type="reset" value="清除"/>
    </p>
    </form>
    <!-- <center><table border="1"> -->
    <%
    String year = request.getParameter("year");
    String month = request.getParameter("month");
    try{
        Class.forName(JDBC_DRIVER); 
        Connection con= DriverManager.getConnection(DB_URL,USER,PASS);
      
         Statement st = con.createStatement();
      
        String sql = "SELECT SUM(`amount`) as `sum`,`month` FROM `record` ";
        sql += "WHERE `uid`=? AND `year`=? AND `month`=? AND `category='食'";
        sql += "GROUP BY `month` ORDER BY `month`";

        String sql1 = "SELECT SUM(`amount`) as `sum`,`month` FROM `record` ";
        sql1 += "WHERE `uid`=? AND `year`=? AND `month`=? AND `category='衣'";
        sql1 += "GROUP BY `month` ORDER BY `month`";

        String sql2 = "SELECT SUM(`amount`) as `sum`,`month` FROM `record` ";
        sql2 += "WHERE `uid`=? AND `year`=? AND `month`=? AND `category='住'";
        sql2 += "GROUP BY `month` ORDER BY `month`";

        String sql3 = "SELECT SUM(`amount`) as `sum`,`month` FROM `record` ";
        sql3 += "WHERE `uid`=? AND `year`=? AND `month`=? AND `category='行'";
        sql3 += "GROUP BY `month` ORDER BY `month`";

        String sql4 = "SELECT SUM(`amount`) as `sum`,`month` FROM `record` ";
        sql4 += "WHERE `uid`=? AND `year`=? AND `month`=? AND `category='育'";
        sql4 += "GROUP BY `month` ORDER BY `month`";

        String sql5 = "SELECT SUM(`amount`) as `sum`,`month` FROM `record` ";
        sql5 += "WHERE `uid`=? AND `year`=? AND `month`=? AND `category='樂'";
        sql5 += "GROUP BY `month` ORDER BY `month`";

        String sql6 = "SELECT SUM(`amount`) as `sum`,`month` FROM `record` ";
        sql6 += "WHERE `uid`=? AND `year`=? AND `month`=? AND `category='其他'";
        sql6 += "GROUP BY `month` ORDER BY `month`";

        PreparedStatement ps = con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                 
        ps.setString(1,id);
        ps.setString(2,year);
        ps.setString(3,month);
        ps.executeQuery();
        ResultSet rs = ps.executeQuery();
/*
        rs.last();                   // 測試用
        int z = rs.getInt("month");
        int n = rs.getInt("sum");
        rs.first();
        int m = rs.getInt("month");
        out.println(m);
        out.println("<br>");
        out.println(n);
        out.println("<br>");
        out.println(z);
*/

           // out.println("<tr><th>month</th><th>sum</th></tr>");
            
            while (rs.next() ){
                //out.println("<tr><td>"+rs.getInt("month")+"</td>");         
                //out.println("<td>"+rs.getInt("sum")+"</td></tr>");      
                int m = rs.getInt("month");
                int s = rs.getInt("sum");
              }
              rs.close();
              st.close();
              con.close();
          }catch(Exception e){
            //out.println("資料庫連結錯誤："+e.toString() );
          }      
         %>   
         <div id="main" style="width: 100%;height:600px;"></div>   
        
        <script src="../static/js/pie.js"></script>
</body>
</html>