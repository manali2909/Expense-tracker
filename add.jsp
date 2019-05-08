<%-- 
    Document   : add
    Created on : 5 Apr, 2019, 5:37:26 PM
    Author     : DELL
--%>

<%@page import="java.text.SimpleDateFormat"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="myP.Dao"%>
<!DOCTYPE html>
<%
                            HttpSession s=request.getSession(false);
                            //String name=(String)s.getAttribute("uname");
                            int i=(Integer)s.getAttribute("id");
                            
//getting attirbutes from the form
            int amount=Integer.parseInt(request.getParameter("amt"));
            String item=request.getParameter("item");
            String date=request.getParameter("date");
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); // to fromat the date
                            java.util.Date dateStr = formatter.parse(date);
                            java.sql.Date dateDB = new java.sql.Date(dateStr.getTime());
            
            
                            
                            //out.println("id= "+i+" amount: "+amount+" item: "+item+" date="+date);
                           // out.println("dateStr: "+dateStr+" dateDB: "+dateDB);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection c=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:8888/pra","root","2903"); 
               // String q="insert into tr uid,amount,item,date values(?,?,?,?)";
                
                PreparedStatement p=c.prepareStatement("insert into tr(uid,amount,item,date)  values(?,?,?,?)");
                p.setInt(1, i);
                p.setInt(2, amount);
                p.setString(3,item);
                p.setDate(4, dateDB);
                
                int var=p.executeUpdate();
                out.print(i);
                
                if(var==1){
                     response.sendRedirect("table.jsp");
                     
                }
            }
            catch(Exception e){
                e.printStackTrace();
            }
        %>
        
     
    </body>
    
</html>

