<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignIn.aspx.cs" Inherits="BoomCloudDemo.SignIn" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>SignIn Form</title>
    <style>
        .signup-container {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            margin-top: 40px;
            border-radius: 15px;
        }
        .signup-container .form-group label {
            font-weight: normal;
        }

        .signup-container .form-group .error-message {
            margin-top: 5px;
        }

    </style>
</head>
<body style="background-color:deepskyblue;font-family:arial">
    <form id="form" runat="server">
        <telerik:RadScriptManager ID="radScriptManager" runat="server"></telerik:RadScriptManager>
        <asp:UpdatePanel ID="updatepnl" runat="server">
        <ContentTemplate> 

        <div class="signup-container" style="padding-left:5%;border:hidden;margin-top:8%">
            <img src="Horizontal_Logo.png" width="280" height="80" style="margin-left:10%" />
            <h1 style="margin-left:130px;color:white">SIGN IN</h1>
            
        <div class="form-group">
            <telerik:RadTextBox  ID="txtUserName" runat="server" Width="93%" Height="36px" InputType="Text" style=" border-radius:20px;margin-right:50px;background-color:pink;margin-top:10px;background-color:lightblue;font-size:15px"  Placeholder="Username" MaxLength="100" CssClass="rounded-textbox" /><br />
            <asp:RequiredFieldValidator ID="usernameValidator" ControlToValidate="txtUserName" ValidationGroup="signInValidation"   runat="server" ForeColor="Red" ErrorMessage="Please Enter Username" Display="Dynamic"   ></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ControlToValidate="txtUsername" ValidationGroup="signInValidation" ForeColor="Red" ID="regularExpressionValidator1" Display="Dynamic" runat="server" ErrorMessage="Please enter alphabets only" ValidationExpression="^[a-zA-Z\s]+$"></asp:RegularExpressionValidator><br />
        </div>
        

            <div class="form-group">
                <telerik:RadTextBox ID="txtPassword" TextMode="Password" Width="93%" Height="36px" style="border-radius:20px;margin-right:50px;background-color:pink;margin-top:10px;background-color:lightblue;font-size:15px"  runat="server"  Placeholder="Password" MinLength="8" MaxLength="16"  /><br />
                <asp:RequiredFieldValidator  ID="passwordValidator" ValidationGroup="signInValidation" ControlToValidate="txtPassword" ForeColor="Red" runat="server" ErrorMessage="Please Enter Password" Display="Dynamic" ></asp:RequiredFieldValidator><br />
            </div>
       
            <div class="form-group">  
                <telerik:RadButton RenderMode="Lightweight" width="93%" style="border-radius:20px;margin-right:50px;background-color:pink;margin-top:10px"  ID="btnSubmit" runat="server" ValidationGroup="signInValidation" Text="SignIn" OnClick="btnSigninClick"
                     SingleClick="true"  SingleClickText="SignIn"></telerik:RadButton>            
            </div>
            <div style="margin-left:120px;color:white;margin-top:30px" >  
               <a  href="#" style="color:white" > Forgot password   </a>  
            </div>
            <div style="margin-left: 50px; color: white; margin-top: 30px;">  
                    Don't have an account? 
                    <a href="SignUp.aspx" style="padding: 10px 10px; border-radius: 4px; color: white;">Sign up Now</a>  
            </div>


            <telerik:RadWindowManager ID="RadWindowManager1" Behaviors="Close" runat="server" Behavior="Close" Skin="Vista">
                                <Windows>
                                    <telerik:RadWindow ID="radWindow" runat="server" Title= "Invalid Credentials" Font-Size="Medium" Width="410px" Height="150px"  style="background-color:pink" VisibleOnPageLoad="true">
                                        <ContentTemplate>
                                        <br />
                                            <asp:label ID="labelMessage" runat="server" Text="Your Username or Password is Incorrect" Font-Size="Medium"></asp:label>
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </Windows>
                </telerik:RadWindowManager>
              
        </div>
        </ContentTemplate> 
        </asp:UpdatePanel> 
    </form> 
</body>
</html>


