<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="BoomCloudDemo.SignUp" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>
<html">
<head runat="server">
    <title>Signup Form</title>
    <style>
        .signup-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            margin-top:40px;
            margin-bottom:20px;
        }

        .signup-container h1 {
            margin-left:30%;
        }

        .signup-container .form-group {
            margin-bottom: 15px;
            margin-left:20%
        }

        .signup-container .form-group label {
            display: block;
            font-weight: bold;
        }

        .signup-container .form-group .error-message {
            margin-top: 5px;
        }

    </style>
</head>
<body style="background-color:deepskyblue;font-family:arial">    
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="radScriptManager1" runat="server"></telerik:RadScriptManager>

    <div class="signup-container" style="padding-left:10%">
        <img src="Horizontal_Logo.png" width="280" height="80" style="margin-left:25%" />
        <h1>Signup Form</h1>

        <div class="form-group">
            <telerik:RadTextBox runat="server" ID="txtUsername" InputType="Text" Width="58%" Height="36px" style="border-radius:20px; font-size:15px; background-color:lightblue"  Placeholder="Name" MaxLength="100" /><br />
            <asp:RequiredFieldValidator ControlToValidate="txtUsername" ValidationGroup="signUpValidation" ForeColor="Red" ID="requiredFieldValidator1" Display="Dynamic" runat="server" ErrorMessage="*Required"></asp:RequiredFieldValidator> 
            <asp:RegularExpressionValidator ControlToValidate="txtUsername" ValidationGroup="signUpValidation" ForeColor="Red" ID="regexName" Display="Dynamic" runat="server" ErrorMessage="Please enter alphabets only" ValidationExpression="^[a-zA-Z\s]+$"></asp:RegularExpressionValidator><br />
        </div>

        <div class="form-group">
            <telerik:RadTextBox runat="server" Width="58%" Height="36px"
                style="border-radius:20px;font-size:15px;background-color:lightblue" ID="txtEmail" Placeholder="Email" MaxLength="50" /><br />
            <telerik:RadLabel ID="RadLabel1" runat="server" ForeColor="red" ></telerik:RadLabel>
            <asp:RequiredFieldValidator  ControlToValidate="txtEmail" ValidationGroup="signUpValidation" ForeColor="Red" ID="requiredFieldValidator2" Display="Dynamic" runat="server" ErrorMessage="*Required"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="rgxEmail" runat="server" ValidationGroup="signUpValidation" ControlToValidate="txtEmail" Display="Dynamic" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ErrorMessage="Invalid email format" ForeColor="Red" ></asp:RegularExpressionValidator><br />
        </div>

        <div class="form-group">
            <telerik:RadTextBox runat="server"  ID="txtPhone" OnKeyPress="validateNumericInput(event);" Width="58%" Height="36px" style="border-radius:20px;font-size:15px;background-color:lightblue" Placeholder="Phone Number" NumberType="Number" Minlength="10" MaxLength="10" />
           <div>
                 <asp:RequiredFieldValidator   ControlToValidate="txtPhone" ValidationGroup="signUpValidation" ForeColor="Red" ID="requiredFieldValidator3" runat="server" ErrorMessage="*Required"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator  ForeColor="Red" runat="server" ValidationGroup="signUpValidation" ControlToValidate="txtPhone" ErrorMessage="Invalid phone number format" ValidationExpression="^\d{10}$"></asp:RegularExpressionValidator>
               </div>
            </div>

        <div class="form-group">
            <telerik:RadDatePicker runat="server" DateInput-DateFormat="MM/dd/yyyy" Width="58%" Height="36px" ID="dpDOB" Placeholder="Date of Birth"  /><br />
            <asp:RequiredFieldValidator   ControlToValidate="dpDOB" ValidationGroup="signUpValidation" ForeColor="Red" ID="requiredFieldValidator4" runat="server" ErrorMessage="*Required" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:CustomValidator ControlToValidate="dpDOB" ValidationGroup="signUpValidation" ForeColor="Red" ID="customValidator1" runat="server" OnServerValidate="customValidator1_ServerValidate" ErrorMessage="User Must be 18 Years Old" Display="Dynamic"></asp:CustomValidator><br />
        </div>


        <div class="form-group">
            <telerik:RadTextBox runat="server" Width="58%" Height="36px" style="border-radius:20px;background-color:lightblue;font-size:15px;" ID="txtPassword" TextMode="Password" Placeholder="Password" MinLength="8" MaxLength="16" /><br />
            <asp:RequiredFieldValidator  ControlToValidate="txtPassword" ValidationGroup="signUpValidation" ForeColor="Red" ID="requiredFieldValidator5" Display="Dynamic" runat="server" ErrorMessage="*Required"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="passvalidator"  runat="server" ValidationGroup="signUpValidation" ErrorMessage="Enter a strong password.(Password must contain at least 1 lowercase alphabet, 1 uppercase alphabet, 1 special symbol, and 1 digit)" Display="Dynamic" ValidationExpression="^.*(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!*@#$%^&+=]).*$" ControlToValidate="txtPassword" ForeColor="White"></asp:RegularExpressionValidator><br />
        </div>
        <div class="form-group">
            <telerik:RadTextBox runat="server" Width="58%" Height="36px" style="border-radius:20px;background-color:lightblue;font-size:15px;" ID="txtConfirmPassword" TextMode="Password" Placeholder="Confirm Password" MinLength="8" MaxLength="16" /><br />
            <asp:RequiredFieldValidator ControlToValidate="txtConfirmPassword" ValidationGroup="signUpValidation"  Display="Dynamic" ForeColor="Red" ID="requiredFieldValidator6" runat="server" ErrorMessage="*Required"></asp:RequiredFieldValidator>
            <asp:CompareValidator  ID="CompareValidator1" ValidationGroup="signUpValidation" runat="server"  Display="Dynamic" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ForeColor="Red" ErrorMessage="Password must be the same"></asp:CompareValidator>
        </div>

        <div class="form-group" style="margin-left:20%;margin-top:30px;border-radius:20px">
            <telerik:RadButton  Width="29%" Height="36px" style="font-size:15px;border-radius:20px;text-align:center"  runat="server" ID="btnSignup"  Text="Sign up" ButtonType="LinkButton" OnClick="btnSignupClick" ValidationGroup="signUpValidation" SingleClick="true" SingleClickText="SignUp" />
            <telerik:RadButton Width="29%" Height="36px" style="font-size:15px;border-radius:20px;text-align:center" runat="server" ID="btnBack"  Text="Back" ButtonType="LinkButton" NavigateUrl="SignIn.aspx"></telerik:RadButton>
        </div>
        <telerik:RadWindowManager ID="SignUpRadWindow" Behaviors="Close" runat="server" Behavior="Close" Skin="Vista">
                                <Windows>
                                    <telerik:RadWindow ID="rwEmailExist" runat="server" Title= "Email Exist Window" Font-Size="Medium" Width="410px" Height="150px"  style="background-color:pink" VisibleOnPageLoad="true">
                                        <ContentTemplate>
                                        <br />
                                            <asp:label ID="lblMessage" runat="server" Text="Email Already Exist" Font-Size="Medium"></asp:label>
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </Windows>
                </telerik:RadWindowManager>
        <telerik:RadWindowManager ID="RadWindowManager1" Behaviors="Close" runat="server" Behavior="Close" Skin="Vista">
                                <Windows>
                                    <telerik:RadWindow ID="rwSignUpMsg" runat="server" Title= "Sign Up Status" Font-Size="Medium" Width="410px" Height="150px"  style="background-color:pink" VisibleOnPageLoad="true">
                                        <ContentTemplate>
                                        <br />
                                            <asp:label ID="lblSignedUp" runat="server" Text="User Signed Up Sucessfully" Font-Size="Medium"></asp:label>
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </Windows>
                </telerik:RadWindowManager>
    </div>
    </form>
<script type="text/javascript">
    function validateNumericInput(event) {
        var keyCode = event.keyCode ? event.keyCode : event.which;
        if (keyCode < 48 || keyCode > 57) {     
            event.preventDefault();
            return false;
        }
    }
</script>
</body>
</html>

