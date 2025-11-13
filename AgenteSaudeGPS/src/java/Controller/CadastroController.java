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
        
        // Evita erro se o campo CEP estiver vazio
        String cepParam = request.getParameter("cep");
        int cep = 0;
        try {
            if (cepParam != null && !cepParam.isEmpty()) {
                cep = Integer.parseInt(cepParam);
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
            // --- Tenta cadastrar o cliente ---
            if (dao.cadastrar(cli)) {
                // Cadastro bem-sucedido → redireciona para a tela de sucesso
                response.sendRedirect(request.getContextPath() + "/site/sucesso.jsp");
                return;
            } else {
                // Erro no cadastro → volta pra tela de cadastro
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
