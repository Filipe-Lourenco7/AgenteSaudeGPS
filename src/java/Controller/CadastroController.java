/**
 * Caio & Filipe
 */
package Controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import model.Cliente;
import modelDAO.ClientesDAO;

public class CadastroController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // --- Coleta de dados do formulário ---
        Cliente cli = new Cliente();
        cli.setName(request.getParameter("name"));
        cli.setEmail(request.getParameter("email"));

        // Coleta e validação do CEP
        String cepParam = request.getParameter("cep");
        int cep = 0;

        try {
            if (cepParam != null && !cepParam.isEmpty()) {
                cep = Integer.parseInt(cepParam);  // Mantive int porque VC USA int no Model
            }
        } catch (NumberFormatException e) {
            request.setAttribute("erro", "CEP inválido. Digite apenas números.");
            RequestDispatcher rd = request.getRequestDispatcher("login/cadastro.jsp");
            rd.forward(request, response);
            return;
        }

        cli.setCep(cep);
        cli.setSenha(request.getParameter("senha"));

        ClientesDAO dao = new ClientesDAO();

        try {
            // --- Tenta cadastrar ---
            if (dao.cadastrar(cli)) {

                // --- Salva o cliente na sessão ---
                HttpSession sessao = request.getSession();
                sessao.setAttribute("usuarioLogado", cli);

                // Converte o CEP int para string e salva na sessão
                sessao.setAttribute("cepUsuario", String.valueOf(cep));

                // Redireciona para o painel
                response.sendRedirect(request.getContextPath() + "/site/home.jsp");
                return;

            } else {
                request.setAttribute("erro", "Erro ao cadastrar. Tente novamente.");
                RequestDispatcher rd = request.getRequestDispatcher("login/cadastro.jsp");
                rd.forward(request, response);
                return;
            }

        } catch (ClassNotFoundException ex) {
            throw new ServletException(ex);
        }
    }
}
