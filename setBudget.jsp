<%-- 
    Document   : setBudget
    Created on : 16 Apr, 2019, 11:03:21 PM
    Author     : DELL
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="myP.Dao"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>setBudget</title>
    </head>
    <body>
        <%
            HttpSession s=request.getSession(false);
                            String name=(String)s.getAttribute("uname");
                            int i=(Integer)s.getAttribute("id");
                            
                           int amt=Integer.parseInt(request.getParameter("amt"));
                          // String d=request.getParameter("date");
                          String date = request.getParameter("date");
                           SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); // your template here
                            java.util.Date dateStr = formatter.parse(date);
                            java.sql.Date dateDB = new java.sql.Date(dateStr.getTime());

                          // out.println(name +" "+i+" "+amt+" "+dateDB );
                          
                     try {
                     
                         Class.forName("com.mysql.jdbc.Driver");
                            Connection c=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:8888/pra","root","2903"); 
                            //String q="insert into monthly values("+i+","+amt+",month("+dateDB)+"),year("+)+"));";
                            PreparedStatement ps=c.prepareStatement("select count(budget) from monthly where id=? and month=? and year=?");
                            PreparedStatement p ;
                             ps.setInt(1,i);
                             ps.setDate(2, dateDB);
                             ps.setDate(3,dateDB);
                             ResultSet rs = ps.executeQuery();
                             out.println("Before while ");
                             while(rs.next()){
                                 out.println("in while ");
                               PreparedStatement pd=c.prepareStatement("delete from monthly where id=? and month=month(?) and year=year(?)");
                                    pd.setInt(1,i);
                                    
                                    pd.setDate(2 ,dateDB);
                                    pd.setDate(3,dateDB);
                                    
                                    int ups=pd.executeUpdate();
                                    
                                    if(ups>0)
                                        out.println("deleted");
                                    else
                                        out.println("c=did not delete");

                             }
                             out.println(" Before inserting ");
                                p=c.prepareStatement("insert into monthly values(?,?,month(?),year(?))");
                             
                                p.setInt(1,i);
                                p.setInt(2,amt);
                                p.setDate(3, dateDB);
                                p.setDate(4,dateDB);


                                int t=p.executeUpdate();

                                if(t==1)
                                   response.sendRedirect("table.jsp");
                                   // out.println("updated");

                                else 
                                    out.println("failed");
                            
                         }
                     catch(Exception e){
                         out.print(e);
                             
                     }
        %>
    </body>
</html>
