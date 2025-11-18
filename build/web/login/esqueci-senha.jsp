<%-- 
    Document   : esqueci-senha
    Created on : 12 de nov. de 2025
    Autores    : Filipe & Caio
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Recuperar Senha - GPS para Agentes</title>

    <style>
        :root {
            --bg: #0d0d0d;
            --text: #f1f1f1;
            --card: #151515;
            --accent: #4caf50;
            --highlight: #2e7dff;
        }

        body.light {
            --bg: #ffffff;
            --text: #111111;
            --card: #f3f3f3;
            --accent: #2e7dff;
            --highlight: #4caf50;
        }

        body {
            background-color: var(--bg);
            color: var(--text);
            font-family: Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            transition: background-color .4s ease, color .4s ease;
        }

        .theme-toggle {
            position: absolute;
            top: 15px;
            right: 15px;
            background: transparent;
            border: none;
            font-size: 26px;
            color: var(--text);
            cursor: pointer;
            transition: .3s;
        }

        .theme-toggle:hover {
            transform: scale(1.14);
        }

        .container {
            background: var(--card);
            padding: 40px;
            width: 350px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,.3);
            text-align: center;
            transition: background .4s ease;
            animation: fadeIn .5s ease;
        }

        @keyframes fadeIn {
            from { opacity:0; transform: translateY(12px); }
            to   { opacity:1; transform: translateY(0); }
        }

        h1 {
            margin-bottom: 10px;
        }

        p {
            margin-bottom: 20px;
            font-size: 14px;
            color: var(--text);
        }

        input[type="email"] {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #444;
            background: #222;
            color: #fff;
            margin-top: 8px;
            font-size: 14px;
        }

        body.light input {
            background: #fff;
            color: #000;
            border: 1px solid #ccc;
        }

        button {
            width: 100%;
            margin-top: 15px;
            background: var(--highlight);
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            cursor: pointer;
            transition: .2s;
        }

        button:hover {
            transform: translateY(-2px);
            opacity: .92;
        }

        a {
            margin-top: 16px;
            display: inline-block;
            color: var(--accent);
            font-size: 14px;
            text-decoration: none;
        }

        .mensagem-sucesso {
            color: #4caf50;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .mensagem-erro {
            color: #ff4b4b;
            margin-bottom: 10px;
            font-weight: bold;
        }
    </style>
</head>

<body>

<!-- Botão tema -->
<button class="theme-toggle" id="themeIcon" onclick="toggleTheme()">🌙</button>

<div class="container">

    <h1>Esqueci minha senha</h1>
    <p>Informe seu e-mail e enviaremos instruções para redefinir sua senha.</p>

    <% 
        String msgSucesso = (String) request.getAttribute("mensagemSucesso");
        String msgErro = (String) request.getAttribute("mensagemErro");
    %>

    <% if (msgSucesso != null) { %>
        <div class="mensagem-sucesso"><%= msgSucesso %></div>
    <% } else if (msgErro != null) { %>
        <div class="mensagem-erro"><%= msgErro %></div>
    <% } %>

    <form action="<%= ctx %>/RecuperarSenhaController" method="post">
        <input type="email" name="email" placeholder="Seu e-mail" required>
        <button type="submit">Enviar instruções</button>
    </form>

    <a href="<%= ctx %>/login/login.jsp">Voltar para o Login</a>
</div>
<script>
    const icone = document.getElementById("themeIcon");

    function toggleTheme() {
        document.body.classList.toggle("light");

        const tema = document.body.classList.contains("light") ? "light" : "dark";
        localStorage.setItem("theme", tema);

        icone.textContent = tema === "light" ? "🌞" : "🌙";
    }

    function aplicarTemaSalvo() {
        const salvo = localStorage.getItem("theme");
        if (salvo === "light") {
            document.body.classList.add("light");
            icone.textContent = "🌞";
        } else {
            document.body.classList.remove("light");
            icone.textContent = "🌙";
        }
    }

    aplicarTemaSalvo();
</script>

</body>
</html>
