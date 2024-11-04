<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.util.*" %>
<%
String mailId = request.getParameter("mailId"); // Assuming user enters the mail ID to delete

if (mailId != null && !mailId.isEmpty()) {
    try {
        int mid = Integer.parseInt(mailId);
        
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/emailsoftware", "keerthi", "Keerthi@123");
        Statement st = conn.createStatement();
        
        // Execute SQL DELETE query
        int i = st.executeUpdate("DELETE FROM mails WHERE mid = " + mid);
        
        if (i > 0) {
            out.println("<center><b>Mail deleted successfully!</b></center>");
            
            // Now fetch remaining mails
            ResultSet resultSet = st.executeQuery("SELECT * FROM mails");
            %>
            <br>
            <table border="1" align="center" width="80%">
                <tr>
                    <th>Mail ID</th>
                    <th>From</th>
                    <th>To</th>
                    <th>Subject</th>
                    <th>Message</th>
                </tr>
            <% 
            while (resultSet.next()) {
                int remainingMailId = resultSet.getInt("mid");
                String from = resultSet.getString("mfrom");
                String to = resultSet.getString("mto");
                String subject = resultSet.getString("subject");
                String message = resultSet.getString("mtext");
            %>
                <tr>
                    <td><%= remainingMailId %></td>
                    <td><%= from %></td>
                    <td><%= to %></td>
                    <td><%= subject %></td>
                    <td><%= message %></td>
                </tr>
            <% } %>
            </table>
            <%
            resultSet.close();
        } else {
            out.println("<center><b>No mail found with ID: " + mid + "</b></center>");
        }
        
        conn.close();
    } catch (NumberFormatException e) {
        out.println("<center><b>Invalid mail ID format!</b></center>");
    } catch (Exception e) {
        out.print(e.getMessage());
        e.printStackTrace();
    }
} else {
    out.println("<center><b>Please enter a mail ID to delete.</b></center>");
}
%>

