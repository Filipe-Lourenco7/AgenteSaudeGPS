package Controller;

import java.util.Properties;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailSender {

    private static final String EMAIL_REMETENTE = "filipe.cavaleiro2018@gmail.com";
    private static final String SENHA_APP = "awbikflklvzickug";

    public static void enviarEmail(String destinatario, String assunto, String mensagemHtml) {

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587"); 
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        props.put("mail.smtp.connectiontimeout", "10000");
        props.put("mail.smtp.timeout", "10000");

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_REMETENTE, SENHA_APP);
            }
        });

        session.setDebug(true);

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_REMETENTE)); // sem nome aqui!
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            message.setSubject(assunto);

            String corpoSeguro = "<html><body>"
                + "<h2 style='color:#2563eb;'>GPS para Agentes</h2>"
                + "<p>Você solicitou a recuperação de senha.</p>"
                + "<br>"
                + mensagemHtml
                + "<br><br>"
                + "<small>Se você não solicitou isso, ignore este e-mail.</small>"
                + "</body></html>";

            message.setContent(corpoSeguro, "text/html; charset=UTF-8");

            Transport.send(message);

            System.out.println("E-mail enviado para: " + destinatario);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
