<html>
<!DOCTYPE html>
<html>
<head>
    <title>Force.com Canvas Java Quick Start</title>

    <link rel="stylesheet" type="text/css" href="/default/default.css" />
    <link rel="stylesheet" type="text/css" href="/default/tabs.css" />

    <script type="text/javascript" src="/scripts/json2.js"></script>
    <script type="text/javascript" src="/sdk/js/canvas-all.js"></script>
    <script type="text/javascript" src="/default/tabs.js"></script>

    <script>
        function resetSize(newDimensions) {
        	var options = newDimensions ? newDimensions : {};
            console.log("resize.");
            Sfdc.canvas.client.resize(sr.client,  {
            	width : options.width?options.width:"600px", 
      			height : options.height?options.height:"600px"
			});
        }

        var sr = JSON.parse('${canvasRequestJson}');
        Sfdc.canvas(function() {
            var photoUri = sr.context.user.profileThumbnailUrl +  "?oauth_token=" + sr.client.oauthToken;
            Sfdc.canvas.byId('header').style.backgroundImage =  "url('"+(photoUri.indexOf("http")==0 ? "" :sr.client.instanceUrl) + photoUri+"')";
            resetSize();
            initTabs();
        });
    </script>

</head>
<body>
    <div id="content">
        <div id="header">
            <h1>Hello <span id='fullname'>${canvasRequest.context.userContext.fullName}</span>!</h1>
            <h2>Welcome to the Force.com Canvas Java Quick Start Template!</h2>
        </div>

        <div class="tab-box">
            <a href="javascript:;" onclick="resetSize()" class="tabLink activeLink" id="context">Context</a>
            <a href="javascript:;" onclick="resetSize()" class="tabLink " id="resize">Resize</a>
            <a href="javascript:;" onclick="resetSize()" class="tabLink " id="events">Events</a>
            <a href="javascript:;" onclick="resetSize()" class="tabLink " id="scroll">Scrolling</a>
        </div>

        <div class="tabcontent paddingAll" id="context-1">
            <jsp:include page="context.jsp"/>
        </div>

        <div class="tabcontent paddingAll hide" id="resize-1">
            <jsp:include page="resize.jsp"/>
        </div>

        <div class="tabcontent paddingAll hide" id="events-1">
            <jsp:include page="events.jsp"/>
        </div>
        <div class="tabcontent paddingAll hide" id="scroll-1">
            <jsp:include page="scroll.jsp"/>
        </div>
        <div id="footercont">
            <div id="footerleft">
                <p>Powered By: <a title="Heroku" href="#" onclick="window.top.location.href='http://www.heroku.com'"><strong>Heroku</strong></a>
                </p>
            </div>
            <div id="footerright">
                <p>Salesforce: <a title="Safe Harbor" href="http://www.salesforce.com/company/investor/safe_harbor.jsp"><strong>SafeHarbor</strong></a>
                </p>
            </div>
        </div>
    </div>
</body>
</html>
