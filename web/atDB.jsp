<%@ page language="java" contentType="text/html" import="java.sql.*, java.text.*"%>
<jsp:include page="bootstrap.html" />

<!DOCTYPE HTML>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Atualizando dados via JDBC com JSP</title>
        <script>
        //função para carregar valores do bd tabela EDITORA
        function carregaEditora() {
          var select_c = document.getElementById("Lista_e").value;
          document.getElementById("Edito").value = select_c;
        }
      </script>
    </head>
    <body>
        <%
            String id = request.getParameter("id").trim(); //Recebe parâmetro por Get ou Post
            if (id != null) {
                Connection conn = null;
                PreparedStatement pst = null;
                ResultSet rs = null;
                SimpleDateFormat dateFormat = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/livraria", "root", "");

                    pst = conn.prepareStatement("select * from livros where id=?");
                    pst.setString(1, id);
                    rs = pst.executeQuery();
                    pst.clearParameters();
                    dateFormat = new SimpleDateFormat("yyyy");

                    if (rs.next()) {
        %>
       <div class="container">
       <h3>Edição de Livros</h3>        
       <form  action="atualizaDB.jsp" method="post">
        <table class="table table-success table-striped">        
              <tr>
                    <td>Id:</td>
                    <td><input class="form-control" type="text" name="id"
                               value="<%= rs.getString("id")%>"
                               readonly="readonly" />
                    </td>
                </tr>
                <tr>
                    <td>Título:</td>
                    <td><input class="form-control" type="text" name="titulo"
                               value="<%= rs.getString("titulo")%>" />
                    </td>
                </tr>
                <tr>
                    <td>Edição:</td>
                    <td><input class="form-control" type="text" name="edicao"
                               value="<%= rs.getString("edicao")%>" />
                    </td>
                </tr>
                <tr>
                    <td>Publicação:</td>
                    <td>
                        <input class="form-control" type="text" name="publicacao"
                               value="<%= rs.getString("publicacao")%>"
                               />
                    </td>
                </tr>
                <tr>
                    <td>Descrição:</td>
                    <td>
                        <textarea class="form-control" name="descricao" cols="50" style= "padding: 24px 127px;" style= "text-align: right;"  >
                            <%= rs.getString("descricao")%></textarea>
                    </td>
                </tr>
                <tr>
                    <td>Selecione a editora:</td>
                    <td><select class="form-control form-control-sm" id="Lista_e" name="select" onchange="carregaEditora()">
                        <% 
                        Statement st = null;
                        ResultSet rs2 = null;
                       
                        st = conn.createStatement();
                        rs2 = st.executeQuery("select idedit, editora from editoras"); 
                        
                        while (rs2.next()) { %>
                        <option value="<%= rs2.getString("idedit")%>">
                          <%= rs2.getString("editora")%>
                        </option>
                        <%} %>
                    </td>
                </tr>
                <tr>
                    <td>idEditora:</td>
                    <td><input class="form-control" id="Edito" type="text" name="idEditora" value="<%= rs.getString("ideditora")%>"/></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input class="btn btn-primary" type="submit" name="btAtualizar" value="Atualizar" />
                        <a class="btn btn-link" href="index.jsp">Voltar </a>
                    </td>
                </tr>
            </table>
        </form>
        </div>            
        <%
                    }//end if
                    else {
                        out.println("Livro não encontrado");
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                } finally {
                    if (pst != null) {
                        pst.close();
                    }
                    if (rs != null) {
                        rs.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                }
            }// end if
        %>
    </body>
</html>
