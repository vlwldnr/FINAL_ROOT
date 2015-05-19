<%@page import="java.io.*"%>
<%!
String sensor;
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
String email;
String user;
Boolean mail_flag = true;
%>

<%!
public void sendMail()
{
	try{
		String path = "/var/lib/tomcat7/webapps/ROOT/send_email.sh ";
		String cmd_ = "sh " + path + temp_buf + " " + email ;
		Process pp = Runtime.getRuntime().exec(cmd_);
		System.out.println(cmd_);
		pp.waitFor();
		pp.destroy();
	} catch (Exception e){
		System.out.println(e.toString());
	}
}
%>

<br>

	<%
	prev_state = request.getParameter("sensor");

	if(prev_state == null && sensor == null){
		sensor = "disable";
	} else if(prev_state != null) {
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
	String email_t = request.getParameter("email");
	if(email_t != null){
		email = email_t;
	}
	String user_t = request.getParameter("user");
	if(user_t != null){
		user = user_t;
	}

	%>

	<html>
		<head>
			<title>Door To IoT... DoIT..!</title>
			<link rel="stylesheet" type="text/css" href="main.css">
				<META HTTP-EQUIV="refresh" CONTENT="19">
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
				</head>
				<body>
					<%int i;
					int count = 1;%>
					<center>
					<div id="header">
						<img src="http://s3.postimg.org/gfthfiwsz/Do_IT.png" height="150" width="320" id="logo">
							<p id="header">
								Door To IoT
								<% if(user != null) {%>
									<h2><p class="bg-success"> Welcome back <%=user%>!</p><h2>
								<% } if(email != null) { %>
									<h2><p class="bg-info"><small> Your current e-mail address is <%=email%>.</small></p></h2>
								<% } %>
							</p>
						</center>
						<hr class="type1">
							<%
							if(button.equals("erase")) {
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
								} catch (Exception e) {
									out.println(e.toString());
								}
						}
						%>

						<%
							BufferedReader input = new BufferedReader (new FileReader ("/home/pi/libcoap-4.1.1/examples/output.txt"));
							String line = "";
						%>
						</div>
							<div id="outer">
								<div id="inner_left">
									<div id="inner_log">
										<table class="table table-striped" border="1" id="log_table">
											<tr align=center>
												<td width="50px">Num</td>
												<td width="200px">LOG</td>
											</tr>

											<% while((line = input.readLine()) != null) { %>
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
											<input class="btn btn-warning" type="submit" name="submit" value="Erase Log" align="center" />
										</form>
									</center>
								</div>

								<div id="inner_right">
									<p id="en_dis">
										<% if(sensor.equals("enable")){ %>
										Enable <input class="onoff_en" type="checkbox" disabled="disabled" checked="checked">
										&nbsp&nbsp
										&nbsp&nbsp
										Disable <input class="onoff_dis" type="checkbox" disabled="disabled">
										<% }else{ %>
										Enable <input class="onoff_en" type="checkbox" disabled="disabled">
										&nbsp&nbsp
										&nbsp&nbsp
										Disable <input class="onoff_dis" type="checkbox" disabled="disabled" checked="checked">
										<% } %>

								</p>
									<center>

										<%if(button.equals("on")){%>
										<img src="http://s30.postimg.org/5dj8kefst/image.jpg" id="light" class="img-rounded">
											<%} else{ %>
											<img src="http://s21.postimg.org/d2fc9mpfn/offff.jpg" id="light" class="img-rounded">
												<%}%>
												<form class="sensor_button" method="POST" action="main.jsp">
													<input type="hidden" name="sensor" value="enable"/>
													<input class="btn btn-default btn-lg btn-block" id="enable" type="submit" name="submit" value="ENABLE" />
												</form>

												<form class="sensor_button" method="POST" action="main.jsp">
													<input type="hidden" name="sensor" value="disable"/>
													<input class="btn btn-default btn-lg btn-block" id="disable" type="submit" name="submit" value="DISABLE" />
												</form>
												<br><br>
													<form class="light_button" method="POST" action="main.jsp">
														<input type="hidden" name="button" value="on"/>
														<input class="btn btn-default" id="light_on" type="submit" name="submit" value="LIGHT ON" />
													</form>
													<form class="light_button" method="POST" action="main.jsp">
														<input type="hidden" name="button" value="off"/>
														<input class="btn btn-default" id="light_off" type="submit" name="submit" value="LIGHT OFF" />
													</form>
												</center>
												<br><br><br>
													<center>
														<hr class="type2">
															<form class="form-inline" method="POST" action="main.jsp">
													 			<div class="form-group">
																	<label for="InputUser"> Name </label>
																	<input type="text" class="form-control" id="InputUser" placeholder="Jane Doe" name="user">
																</div>
																&nbsp&nbsp
																<div class="form-group">
																	<label for="InputEmail">E-mail</label>
																	<input type="email" class="form-control" id="InputEmail" placeholder="jane.doe@example.com" name="email">
																</div>
																&nbsp<button type="submit" class="btn btn-default">Set E-mail </button>
															<!--Type your E-mail address:
													  			<input type="hidden" name="email_s" value="email_s">
													  			<input type="email" name="email" >
													  			<input type="submit" name="submit" value="Save">
															-->
																			</form>
																			<br>
																				<form method="POST" action="main.jsp">
																					Please set your alarm time zone below : <br><br>
																					<select name="start_hour">
																						<%for(i=1; i<25;i++){ %>
																						<option value="<%=i%>"><%=i%></option>
																						<%}%>
																					</select>
																					:
																					<select name="start_min">
																						<%for(i=0; i<61;i++){ %>
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
																						<%for(i=0; i<61;i++){ %>
																						<option value="<%=i%>"><%=i%></option>
																						<%}%>
																					</select>
																					<input type="submit" value="SET">
																					&nbsp&nbsp
																					<input class="btn btn-info" type="submit" value="SET">

																						<%

																						if(temp_start_hour != null && temp_start_min != null && temp_end_hour != null && temp_end_min != null){
																							start_hour = Integer.parseInt(temp_start_hour);
																							start_min = Integer.parseInt(temp_start_min);
																							end_hour = Integer.parseInt(temp_end_hour);
																							end_min = Integer.parseInt(temp_end_min);
																						}

																						/* TIME ZONE SETTINGS  */
							                              last_entry = count - 1;
																						//out.println("last_entry: " + last_entry  + "     ");
																						//out.println("prev_entry: " + prev_entry + "\n");
																						if(last_entry > prev_entry){
																							prev_entry = last_entry;
																							temp_buf.getChars(11, 13, log_hour_buf, 0);
																							temp_buf.getChars(14, 16, log_min_buf, 0);
																							log_hour = Integer.parseInt((String.valueOf(log_hour_buf)).trim());
																							log_min = Integer.parseInt((String.valueOf(log_min_buf)).trim());

																							/* COMPARE WITH TIME ZONE SETTING */
																							// Works with start hour, end hour, email.
																							if(start_hour != 0 && end_hour != 0 && email != null){
																								// end_hour doesn't pass day
																								if(start_hour <= end_hour){
																									// log_hour is passed start_hour
																									if(log_hour > start_hour){
																										// log_hour is is in range
																										if(log_hour < end_hour){
																											if(mail_flag){
																												sendMail();
																												out.println("ALARM!");
																												mail_flag = false; // Detected and Mail triggered, sleep until this period end.
																											}
																										}
																										// Same hour
																										else if(log_hour == end_hour && log_min <= end_min){
																											sendMail();
																											out.println("ALARM!");
																										} else {
																											// Not in ALARM Condition, reset flag for further alarm op.
																											// This condition should never happened
																											mail_flag = true;
																										}
																									} else if(log_hour == start_hour) {
																										if(log_min >= start_min){
																											if(log_hour < end_hour){
																												if(mail_flag){
																													sendMail();
																													out.println("ALARM!");
																													mail_flag = false; // Detected and Mail triggered, sleep until this period end.
																												}
																											}
																											else if(log_hour == end_hour && log_min <= end_min){
																												if(mail_flag){
																													sendMail();
																													out.println("ALARM!");
																													mail_flag = false; // Detected and Mail triggered, sleep until this period end.
																												}
																											} else {
																												// Not in ALARM Condition, reset flag for further alarm op.
																												mail_flag = true;
																											}
																										}
																									}
																								}
																								// Example: 18:00 to 02:00 next day
																								else if(start_hour > end_hour){
																									if(log_hour > start_hour){
																										if(mail_flag){
																											sendMail();
																											out.println("ALARM!");
																											mail_flag = false; // Detected and Mail triggered, sleep until this period end.
																										}
																									}	else if(log_hour < end_hour){
																										if(mail_flag){
																											sendMail();
																											out.println("ALARM!");
																											mail_flag = false; // Detected and Mail triggered, sleep until this period end.
																										}
																									} else if(log_hour == start_hour && log_min >= start_min){
																										if(mail_flag){
																											sendMail();
																											out.println("ALARM!");
																											mail_flag = false; // Detected and Mail triggered, sleep until this period end.
																										}
																									} else if(log_hour == end_hour && log_min <= end_min){
																										if(mail_flag){
																											sendMail();
																											out.println("ALARM!");
																											mail_flag = false; // Detected and Mail triggered, sleep until this period end.
																										}
																									} else {
																										// Not in ALARM Condition, reset flag for further alarm op.
																										mail_flag = true;
																									}
																								}
																							}
																						}

																						/*out.println("temp_buf: " + temp_buf + "    ");
																						out.println("log_hour: " + String.valueOf(log_hour_buf) + "    ");
																						out.println("log_min: " + String.valueOf(log_min_buf) + "    ");
																						out.println("start_hour : "+start_hour + "  ");
																						out.println("end_hour : " + end_hour + "  ");*/
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
																			// Checks only when mail_flag is true
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
																				//out.println("STARTING get command\n");
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
																				//out.println("STOPPING get command\n");
																			}
																			if(button.equals("on")){
																				try{
																					Runtime r4 = Runtime.getRuntime();
																					String cmd4 = "/var/lib/tomcat7/webapps/ROOT/light_on.sh";
																					Process p4 = r4.exec(cmd4);
																					p4.waitFor();
																					p4.destroy();
																				} catch (Exception e){
																					out.println(e.toString());
																				}
																			}
																			if(button.equals("off")){
																				try{
																					Runtime r5 = Runtime.getRuntime();
																					String cmd5 = "/var/lib/tomcat7/webapps/ROOT/light_off.sh";
																					Process p5 = r5.exec(cmd5);
																					p5.waitFor();
																					p5.destroy();
																				} catch (Exception e){
																					out.println(e.toString());
																				}
																			}
																			out.flush();
																			input.close();
																			%>
																		</body>
																	</html>
