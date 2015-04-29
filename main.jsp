<%@page import="java.io.*"%>
<% String button = request.getParameter("button"); 
   if(button == null){
     button = "none";
   }%>

<html>
 	<head><title>First JSP</title></head>
	<body bgcolor="#4863A0">
		<%! int count = 1; %>
		<% double num = Math.random();
		   if (num > 0.95) {  %>
		      <h2>You'll have a luck day!</h2><p>(<%= num %>)</p>
		<%
		    } else {
		%>
		      <h2>Well, life goes on ... </h2><p>(<%= num %>)</p>
		<%
		    }
		%>
		<hr>
		<hr>
	        <button onclick="location.href='main.jsp?button=erase'";> Erase Log </button>	
		<!-- <input type=submit value="Erase Log" onclick="eraseLog()"/>
	  
	  	<script language="JavaScript">
	  	function eraseLog(){
	  		document.forms["myForm"].action = "main.jsp?button=erase"
	  	}
		</script>
	        !-->
		<a href="<%= request.getRequestURI() %>"><h3>Try Again</h3></a>
		<br><br> 
	  
	  	<% if(button.equals("erase")) {
	  	try{
			Runtime r = Runtime.getRuntime();
		   	String msg = "", emsg = "";
		   	String cmd = "/var/lib/tomcat7/webapps/ROOT/button.sh";
		   	Process p = r.exec(cmd);
		   	p.waitFor();
		   	p.destroy();
			out.println("-" + button + "-");
	  	} catch (Exception e){
	  		out.println(e.toString());
	  	}
                }else { out.println("HI [" + button + " ]");}

	        %>
  		 
		<% 
		BufferedReader input = new BufferedReader (new FileReader ("/home/pi/libcoap-4.1.1/examples/output.txt"));
		String line = "";
		%>
	
	  	<div style="overflow-y: auto; width:41%; height:70%; position:absolute;background-color:white;">
	  	<div style="overflow-y: auto; padding:10px; margin: 5px;">
			<table border="1" style="width: 100%">
			<tr align=center>
				<td width="50px">Num</td>
				<td width="200px">LOG</td>
			</tr>
		
			<%while((line = input.readLine()) != null) {%>
			<tr align=center>
				<td> 1 </td>
				<td><%out.println(line);%> </td>   
			</tr>
	        	<% } %>
	    		</table>
	  	</div>
	  	</div>
	  	<% 
			out.flush();
			input.close();
	  	%>

  	</body>
</html>
