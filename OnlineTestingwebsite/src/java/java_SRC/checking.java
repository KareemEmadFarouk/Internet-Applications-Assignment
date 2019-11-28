/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package java_SRC;

import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import static org.apache.coyote.http11.Constants.a;

/**
 *
 * @author Kareem E.Farouk
 */
public class checking extends HttpServlet {

    private int executeUpdate;

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
        try (PrintWriter out = response.getWriter()) {
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Storing in Database...</title>");            
            out.println("</head>");
            int sid; /* Student ID */
            HttpSession se = request.getSession();  //* Start a session object for that student ... *//
            sid = (int) se.getAttribute("id");
              int qid; /* Question ID */
            qid = (int) se.getAttribute("a1");
              int aid = -1;
              String [] aids = request.getParameterValues("cb");
              for (int i = 0; i < aids.length; i++) {
                     if(aids[i].equals("1"))
                     {
                         if(i==0)
                             aid = (int)se.getAttribute("a1"); /* Selected Answer */
                         else if(i==1)
                             aid = (int)se.getAttribute("a2");
                         else if(i==2)
                             aid = (int)se.getAttribute("a3");
                     }
              }/*                                    ('200', '300', '400');   */
            try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(checking.class.getName()).log(Level.SEVERE, null, ex);
            }
              Connection conn = null;
            try {
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_tests_database", "root", "sesame");
            } catch (SQLException ex) {
                Logger.getLogger(checking.class.getName()).log(Level.SEVERE, null, ex);
            }
              Statement stat = null;
            try {
                stat = conn.createStatement();
            } catch (SQLException ex) {
                Logger.getLogger(checking.class.getName()).log(Level.SEVERE, null, ex);
            }
              String sql = "Insert Into studentanswers" + " Values ( "+"\""+ sid + "\"," + "\"" + qid + "\"," + "\"" + aid +"\");";
            try {
                //sql = sql.toString();
                stat.executeUpdate(sql);
            } catch (SQLException ex) {
                Logger.getLogger(checking.class.getName()).log(Level.SEVERE, null, ex);
            }
            out.print("you have submitted your exam successfully ... Thanks!");
            out.println("<a href=\"student.jsp\"> student page </a>");
        }
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
