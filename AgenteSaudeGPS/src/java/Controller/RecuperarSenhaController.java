package Controller;

/**
 * Caio & Filipe
 */

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import modelDAO.ClientesDAO;

public class RecuperarSenhaController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        ClientesDAO dao = new ClientesDAO();

        try {
            // Verifica se o e-mail existe no banco
            if (dao.emailExiste(email)) {
                System.out.println("✅ E-mail encontrado no banco: " + email);

                // Envia o e-mail de redefinição
                String assunto = "Redefinição de Senha - GPS para Agentes";
                String mensagemHtml = "<h2>Olá!</h2>"
                        + "<p>Recebemos um pedido para redefinir sua senha.</p>"
                        + "<p><a href='http://localhost:8080/AgenteSaudeGPS/login/redefinir-senha.jsp'>"
                        + "Clique aqui para redefinir sua senha</a></p>"
                        + "<p>Se você não fez este pedido, ignore este e-mail.</p>";

                // 🔥 Chama o EmailSender
                System.out.println("🚀 Chamando EmailSender...");
                EmailSender.enviarEmail(email, assunto, mensagemHtml);
                System.out.println("📤 EmailSender executado com sucesso!");

                // Exibe mensagem de sucesso na página
                request.setAttribute("mensagemSucesso", "E-mail encontrado! Um link de redefinição será enviado em breve.");
            } else {
                System.out.println("❌ E-mail não encontrado: " + email);
                request.setAttribute("mensagemErro", "E-mail não encontrado em nosso sistema.");
            }

            // Retorna para a mesma tela
            RequestDispatcher rd = request.getRequestDispatcher("login/esqueci-senha.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}
