<%@page import="java.io.*"%>
<% String button = request.getParameter("button"); 
   if(button == null){
     button = "none";
   }%>

<style type="text/css">
	input
 	{
		text-align: right;
	}
</style>

<html>
 	<head><title>First JSP</title></head>
	<body bgcolor="#4863A0">
		<%int i;
		  int count = 1;%>
			
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
		<a href="<%= request.getRequestURI() %>"><h3>Try Again</h3></a>
		<hr>
		<hr>
	        <!--<button onclick="location.href='main.jsp?button=erase'";> Erase Log </button> --!>	
		<br><br> 
	  
	  	<% if(button.equals("erase")) {
	  	try{
			count = 1;
			Runtime r = Runtime.getRuntime();
		   	String msg = "", emsg = "";
		   	String cmd = "/var/lib/tomcat7/webapps/ROOT/erase_log.sh";
		   	Process p = r.exec(cmd);
		   	p.waitFor();
			BufferedReader inOut = new BufferedReader(new InputStreamReader(p.getInputStream()));
 			BufferedReader inErr = new BufferedReader(new InputStreamReader(p.getErrorStream()));
			while((msg = inOut.readLine()) != null)
			{
				out.println("Out = " + msg);
			}
			while ((emsg = inErr.readLine()) != null)
			{
				out.println("Error = "+ emsg);
			}
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
		
		<div style="overflow-y: auto; overflow-x: auto; width: 95% height:70%; background-color:#4963A0; overflow: hidden;">	
	  	<div style="overflow-y: auto; width:41%; height:70%; background-color:#4963A0; float: left;">
	  	<div style="overflow-y: auto; height:85%; padding:10px; margin: 5px;background-color:#ffffff;">
			<table border="1" style="width: 100%">
			<tr align=center>
				<td width="50px">Num</td>
				<td width="200px">LOG</td>
			</tr>
		
			<%while((line = input.readLine()) != null) {%>
			<tr align=center>
				<td><%out.println(count++);%> </td>
				<td><%out.println(line);%> </td>   
			</tr>
	        	<% } %>
	    		</table>
	  	</div>
		<center>
		<form method="POST" action="main.jsp">
  			<input type="hidden" name="button" value="erase"/>
			<input type="submit" name="submit" value="Erase Log" align="center" />
		</form>	
		</center>
		</div>
		<div style="overflow-y:auto; width:50%; height: 70%;margin-left: 45%">
		<center>
		<br>
		<%if(button.equals("on")){%> 
			<img src="http://s30.postimg.org/5dj8kefst/image.jpg"> 
 		<%} else{ %> 
 			<img src="http://s21.postimg.org/d2fc9mpfn/offff.jpg"> 
 		<%}%> 
		<br><br>
 		<form method="POST" action="main.jsp"> 
   			<input type="hidden" name="button" value="on"/> 
 			<input type="submit" name="submit" value="LIGHT ON" /> 
 		</form> 
 		<form method="POST" action="main.jsp"> 
   			<input type="hidden" name="button" value="off"/> 
 			<input type="submit" name="submit" value="LIGHT OFF" /> 
 		</form>
		<br><br>
		<hr>
		<br><br>
		<form method="POST" action="main.jsp"> 
 		&nbsp;	Type your Email address below :  
 			<input type="hidden" name="email" value="email"> 
 			<input type="email" name="email" > 
 			<input type="submit" name="submit" value="Save"> 
 		<br><br><br> 
 		<form method="POST" action="main.jsp"> 
 			Please set your alarm time zone below : <br><br> 
			<select name="start_hour">
				<%for(i=1; i<25;i++){ %>
					<option value="<%=i%>"><%=i%></option>
				<%}%>  
			</select>
 			: 
			<select name="start_min">
				<%for(i=1; i<61;i++){ %>
					<option value="<%=i%>"><%=i%></option>
				<%}%>  
			</select>
 			&nbsp ~ &nbsp 
			<select name="end_hour">
				<%for(i=1; i<25;i++){ %>
					<option value="<%=i%>"><%=i%></option>
				<%}%>  
			</select>
			:
			<select name="end_min">
				<%for(i=1; i<61;i++){ %>
					<option value="<%=i%>"><%=i%></option>
				<%}%>  
			</select>
			<input type="submit" value="SET"> 
		</center>		
		</div>
	  	</div>
		<% 
			out.flush();
			input.close();
	  	%>
		
  	</body>
</html>
