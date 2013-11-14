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

        function resetSize() {
            console.log("resize.");
            Sfdc.canvas.client.resize(sr.client,  {width : "600px", height : "500px"});
        }

        var sr = JSON.parse('${canvasRequestJson}');
        Sfdc.canvas(function() {
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
            <a href="javascript:;" class="tabLink activeLink" id="cont-1">Context</a>
            <a href="javascript:;" class="tabLink " id="cont-2">Resize</a>
            <a href="javascript:;" class="tabLink " id="cont-3">Events</a>
        </div>

        <div class="tabcontent paddingAll" id="cont-1-1">
            This is content box one
        </div>

        <div class="tabcontent paddingAll hide" id="cont-2-1">
            <jsp:include page="resize.jsp"/>
        </div>

        <div class="tabcontent paddingAll hide" id="cont-3-1">
            This is content box Three
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
