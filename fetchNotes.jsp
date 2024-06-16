<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    List<Map<String, String>> notes = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "SHN2606");

        String sqlQuery = "SELECT * FROM notes";
        statement = connection.createStatement();
        resultSet = statement.executeQuery(sqlQuery);

        while (resultSet.next()) {
            Map<String, String> note = new HashMap<>();
            note.put("title", resultSet.getString("title"));
            note.put("subject", resultSet.getString("subject"));
            note.put("content", resultSet.getString("content"));
            note.put("created_at", resultSet.getString("created_at"));
            notes.add(note);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    response.setContentType("application/json");
    out.print("[");
    for (int i = 0; i < notes.size(); i++) {
        Map<String, String> note = notes.get(i);
        out.print("{\"title\":\"" + note.get("title") + "\", \"subject\":\"" + note.get("subject") + "\", \"content\":\"" + note.get("content") + "\", \"created_at\":\"" + note.get("created_at") + "\"}");
        if (i < notes.size() - 1) {
            out.print(",");
        }
    }
    out.print("]");
%>
