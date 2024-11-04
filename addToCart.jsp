<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.example.DatabaseConnection" %>
<html>
<head>
    <title>Add to Cart</title>
</head>
<body>
    <%
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double total = 0;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseConnection.getConnection();
            
            // Get book price
            pstmt = conn.prepareStatement("SELECT price FROM books WHERE id = ?");
            pstmt.setInt(1, bookId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                double price = rs.getDouble("price");
                total = price * quantity;

                // Insert order into database
                pstmt = conn.prepareStatement("INSERT INTO orders (book_id, quantity, total) VALUES (?, ?, ?)");
                pstmt.setInt(1, bookId);
                pstmt.setInt(2, quantity);
                pstmt.setDouble(3, total);
                pstmt.executeUpdate();
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
    <h1>Order Placed</h1>
    <p>Your order has been placed successfully. Total amount: $<%= total %></p>
    <a href="bookList.jsp">Back to Book List</a>
</body>
</html>

