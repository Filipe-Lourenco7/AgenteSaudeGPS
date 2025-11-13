<%-- 
    Document   : Login
    Created on : 12 de nov. de 2025, 08:31:38
    Author     : Filipe & Caio
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <base href="${pageContext.request.contextPath}/login/">
    <title>GPS para Agentes - Login</title>
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
            width: 350px;
            text-align: center;
        }
        img {
            width: 60px;
            margin-bottom: 15px;
        }
        h1 {
            font-size: 22px;
            margin-bottom: 10px;
        }
        p {
            margin-bottom: 20px;
            color: #444;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
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
        .links {
            margin-top: 15px;
        }
        a {
            color: #2563eb;
            text-decoration: none;
            font-size: 14px;
        }
        footer {
            margin-top: 20px;
            font-size: 12px;
            color: #888;
        }
        .erro {
            color: red;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .captcha-area {
            margin-top: 10px;
        }
        .captcha-area img {
            width: 150px;
            height: 50px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        .refresh-btn {
            background-color: #e5e7eb;
            color: #333;
            border: none;
            margin-top: 5px;
            padding: 5px 10px;
            border-radius: 6px;
            font-size: 12px;
            cursor: pointer;
        }
        .refresh-btn:hover {
            background-color: #d1d5db;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>GPS para Agentes</h1>
        <img src="https://cdn-icons-png.flaticon.com/512/684/684908.png" alt="Logo">
        <p>Por favor, faça login para continuar</p>

        <!-- Exibir mensagem de erro (captcha ou login) -->
        <%
            String erro = (String) request.getAttribute("erro");
            if (erro != null) {
        %>
            <div class="erro"><%= erro %></div>
        <% } %>

        <!-- Formulário de Login -->
        <form action="<%=request.getContextPath()%>/LoginController" method="post">
            <input type="text" name="email" placeholder="Endereço de e-mail" required><br>
            <input type="password" name="senha" placeholder="Senha" required><br>

            <!-- Captcha -->
            <div class="captcha-area">
                <img id="captcha-img" src="${pageContext.request.contextPath}/captcha" alt="Captcha"><br>
                <button type="button" class="refresh-btn" onclick="atualizarCaptcha()">🔄 Atualizar Captcha</button>
            </div>

            <input type="text" name="captcha_input" placeholder="Digite o código acima" required><br>
            
            <!<!--Botão Lembrar de mim-->
            <label style="display: flex; align-items: center; gap: 5px; font-size: 14px; margin-top: 10px;">
                <input type="checkbox" name="lembrar" value="true">
                Lembrar de mim
            </label>

            <button type="submit">Entrar</button>
        </form>

        <div class="links">
            <a href="<%= request.getContextPath() %>/login/esqueci-senha.jsp" class="link-esqueci">Esqueci minha senha</a>
            <span class="divisor">•</span>
            <a href="<%= request.getContextPath() %>/login/cadastro.jsp" class="link-cadastrar">Cadastrar</a>
        </div>

        <footer>© 2025 - Code Hunt</footer>
    </div>

    <!-- Script para recarregar captcha -->
    <script>
        function atualizarCaptcha() {
            const img = document.getElementById('captcha-img');
            img.src = '${pageContext.request.contextPath}/captcha?ts=' + new Date().getTime();
        }
    </script>
</body>
</html>
