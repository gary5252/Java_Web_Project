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
    <a href="chart.jsp">支出比列檢視</a>
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
    <p>
        <button type="submit">查詢</button>
        <input type="reset" value="清除"/>
    </p>
    </form>
    <!-- <center><table border="1"> -->
    <%
    String year = request.getParameter("year");
    try{
        Class.forName(JDBC_DRIVER); 
        Connection con= DriverManager.getConnection(DB_URL,USER,PASS);
      
        String sql = "SELECT SUM(`amount`) as `sum`,`month` FROM `record` WHERE `uid`=? AND `year`=? AND category != '收入'";
        sql += "GROUP BY `month` ORDER BY `month`";    // 支出金額合計

        String sql1 = "SELECT SUM(`amount`) as `sum`,`month` FROM `record` WHERE `uid`=? AND `year`=? AND category = '收入'";
        sql += "GROUP BY `month` ORDER BY `month`";    // 收入金額合計

        PreparedStatement ps = con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                 
        ps.setString(1,id);
        ps.setString(2,year);
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
        int[] array = new int[12];
        int jan = 0;
        int feb = 0;
        int mar = 0;
        int apr = 0;
        int may = 0;
        int jun = 0;
        int jul = 0;
        int aug = 0;
        int sep = 0;
        int oct = 0;
        int nov = 0;
        int dec = 0;

        //int[] array = {0,1,8,6};
        //array[1] = z;
        //array[3] = n;

        //for (int i=0;i<array.length;i++){
          //  out.println(array[i]);
        //}
           // out.println("<tr><th>month</th><th>sum</th></tr>");
            
            while (rs.next() ){
                //out.println("<tr><td>"+rs.getInt("month")+"</td>");         
                //out.println("<td>"+rs.getInt("sum")+"</td></tr>");      
                int m = rs.getInt("month");
                int s = rs.getInt("sum");
                array[m-1] = s;
              }
        jan = array[0];
        feb = array[1];
        mar = array[2];
        apr = array[3];
        may = array[4];
        jun = array[5];
        jul = array[6];
        aug = array[7];
        sep = array[8];
        oct = array[9];
        nov = array[10];
        dec = array[11];
            //for (int i=0;i<array.length;i++){
              //  out.println(array[i]);
            //}
              rs.close();
              con.close();
          }catch(Exception e){
            //out.println("資料庫連結錯誤："+e.toString() );
          }      
         %>   
         <div id="main" style="width: 100%;height:600px;"></div>   
        
        <script src="../static/js/main.js"></script>
</body>
</html>