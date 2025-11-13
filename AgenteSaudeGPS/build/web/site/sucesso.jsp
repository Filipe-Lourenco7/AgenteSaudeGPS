<%-- 
    Document   : sucesso
    Created on : 12 de nov. de 2025, 11:31:02
    Autores     : Caio & Filipe
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Cadastro Concluído - GPS para Agentes</title>
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
            width: 400px;
        }
        .icon {
            font-size: 70px;
            color: #22c55e;
        }
        h1 {
            color: #222;
            font-size: 24px;
            margin-bottom: 10px;
        }
        p {
            color: #444;
            font-size: 15px;
            margin-bottom: 25px;
        }
        a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #2563eb;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
        }
        a:hover {
            background-color: #1e4fd7;
        }
        footer {
            margin-top: 30px;
            font-size: 12px;
            color: #888;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon">✅</div>
        <h1>Cadastro realizado com sucesso!</h1>
        <p>Seu cadastro foi concluído. Agora você já pode fazer login no sistema.</p>
        <a href="<%= request.getContextPath() %>/login/login.jsp">Ir para o Login</a>

        <footer>© 2025 - Code Hunt Technology</footer>
    </div>
</body>
</html>
