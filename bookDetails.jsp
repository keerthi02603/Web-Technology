<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.example.DatabaseConnection" %>
<html>
<head>
    <title>Book Details</title>
</head>
<body>
    <h1>Book Details</h1>
    <%
        int bookId = Integer.parseInt(request.getParameter("id"));
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseConnection.getConnection();
            pstmt = conn.prepareStatement("SELECT * FROM books WHERE id = ?");
            pstmt.setInt(1, bookId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String title = rs.getString("title");
                String author = rs.getString("author");
                double price = rs.getDouble("price");
                String description = rs.getString("description");
    %>
    <h2><%= title %></h2>
    <p><strong>Author:</strong> <%= author %></p>
    <p><strong>Price:</strong> $<%= price %></p>
    <p><strong>Description:</strong> <%= description %></p>
    <form action="addToCart.jsp" method="post">
        <input type="hidden" name="bookId" value="<%= bookId %>" />
        <label>Quantity:</label>
        <input type="number" name="quantity" min="1" required />
        <input type="submit" value="Add to Cart" />
    </form>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</body>
</html>

