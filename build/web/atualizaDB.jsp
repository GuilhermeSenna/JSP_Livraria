<%-- 
    Document   : AtualizarDados
    Created on : 2/03/2021, 17:40:20
    Author     : Sergio Fred
--%>
<%@ page language="java"  contentType="text/html"	import="java.sql.*" %>

<%
	String id = request.getParameter("id");
	String titulo = request.getParameter("titulo");
	String edicao = request.getParameter("edicao");
	String publicacao = request.getParameter("publicacao");
	String descricao = request.getParameter("descricao");

	if(id!=null) {
		Connection conn = null;
		PreparedStatement pst = null;

		try {
		    Class.forName("com.mysql.jdbc.Driver").newInstance( );
		    conn =
		    DriverManager.getConnection("jdbc:mysql://localhost/livraria", "root","");
 	 	    String SQL = "UPDATE livros SET titulo=?,  edicao=?, publicacao=?, descricao=? " +
	        		    "where id=?";
		    pst = conn.prepareStatement(SQL);                    
		    pst.setString(1, titulo);
		    pst.setInt(2, Integer.parseInt(edicao));
		    pst.setString(3, publicacao);
		    pst.setString(4, descricao);
                                      pst.setString(5, id);
		    pst.executeUpdate( );
		    pst.clearParameters( );
	                     %>                       
                                  
                                 <%
                                       }  catch (Exception ex) {
                                                        ex.printStackTrace( );
                                                        out.println("Erro ao atualizar");
                                        }  finally {
                                                        if (pst != null) pst.close( );
                                                        if (conn != null) conn.close( );
                                        }
                                        }//end if
                                        else {
                                                       out.println("ISBN não existente");
                                       }  
	%>
<script>
     window.location.href='index.jsp';
</script>
