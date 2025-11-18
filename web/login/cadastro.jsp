<%-- 
    Document   : cadastro
    Created on : 12 de nov. de 2025
    Author     : Filipe & Caio
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Criar conta - GPS para Agentes</title>

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
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
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

        .card {
            background: var(--card);
            padding: 40px;
            width: 400px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0,0,0,.3);
            transition: background .4s ease;
            animation: fadeIn .5s ease;
        }

        @keyframes fadeIn {
            from { opacity:0; transform: translateY(12px); }
            to   { opacity:1; transform: translateY(0); }
        }

        .logo {
            width: 70px;
            margin-bottom: 15px;
        }

        h1 {
            margin-bottom: 10px;
        }

        p {
            margin-bottom: 25px;
            font-size: 14px;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="number"] {
            width: 100%;
            padding: 12px;
            border-radius: 6px;
            border: 1px solid #444;
            margin-bottom: 14px;
            background: #222;
            color: #fff;
            font-size: 14px;
        }

        body.light input {
            background: #fff;
            color: #000;
            border: 1px solid #ccc;
        }

        button {
            width: 100%;
            background: var(--highlight);
            border: none;
            color: #fff;
            padding: 12px;
            border-radius: 6px;
            font-size: 15px;
            cursor: pointer;
            transition: .2s;
        }

        button:hover {
            transform: translateY(-2px);
            opacity: .9;
        }

        a {
            display: inline-block;
            margin-top: 15px;
            color: var(--accent);
            text-decoration: none;
            font-size: 14px;
        }

        a:hover { text-decoration: underline; }

        footer {
            margin-top: 20px;
            font-size: 12px;
            color: #aaa;
        }
    </style>
</head>

<body>

<!-- Botão tema -->
<button id="themeIcon" class="theme-toggle" onclick="toggleTheme()">🌙</button>

<div class="card">
    <img id="logo" class="logo" src="../imagem/Logo GPS preta.png" alt="Logo">

    <h1>Criar conta</h1>
    <p>Preencha os campos abaixo para se cadastrar no GPS para Agentes</p>

    <form action="<%= ctx %>/CadastroController" method="post">
        <input type="text" name="name" placeholder="Nome completo" required>
        <input type="email" name="email" placeholder="E-mail" required>
        <input type="number" name="cep" placeholder="CEP" required>
        <input type="password" name="senha" placeholder="Senha" required>
        <button type="submit">Cadastrar</button>
    </form>

    <a href="login.jsp">Já tem uma conta? Faça login</a>

    <footer>© 2025 - Code Hunt</footer>
</div>

<script>
    function toggleTheme() {
        document.body.classList.toggle("light");
        const tema = document.body.classList.contains("light") ? "light" : "dark";
        localStorage.setItem("theme", tema);
        updateLogo();
        updateIcon();
    }

    function updateLogo() {
        const logo = document.getElementById("logo");
        if (document.body.classList.contains("light")) {
            logo.src = "../imagem/Logo_GPS.png";    // tema claro
        } else {
            logo.src = "../imagem/Logo GPS preta.png"; // tema escuro
        }
    }

    function updateIcon() {
        const icone = document.getElementById("themeIcon");
        icone.textContent = document.body.classList.contains("light") ? "🌞" : "🌙";
    }

    (function() {
        const tema = localStorage.getItem("theme");
        if (tema === "light") {
            document.body.classList.add("light");
        }
        updateLogo();
        updateIcon();
    })();
</script>

</body>
</html>
