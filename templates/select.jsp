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
        <!-- <input type="reset" value="清除"/> -->
    </p>
    </form>
    <div>
    <!-- <table border="1" style="display:inline-block;position: relative;bottom: 350px;"> -->
    <table border="1" style="display:inline-block;">
    <%
    String year = request.getParameter("year");
    try{
        Class.forName(JDBC_DRIVER); 
        Connection con= DriverManager.getConnection(DB_URL,USER,PASS);
      
        String sql = "SELECT SUM(`amount`) as `sum`,`month` FROM `record` WHERE `uid`=? AND `year`=? AND category != '收入'";
        sql += "GROUP BY `month` ORDER BY `month`";    // 支出金額合計

        String sql1 = "SELECT SUM(`amount`) as `sum`,`month` FROM `record` WHERE `uid`=? AND `year`=? AND category = '收入'";
        sql1 += "GROUP BY `month` ORDER BY `month`";    // 收入金額合計

        PreparedStatement ps = con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
        PreparedStatement ps1 = con.prepareStatement(sql1,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                 
        ps.setString(1,id);
        ps.setString(2,year);
        ps.executeQuery();
        ResultSet rs = ps.executeQuery();

        ps1.setString(1,id);
        ps1.setString(2,year);
        ps1.executeQuery();
        ResultSet rs1 = ps1.executeQuery();
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

        int[] income = new int[12];
        int janIn = 0;
        int febIn = 0;
        int marIn = 0;
        int aprIn = 0;
        int mayIn = 0;
        int junIn = 0;
        int julIn = 0;
        int augIn = 0;
        int sepIn = 0;
        int octIn = 0;
        int novIn = 0;
        int decIn = 0;
        //int[] array = {0,1,8,6};
        //array[1] = z;
        //array[3] = n;

        //for (int i=0;i<array.length;i++){
          //  out.println(array[i]);
        //}
            out.println("<tr><th colspan=\"2\">" + year +"</th></tr>");
            out.println("<tr><th>month</th><th>sum</th></tr>");
            out.println("<tr><td colspan=\"2\">支出部分</td></tr>");
            
            while (rs.next() ){
                out.println("<tr><td>"+rs.getObject("month")+"</td>");         
                out.println("<td>"+rs.getObject("sum")+"</td></tr>");      
                int m = rs.getInt("month");
                int s = rs.getInt("sum");
                array[m-1] = s;
              }
            out.println("<tr><td colspan=\"2\">-我是分隔線-</td></tr>");
            out.println("<tr><td colspan=\"2\">收入部分</td></tr>");
            while (rs1.next() ){
                out.println("<tr><td>"+rs1.getObject("month")+"</td>");         
                out.println("<td>"+rs1.getObject("sum")+"</td></tr>");      
                int x = rs1.getInt("month");
                int y = rs1.getInt("sum");
                income[x-1] = y;
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

        janIn = income[0];
        febIn = income[1];
        marIn = income[2];
        aprIn = income[3];
        mayIn = income[4];
        junIn = income[5];
        julIn = income[6];
        augIn = income[7];
        sepIn = income[8];
        octIn = income[9];
        novIn = income[10];
        decIn = income[11];
%>
<input type="hidden" name="jan" id="jan" value="<%=jan %>">
<input type="hidden" name="feb" id="feb" value="<%=feb %>">
<input type="hidden" name="mar" id="mar" value="<%=mar %>">
<input type="hidden" name="apr" id="apr" value="<%=apr %>">
<input type="hidden" name="may" id="may" value="<%=may %>">
<input type="hidden" name="jun" id="jun" value="<%=jun %>">
<input type="hidden" name="jul" id="jul" value="<%=jul %>">
<input type="hidden" name="aug" id="aug" value="<%=aug %>">
<input type="hidden" name="sep" id="sep" value="<%=sep %>">
<input type="hidden" name="oct" id="oct" value="<%=oct %>">
<input type="hidden" name="nov" id="nov" value="<%=nov %>">
<input type="hidden" name="dec" id="dec" value="<%=dec %>">

<input type="hidden" name="janIn" id="janIn" value="<%=janIn %>">
<input type="hidden" name="febIn" id="febIn" value="<%=febIn %>">
<input type="hidden" name="marIn" id="marIn" value="<%=marIn %>">
<input type="hidden" name="aprIn" id="aprIn" value="<%=aprIn %>">
<input type="hidden" name="mayIn" id="mayIn" value="<%=mayIn %>">
<input type="hidden" name="junIn" id="junIn" value="<%=junIn %>">
<input type="hidden" name="julIn" id="julIn" value="<%=julIn %>">
<input type="hidden" name="augIn" id="augIn" value="<%=augIn %>">
<input type="hidden" name="sepIn" id="sepIn" value="<%=sepIn %>">
<input type="hidden" name="octIn" id="octIn" value="<%=octIn %>">
<input type="hidden" name="novIn" id="novIn" value="<%=novIn %>">
<input type="hidden" name="decIn" id="decIn" value="<%=decIn %>">
<%
//out.println(janIn);
//out.println(febIn);
//out.println(marIn);
//out.println(aprIn);
            //for (int i=0;i<income.length;i++){
              //  out.println(income[i]);
            //}
              rs1.close();
              rs.close();
              ps1.close();
              ps.close();
              con.close();
          }catch(Exception e){
           // out.println("資料庫連結錯誤："+e.toString() );
          }      
         %>   
        </table>
         <div id="main" style="width: 80%;height:600px;display:inline-block"></div>   
        </div>
        <script src="../static/js/main.js"></script>
</body>
</html>