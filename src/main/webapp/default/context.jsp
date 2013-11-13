<table border="0" width="100%">
    <tr>
      <td><b>First Name: </b><span id='firstname'>${canvasRequest.context.userContext.firstName}</span></td>
      <td><b>Last Name: </b><span id='lastname'>${canvasRequest.context.userContext.lastName}</span></td>
    </tr>
    <tr>
      <td><b>Username: </b><span id='username'>${canvasRequest.context.userContext.userName}</span></td>
      <td colspan="2"><b>Email Address: </b><span id='email'>${canvasRequest.context.userContext.email}</span></td>
    </tr>
    <tr>
      <td colspan="3"><b>Company: </b><span id='company'>${canvasRequest.context.organizationContext.name}</span></td>
    </tr>
</table>
