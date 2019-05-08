/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.mysql.jdbc.Connection;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import myP.*;

/**
 *
 * @author DELL
 */
public class Send1 extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String n=request.getParameter("user");
        String p=request.getParameter("pass");
        boolean ans=Dao.match(n, p);
        Dao d=new Dao();
        int i=d.getId(n);
        
        DateFormat nowYear = new SimpleDateFormat("yyyy");
     DateFormat nowMonth = new SimpleDateFormat("MM");
    Date date = new Date();
    //out.println(date);
    int  y=Integer.parseInt(nowYear.format(date));
    int  m=Integer.parseInt(nowMonth.format(date));
    int a=d.getBudget(i, m, y);
    int bal=Dao.getBalance(i, m, y);
    
        out.println("id="+i);
        if(ans==true){
        HttpSession s=request.getSession();
        s.setAttribute("uname",n);
        s.setAttribute("id", i);
        s.setAttribute("amt", a);
        s.setAttribute("balance",bal);
        request.getRequestDispatcher("table.jsp").forward(request, response);  
        
        }
        else
        out.println(ans);

        /*boolean status=false;
        try{
             Class.forName("com.mysql.jdbc.Driver");  
             Connection con=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:8888/pra","root","2903");  
             PreparedStatement ps=con.prepareStatement("select * from test1 where name=? and pass=?");
             ps.setString(1, n);
             ps.setString(2, p);
             
             ResultSet rs = ps.executeQuery();
                status=rs.next();
                
             if(status==true){
                String uname=rs.getString(1);
                out.println("login successful"+uname);
            }
            else  out.println("Invalid");
             
        }
        catch(Exception e){
            //e.printStackTrace();
            out.println("in catch "+e);
        }
              try { 
            Class.forName("com.mysql.jdbc.Driver");  
           Connection con=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:8888/pra","root","2903");  
           
            String query = "select * from test1";
           Statement st=con.createStatement();
           ResultSet rs = st.executeQuery(query);
           
           while(rs.next()){
               if(rs.getString(1).equals(n))
               out.println(rs.getString(2));
           }
           
           PreparedStatement ps=con.prepareStatement("insert into test1 values(?,?)");
           ps.setString(1, n);
           ps.setString(2, p);
           
           int i= ps.executeUpdate();
           
           if(i>0)  
            out.print("You are successfully registered...");  
            // TODO output your page here. You may use following sample code. 
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Send1</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Send1 at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            
            
            
        }
       catch(Exception e){
            e.printStackTrace();
       }*/
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
