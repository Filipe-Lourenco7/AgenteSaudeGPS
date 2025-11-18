<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>GPS for Agents - Landing Page</title>

    <style>
        :root {
            --bg: #0d0d0d;
            --text: #f1f1f1;
            --accent: #4caf50;
            --highlight: #2e7dff;
            --card: #151515;
        }

        body.light {
            --bg: #ffffff;
            --text: #111111;
            --accent: #2e7dff;
            --highlight: #4caf50;
            --card: #f3f3f3;
        }

        body {
            transition: background-color 0.4s ease, color 0.4s ease;
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: var(--bg);
            color: var(--text);
        }

        /* HEADER */
        header {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 60px;
            max-width: 1500px;
            margin: 0 auto;
        }

        header img {
            height: 150px;
            transition: opacity 0.3s ease;
        }

        .top-buttons {
            display: flex;
            gap: 16px;
            align-items: center;
        }

        /* BOTÕES */
        .btn {
            padding: 12px 26px;
            border-radius: 999px;
            background: var(--accent);
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            border: none;
            cursor: pointer;
            display: inline-block;
            transition: background-color 0.25s ease, transform 0.2s ease, box-shadow 0.25s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(0,0,0,0.25);
        }

        #themeToggle {
            padding: 10px 20px;
            border-radius: 999px;
            background: #444;
            color: #fff;
            border: none;
            cursor: pointer;
            font-size: 1.2rem;
            transition: 0.25s ease;
        }

        /* HERO */
        .hero-wrapper {
            max-width: 1500px;
            margin: 40px auto 0;
            padding: 0 60px 80px;
        }

        .hero {
            position: relative;
            text-align: center;
            padding: 80px 20px;
            border-radius: 24px;
            overflow: hidden;
            background-image:
                linear-gradient(rgba(0,0,0,0.65), rgba(0,0,0,0.65)),
                url('<%= ctx %>/imagem/mapa_urbano.png');
            background-size: cover;
            background-position: center;
            box-shadow: 0 20px 40px rgba(0,0,0,0.35);
        }

        body.light .hero {
            background-image:
                linear-gradient(rgba(255,255,255,0.75), rgba(255,255,255,0.85)),
                url('<%= ctx %>/imagem/mapa_urbano.png');
        }

        .hero h1 {
            font-size: 3rem;
            margin-bottom: 18px;
            font-weight: bold;
        }

        .hero p {
            font-size: 1.15rem;
            max-width: 900px;
            margin: 0 auto;
            line-height: 1.6;
            color: #e0e0e0;
        }

        body.light .hero p {
            color: #444;
        }

        /* FEATURES */
        .features-section {
            max-width: 1500px;
            margin: 40px auto;
            padding: 20px 60px;
            text-align: center;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }

        .feature-card {
            background: var(--card);
            padding: 22px;
            border-radius: 16px;
            font-size: 1.1rem;
            box-shadow: 0 6px 16px rgba(0,0,0,0.25);
            transition: transform .25s;
        }

        .feature-card:hover {
            transform: translateY(-5px);
        }

        /* SCREENSHOT */
        .screenshot-section {
            text-align: center;
            margin: 40px auto;
            padding: 20px 60px;
            max-width: 1500px;
        }

        .screenshot-section img {
            width: 100%;
            border-radius: 18px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.35);
        }

        /* BENEFÍCIOS */
        .benefits {
            max-width: 1500px;
            margin: 60px auto;
            padding: 20px 60px;
            text-align: center;
        }

        .benefits ul {
            list-style: none;
            padding: 0;
            font-size: 1.2rem;
            line-height: 2.2;
        }

        /* TESTEMUNHOS */
        .testimonials {
            max-width: 1500px;
            margin: 80px auto;
            padding: 20px 60px;
            text-align: center;
        }

        .testimonials-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }

        .testimonial {
            background: var(--card);
            padding: 22px;
            border-radius: 16px;
            font-size: 1.05rem;
            box-shadow: 0 8px 20px rgba(0,0,0,0.25);
            line-height: 1.6;
        }

        /* CTA FINAL */
        .cta-final {
            text-align: center;
            margin: 80px auto;
            padding: 40px 20px;
        }

        .cta-final h2 {
            font-size: 2.2rem;
            margin-bottom: 25px;
        }

        footer {
            margin-top: 40px;
            padding: 20px;
            font-size: 0.9rem;
            color: #aaa;
            text-align: center;
        }
    </style>
