<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String ctx = request.getContextPath(); // /AgenteSaudeGPS
    response.sendRedirect(ctx + "/login/login.jsp");
%>
