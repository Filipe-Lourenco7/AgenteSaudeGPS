<%@ page contentType="text/html; charset=UTF-8" %>

<%
    String lat = request.getParameter("lat");
    String lng = request.getParameter("lng");
    String zoom = request.getParameter("zoom");

    if(lat == null || lat.equals("") || lat.equals("undefined") || lat.equals("NaN")) lat = "-23.5226";
    if(lng == null || lng.equals("") || lng.equals("undefined") || lng.equals("NaN")) lng = "-46.1883";
    if(zoom == null || zoom.equals("") || zoom.equals("undefined") || zoom.equals("NaN")) zoom = "15";
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Criar Mapa da Área</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            background: #121212;
            color: white;
            font-family: 'Segoe UI', sans-serif;
        }
        #topbar {
            height: 70px;
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px;
            background: #000;
            border-bottom: 2px solid #2e7dff;
        }
        #map {
            width: 100%;
            height: calc(100vh - 70px);
            background: #333;
        }
    </style>
</head>

<body>

<div id="topbar">
    <button onclick="voltar()" class="btn btn-light">
        <i class="bi bi-arrow-left"></i> Voltar
    </button>

    <button onclick="gerarImagem()" class="btn btn-primary">
        <i class="bi bi-image"></i> Gerar Imagem
    </button>

    <button onclick="gerarPDF()" class="btn btn-success">
        <i class="bi bi-filetype-pdf"></i> PDF
    </button>
</div>

<div id="map"></div>

<script>
let map;

function initMap() {
    map = new google.maps.Map(document.getElementById("map"), {
        zoom: Number("<%=zoom%>"),
        center: {
            lat: Number("<%=lat%>"),
            lng: Number("<%=lng%>")
        },
        draggable: false,
        scrollwheel: false,
        disableDoubleClickZoom: true,
        gestureHandling: "none"
    });
}

function voltar() {
    window.location.href = "<%=request.getContextPath()%>/site/home.jsp";
}

function gerarImagem() {
    const url =
        `https://maps.googleapis.com/maps/api/staticmap?center=<%=lat%>,<%=lng%>&zoom=<%=zoom%>&size=1280x720&key=AIzaSyDF4L49IMVcew2OAuPet4sXlgv_fkBCOsw`;

    const link = document.createElement('a');
    link.href = url;
    link.download = "mapa.png";
    link.click();
}

function gerarPDF() {
    const url =
        `https://maps.googleapis.com/maps/api/staticmap?center=<%=lat%>,<%=lng%>&zoom=<%=zoom%>&size=1280x720&key=AIzaSyDF4L49IMVcew2OAuPet4sXlgv_fkBCOsw`;

    fetch(url)
        .then(r => r.blob())
        .then(blob => {
            const reader = new FileReader();
            reader.onload = function () {

                const imgBase64 = reader.result;

                const w = window.open("", "_blank");
                w.document.write(`
                    <img src="${imgBase64}" style="width:100%">
                    <scr` + `ipt>
                        window.onload = function() {
                            window.print();
                        }
                    </scr` + `ipt>
                `);
            };
            reader.readAsDataURL(blob);
        });
}
</script>

<script defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDF4L49IMVcew2OAuPet4sXlgv_fkBCOsw&callback=initMap"></script>

</body>
</html>
