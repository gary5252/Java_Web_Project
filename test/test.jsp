<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
  
    <%@ page contentType="text/html;charset=utf-8" 
    import="java.sql.*, java.text.SimpleDateFormat" %>
</head>
<body>
    獲取 INPUT 日期，然後轉字串陣列
    <form action="" method="get">
        <input type="date" name="test" id="test">
        <input type="number" id="amount" name="amount"/>
        <button type="submit">yes</button>
    </form>
    <%
    try{
    String[] date = request.getParameter("test").split("-");
    for (int i = 0; i < date.length; i++){
    out.println(date[i] + "<br>");
    }
    String year = date[1];
    out.println(year);
}catch(Exception e){
    out.println(e.toString());
}
    int x = 0;
    try{
    x = Integer.parseInt((request.getParameter("amount")).trim());
}catch(Exception e){
    //out.println(e.toString());
  }
    out.println(x);
    out.println("test");
    %>
    <p>
    整數編譯問題 > request.getParameter() 設在同一網頁會開不起來報錯是因為還沒
	submit 前那個欄位是空值 NULL ，NULL沒辦法轉換整數型態所以才一直報錯
	解決方法 : 要馬將 request 設在另一網頁透過 submit 攜值前往 不然就是
		   使用 try catch 先在一開始 NULL 問題時能先成功編譯再透過
		   submit 賦值讓他格式轉換成功
        </p>
        <textarea name="" id="" cols="30" rows="10"></textarea>
</body>
</html>