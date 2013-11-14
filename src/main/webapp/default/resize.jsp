<script type="text/javascript">
    function displaySize() {
        var sizes = Sfdc.canvas.client.size();
        var sizeElem = document.getElementById('dimensions');
        sizeElem.innerHTML = "Width: " + sizes.widths.pageWidth + ", Height: " + sizes.heights.pageHeight;
    }

    function adjustHeight(inc) {
        var dim = Sfdc.canvas.client.size(sr.client);
        console.log("Dim ", dim.heights.pageHeight);
        Sfdc.canvas.client.resize(sr.client, {height : dim.heights.pageHeight + inc + "px"});
        displaySize();
    }
    function adjustWidth(inc) {
        var dim = Sfdc.canvas.client.size(sr.client);
        console.log("Dim ", dim.widths.pageWidth);
        Sfdc.canvas.client.resize(sr.client, {width : dim.widths.pageWidth + inc + "px"});
        displaySize();
    }

</script>
<p>
Force.com Canvas supports dynamic and automatic resizing so you can manage the size of the Canvas application yourself,
or let Force.com Canvas do all the work.
</p> 
<p>
<a href="#" onclick="subscribe('canvas.resize');">Subscribe</a> to the resize event and see the resize event
in action on the "Events" tab.
</p>
<table>
    <tr>
        <td></td>
        <td><input type='button' value='Decrease Height' onclick='adjustHeight(-10)'/></td>
        <td></td>
    </tr>
    <tr>
        <td><input type='button' value='Decrease Width' onclick='adjustWidth(-10)'/></td>
        <td><span id='dimensions'></span></td>
        <td><input type='button' value='Increase Width' onclick='adjustWidth(10)'/></td>
    </tr>
    <tr>
        <td></td>
        <td><input type='button' value='Increase Height' onclick='adjustHeight(10)'/></td>
        <td></td>
    </tr>
</table>
