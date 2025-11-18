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

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        html, body {
            height: 100%;
            margin: 0;
            overflow: hidden;
            background: #000;
            font-family: 'Segoe UI', sans-serif;
        }

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
            overflow-y: auto;
            z-index: 20;
        }

        #sidebar h3 {
            text-align: center;
            color: #4CAF50;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .btn-menu {
            width: 100%;
            background: #1a1a1a;
            border: 1px solid #333;
            color: #ccc;
            margin-bottom: 10px;
            border-radius: 8px;
            padding: 12px;
            transition: .2s;
            text-align: left;
        }
        .btn-menu:hover {
            background: #4CAF50;
            color: #fff;
        }

        #btnCriarMapa {
            width: 100%;
            background: #2e7dff;
            border: none;
            color: white;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        #btnToggleEdicao {
            width: 100%;
            background: #111;
            color: #FFC107;
            border: 2px solid #FFC107;
            padding: 10px;
            border-radius: 8px;
            font-weight: bold;
        }
        #btnToggleEdicao.active {
            background: #FFC107;
            color: #111;
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
<h1 style="color:red;">VERSÃO TESTE 999</h1>

<div id="sidebar">
    <h3>GPS for Agents</h3>

    <button class="btn-menu"><i class="bi bi-geo-alt"></i> &nbsp;Mapa</button>
    <button class="btn-menu"><i class="bi bi-bar-chart"></i> &nbsp;Dashboard</button>
    <button class="btn-menu"><i class="bi bi-journal-text"></i> &nbsp;Minhas Anotações</button>
    <button class="btn-menu"><i class="bi bi-person-circle"></i> &nbsp;Perfil</button>
    <button class="btn-menu"><i class="bi bi-gear"></i> &nbsp;Configurações</button>
    <button class="btn-menu"><i class="bi bi-question-circle"></i> &nbsp;Dúvidas</button>

    <hr>

    <label>Buscar CEP:</label>
    <input id="cepInput" class="form-control mb-2" placeholder="Digite o CEP">
    <button id="btnBuscarCEP" class="btn btn-success w-100 mb-3">Buscar CEP</button>

    <hr>

    <button id="btnCriarMapa">Criar mapa dessa área</button>

    <label>Modo Edição:</label>
    <button id="btnToggleEdicao" class="mb-4">OFF</button>

    <hr>

    <button onclick="confirmarSaida()" class="btn btn-danger w-100">Sair</button>
</div>

<div id="map"></div>

<script>
console.log("SCRIPT DO HOME.JSP ESTÁ RODANDO.");
let map, geocoder;
let editMode = false;

function initMap() {
    console.log("INITMAP LOAD");

    map = new google.maps.Map(document.getElementById("map"), {
        zoom: 14,
        center: { lat: -23.5226, lng: -46.1883 },
        draggable: true,
        scrollwheel: true
    });
}


function configurarUI() {
    const btnCriarMapa = document.getElementById("btnCriarMapa");
    const btnEdicao = document.getElementById("btnToggleEdicao");
    const btnCep = document.getElementById("btnBuscarCEP");
    const cepInput = document.getElementById("cepInput");

    btnCep.addEventListener("click", () => buscarCEP(cepInput.value));

    btnEdicao.addEventListener("click", () => {
        editMode = !editMode;
        btnEdicao.textContent = editMode ? "ON" : "OFF";
        btnEdicao.classList.toggle("active");

        map.setOptions({
            draggable: !editMode,
            scrollwheel: !editMode,
            disableDoubleClickZoom: editMode
        });
    });

btnCriarMapa.addEventListener("click", () => {

    google.maps.event.addListenerOnce(map, "idle", () => {

        const lat = map.getCenter().lat();
        const lng = map.getCenter().lng();
        const zoom = map.getZoom();

        console.log("ENVIANDO:", lat, lng, zoom);

        window.location.href =
            `<%=ctx%>/site/mapa.jsp?lat=${lat}&lng=${lng}&zoom=${zoom}`;
    });

    // força o "idle" disparar mesmo se o mapa não se mover
    map.panBy(0, 0);
});



function buscarCEP(cep) {
    cep = cep.replace(/\D/g, "");
    if (cep.length !== 8) return alert("CEP inválido.");

    geocoder.geocode({ address: cep }, (results, status) => {
        if (status !== "OK") return alert("CEP não encontrado.");

        map.setCenter(results[0].geometry.location);
        map.setZoom(17);
    });
}

function confirmarSaida() {
    if (confirm("Tem certeza que deseja sair?"))
        window.location.href = "<%=ctx%>/index.jsp";
}
</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDF4L49IMVcew2OAuPet4sXlgv_fkBCOsw&callback=initMap" async></script>

</body>
</html>
