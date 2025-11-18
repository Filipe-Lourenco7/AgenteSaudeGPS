<%-- 
    Document   : Login
    Created on : 12 de nov. de 2025
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
        /* ===========================
           VARIÁVEIS DO TEMA (IGUAL AO OUTRO JSP)
        ============================ */
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
            --card: #f2f2f2;
            --accent: #2e7dff;
            --highlight: #4caf50;
        }

        /* ===========================
           ESTILO GLOBAL
        ============================ */
        body {
            background-color: var(--bg);
            color: var(--text);
            font-family: Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            transition: background .4s ease, color .4s ease;
        }

        .container {
            background: var(--card);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,.3);
            width: 350px;
            text-align: center;
            transition: background .4s ease;
            animation: fadeIn .5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        img.logo {
            width: 120px;
            margin-bottom: 15px;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            border-radius: 6px;
            border: 1px solid #444;
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
            margin-top: 12px;
            background-color: var(--highlight);
            color: white;
            border: none;
            padding: 10px;
            border-radius: 6px;
            font-size: 15px;
            cursor: pointer;
            transition: .2s;
        }

        button:hover {
            transform: translateY(-2px);
            opacity: .9;
        }

        /* ========= CAPTCHAS & ESPAÇAMENTO ========= */
        .captcha-area {
            margin-top: 18px;
            margin-bottom: 10px;
        }

        .captcha-area img {
            width: 150px;
            height: 50px;
            border-radius: 6px;
            border: 1px solid #666;
        }

        .refresh-btn {
            margin-top: 10px;
            margin-bottom: 18px;
            width: 100%;
            padding: 8px;
            background: #2563eb;
            color: #fff;
            font-size: 14px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
        }

        body.light .refresh-btn {
            background: #2e7dff;
        }

        input[name="captcha_input"] {
            margin-top: 10px;
            margin-bottom: 18px;
        }

        /* ========= LINKS ========= */
        a {
            color: var(--accent);
            text-decoration: none;
            font-size: 14px;
        }

        /* ========= BOTÃO DE TEMA ========= */
        .theme-toggle {
            position: absolute;
            top: 15px;
            right: 15px;
            background: transparent;
            color: var(--text);
            font-size: 26px;
            border: none;
            cursor: pointer;
            transition: .3s;
        }

        .theme-toggle:hover {
            transform: scale(1.15);
        }
    </style>
</head>

<body>

    <!-- Botão Dark/Light -->
    <button id="themeIcon" class="theme-toggle" onclick="toggleTheme()">🌙</button>

    <div class="container">
        <img id="logo" class="logo" src="../imagem/Logo GPS preta.png" alt="Logo">

        <h1>GPS para Agentes</h1>
        <p>Por favor, faça login para continuar</p>

        <% 
            String erro = (String) request.getAttribute("erro");
            if (erro != null) { %>
            <div style="color:#ff4b4b; font-weight:bold; margin-bottom:10px;">
                <%= erro %>
            </div>
        <% } %>

        <form action="<%=request.getContextPath()%>/LoginController" method="post">

            <input type="text" name="email" placeholder="E-mail" required>
            <input type="password" name="senha" placeholder="Senha" required>

            <div class="captcha-area">
                <img id="captcha-img" src="${pageContext.request.contextPath}/captcha">
            </div>

            <button type="button" class="refresh-btn" onclick="atualizarCaptcha()">🔄 Atualizar</button>

            <input type="text" name="captcha_input" placeholder="Digite o código acima" required>

            <label style="display:flex; align-items:center; gap:5px; font-size:14px;">
                <input type="checkbox" name="lembrar"> Lembrar de mim
            </label>

            <button type="submit">Entrar</button>

        </form>

        <div class="links" style="margin-top:15px;">
            <a href="<%= request.getContextPath() %>/login/esqueci-senha.jsp">Esqueci a senha</a> •
            <a href="<%= request.getContextPath() %>/login/cadastro.jsp">Cadastrar</a>
        </div>

        <footer style="margin-top:15px; font-size:12px; color:#999;">
            © 2025 - Code Hunt
        </footer>
    </div>

    <!-- SCRIPT DO TEMA E LOGO -->
    <script>
        function atualizarCaptcha() {
            document.getElementById("captcha-img").src =
                '${pageContext.request.contextPath}/captcha?ts=' + new Date().getTime();
        }

        function toggleTheme() {
            document.body.classList.toggle("light");
            const tema = document.body.classList.contains("light") ? "light" : "dark";
            localStorage.setItem("theme", tema);
            atualizarLogo();
            atualizarIcone();
        }

        function atualizarLogo() {
            const logo = document.getElementById("logo");
            if (document.body.classList.contains("light")) {
                logo.src = "../imagem/Logo_GPS.png"; 
            } else {
                logo.src = "../imagem/Logo GPS preta.png";
            }
        }

        function atualizarIcone() {
            const icone = document.getElementById("themeIcon");
            icone.textContent = document.body.classList.contains("light") ? "☀️" : "🌙";
        }

        (function() {
            const salvo = localStorage.getItem("theme");
            if (salvo === "light") {
                document.body.classList.add("light");
            }
            atualizarLogo();
            atualizarIcone();
        })();
    </script>

</body>
</html>
