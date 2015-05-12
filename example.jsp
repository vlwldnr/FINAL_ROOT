<html>
<body>
<%

	@Singleton
	public class SomeBackgroundJob {

	    @PostConstruct
	    @Schedule(hour="0", minute="0", second="3", persistent=false)
	    public void run() {
		printf("HI");
	    }

	}


%>
</body>
</html>
