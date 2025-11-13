package Controller;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

public class CaptchaServlet extends HttpServlet {
    private static final int WIDTH = 150;
    private static final int HEIGHT = 50;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // gerar código
        String chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
        Random rnd = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 5; i++) sb.append(chars.charAt(rnd.nextInt(chars.length())));
        String captcha = sb.toString();

        // salvar na sessão
        HttpSession session = req.getSession();
        session.setAttribute("captcha", captcha);

        // criar imagem
        BufferedImage img = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = img.createGraphics();
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, WIDTH, HEIGHT);
        g.setFont(new Font("Arial", Font.BOLD, 32));
        // rascunho de ruído
        for (int i = 0; i < 15; i++) {
            g.setColor(new Color(rnd.nextInt(256), rnd.nextInt(256), rnd.nextInt(256)));
            int x1 = rnd.nextInt(WIDTH), y1 = rnd.nextInt(HEIGHT);
            int x2 = rnd.nextInt(WIDTH), y2 = rnd.nextInt(HEIGHT);
            g.drawLine(x1, y1, x2, y2);
        }
        // texto do captcha
        g.setColor(Color.BLACK);
        g.drawString(captcha, 20, 35);
        g.dispose();

        resp.setContentType("image/png");
        ImageIO.write(img, "png", resp.getOutputStream());
    }
}