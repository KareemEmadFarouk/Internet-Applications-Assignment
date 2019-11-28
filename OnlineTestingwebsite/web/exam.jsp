<%-- 
    Document   : exam
    Created on : Nov 13, 2019, 8:27:32 PM
    Author     : Kareem E.Farouk
--%>
<%@page import="java.sql.*"%>
<html>
    <head>
        <%
           int sid = (int) session.getAttribute("id");
        %>
        <title>Exam_Student <% out.print(sid + " ");%>*</title>
    </head>
    
    <body>
        <%
                String qText = "";
                String aText = "";
                String aText2 = "";
                String aText3 = "";
                double randomDouble = Math.random();
	        randomDouble = randomDouble * 10 + 1; /// a random question id within a range between 1 - 10
	        int randomInt = (int) randomDouble;
                int randomInt2 = randomInt++;
                int randomInt3 = randomInt--;
                if(randomInt2<=0)
                    randomInt2=1;
                else if(randomInt2>10)
                    randomInt2=10;
                if(randomInt3<=0)
                    randomInt2=1;
                else if(randomInt3>10)
                    randomInt2=10;
                session.setAttribute("a1", randomInt);
                session.setAttribute("a2", randomInt2);
                session.setAttribute("a3", randomInt3);
                boolean flag = false;
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/online_tests_database", "root", "sesame");
                Statement stat1 = conn.createStatement();
                Statement stat2 = conn.createStatement();
                ResultSet res1 = stat1.executeQuery("SELECT * FROM question");
                ResultSet res2 = stat2.executeQuery("SELECT * FROM answers");
                while(res1.next()){ 
                    if((randomInt==(res1.getInt(1)))){
                        qText = res1.getString(2);
                        flag = true;
                        break;
                    }
                }
                if(flag == false){
                   out.print("Invalid Question ID");
                }
                while(res2.next()){ 
                    if((randomInt==(res2.getInt(4)))){ /* The correct answer... */ 
                        aText = res2.getString(2);
                        flag = true;
                    }
                    if((randomInt2==(res2.getInt(4)))){  /* The other incorrect answer... */
                        aText2 = res2.getString(2);
                        flag = true;
                    }
                    if((randomInt3==(res2.getInt(4)))){  /* The incorrect answer... */
                        aText3 = res2.getString(2);
                        flag = true;
                    }
                }
                if(flag == false){  //* It means that this student in fact does't Exist ..*//
                   out.print("Invalid Answer ID");
                }
        %>
        <h2> Select the correct Answer For the following question:- </h2><br>
        <form action="checking" method="POST">
        <table>
            <tr><td><% out.print(qText);%></td>
                <td>
                    <input type="checkbox" name="cb" value="1" onclick="onlyOne(this)">
                        <% out.print(aText + "   ");%>
                        <input type="checkbox" name="cb" value="2" onclick="onlyOne(this)">
                        <% out.print(aText2 + "    ");%>
                        <input type="checkbox" name="cb" value="3" onclick="onlyOne(this)">
                    <% out.print(aText3 + " \t\t\t ");%>
                        <input type="submit" value="Submit your Ansewr" />
                </td>
            </tr>
        </table>
        </form>
        <script type="text/javascript">
              function onlyOne(cbItem) //* The first selected checkbox*//
              {
                  var checkboxes = document.getElementsByName('cb');
                  var i;
                  for(i=0; i<checkboxes.length; i++){
                      if(checkboxes[i].value !== cbItem.value){
                          checkboxes[i].checked = false;
                          checkboxes[i].value = "0";
                      } 
                      else
                          checkboxes[i].value = "1";
                  }
              }
        </script>
    </body>
</html>