</head>
<body>

<header>
    <img id="logo" src="<%= ctx %>/imagem/Logo_GPS.png" alt="Logo GPS for Agents">

    <div class="top-buttons">
        <a href="<%= ctx %>/login/cadastro.jsp" class="btn">Cadastrar</a>
        <a href="<%= ctx %>/login/login.jsp" class="btn" style="background: var(--highlight);">Login</a>
        <button id="themeToggle">🌙</button>
    </div>
</header>

<!-- HERO -->
<div class="hero-wrapper">
    <section class="hero">
        <h1>Simplifique a rotina dos Agentes de Saúde</h1>
        <p>Organize visitas, mapeie regiões, acompanhe famílias e gerencie campanhas com uma plataforma moderna, rápida e prática feita sob medida para Agentes Comunitários.</p>
    </section>
</div>

<!-- FUNCIONALIDADES -->
<section class="features-section">
    <h2>Funcionalidades Principais</h2>
    <div class="features-grid">
        <div class="feature-card">📍 Mapeamento Urbano Inteligente</div>
        <div class="feature-card">🏠 Cadastro de Famílias</div>
        <div class="feature-card">📅 Planejamento de Visitas</div>
        <div class="feature-card">📊 Relatórios Rápidos</div>
        <div class="feature-card">🗺️ Acompanhamento de Microáreas</div>
    </div>
</section>

<!-- PRINT DO SISTEMA -->
<section class="screenshot-section">
    <h2>Veja como o sistema funciona</h2>
    <img src="<%= ctx %>/imagem/demo_sistema.png" alt="Demonstração do Sistema">
</section>

<!-- BENEFÍCIOS -->
<section class="benefits">
    <h2>Por que utilizar o GPS for Agents?</h2>
    <ul>
        <li>✔ Reduz tempo das visitas</li>
        <li>✔ Facilita campanhas de vacinação</li>
        <li>✔ Melhora a organização da equipe</li>
        <li>✔ Evita perda de dados</li>
        <li>✔ Mapeia microáreas automaticamente</li>
    </ul>
</section>

<!-- DEPOIMENTOS -->
<section class="testimonials">
    <h2>O que Agentes dizem</h2>
    <div class="testimonials-grid">
        <div class="testimonial">“Facilitou muito minha organização diária.” — Carla, ACS</div>
        <div class="testimonial">“O mapa inteligente mudou tudo.” — Marcos, ACS</div>
        <div class="testimonial">“Plataforma rápida e prática.” — Juliana, Supervisora</div>
    </div>
</section>

<!-- CTA FINAL -->
<section class="cta-final">
    <h2>Pronto para agilizar sua rotina?</h2>
    <a href="<%= ctx %>/login/cadastro.jsp" class="btn" style="font-size:1.3rem;">Criar Conta Agora</a>
</section>

<footer>© 2025 GPS for Agents — Todos os direitos reservados.</footer>

<script>
    const themeBtn = document.getElementById("themeToggle");
    const logo = document.getElementById("logo");

    function applySavedTheme() {
        const saved = localStorage.getItem("theme");

        if (saved === "light") {
            document.body.classList.add("light");
            themeBtn.textContent = "🌞";
        } else {
            document.body.classList.remove("light");
            themeBtn.textContent = "🌙";
        }

        updateLogo();
    }

    function updateLogo() {
        if (document.body.classList.contains("light")) {
            logo.src = "<%= ctx %>/imagem/Logo_GPS.png"; // tema claro
        } else {
            logo.src = "<%= ctx %>/imagem/Logo GPS preta.png"; // tema escuro
        }
    }

    themeBtn.addEventListener("click", () => {
        document.body.classList.toggle("light");

        const tema = document.body.classList.contains("light") ? "light" : "dark";

        localStorage.setItem("theme", tema);

        themeBtn.textContent = tema === "light" ? "🌞" : "🌙";

        updateLogo();
    });
    applySavedTheme();
</script>


</body>
</html>
