<%-- 
    Document   : student
    Created on : Nov 13, 2019, 8:27:19 PM
    Author     : Kareem E.Farouk
--%>

<%@page import="java.sql.*"%>
<html>
    <head>
        <%
           int sid = (int) session.getAttribute("id");
        %>
        <title>Student <% out.print(sid + " ");%> Main Page</title>
    </head>
    <body>
        <%
            boolean flag = false;
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_tests_database", "root", "sesame");
            Statement stat = conn.createStatement();
            ResultSet res = stat.executeQuery("SELECT * FROM studentanswers");
                while(res.next()){ 
                    if((sid==(res.getInt(1)))){ //* It means that this student Exists *//
                        flag = true;
                        break;
                    }
                }
                if(flag == true){  //* It means that this student in fact does't Exist ..*//
                   out.print("Actually, You Have Taken Your Exam !");
                   out.print("\n\n\n");
        %>
                   <form  action="exam.jsp" method="POST"><br><br>
                       <input  type="submit" disabled="true" value="Start Exam"/>    
                   </form>    
        <%
                }
                else{
        %>
        <p><em><b> You Can Start Your Exam Now: </b></em></p><br>
        <form action="exam.jsp" method="POST"><br>
              <input type="submit" value="Start Exam"/>    
        </form>
        <%
            }
        %>        
    </body>
</html>
