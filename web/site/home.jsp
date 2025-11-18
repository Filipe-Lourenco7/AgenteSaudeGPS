<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
    String cepUsuario = (String) session.getAttribute("cepUsuario");
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>GPS for Agents - Home</title>

    <!-- BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- BOOTSTRAP ICONS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden;
            background: #000;
            font-family: 'Segoe UI', sans-serif;
        }

        /* SIDEBAR */
        #sidebar {
            width: 260px;
            height: 100vh;
            background: #0c0c0c;
            color: white;
            position: fixed;
            top: 0;
            left: 0;
            padding: 22px;
            border-right: 3px solid #4CAF50;
            z-index: 20;
            overflow-y: auto; /* Scroll interno */
        }

        #sidebar h3 {
            text-align: center;
            font-weight: bold;
            color: #4CAF50;
            margin-bottom: 25px;
            letter-spacing: 1px;
            font-size: 20px;
        }

        .btn-menu {
            width: 100%;
            background: #1a1a1a;
            border: 1px solid #333;
            color: #ddd;
            margin-bottom: 12px;
            border-radius: 8px;
            padding: 12px;
            font-size: 15px;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-menu:hover {
            background: #4CAF50;
            color: #fff;
            transform: translateY(-2px);
        }

        #btnBuscarCEP {
            background: #4CAF50;
            border: none;
            color: white;
            padding: 12px;
            border-radius: 8px;
            transition: .2s;
            width: 100%;
            font-weight: 600;
        }

        #btnBuscarCEP:hover {
            transform: translateY(-2px);
            opacity: .9;
        }

        #btnCriarMapa {
            width: 100%;
            background: #2e7dff;
            border: none;
            color: #fff;
            padding: 12px;
            border-radius: 8px;
            font-size: 15px;
            cursor: pointer;
            margin-bottom: 10px;
            transition: .2s;
            font-weight: 600;
        }
        #btnCriarMapa:hover {
            transform: translateY(-2px);
            opacity: .85;
        }

        #btnToggleEdicao {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            font-size: 15px;
            text-align: center !important;
            display: block;
            background: #111;
            color: #FFC107;
            border: 2px solid #FFC107;
            transition: .2s;
            font-weight: bold;
        }
        #btnToggleEdicao.active {
            background: #FFC107;
            color: #000;
        }

        #map {
            position: absolute;
            left: 260px;
            top: 0;
            width: calc(100% - 260px);
            height: 100vh;
        }
    </style>
</head>

<body>

<!-- SIDEBAR -->
<div id="sidebar">
    <h3>GPS for Agents</h3>

    <button class="btn-menu"><i class="bi bi-geo-alt"></i> &nbsp;Mapa</button>
    <button class="btn-menu"><i class="bi bi-bar-chart"></i> &nbsp;Dashboard</button>
    <button class="btn-menu"><i class="bi bi-journal-text"></i> &nbsp;Minhas Anotações</button>
    <button class="btn-menu"><i class="bi bi-person-circle"></i> &nbsp;Perfil</button>
    <button class="btn-menu"><i class="bi bi-gear"></i> &nbsp;Configurações</button>
    <button class="btn-menu"><i class="bi bi-question-circle"></i> &nbsp;Dúvidas</button>

    <hr>

    <label for="cepInput">Buscar CEP:</label>
    <input type="text" id="cepInput" class="form-control mb-2" placeholder="Digite o CEP">
    <button id="btnBuscarCEP" class="mb-3">Buscar CEP</button>

    <hr>

    <!-- Envia lat/lng/zoom -->
    <button id="btnCriarMapa">Criar mapa dessa área</button>

    <label>Modo Edição:</label>
    <button id="btnToggleEdicao" class="mb-4">OFF</button>

    <hr>

    <!-- BOTÃO SAIR -->
    <button class="btn btn-danger w-100 mb-3" onclick="confirmarSaida()">Sair</button>
</div>

<!-- MAPA -->
<div id="map"></div>

