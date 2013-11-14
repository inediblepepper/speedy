<html>
<!DOCTYPE html>
<html>
<head>
    <title>Force.com Canvas Java Quick Start</title>

    <link rel="stylesheet" type="text/css" href="/default/default.css" />
    <link rel="stylesheet" type="text/css" href="/default/tabs.css" />

    <script type="text/javascript" src="/scripts/json2.js"></script>
    <script type="text/javascript" src="/sdk/js/canvas-all.js"></script>

    <script>
        function resetSize() {
            console.log("resize");
            Sfdc.canvas.client.resize(sr.client,  {width : "600px", height : "500px"});
        }

        var sr = JSON.parse('${canvasRequestJson}');
        Sfdc.canvas(function() {
            resetSize();
        });
    </script>

</head>
<body>
    <div id="content">
        <div id="header">
            <h1>Hello <span id='fullname'>${canvasRequest.context.userContext.fullName}</span>!</h1>
            <h2>Welcome to the Force.com Canvas Java Quick Start Template!</h2>
        </div>
        <div class="tabbed-area">
            <ul class="tabs group">
                <li><a href="#box-one">Context</a></li>
                <li><a href="#box-two" onclick='resetResize()'>Resize</a></li>
                <li><a href="#box-three">Events</a></li>
            </ul>
            <div class="box-wrap">
                <div id="box-one" onclick='resetResize()'>
                    box one content
                </div>
                <div id="box-two" onclick='resetResize()'>
                    <jsp:include page="resize.jsp"/>
                </div>
                <div id="box-three" onclick='resetResize()'>
                    box three content
                </div>
            </div>
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
