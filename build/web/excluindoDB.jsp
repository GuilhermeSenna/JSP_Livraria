<%-- 
    Document   : excluindoDB
    Created on : 26/08/2020, 11:27:13
    Author     : Sergio Fred
--%>
<%@ page language="java" contentType ="text/html;"  import="java.sql.*"%>
<jsp:include page="bootstrap.html" />

        <%
        String id = request.getParameter("id");
        if (id !=null) {
            Connection conn = null;
            Statement st = null;
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance( );
                conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/livraria","root","" );
                st = conn.createStatement();
                st.executeUpdate("DELETE FROM LIVROS WHERE id= '"+id+"' ");
                out.println("O livro de ISBN <strong>"+id+"</strong> foi excluído com sucesso!");
                } catch (Exception ex) { ex.printStackTrace();
                out.println("Problema ao excluir livro");
                } finally {
                    if (st != null) st.close();
                    if (conn != null) conn.close();
                    }
            }
       %>
    <script>
        window.location.href='index.jsp';
    </script>
    </body>
</html>
