<%-- 
    Document   : cadastro
    Created on : 12 de nov. de 2025, 09:12:05
    Author     : Filipe & Caio
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Criar conta - GPS para Agentes</title>
    <style>
        body {
            background-color: #f5f6fa;
            font-family: 'Roboto', Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            width: 400px;
            padding: 40px;
            text-align: center;
        }
        .logo {
            width: 48px;
            margin-bottom: 15px;
        }
        h1 {
            font-size: 22px;
            margin-bottom: 10px;
            color: #202124;
        }
        p {
            font-size: 14px;
            color: #5f6368;
            margin-bottom: 25px;
        }
        input[type="text"], input[type="email"], input[type="password"], input[type="number"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 12px;
            border: 1px solid #dadce0;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
        }
        input:focus {
            border-color: #1a73e8;
            box-shadow: 0 0 0 1px #1a73e8;
        }
        button {
            width: 100%;
            background-color: #1a73e8;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 6px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
        }
        button:hover {
            background-color: #155ec9;
        }
        .link {
            margin-top: 15px;
        }
        a {
            color: #1a73e8;
            text-decoration: none;
            font-size: 14px;
        }
        a:hover {
            text-decoration: underline;
        }
        footer {
            margin-top: 20px;
            font-size: 12px;
            color: #888;
        }
    </style>
</head>
<body>
    <div class="card">
        <img src="https://cdn-icons-png.flaticon.com/512/684/684908.png" alt="Logo" class="logo">
        <h1>Criar conta</h1>
        <p>Preencha os campos abaixo para se cadastrar no GPS para Agentes</p>

        <!-- 🔹 Envia para o servlet (futuramente CadastroController) -->
        <form action="<%= request.getContextPath() %>/CadastroController" method="post">
            <input type="text" name="name" placeholder="Nome completo" required>
            <input type="email" name="email" placeholder="E-mail" required>
            <input type="number" name="cep" placeholder="CEP" required>
            <input type="password" name="senha" placeholder="Senha" required>
            <button type="submit">Cadastrar</button>
        </form>

        <div class="link">
            <a href="login.jsp">Já tem uma conta? Faça login</a>
        </div>

        <footer>© 2025 - Code Hunt</footer>
    </div>
</body>
</html>
