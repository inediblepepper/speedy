/**
*@namespace Sfdc.canvas.client
*@name Sfdc.canvas.client
*/
(function ($$) {

    "use strict";

    var pversion, cversion = "27.0", loaded = false;

    var module =   (function() /**@lends module */ {
        
        var purl, cbs = [], seq = 0;
        /**
        * @description
        * @function
        * @returns The url of the Parent Window
        */
        function getParentUrl() {
            // This relies on the parent passing it in. If it doesn't we can still recover.
            if (purl) {return purl;}
            var h = document.location.hash;
            if (h) {
                h = decodeURIComponent(h.replace(/^#/, ''));
                purl = (h.substring(0, 4) === "http") ? h : null;
            }
            return purl;
        }

        function callbacker(data) {
            if (data) {
                // If the server is telling us the access_token is invalid, wipe it clean.
                if (data.status === 401 &&
                    $$.isArray(data.payload) &&
                    data.payload[0].errorCode &&
                    data.payload[0].errorCode === "INVALID_SESSION_ID") {
                    // Session has expired logout.
                    $$.oauth.logout();
                }
                if ($$.isFunction(cbs[data.seq])) {
                    cbs[data.seq](data);
                }
                else {
                    // This can happen when the user switches out canvas apps real quick,
                    // before the request from the last canvas app have finish processing.
                    // We will ignore any of these results as the canvas app is no longer active to
                    // respond to the results.
                }
            }
        }

        function postit(clientscb, message) {
            // need to keep a mapping from request to callback, otherwise
            // wrong callbacks get called. Unfortunately, this is the only
            // way to handle this as postMessage acts more like topic/queue.
            // limit the sequencers to 100 avoid out of memory errors
            seq = (seq > 100) ? 0 : seq + 1;
            cbs[seq] = clientscb;
            var wrapped = {seq : seq, src : "client", clientVersion : cversion, parentVersion: pversion, body : message};
            $$.xd.post(wrapped, getParentUrl(), parent);
        }

        /**
        * @description Get the context for the current user and organization
        * @public
        * @name Sfdc.canvas.client#ctx
        * @function
        * @param {Function} clientscb Callback function to run when the call to ctx is complete
        * @param {String} token OAuth token to send. 
        * @example
        * // Gets context in the canvas app.
        * 
        * function callback(msg) {
        *   if (msg.status !== 200) {
        *     alert("Error: " + msg.status);
        *     return;
        *   }
        *   alert("Payload: ", msg.payload);
        * }
        * var ctxlink = connect.byId("ctxlink");
        * var oauthtoken = connect.oauth.token();
        * ctxlink.onclick=function() {
        *   connect.client.ctx(callback, oauthtoken)};
        * }
        */
        function getContext(clientscb, token) {
            token = token || $$.oauth.token();
            postit(clientscb, {type : "ctx", accessToken : token});
        }
        
        /**
        * @description Perform a cross-domain, asynchronous HTTP request.  
            <br>Note:  this should not be used for same domain requests.
        * @param {String} url The URL to which the request is sent
        * @param {Object} settings A set of key/value pairs to configure the request.  
            <br>The success setting is required at minimum and should be a callback function
        * @name Sfdc.canvas.client#ajax
        * @function
        * @throws illegalArgumentException if the URL is missing or the settings object does not contain a success callback function.
        * @example
        * //Posting To a Chatter Feed:
        * var sr = JSON.parse('<%=signedRequestJson%>');
        * var url = sr.context.links.chatterFeedsUrl+"/news/"
        *                                   +sr.context.user.userId+"/feed-items";
        * var body = {body : {messageSegments : [{type: "Text", text: "Some Chatter Post"}]}};
        * connect.client.ajax(url,
        *   {token : sr.oauthToken,
        *     method: 'POST',
        *     contentType: "application/json",
        *     data: JSON.stringify(body),
        *     success : function(data) {
        *     if (201 === data.status) {
        *          alert("Success"
        *          } 
        *     }
        *   });
        * @example
        * // Gets a List of Chatter Users:
        * // Paste the signed request string into a JavaScript object for easy access.
        * var sr = JSON.parse('<%=signedRequestJson%>');
        * // Reference the Chatter user's URL from Context.Links object.
        * var chatterUsersUrl = sr.context.links.chatterUsersUrl;
        *
        * // Make an XHR call back to salesforce through the supplied browser proxy.
        * connect.client.ajax(chatterUsersUrl,
        *   {token : sr.oauthToken,
        *   success : function(data){
        *   // Make sure the status code is OK.
        *   if (data.status === 200) {
        *     // Alert with how many Chatter users were returned.
        *     alert("Got back "  + data.payload.users.length +
        *     " users"); // Returned 2 users
        *    }
        * })};
        */
         function ajax(url, settings) {

            var token = settings.token || $$.oauth.token();
            var config,
                defaults = {
                    method: 'GET',
                    async: true,
                    contentType: "application/json",
                    headers: {"Authorization" : "OAuth "  + token,
                        "Accept" : "application/json"},
                    data: null
                };

            if (!url) {
                throw {name : "illegalArgumentException" , message : "url required"};
            }
            if (!settings || !$$.isFunction(settings.success)) {
                throw {name : "illegalArgumentException" , message : "setting.success missing."};
            }

            var ccb = settings.success;
            config = $$.extend(defaults, settings || {});
            // Remove any listeners as functions cannot get marshaled.
            config.success = undefined;
            config.failure = undefined;
            postit(ccb, {type : "ajax", accessToken : token, url : url, config : config});
        }

        function register() {
            function cb(info) {
                pversion = info.parentVersion;
                loaded = true;
            }
            postit(cb, {type : "register", url : document.location.href});
        }

        function token(t) {
            $$.oauth.token(t);
        }

        function version() {
            return {clientVersion: cversion, parentVersion : pversion};
        }

        function isLoaded() {
            return loaded;
        }

        $$.xd.receive(callbacker, getParentUrl());
        register();

        return {
            ctx : getContext,
            ajax : ajax,
            token : token,
            version : version,
            loaded : isLoaded
        };
    }());

    $$.module('Sfdc.canvas.client', module);

}(Sfdc.canvas));