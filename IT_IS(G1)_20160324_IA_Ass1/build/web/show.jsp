<%-- 
    Document   : show
    Created on : Oct 11, 2019, 11:43:11 PM
    Author     : Kareem E.Farouk
--%>


<html>
    <head>
        <title>Assignment #1</title>
    </head>
    <body>
        <h2>Thanks for using Assignment #1<h2>                    
                <table border='1' size="100" cellpadding='10' cellspacing='1'>       
        <%
           int criticalNo = Integer.parseInt(request.getParameter("critical#")); 
           if (criticalNo<=0) {
                   out.println("Error!");
                   out.println("</html");
               }
           int countNO = 1;
           boolean key = false;
           for(int rows=1; rows<=(2*criticalNo)-1; rows++){
        %>
            <tr>
        <%
               for(int cols=1; cols<=criticalNo; cols++){           
                  if(!(key)){   /* The 1st Half */
                      if((cols<=countNO)){
        %>              
                         <td width='200' align='center' style="background-color: blue;"> * </td>
        <%
                      }
                      else{
        %>                  
                          <td width='200'></td> 
        <%   
                      } 
                   }
                   else{     /* The 2nd Half */
                      if((cols<=countNO)){
        %>
                         <td width='200' align='center' style="background-color: blue;"> * </td>
                                
        <%
                      }
                      else{
        %>
                         <td width='200'></td>
        <%            }
                   }
              }
            
            if(criticalNo<=countNO){ /* The Critical Position */
               countNO--;
               key = true;
            }
            else{
                if(key==true)  /* Because we entered the 2nd half at this stage 
                                  so, we want to be sure that the counter will not re-increase again...
                               */
                   countNO--;
                else{
                   countNO++;
                   key = false;
                } 
           }
        %>
            </tr>
         
         <%
             }
         %>
        </table>
        <p>
            <a href = "index.html"> 
                <input type="submit" value="Back" style="width: 150px; height: 30px;" > 
            </a>
        </p>
        
        
    </body>
</html>
