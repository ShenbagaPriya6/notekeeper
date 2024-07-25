<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <h1>Search Results</h1>
    <div id="notes-list">
        <h2>Notes</h2>
        <ul id="notes">
            <!-- Notes will be displayed here -->
            <% 
                String criteria = request.getParameter("criteria");
                String query = request.getParameter("query");

                Connection connection = null;
                PreparedStatement preparedStatement = null;
                ResultSet resultSet = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "SHN2606");

                    String sqlQuery = "";
                    switch(criteria) {
                        case "date":
                            sqlQuery = "SELECT * FROM notes WHERE DATE(created_at) = ?";
                            break;
                        case "title":
                            sqlQuery = "SELECT * FROM notes WHERE title LIKE ?";
                            query = "%" + query + "%";
                            break;
                        case "subject":
                            sqlQuery = "SELECT * FROM notes WHERE subject LIKE ?";
                            query = "%" + query + "%";
                            break;
                        case "content":
                            sqlQuery = "SELECT * FROM notes WHERE content LIKE ?";
                            query = "%" + query + "%";
                            break;
                    }

                    preparedStatement = connection.prepareStatement(sqlQuery);
                    preparedStatement.setString(1, query);
                    resultSet = preparedStatement.executeQuery();

                    while (resultSet.next()) {
                        %>
                        <li>
                            <h3><%= resultSet.getString("title") %></h3>
                            <p><strong>Subject:</strong> <%= resultSet.getString("subject") %></p>
                            <p><%= resultSet.getString("content") %></p>
                            <p><strong>Created at:</strong> <%= resultSet.getString("created_at") %></p>
                        </li>
                        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (resultSet != null) resultSet.close();
                        if (preparedStatement != null) preparedStatement.close();
                        if (connection != null) connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </ul>
        <a href="index.html">Go Back</a>
    </div>
</body>
</html>
