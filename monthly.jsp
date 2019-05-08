<%-- 
    Document   : monthly
    Created on : 19 Apr, 2019, 10:54:53 PM
    Author     : DELL
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="myP.Dao"%>
<%
    HttpSession s=request.getSession(false);
                            String name=(String)s.getAttribute("uname");
                            Dao d=new Dao();
                            int i=d.getId(name);
                            
                            String dt=request.getParameter("month");
                            
                            SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
                            int y=Integer.parseInt(dt.substring(0, 4));
                            int m=Integer.parseInt(dt.substring(5, 7));
                            java.util.Date dateStr = formatter.parse(dt);
                            java.sql.Date dateDB = new java.sql.Date(dateStr.getTime());
                            
                            out.println("id: "+i+" date: "+m +" year: "+y);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./ncss.css"/>
        <title>Monthly Transactions</title>
    </head>
    <body>
        <div>
             <button id="myBtn2" class="btnModal">Monthly Transactions</button>

        <!-- The Modal -->
        <div id="myModal2" class="modal">

          <!-- Modal content -->
          <div class="modal-content">
            <span class="close">&times;</span>
            <form action="monthly.jsp" method="post"> 
                Select month: <input type="month" name="month">
                <input type="submit" value="Show">
                 
            </form>
          </div>

        </div>     
            
        </div>
        <hr>
      <%
          
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection c=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:8888/pra","root","2903"); 
                PreparedStatement ps=c.prepareStatement("select item,amount,date from tr where uid=?"
                                                         + " and month(date)=? and year(date)=? order by t_id desc;");
                ps.setInt(1, i);
                ps.setInt(2, m);
                ps.setInt(3, y);
                ResultSet rs = ps.executeQuery();
       
      
      %>
      
       <TABLE >
            <TR>
                <TH>Item</TH>
                <TH>Amount</TH>
                <TH>Date</TH>
                
            </TR>
        <% 
        while(rs.next()){
        %>
        <tr>
            <td><%= rs.getString("item") %></td>
            <td><%= rs.getInt("amount") %></td>
            <td><%= rs.getDate("date") %></td>
            
            
        </tr>
        
        <%  } %>
        </TABLE>
        
         <% 
                }
            catch(Exception e){
        %>  <h3> <% e.printStackTrace(); %></h3>
        <%
                }
        %>
        <script>
            var modal2 = document.getElementById("myModal2");
            var btn2 = document.getElementById("myBtn2");
            var span2 = document.getElementsByClassName("close")[0];
            
            btn2.onclick = function() {
          modal2.style.display = "block";
        }
        
        span2.onclick = function() {
          modal2.style.display = "none";
        }
        
         window.onclick = function(event) {
          
          if (event.target == modal1) {
            modal2.style.display = "none";
          }
          
            
        </script>
    </body>
    
</html>
