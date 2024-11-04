<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.example.DatabaseConnection" %>
<html>
<head>
    <title>Book List</title>
</head>
<body>
    <h1>Book List</h1>
    <table border="1">
        <tr>
            <th>Title</th>
            <th>Author</th>
            <th>Price</th>
            <th>Details</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                conn = DatabaseConnection.getConnection();
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT * FROM books");

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String title = rs.getString("title");
                    String author = rs.getString("author");
                    double price = rs.getDouble("price");
        %>
        <tr>
            <td><%= title %></td>
            <td><%= author %></td>
            <td><%= price %></td>
            <td><a href="bookDetails.jsp?id=<%= id %>">View Details</a></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error: " + e.getMessage());
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </table>
</body>
</html>

