<%-- 
    Document   : index
    Created on : 22 de nov. de 2021, 19:34:25
    Author     : andriw
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Tasks.Tasks"%>
<%@page import="Listener.DBListener"%>

<%@include file='WEB-INF/jspf/header.jspf'%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <%
        Exception requestException =null;
        ArrayList<String> taskList = new ArrayList<>();
        
        try {
                if (request.getParameter("add")!=null) {
                        String rt = request.getParameter("task_name");
                        Tasks.addTask(rt);
                        response.sendRedirect(request.getResquestURI()); 
                    }
                if (request.getParameter("del")!=null) {
                        String rt = request.getParameter("task_name");
                        Tasks.removeTask(rt);
                        response.sendRedirect(request.getResquestURI()); 
                    }
                
                taskList = Tasks.getTasks();
            } catch (Exception e) {
                
                requestException = ex;
            }
    %>
    
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Index</title>
    </head>
    <body>
        <% if (user!=null) { %>
           
        <% if (DBListener.exception!=null) { %>
        <div style="color:red">        
            Erro na criação do Banco:
            <%=DBListener.exception.getMessage()%>            
        </div>
        <%}%>
        
        <%if(requestException=!null) { %>
        <div>
            Erro na leitura ou gravação das Tasks
            <%requestException.getMessage()%>
        </div>
        <%}%>
        
        <form action="action">
            
            <input type="text" name="task_name">
            <input  type="submit" name="add" value="+">
            
        </form>
        
        <<table>
            <%for (String rt:taskList) { %>
            <tr>
                <td><%= rt%></td>
                <td>
                    <<form action="action">
                        <input type="hidden" name="flavio" value="<%=rt%>">
                        <input  type="submit" name="remove" value="-">
                    </form>
                </td>
            </tr>
            <%}%>
        </table>
        <%}else{%>
        <p>Por favor, fazer login!</p>
    </body>
</html>
