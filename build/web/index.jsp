<%@ page contentType="text/html"  import= "java.sql.*"%>
<jsp:include page="bootstrap.html" />

<!DOCTYPE HTML>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Conectando sua aplica??o JSP ao MySQL via JDBC</title>
        <script>
    //fun??o para carregar valores do bd tabela EDITORA
    function carregaEditora() {
      var select_c = document.getElementById("Lista_e").value;
      document.getElementById("Edito").value = select_c;
    }
  </script>
    </head>
    <body>
        <div class="container">
        <h2>UESC - Programa??o para Aplica??es Web</h2>
        <h3>Sistema de Cadastro de Livros em JAVA EE (JSP) - 1 tabela</h3>    
        <form action="inserindoDados.jsp" method="post">
           <table class="table table-success table-striped">
                <tr>
                    <td>T?tulo:</td>
                    <td><input class="form-control" type="text"name="titulo"/></td>
                </tr>
                <tr>
                    <td>Edi??o:</td>
                    <td><input class="form-control" type="text"name="edicao"/></td>
                </tr>
                <tr>
                    <td>Publica??o:</td>
                    <td><input class="form-control" type="text"name="publicacao"/></td>
                </tr>
                <tr>
                    <td>Descri??o:</td>
                    <td><textarea class="form-control" name="descricao"rows="5"cols="25"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>Selecione a editora:</td>
                    <td><select class="form-control form-control-sm" id="Lista_e" name="select" onchange="carregaEditora()">
                        <% 
                        Connection conn = null;
                        Statement st = null;
                        ResultSet rs = null;
                        
                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/livraria", "root", "");
                        st = conn.createStatement();
                        rs = st.executeQuery("select idedit, editora from editoras"); 
                        
                        while (rs.next()) { %>
                        <option value="<%= rs.getString("idedit")%>">
                          <%= rs.getString("editora")%>
                        </option>
                        <%} %>
                    </td>
                </tr>
                <tr>
                    <td>idEditora:</td>
                    <td><input class="form-control" id="Edito" type="text" name="idEditora"/></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input class="btn btn-primary" type="submit" name="btCadastrar" value="Inserir"/>
                    </td>
                </tr>
            </table >
        </form>
        </div>   
        <p> </p>
        <div class="container">
        <table class="table table-success table-striped" border="1" >
            <thead>
                <tr>
                    <th> Id </th>
                    <th> T?tulo </th>
                    <th> Edi??o </th>
                    <th> Publica??o </th>
                    <th> Descri??o </th>
                    <th> Editora </th>
                    <th> Excluir </th>
                    <th> Atualiza??o</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Statement st2 = null;
                    ResultSet rs2 = null;
                    String editora = "";
                    try {
//                        Class.forName("com.mysql.jdbc.Driver").newInstance();
//                        Class.forName("com.mysql.jdbc.Driver").newInstance();
//                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/livraria", "root", "");
                        st = conn.createStatement();
                        rs = st.executeQuery("select id, titulo,edicao,publicacao,descricao, ideditora from livros");                 
//                        rs2 = st2.executeQuery("select editora from editoras where idedit = ", rs.getString("ideditora"));                     
                        while (rs.next()) {
                            st = conn.createStatement();
                            rs2 = st.executeQuery("select editora from editoras where idedit = " + rs.getString("ideditora"));
                            while(rs2.next()){
                                editora = rs2.getString("editora");
                                break;
                            }
                            
                %>
                <tr>
                    <td> <%= rs.getString("id")%>   </td>
                    <td> <%= rs.getString("titulo")%> </td>
                    <td> <%= rs.getString("edicao")%> </td>
                    <td> <%= rs.getString("publicacao")%> </td>
                    <td> <%= rs.getString("descricao")%> </td>
                    <td> <%= editora %> </td>
                    <td>
                        <a onclick="return confirm('Tem certeza da remo??o do Livro: '+'<%=  rs.getString("id") %>' + ', ' + '<%=  rs.getString("titulo") %>') "  
                             href="excluindoDB.jsp?id=<%=rs.getString("id")%>" class="btn btn-success btn-sm">
                            Excluir
                        </a>
                    </td>
                    <td>
                        <a  href="atDB.jsp?id=<%=rs.getString("id")%>" class="btn btn-info btn-sm">    
                            Editar    
                        </a>
                    </td>
                </tr>
                <%
                        }
                //end while
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    } finally {
                        if (rs != null) {
                            rs.close();
                        }
                        if (st != null) {
                            st.close();
                        }
                        if (conn != null) {
                            conn.close();
                        }
                    }
                %>
            </tbody>
        </table>
        </div>    
        <p> </p>
    </body>
</html>
