<script type="text/javascript">

if(!String.prototype.startsWith){
    String.prototype.startsWith = function (str) {
        return !this.indexOf(str);
    }
}
var subscriptions = [];

function eventHandler(eventName, payload){
	var data,logger = document.getElementById('event-log');
	data = Sfdc.canvas.isObject(payload) ? JSON.stringify(payload) : payload;
    if(logger){
        logger.value += "Received '" + eventName + "': " + data + '\n';
    }
}

Sfdc.canvas.onReady(function() {
	subscribe("${canvasRequest.context.appContext.namespace}_${canvasRequest.context.appContext.devName}.eventFired");
});

function subscribe(eventName){
	var name,params={},streaming;
	if (eventName){
		if (eventName.startsWith("sfdc.streamingapi")){
			streaming = getStreaming(eventName);
			name = streaming.event;
			params = streaming.params;
		}
		else{
			name = eventName;
		}
		Sfdc.canvas.client.subscribe(sr.client, [{
			name: name,
			params:params,
			onData: function(payload){
				eventHandler(eventName,payload);
			}
		}]);
		if (Sfdc.canvas.indexOf(subscriptions,eventName) < 0){
			subscriptions[subscriptions.length] = eventName;
			subscriptions.sort();
		}
	}
	updateSubscriptions();
}

function fire(){
	var payload = document.getElementById('event-payload');
	if (payload){
		Sfdc.canvas.client.publish(sr.client,{
			name : "${canvasRequest.context.appContext.namespace}_${canvasRequest.context.appContext.devName}.eventFired", 
			payload : payload.value
		});
		payload.value="";
	}
    return true;
}

function getStreaming(eventName){
	var streaming = eventName.split(":");
	return {
		event:streaming[0],
		params:streaming.length>1? {topic:streaming[1]}: null
	};
	

}

function unsubscribe(eventName) {
	var index,params={},streaming,name;
	if(eventName){
		if (eventName.startsWith("sfdc.streamingapi")){
			streaming = getStreaming(eventName);
			name = streaming.event;
			params = streaming.params;
		}
		else{
			name = eventName;
		}
	    Sfdc.canvas.client.unsubscribe(sr.client, {name:name,params:params});
	    index = Sfdc.canvas.indexOf(subscriptions,eventName);
	    if (index >= 0){
	    	subscriptions.splice(index,1);
	    }
	    updateSubscriptions();
	}
    return false;
}

function updateSubscriptions(){
	var subs = document.getElementById("subscriptions"),
	html="",name;
	if (subs){
		for (index in subscriptions){
			name = subscriptions[index]; 
			html+= name + " <a href=\"#events\" onclick=\"unsubscribe('"+name+"');\">Remove</a><br/>"
		}
	}
	subs.innerHTML = html;
}

function clearLog(){
	document.getElementById('event-log').value="";
	return false;
}
</script>

<p>
Force.com Canvas supports cross-domain eventing between multiple canvas applications.  Give it a try... Type in some text and click "Fire!"
to see the event subscription in action! 
</p>
<p>
You can also subscribe to custom or other Force.com Canvas events.  Enter the event name and click "Subscribe".  Streaming api event names should
look be in the form <b><code>sfdc.streamingapi:/topics/somecustomtopic</code></b>
</p>
<table  id="event-table" border="0"  width="100%" height="100%" style="text-align:left; ">
    <tr height="15%">
      <td valign="top" width="30%"><b>Enter event text to send:</b></td>
      <td width="60%"><span><input id="event-payload" type="text"/></span></td>
      <td width="*"><input onclick="fire();" type="submit" value="Fire!"></input></td>
    </tr>
    <tr height="35%">
      <td valign="top"><b>Subscribe to event:</b></td>
      <td width="60%"><span><input id="new-topic" type="text"/></span></td>
      <td width="*"><input onclick="subscribe(document.getElementById('new-topic').value);document.getElementById('new-topic').value='';" type="submit" value="Subscribe"></input></td>
    </tr>
    <tr height="35%">
      <td valign="top"><b>Current subscriptions:</b></td>
      <td colspan="2" width="60%"><span id="subscriptions"></span></td>
    </tr>
    <tr height="*">
      <td valign="top"><b>Event Log: </b>(<a href="#events" onclick="clearLog();">Clear</a>)</td>
      <td colspan="2" width="60%"><span><textarea wrap="off" rows="10" name="event-log" id="event-log" readonly="true"></textarea></span></td>
    </tr>
</table>
