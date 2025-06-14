/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author U S E R
 */
public class EmailUtil {
    public static void send(String to, String subject, String content) {
        // For testing, just log to console
        System.out.println("Sending email to: " + to);
        System.out.println("Subject: " + subject);
        System.out.println("Content: " + content);
        // You can integrate JavaMail here for real email sending
    }
}
