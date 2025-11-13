<%-- 
    Document   : esqueci-senha
    Created on : 12 de nov. de 2025, 19:49:17
    Autores     : Filipe & Caio
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Recuperar Senha - GPS para Agentes</title>
    <style>
        body {
            background-color: #f5f6fa;
            font-family: Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            text-align: center;
            width: 350px;
        }
        h1 {
            font-size: 22px;
            margin-bottom: 10px;
        }
        p {
            color: #444;
            font-size: 14px;
            margin-bottom: 20px;
        }
        input[type="email"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }
        button {
            width: 100%;
            margin-top: 15px;
            background-color: #2563eb;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 6px;
            font-size: 15px;
            cursor: pointer;
        }
        button:hover {
            background-color: #1e4fd7;
        }
        a {
            display: inline-block;
            margin-top: 15px;
            color: #2563eb;
            text-decoration: none;
            font-size: 14px;
        }
        .mensagem-sucesso {
            color: green;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .mensagem-erro {
            color: red;
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Esqueci minha senha</h1>
        <p>Informe seu e-mail e enviaremos instruções para redefinir sua senha.</p>

        <!-- Exibe mensagens vindas do controller -->
        <%
            String msgSucesso = (String) request.getAttribute("mensagemSucesso");
            String msgErro = (String) request.getAttribute("mensagemErro");
        %>
        <% if (msgSucesso != null) { %>
            <div class="mensagem-sucesso"><%= msgSucesso %></div>
        <% } else if (msgErro != null) { %>
            <div class="mensagem-erro"><%= msgErro %></div>
        <% } %>

        <!-- Formulário -->
        <form action="<%= request.getContextPath() %>/RecuperarSenhaController" method="post">
            <input type="email" name="email" placeholder="Seu e-mail" required>
            <button type="submit">Enviar instruções</button>
        </form>

        <a href="<%= request.getContextPath() %>/login/login.jsp">Voltar para o Login</a>
    </div>
</body>
</html>
