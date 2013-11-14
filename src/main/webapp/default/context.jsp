<p>
Force.com Canvas delivers user context information directly to your application, complete
with a scoped authentication token to allow your application to communicate with Salesforce.com.
</p>
<p>
Below is a sample of that information:
</p>
<table border="0" width="100%">
    <tr>
      <td width="30%"><b>First Name: </b></td>
      <td><span id='firstname'>${canvasRequest.context.userContext.firstName}</span></td>
    </tr>
    <tr>
      <td><b>Last Name: </b></td>
      <td><span id='lastname'>${canvasRequest.context.userContext.lastName}</span></td>
    </tr>
    <tr>
      <td><b>Username: </b></td>
      <td><span id='username'>${canvasRequest.context.userContext.userName}</span></td>
    </tr>
    <tr>
      <td><b>Email Address: </b></td>
      <td><span id='email'>${canvasRequest.context.userContext.email}</span></td>
    </tr>
    <tr>
      <td><b>Company: </b></td>
      <td><span id='company'>${canvasRequest.context.organizationContext.name}</span></td>
    </tr>
</table>
