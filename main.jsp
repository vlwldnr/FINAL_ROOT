<%@page import="java.io.*"%>
<%! String sensor; 
    String prev_state;
    int start_hour = 0;
    int start_min = 0;
    int end_hour = 0;
    int end_min = 0;
    int sensor_counter = 0;
    int last_entry = 0;
    int prev_entry = 0;
    int log_hour;
    int log_min;
    char[] log_hour_buf = new char[3];
    char[] log_min_buf = new char[3];
    String temp_buf;

%>


<br>
<% prev_state = request.getParameter("sensor");
   if(prev_state == null && sensor == null){ 
	sensor = "disable";
   }else if(prev_state != null){  
	sensor = prev_state;
   }

   String button = request.getParameter("button"); 
   if(button == null){
   	button = "none";
   }

   String temp_start_hour = request.getParameter("start_hour");
   String temp_start_min = request.getParameter("start_min");
   String temp_end_hour = request.getParameter("end_hour");
   String temp_end_min = request.getParameter("end_min");
	

%>

<html>
 	<head>
		<title>Door To IoT... DoIT..!</title>
		<link rel="stylesheet" type="text/css" href="main.css">
		<META HTTP-EQUIV="refresh" CONTENT="19">
	</head>
	<body bgcolor="#4863A0">
		<%int i;
		  int count = 1;%>
		<center>
		<img src="http://s3.postimg.org/gfthfiwsz/Do_IT.png" height="150" width="320" id="logo"> 
		<p id="header">
			Door To IoT
		</p>
		</center>
		<hr class="type1">
	  	<% if(button.equals("erase")) {
	  	try{
			count = 1;
			prev_entry = 0;
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
                }else { out.println("HI [" + button + " ], [" + sensor + "]");
		
		}

	        %>
  		 
		<% 
		BufferedReader input = new BufferedReader (new FileReader ("/home/pi/libcoap-4.1.1/examples/output.txt"));
		String line = "";
		%>
		
		<div id="outer">	
	  	<div id="inner_left">
	  	<div id="inner_log">
			<table border="1" id="log_table">
			<tr align=center>
				<td width="50px">Num</td>
				<td width="200px">LOG</td>
			</tr>
		
			<%while((line = input.readLine()) != null) {%>
			<tr align=center>
				<td><%out.println(count++);%> </td>
				<td><%out.println(line);%> </td>  
				<%
					temp_buf = line;
				%>
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

		<div id="inner_right">
		<br>
		<center>
		<%if(button.equals("on")){%> 
			<img src="http://s30.postimg.org/5dj8kefst/image.jpg" id="light"> 
 		<%} else{ %> 
 			<img src="http://s21.postimg.org/d2fc9mpfn/offff.jpg" id="light"> 
 		<%}%> 
 		<form class="sensor_button" method="POST" action="main.jsp"> 
   			<input type="hidden" name="sensor" value="enable"/> 
 			<input id="enable" type="submit" name="submit" value="ENABLE" /> 
 		</form> 
 		<form class="sensor_button" method="POST" action="main.jsp"> 
   			<input type="hidden" name="sensor" value="disable"/> 
 			<input id="disable" type="submit" name="submit" value="DISABLE" /> 
 		</form> 
		<br><br>
 		<form class="light_button" method="POST" action="main.jsp"> 
   			<input type="hidden" name="button" value="on"/> 
 			<input id="light_on" type="submit" name="submit" value="LIGHT ON" /> 
 		</form> 
 		<form class="light_button" method="POST" action="main.jsp"> 
   			<input type="hidden" name="button" value="off"/> 
 			<input id="light_off" type="submit" name="submit" value="LIGHT OFF" /> 
 		</form>
		</center>
		<br><br><br><br><br>
		<center>
		<hr class="type2">
		<br>
		<form method="POST" action="main.jsp"> 
 		&nbsp;	Type your E-mail address:  
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

			<% 
			
			if(temp_start_hour != null && temp_start_min != null && temp_end_hour != null && temp_end_min != null){
				start_hour = Integer.parseInt(temp_start_hour); 
				start_min = Integer.parseInt(temp_start_min); 
				end_hour = Integer.parseInt(temp_end_hour); 
				end_min = Integer.parseInt(temp_end_min);
 			}

			/* TIME ZONE SETTINGS  */

			last_entry = count - 1;
			if(last_entry > prev_entry){
				prev_entry = last_entry;
				out.println("last entry " + temp_buf + "\n");
				temp_buf.getChars(11, 13, log_hour_buf, 0); 	
				temp_buf.getChars(14, 16, log_min_buf, 0);
				log_hour = Integer.parseInt((String.valueOf(log_hour_buf)).trim());
				log_min = Integer.parseInt((String.valueOf(log_min_buf)).trim());

				/* COMPARE WITH TIME ZONE SETTING */
				if(start_hour != 0 && start_min != 0 && end_hour != 0 && end_min != 0){
					if(log_hour > start_hour){	
						if(log_hour < end_hour)
							out.println("ALARM!");
						else if(log_hour == end_hour && log_min <= end_min)
							out.println("ALARM!");			
					}else if(log_hour == start_hour){
						if(log_min >= start_min){
							if(log_hour < end_hour)
								out.println("ALARM!");
							if(log_hour == end_hour && log_min <= end_min)
									out.println("ALARM!");
						}
					}	
				}
			}
			out.println("temp_buf: " + temp_buf + "    ");
			out.println("log_hour: " + String.valueOf(log_hour_buf) + "    ");
			out.println("log_min: " + String.valueOf(log_min_buf) + "    ");
			out.println("last_entry: " + last_entry  + "     "); 
			out.println("prev_entry: " + prev_entry + "\n"); 
			
			%>
		</center>		
		</div>
	  	</div>
		<% 
		    	if(sensor.equals("disable")){
				if(sensor_counter > 0){
					sensor_counter = 0;
				}
				sensor_counter--;
			}else{
				if(sensor_counter < 0){
					sensor_counter = 0;
				}
				sensor_counter++;
			}
			if(sensor.equals("enable") && sensor_counter == 1){
	  			try{
					Runtime r2 = Runtime.getRuntime();
		   			String cmd2 = "/var/lib/tomcat7/webapps/ROOT/get_enable.sh";
		   			Process p2 = r2.exec(cmd2);
		  	 		p2.waitFor();
		   			p2.destroy();
				} catch (Exception e){
	  				out.println(e.toString());
				}
				out.println("STARTING get command\n"); 
			}
		    	if(sensor.equals("disable") && sensor_counter == -1){
	  			try{
					Runtime r3 = Runtime.getRuntime();
		   			String cmd3 = "/var/lib/tomcat7/webapps/ROOT/get_disable.sh";
		   			Process p3 = r3.exec(cmd3);
		  	 		p3.waitFor();
		   			p3.destroy();
				} catch (Exception e){
	  				out.println(e.toString());
				}
				out.println("STOPPING get command\n"); 
			}
		    	out.flush();
		    	input.close();
	  	%>
		
  	</body>
</html>
