<%@ page contentType="text/html"  import= "java.sql.*"%>
<jsp:include page="bootstrap.html" />

<!DOCTYPE HTML>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Conectando sua aplicação JSP ao MySQL via JDBC</title>
    </head>
    <body>
        <div class="container">
        <h2>UESC - Programação para Aplicações Web</h2>
        <h3>Sistema de Cadastro de Livros em JAVA EE (JSP) - 1 tabela</h3>    
        <form action="inserindoDados.jsp" method="post">
           <table class="table table-success table-striped">
                <tr>
                    <td>Título:</td>
                    <td><input class="form-control" type="text"name="titulo"/></td>
                </tr>
                <tr>
                    <td>Edição:</td>
                    <td><input class="form-control" type="text"name="edicao"/></td>
                </tr>
                <tr>
                    <td>Publicação:</td>
                    <td><input class="form-control" type="text"name="publicacao"/></td>
                </tr>
                <tr>
                    <td>Descrição:</td>
                    <td><textarea class="form-control" name="descricao"rows="5"cols="25"></textarea>
                    </td>
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
                    <th> Título </th>
                    <th> Edição </th>
                    <th> Publicação </th>
                    <th> Descrição </th>
                    <th> Excluir </th>
                    <th> Atualização</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    Statement st = null;
                    ResultSet rs = null;
                    try {
//                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/livraria", "root", "");
                        st = conn.createStatement();
                        rs = st.executeQuery("select id, titulo,edicao,publicacao,descricao from livros");
                        while (rs.next()) {
                %>
                <tr>
                    <td> <%= rs.getString("id")%>   </td>
                    <td> <%= rs.getString("titulo")%> </td>
                    <td> <%= rs.getString("edicao")%> </td>
                    <td> <%= rs.getString("publicacao")%> </td>
                    <td> <%= rs.getString("descricao")%> </td>
                    <td>
                        <a onclick="return confirm('Tem certeza da remoção do Livro: '+'<%=  rs.getString("id") %>' + ', ' + '<%=  rs.getString("titulo") %>') "  
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
