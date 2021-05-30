<%-- 
    Document   : InserindoDados
    Created on : 2/03/2021, 17:40:20
    Author     : Sergio Fred
--%>

<%@ page language="java" contentType ="text/html;" import="java.sql.*"%>

<%
String id = request.getParameter("id");
String titulo = request.getParameter("titulo");
String edicao = request.getParameter("edicao");
String publicacao = request.getParameter("publicacao");
String descricao = request.getParameter("descricao");

Connection conn =null;
PreparedStatement pst =null;
try
{
Class.forName("com.mysql.jdbc.Driver").newInstance( );
conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/livraria", "root","");

String SQL = "INSERT INTO livros (titulo,edicao,publicacao,descricao)values (?, ?, ?, ?)";
pst = conn.prepareStatement(SQL);
pst.setString(1, titulo);
pst.setInt(2, Integer.parseInt(edicao));
pst.setInt(3, Integer.parseInt(publicacao));
pst.setString(4, descricao);
pst.executeUpdate( );
pst.clearParameters( );
}
catch (Exception ex) {ex.printStackTrace( );
}
finally
{
if (pst !=null) pst.close( );
if (conn !=null) conn.close( );
}
%>
<script>
    window.location.href='index.jsp';
</script>


