<%@page import="java.io.*"%>
<% String button = request.getParameter("button"); 
   if(button == null){
     button = "none";
   }%>

<html>
 	<head><title>First JSP</title></head>
	<body bgcolor="#4863A0">
		<%! int count = 1; %>
		<hr>
		<hr>
	        <button onclick="location.href='main.jsp?button=erase'";> Erase Log </button>	
		<br><br> 
	  
	  	<% if(button.equals("erase")) {
	  	try{
			Runtime r = Runtime.getRuntime();
		   	String msg = "", emsg = "";
		   	String cmd = "sh /var/lib/tomcat7/webapps/ROOT/button.sh";
		   	Process p = r.exec(cmd);
		   	p.waitFor();
		   	p.destroy();
			out.println("-" + button + "-");
	  	} catch (Exception e){
	  		out.println(e.toString());
	  	}
                }else if(button.equals("on")){
                try{
			Runtime r = Runtime.getRuntime();
		   	String msg = "", emsg = "";
		   	String cmd = "sh /var/lib/tomcat7/webapps/ROOT/led_on.sh";
		   	Process p = r.exec(cmd);
		   	p.waitFor();
		   	p.destroy();
			out.println("-" + button + "-");
	  	} catch (Exception e){
	  		out.println(e.toString());
	  	}
           
                }else if(button.equals("off")){
           	try{
			Runtime r = Runtime.getRuntime();
		   	String msg = "", emsg = "";
		   	String cmd = "sh /var/lib/tomcat7/webapps/ROOT/led_off.sh";
		   	Process p = r.exec(cmd);
		   	p.waitFor();
		   	p.destroy();
			out.println("-" + button + "-");
	  	} catch (Exception e){
	  		out.println(e.toString());
	  	}     
                
                
                }else{ out.println("HI [" + button + " ]");}

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
