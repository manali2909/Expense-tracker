<%-- 
    Document   : table
    Created on : 31 Mar, 2019, 8:29:34 PM
    Author     : DELL
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="myP.Dao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% 
    response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");

//Forces caches to obtain a new copy of the page from the origin server
//response.setHeader("Cache-Control", "no-store");

//Directs caches not to store the page under any circumstance
//response.setDateHeader("Expires", 0);

//Causes the proxy cache to see the page as "stale"
//response.setHeader("Pragma", "no-cache");
//HTTP 1.0 backward enter code here
    
   // out.println("month = "+dateStr2);
    DateFormat nowYear = new SimpleDateFormat("yyyy");
     DateFormat nowMonth = new SimpleDateFormat("MM");
    Date date = new Date();
    //out.println(date);
    int  y=Integer.parseInt(nowYear.format(date));
    int  m=Integer.parseInt(nowMonth.format(date));
    Dao d1=new Dao();
    HttpSession s=request.getSession(false);
                            String name=(String)s.getAttribute("uname");
                            int i=d1.getId(name);
                            int bud=d1.getBudget(i,m,y);
                            
                            
                           // out.println("month = " +m+" year = "+y+" for"+i);
                         if(name!=null){
                        out.println(s.getAttribute("balance"));
                         
                        
                       out.println( "From dao d1: "+d1.getId(name));
                       out.println("Static "+Dao.getBalance(i, m, y));
                        
                    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <link rel="stylesheet" href="./ncss.css"/>
        <title>Transactions</title>
        
    </head>
    <body>
        
        <header>
            <div id="top">
                <h1 id="logo">Expense Management </h1>
                <h1> hello<%out.println(" "+name);%>
                    <form action="Logout" method="post"> 
                        <input type="submit" value="logout">
                    </form>   
                </h1>
            </div>
        </header>
           
                    <h1> Budget for this month is: <%
                                                    out.println(bud);
                                                    
                                                    %>
                         <br>
                         Balance left:<% out.println(" "+d1.getBalance(i,m,y));%>
                    </h1>
                    <progress value="<% out.print(bud-d1.getBalance(i,m,y));%>" max="<% out.print(d1.getBudget(i,m,y));%>"></progress><br><br>
                    
                    <progress value="<%out.println(bud);%>" max="5000"></progress><br><br>
    <button id="myBtn1" class="btnModal">Set Budget</button>

        <!-- The Modal -->
        <div id="myModal1" class="modal">

          <!-- Modal content -->
          <div class="modal-content">
            <span class="close">&times;</span>
            <form action="setBudget.jsp" method="post"> 
                <input type="text" name="amt" placeholder="Enter Amount"/><br><br>
                select month :<input type="date" name="date">
                 <input type="submit" value="Add"/>
            </form>
          </div>

        </div>     
       
 
        <div id="main">
            
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
            
             <a href="monthly.jsp"><h3>View monthly transactions</h3></a>
             
            <div id="left" class="parts"> 
                <p> ndigo is a deep and rich color close to the color wheel blue (a primary color 
                    in the RGB color space), as well as to some variants of ultramarine. It is traditionally regarded as a color
                    in the visible spectrum, as well as one of the seven colors of the rainbow: the color between 
                    violet and blue; however, sources differ as to its actual position in the electromagnetic spectrum. <p>  
            </div> 
        
     
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
        <div id="tab" class="parts">
               <h1>Transaction List</h1>
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
        <button id="myBtn">Add new Expense</button>

        <!-- The Modal -->
        <div id="myModal" class="modal">

          <!-- Modal content -->
          <div class="modal-content">
            <span class="close">&times;</span>
            <form action="add.jsp" method="post"> 
                <input type="text" name="amt" placeholder="Enter Amount" required/>
                <br><br>
                <input type="text" name="item" placeholder="spent on??" required/>
                <br><br>
                Date: <input type="date" id="d" name="date" required/><br><br>
                
                 <input type="submit" value="Add"/>
            </form>
          </div>

        </div>
        
            <% 
                }
            catch(Exception e){
        %>  <h3> <% e.printStackTrace(); %></h3>
        <%
                }
        %>
        
         
        </div>
      
        </div>
        
        <script> 
    // Get the modal
        var modal = document.getElementById("myModal");
        var modal1 = document.getElementById("myModal1");
        var modal2 = document.getElementById("myModal2");
        

        // Get the button that opens the modal
        var btn = document.getElementById("myBtn");
        var btn1 = document.getElementById("myBtn1");
        var btn2 = document.getElementById("myBtn2");
        

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[1];
        var span1 = document.getElementsByClassName("close")[0];
        var span2 = document.getElementsByClassName("close")[2];


        // When the user clicks the button, open the modal 
        btn.onclick = function() {
          modal.style.display = "block";
        }
        btn1.onclick = function() {
          modal1.style.display = "block";
        }
        btn2.onclick = function() {
          modal2.style.display = "block";
        }
        // When the user clicks on <span> (x), close the modal
        span.onclick = function() {
          modal.style.display = "none";
        }
        
        span1.onclick = function() {
          modal1.style.display = "none";
        }
        span2.onclick = function() {
          modal2.style.display = "none";
        }
        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
          if (event.target == modal) {
            modal.style.display = "none";
            getDate();
            
          }
          if (event.target == modal1) {
            modal1.style.display = "none";
          }
          if (event.target == modal1) {
            modal2.style.display = "none";
          }
          
        }   
        
    function getDate(){
            var d=new date();
            document.getElementById("d").value=d;
        }
       
</script>
    </body>
</html>
<% 
        }
        else
             response.sendRedirect("index.html");
%>