<script>
    let map;
    let geocoder;
    let infoWindow;
    let markers = [];
    let editMode = false;

    function initMap() {
        const center = { lat: -23.5226, lng: -46.1883 };

        map = new google.maps.Map(document.getElementById("map"), {
            zoom: 14,
            center: center,
            draggable: true,
            scrollwheel: true,
        });

        geocoder = new google.maps.Geocoder();
        infoWindow = new google.maps.InfoWindow();

        map.addListener("click", (e) => {
            if (!editMode) return;
            adicionarMarcadorComNota(e.latLng);
        });

        configurarUI();

        const cepSessao = "<%= cepUsuario %>";
        if (cepSessao && cepSessao !== "null") {
            buscarCep(cepSessao);
        }
    }

    function configurarUI() {
        const btnCep = document.getElementById("btnBuscarCEP");
        const cepInput = document.getElementById("cepInput");
        const btnEdicao = document.getElementById("btnToggleEdicao");
        const btnCriarMapa = document.getElementById("btnCriarMapa");

        btnCep.addEventListener("click", () => buscarCep(cepInput.value));

        cepInput.addEventListener("keyup", (e) => {
            if (e.key === "Enter") buscarCep(cepInput.value);
        });

        btnEdicao.addEventListener("click", () => {
            editMode = !editMode;

            if (editMode) {
                btnEdicao.textContent = "ON";
                btnEdicao.classList.add("active");

                map.setOptions({
                    draggable: false,
                    scrollwheel: false
                });

            } else {
                btnEdicao.textContent = "OFF";
                btnEdicao.classList.remove("active");

                map.setOptions({
                    draggable: true,
                    scrollwheel: true
                });
            }
        });

        // Botão enviar posição para mapa.jsp
            btnCriarMapa.addEventListener("click", () => {

                if (!map) {
                    alert("O mapa ainda está carregando, tente de novo.");
                    return;
                }

                const center = map.getCenter();

                if (!center) {
                    alert("Não foi possível obter a posição atual do mapa.");
                    return;
                }

                const lat = Number(center.lat());
                const lng = Number(center.lng());
                const zoom = Number(map.getZoom());

                if (isNaN(lat) || isNaN(lng) || isNaN(zoom)) {
                    alert("Erro ao capturar posição do mapa.");
                    return;
                }

                window.location.href = `<%=ctx%>/site/mapa.jsp?lat=${lat}&lng=${lng}&zoom=${zoom}`;
            });
    }

    function confirmarSaida() {
        if (confirm("Tem certeza que deseja sair?")) {
            window.location.href = "<%=ctx%>/index.jsp";
        }
    }

    function buscarCep(cepDigitado) {
        const cep = cepDigitado.replace(/\D/g, "");
        if (cep.length !== 8) {
            alert("CEP inválido!");
            return;
        }
        geocoder.geocode({ address: cep + ", Brasil" }, (results, status) => {
            if (status === "OK" && results[0]) {
                const location = results[0].geometry.location;
                map.setCenter(location);
                map.setZoom(17);
            } else {
                alert("CEP não encontrado.");
            }
        });
    }

    function adicionarMarcadorComNota(latLng) {
        const notaDigitada = prompt("Anotação para este ponto:");
        const notaFinal = notaDigitada?.trim() || "Sem anotação cadastrada.";

        const marker = new google.maps.Marker({
            position: latLng,
            map: map
        });

        marker.nota = notaFinal;
        markers.push(marker);

        marker.addListener("click", () => {
            const htmlInfo =
                "<div style='min-width:220px;'>" +
                "<strong>Ponto registrado</strong><br><br>" +
                marker.nota + "<br><br>" +
                "<button id='btn-excluir-pin' " +
                "style='background:#c62828;color:white;border:none;padding:8px 12px;" +
                "border-radius:6px;cursor:pointer;'>Excluir Pin</button>" +
                "</div>";

            infoWindow.setContent(htmlInfo);
            infoWindow.open(map, marker);

            google.maps.event.addListenerOnce(infoWindow, "domready", () => {
                const btnExcluir = document.getElementById("btn-excluir-pin");
                if (btnExcluir) btnExcluir.onclick = () => excluirPin(marker);
            });
        });
    }

    function excluirPin(marker) {
        marker.setMap(null);
        markers = markers.filter(m => m !== marker);
        infoWindow.close();
    }
</script>

<script async src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDF4L49IMVcew2OAuPet4sXlgv_fkBCOsw&callback=initMap"></script>

</body>
</html>
