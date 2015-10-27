import samplePackage.Message_Builder;
import js.Browser;
import js.html.*;

class WebSocketTest {

//	static var wsUri = "ws://localhost:8080/";
//	static var wsUri = "ws://echo.websocket.org/";
	static var wsUri = "ws://localhost:8080/";
	static var output:Element;
	static var websocket:WebSocket = null;
	
	static function main() {
		Browser.window.addEventListener("load", init, false);
	}

	static function init(e) {
		output = Browser.document.getElementById("output");
		var input:InputElement = cast Browser.document.getElementById("input");

		var openBtn = Browser.document.getElementById("open");
		var sendBtn = Browser.document.getElementById("send");
		var closeBtn = Browser.document.getElementById("close");

		// Get the buttons to do things
		openBtn.addEventListener("click", connect, false);
		sendBtn.addEventListener("click", function(e) {
			doSend(input.value);
		}, false);
		closeBtn.addEventListener("click", function(e) {
			websocket.close();
		}, false);
	}

	static function connect(evt) {
		if(websocket != null){
			trace("still connectin");
			return;
		}
		websocket = new WebSocket(wsUri);
		websocket.onopen = onOpen;
		websocket.onclose = onClose;
		// Haxe seems to have some bad type definitions here.  If you're willing to investigate, I'm sure
		// filing an issue at http://code.google.com/p/haxe/issues/list would see a fix in time for 3.0 :)
		websocket.onmessage = function(event:Dynamic){
			trace("MEssage received " + evt);
//			writeToScreen('<span style="color: blue;">RESPONSE: ' + evt + '</span>');
		};
		websocket.onerror = function(event:Dynamic){
			writeToScreen('<span style="color: red;">ERROR:</span> ' + evt.data);
			websocket = null;
		};
		trace("connectin to <<" + wsUri + ">> ...");
	}

	static function onOpen(evt) {
		writeToScreen("CONNECTED");
//		doSend("WebSocket rocks");
		trace("CONNECTED");
	}

	static function onClose(evt) {
		writeToScreen("DISCONNECTED");
		trace("DISCONNECTED");
		websocket = null;
	}

	static function doSend(message) {
		writeToScreen("SENT: " + message);

		var builder = new samplePackage.Message_Builder();
		builder.message = "Hello, World!";



//		var output = File.write("sample.save");
//		builder.writeTo(output);
//		output.close();
//
//		var out:haxe.io.Output
//
//		var data:ArrayBuffer =
//
//		websocket.send;
	}

	static function writeToScreen(message) {
		var pre = Browser.document.createElement("p");
		pre.style.wordWrap = "break-word";
		pre.innerHTML = message;
		output.appendChild(pre);
	}
}