/**
 * Filipe & Caio
 */
package Controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import model.Cliente;
import modelDAO.ClientesDAO;

public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // --- Verificação do CAPTCHA ---
        String captchaInput = request.getParameter("captcha_input");
        String captchaSession = (String) request.getSession().getAttribute("captcha");

        if (captchaSession == null || !captchaSession.equalsIgnoreCase(captchaInput)) {
            request.setAttribute("erro", "Captcha incorreto. Tente novamente.");
            RequestDispatcher rd = request.getRequestDispatcher("login/login.jsp");
            rd.forward(request, response);
            return;
        }

        // LOGIN
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        ClientesDAO dao = new ClientesDAO();

        try {
            // --- PEGA O CLIENTE COMPLETO DO BANCO ---
            Cliente cli = dao.autenticarRetornandoCliente(email, senha);

            if (cli != null) {

                // --- CRIA SESSÃO ---
                HttpSession sessao = request.getSession();
                sessao.setAttribute("usuarioLogado", cli);
                sessao.setAttribute("cepUsuario", String.valueOf(cli.getCep()));

                // OPCIONAL: lembrar login
                String lembrar = request.getParameter("lembrar");
                if ("true".equals(lembrar)) {
                    Cookie cookie = new Cookie("usuarioLembrado", email);
                    cookie.setMaxAge(60 * 60 * 24 * 7);
                    cookie.setPath(request.getContextPath());
                    response.addCookie(cookie);
                } else {
                    Cookie cookie = new Cookie("usuarioLembrado", "");
                    cookie.setMaxAge(0);
                    cookie.setPath(request.getContextPath());
                    response.addCookie(cookie);
                }

                // --- REDIRECIONA PARA PAINEL ---
                response.sendRedirect(request.getContextPath() + "/site/home.jsp");
                return;

            } else {

                request.setAttribute("erro", "E-mail ou senha inválidos!");
                RequestDispatcher rd = request.getRequestDispatcher("login/login.jsp");
                rd.forward(request, response);
            }

        } catch (ClassNotFoundException ex) {
            throw new ServletException(ex);
        }
    }
}
