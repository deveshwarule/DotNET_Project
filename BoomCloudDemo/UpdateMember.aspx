<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateMember.aspx.cs" MasterPageFile="~/MasterPage.Master"  Inherits="BoomCloudDemo.UpdateMember" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
    .signup-container {
            padding: 20px;
            margin-bottom:20px;
            border: 2px;
            margin-left:15%;
            margin-top:10%
        }

        .signup-container .form-group {
            margin-bottom: 15px;
            margin-left:35%;
        }

        .signup-container .form-group label {
            display: block;
            font-weight: bold;
        }

        .signup-container .form-group .error-message {
            margin-top: 3px;
        }
</style>
    <div class="signup-container" Width="70%" Height="160px" >
        <div class="form-group">
    <h1 style="margin-left:20%">Update Member</h1>
    <telerik:RadLabel runat="server" ID="lblName" Text="Name"></telerik:RadLabel><br />
    <telerik:RadTextBox runat="server" ID="txtname" Width="63%" Height="40px" style="border-radius: 20px; font-size: 15px; background-color: ghostwhite;" Placeholder="Name" MaxLength="30" /><br />
    <asp:RequiredFieldValidator ControlToValidate="txtname" ValidationGroup="updateValidation" ForeColor="Red" ID="requiredFieldValidator1" Display="Dynamic" runat="server" ErrorMessage="Please Enter Name"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator runat="server" ID="regexValidator" ControlToValidate="txtname" ValidationGroup="updateValidation" ForeColor="Red" ErrorMessage="Please enter alphabets only" ValidationExpression="^[a-zA-Z\s]+$" Display="Dynamic"></asp:RegularExpressionValidator>
</div>

<div class="form-group">
    <telerik:RadLabel runat="server" ID="lblAddress" Text="Address"></telerik:RadLabel><br />
    <telerik:RadTextBox runat="server" ID="txtAddress" Width="63%" Height="40px" style="border-radius: 20px; font-size: 15px; background-color: ghostwhite;" Placeholder="Address" MaxLength="50" /><br />
    <asp:RequiredFieldValidator ControlToValidate="txtAddress" ValidationGroup="updateValidation" ForeColor="Red" ID="requiredFieldValidator5" Display="Dynamic" runat="server" ErrorMessage="Please Enter Address"></asp:RequiredFieldValidator>
</div>

<div class="form-group">
    <telerik:RadLabel runat="server" ID="lblCity" Text="City"></telerik:RadLabel><br />
    <telerik:RadTextBox runat="server" ID="txtCity" Width="63%" Height="40px" style="border-radius: 20px; font-size: 15px; background-color: ghostwhite;" Placeholder="City" MaxLength="30" /><br />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCity" ValidationGroup="updateValidation" ForeColor="Red" ID="requiredFieldValidatorCity" Display="Dynamic" ErrorMessage="Please Enter a City"></asp:RequiredFieldValidator>
</div>

<div class="form-group">
    <telerik:RadLabel runat="server" ID="lblState" Text="State"></telerik:RadLabel><br />
    <telerik:RadComboBox ID="cmbState" runat="server" MarkFirstMatch="true" Width="63%" Height="120px"></telerik:RadComboBox>
</div>



<div class="form-group">
    <telerik:RadLabel runat="server" ID="lblPhoneNumber" Text="Phone Number"></telerik:RadLabel><br />
    <telerik:RadTextBox runat="server" OnKeyPress="validateNumericInput(event);" Width="63%" Height="40px" style="border-radius:20px;font-size:15px;background-color:ghostwhite" ID="txtPhone" Placeholder="Phone Number" NumberType="Number" Minlength="10" MaxLength="10" /><br />
    <asp:RequiredFieldValidator ControlToValidate="txtPhone" ValidationGroup="updateValidation" ForeColor="Red" ID="requiredFieldValidator3" Display="Dynamic" runat="server" ErrorMessage="Please Enter Phone Number"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ForeColor="Red" runat="server" ValidationGroup="updateValidation" ControlToValidate="txtPhone" Display="Dynamic" ErrorMessage="Invalid phone number format" ValidationExpression="^\d{10}$"></asp:RegularExpressionValidator>
