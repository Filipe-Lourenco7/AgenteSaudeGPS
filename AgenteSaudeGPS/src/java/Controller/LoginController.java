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
            return; // Impede execução do restante
        }
        // --- Fim da verificação do CAPTCHA ---

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        Cliente cli = new Cliente();
        cli.setEmail(email);
        cli.setSenha(senha);

        ClientesDAO dao = new ClientesDAO();

        try {
            if (dao.autenticar(cli)) {
                // Login válido
                HttpSession sessao = request.getSession();
                sessao.setAttribute("usuario", email);

                // Verifica se o usuário marcou "Lembrar de mim"
                String lembrar = request.getParameter("lembrar");
                if ("true".equals(lembrar)) {
                    Cookie cookie = new Cookie("usuarioLembrado", email);
                    cookie.setMaxAge(60 * 60 * 24 * 7); // 7 dias
                    cookie.setPath(request.getContextPath());
                    response.addCookie(cookie);
                } else {
                    // Apaga cookie anterior (caso exista)
                    Cookie cookie = new Cookie("usuarioLembrado", "");
                    cookie.setMaxAge(0);
                    cookie.setPath(request.getContextPath());
                    response.addCookie(cookie);
                }

                response.sendRedirect(request.getContextPath() + "/site/home.jsp");
                return;

            } else {
                // Login inválido
                request.setAttribute("erro", "E-mail ou senha inválidos!");
                RequestDispatcher rd = request.getRequestDispatcher("login/login.jsp");
                rd.forward(request, response);
                return;
            }

        } catch (ClassNotFoundException ex) {
            throw new ServletException(ex);
        }
    }
}
