<%-- 
    Document   : Home
    Created on : 12 de nov. de 2025, 08:40:53
    Author     : Caio & Filipe
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession sessao = request.getSession(false);
    if (sessao == null || sessao.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head><title>Home</title></head>
<body>
    <h2>Bem-vindo, <%= sessao.getAttribute("usuario") %>!</h2>
    <a href="logout.jsp">Sair</a>
</body>
</html>