</div>

<div class="form-group">
    <telerik:RadLabel runat="server" ID="lblEmail" Text="Email"></telerik:RadLabel><br />
    <telerik:RadTextBox runat="server" Width="63%" Height="40px" style="border-radius:20px;font-size:15px;background-color:ghostwhite" ID="txtEmail" Placeholder="Email" MaxLength="50" /><br />
    <asp:RequiredFieldValidator ControlToValidate="txtEmail" ValidationGroup="updateValidation" ForeColor="Red" ID="requiredFieldValidator7" Display="Dynamic" runat="server" ErrorMessage="Please Enter Email"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="updateValidation" ControlToValidate="txtEmail" Display="Dynamic" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ErrorMessage="Invalid email format" ForeColor="Red"></asp:RegularExpressionValidator>
</div>

    <div class="form-group">
        <telerik:RadLabel runat="server" ID="RadLabel2" Text="Date of Birth"></telerik:RadLabel><br />
        <telerik:RadDatePicker runat="server" ID="dpDOB"  DateInput-DisplayDateFormat="MM/dd/yyyy" Width="63%" Height="40px" Placeholder="Date of Birth"  /><br />
        <asp:RequiredFieldValidator ControlToValidate="dpDOB" ValidationGroup="updateValidation" ForeColor="Red" ID="requiredFieldValidator4" runat="server" ErrorMessage="Please Enter Date of Birth"></asp:RequiredFieldValidator>
    </div>

    <div class="form-group">
            <telerik:RadLabel runat="server" ID="RadLabel1" Text="Password"></telerik:RadLabel><br />
            <telerik:RadTextBox runat="server" Width="63%" Height="40px" style="border-radius:20px;background-color:ghostwhite;font-size:15px;" ID="txtPassword" Placeholder="Password" MinLength="8" MaxLength="16" /><br />
            <asp:RequiredFieldValidator  ControlToValidate="txtPassword" ValidationGroup="updateValidation" ForeColor="Red" ID="requiredFieldValidator2" Display="Dynamic" runat="server" ErrorMessage="Please Enter Password"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="passvalidator"  runat="server" ValidationGroup="updateValidation" ErrorMessage="Enter a strong password" Display="Dynamic" ValidationExpression="^.*(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!*@#$%^&+=]).*$" ControlToValidate="txtPassword" ForeColor="Red"></asp:RegularExpressionValidator><br />
        </div>

        <div class="form-group" style="margin-left:40%;margin-top:30px;border-radius:20px;display:flex">
            <telerik:RadButton  Width="150px" Height="36px" style="font-size:15px" runat="server" ID="btnUpdateMember"  Text="Update Member"  ValidationGroup="updateValidation" OnClick="btnUpdateMember_Click"  SingleClick="true" SingleClickText="Update Member" />
            <telerik:RadButton Width="150px" Height="36px" style="font-size:15px;margin-left:5px" runat="server" ID="btnCancel" Text="Cancel" ButtonType="LinkButton" NavigateUrl="Dashboard.aspx"></telerik:RadButton>
        </div>
    </div>
        <telerik:RadWindowManager ID="RadWindowManager1" Behaviors="Close" runat="server" Behavior="Close" Skin="Vista">
                                <Windows>
                                    <telerik:RadWindow ID="rwUpdateMessage" runat="server" Title= "Update Member Status" Font-Size="Medium" Width="410px" Height="150px"  style="background-color:pink" VisibleOnPageLoad="true">
                                        <ContentTemplate>
                                        <br />
                                            <asp:label ID="lblSignedUp" runat="server" Text="Member Updated Sucessfully" Font-Size="Medium"></asp:label>
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </Windows>
                </telerik:RadWindowManager>
 <script type="text/javascript">
     function validateNumericInput(event) {
         var keyCode = event.keyCode ? event.keyCode : event.which;
         if (keyCode < 48 || keyCode > 57) {
             event.preventDefault();
             return false;
         }
     }
 </script>
</asp:Content>

