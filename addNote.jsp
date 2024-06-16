<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    String title = request.getParameter("title");
    String subject = request.getParameter("subject");
    String content = request.getParameter("content");

    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "SHN2606");

        String query = "INSERT INTO notes (title, subject, content) VALUES (?, ?, ?)";
        preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, title);
        preparedStatement.setString(2, subject);
        preparedStatement.setString(3, content);
        preparedStatement.executeUpdate();
        
        response.sendRedirect("index.html?success=true");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
