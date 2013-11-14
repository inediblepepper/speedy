<script type="text/javascript">
function displaySize() {
    var sizes = Sfdc.canvas.client.size();
    var sizeElem = document.getElementById('dimensions');
    sizeElem.innerHTML = "Width: " + sizes.widths.pageWidth + ", Height: " + sizes.heights.pageHeight;
}

function adjustWidth(offset) {
	var minWidth = 600;
	adjustDimension	(offset,minWidth,"width","content-tabs","button-table");
    displaySize();
}

function adjustHeight(offset) {
	var minHeight = 400;
	adjustDimension(offset,minHeight,"height","content-tabs","button-table");
    displaySize();
}

/**
 * Adjust the dimensions of the element for each ID passed in.
 * @param offset - The number/size to increment/decrement in pixels.
 * @param minDimension - The minimum value of the dimension.
 * @param attribute - The style attribute to manipulate.
 * @param the IDs to update
 */
function adjustDimension(){
	if (arguments.length < 4){
		throw "Unexpected number of arguments";
	}
	var i, perc,bodyDim, minValue = Number(arguments[1]),
		offset = Number(arguments[0].split('%')[0]),
		styleAttr = arguments[2],
		calcAttribute = ("height" === styleAttr) ? 
				"scrollHeight" : 
				"scrollWidth";

	perc = Math.abs(offset)/100;
	bodyDim =  document.body[calcAttribute]; 
	if (bodyDim <= minValue && offset <= 0){
		console.log("Body " + styleAttr + " is less/equal to min value of "+ minValue + ". Returning...");
		return;
	}
	console.log("Current page size " + bodyDim + "px to be computed based on offset " + offset + "% for a increase/decrease of " + perc + "...");
	
	for (i=3;i<arguments.length;i++){
		var id = arguments[i],elem,origHeight,newHeight,newOffset;
		elem = document.getElementById(id);
		if (!elem){
			throw "Unknown element by ID '" + id + "'";
		}
		origHeight = parseInt(window.getComputedStyle(elem)[styleAttr].replace("px",""));
		newOffset =  (Math.round(perc*origHeight)*(offset<0?-1:1));
		newHeight = origHeight + newOffset,minValue;
		console.log("Resizing element '" + id + "' "+ styleAttr + " from " + origHeight + " to " + newHeight);
		elem.style[styleAttr] = newHeight+"px";
	}
	console.log("Page " + styleAttr + " is now at " + document.body[calcAttribute] + "px.");
    Sfdc.canvas.client.resize(sr.client,{width:document.body.scrollWidth+"px",height:document.body.scrollHeight+"px"});
}

function min(value,min){
	return value <= min ? min : value;	
}

</script>
<p>
Force.com Canvas supports dynamic and automatic resizing so you can manage the size of the Canvas application yourself,
or let Force.com Canvas do all the work.  It's that easy!  You can also subscribe to resize events so your application gets
notified. <a href="#resize" onclick="subscribe('canvas.resize');">Subscribe</a> to the resize event and see the resize event
in action on the "Events" tab.
</p>
<table valign="top" id="button-table" border="0"  width="100%" height="300px" style="text-align: center; ">
    <tr>
      <td width="33%">&nbsp;</td>
      <td width="33%"><button type="button" onclick="adjustHeight('-10%');" alt="Decrease Height" style="width:30px;height:60px; background:url(/default/arrow_up.png) no-repeat scroll center center / 16px 16px transparent;"/></td>
      <td width="*">&nbsp;</td>
    </tr>
    <tr>
      <td><button type="button" onclick="adjustWidth('-10%');" alt="Decrease Width" style="width:60px;height:30px; background:url(/default/arrow_left.png) no-repeat scroll center center / 16px 16px transparent;"/></td>
      <td><span id="dimensions"></span></td>
      <td><button type="button" onclick="adjustWidth('10%');" alt="Increase Width" style="width:60px;height:30px; background:url(/default/arrow_right.png) no-repeat scroll center center / 16px 16px transparent;"/></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td ><button type="button" onclick="adjustHeight('10%');"  alt="Increase Height" style="width:30px;height:60px; background:url(/default/arrow_down.png) no-repeat scroll center center / 16px 16px transparent;"/></td>
      <td>&nbsp;</td>
    </tr>
</table>
