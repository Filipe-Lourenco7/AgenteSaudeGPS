package modelDAO;

import java.sql.*;
import config.ConectaDB;
import model.Cliente;

public class ClientesDAO {

    // --- MÉTODO DE AUTENTICAÇÃO ---
    public boolean autenticar(Cliente cli) throws ClassNotFoundException {
        boolean autenticado = false;
        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT * FROM clientes WHERE email = ? AND senha = ?")) {

            stmt.setString(1, cli.getEmail());
            stmt.setString(2, cli.getSenha());
            ResultSet rs = stmt.executeQuery();

            autenticado = rs.next();
            rs.close();

        } catch (SQLException ex) {
            System.out.println("Erro ao autenticar: " + ex.getMessage());
        }
        return autenticado;
    }

    // --- MÉTODO DE CADASTRO ---
    public boolean cadastrar(Cliente cli) throws ClassNotFoundException {
        boolean cadastrado = false;
        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(
                     "INSERT INTO clientes (name, email, cep, senha) VALUES (?, ?, ?, ?)")) {

            stmt.setString(1, cli.getName());
            stmt.setString(2, cli.getEmail());
            stmt.setInt(3, cli.getCep());
            stmt.setString(4, cli.getSenha());
            stmt.executeUpdate();
            cadastrado = true;

        } catch (SQLException ex) {
            System.out.println("Erro ao cadastrar: " + ex.getMessage());
        }
        return cadastrado;
    }

    // --- MÉTODO DE VERIFICAÇÃO DE E-MAIL (ESQUECI SENHA) ---
    public boolean emailExiste(String email) throws ClassNotFoundException {
        boolean existe = false;
        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT COUNT(*) FROM clientes WHERE email = ?")) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                existe = rs.getInt(1) > 0;
            }
            rs.close();

        } catch (SQLException ex) {
            System.out.println("Erro ao verificar e-mail: " + ex.getMessage());
        }
        return existe;
    }
}
