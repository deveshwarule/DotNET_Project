<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.Master" CodeBehind="Members.aspx.cs" Inherits="BoomCloudDemo.Members" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
    .left-tabs {
        text-align: center;
        margin:72px;
        margin-left:30%;
        background-color: ghostwhite;
    }
    .signup-container {
            padding: 20px;
            margin-bottom:20px;
            border: 2px;
            margin-left:15%;
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
    <div class="left-tabs">
        <telerik:RadTabStrip ID="RadTabStrip2" runat="server" MultiPageID="RadMultiPage1" Skin="Bootstrap">
            <Tabs>
                <telerik:RadTab Text="Primary Contact" ></telerik:RadTab>
                <telerik:RadTab Text="Patient Financing" ></telerik:RadTab>
                <telerik:RadTab Text="Benefit Tracking" ></telerik:RadTab>
                <telerik:RadTab Text="Payment Information" ></telerik:RadTab>
                <telerik:RadTab Text="Notes " ></telerik:RadTab>
                <telerik:RadTab Text="Activity History"></telerik:RadTab>
            </Tabs>
        </telerik:RadTabStrip>
    </div>
    <div class="signup-container" Width="70%" Height="160px" >
        <div class="form-group">
    <h1 style="margin-left:20%">Add Member</h1>
    <telerik:RadLabel runat="server" ID="lblName" Text="Name"></telerik:RadLabel><br />
    <telerik:RadTextBox runat="server" ID="txtname" Width="63%" Height="40px" InputType="Text" style="border-radius: 20px;  font-size: 15px; background-color: ghostwhite;" Placeholder="Name" MaxLength="30" /><br />
    <asp:RequiredFieldValidator ControlToValidate="txtname" ValidationGroup="signUpValidation" ForeColor="Red" ID="requiredFieldValidator1" Display="Dynamic" runat="server" ErrorMessage="Please Enter Name"></asp:RequiredFieldValidator>
</div>

<div class="form-group">
    <telerik:RadLabel runat="server" ID="lblAddress" Text="Address"></telerik:RadLabel><br />
    <telerik:RadTextBox runat="server" ID="txtAddress" Width="63%" Height="40px" style="border-radius: 20px; font-size: 15px; background-color: ghostwhite;" Placeholder="Address" MaxLength="100" /><br />
    <asp:RequiredFieldValidator ControlToValidate="txtAddress" ValidationGroup="signUpValidation" ForeColor="Red" ID="requiredFieldValidator5" Display="Dynamic" runat="server" ErrorMessage="Please Enter Address"></asp:RequiredFieldValidator>
</div>

<div class="form-group">
    <telerik:RadLabel runat="server" ID="lblCity" Text="City"></telerik:RadLabel><br />
    <telerik:RadTextBox runat="server" ID="txtCity" Width="63%" Height="40px" InputType="Text" style="border-radius: 20px; font-size: 15px; background-color: ghostwhite;" Placeholder="City" MaxLength="100" /><br />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCity" ValidationGroup="signUpValidation" ForeColor="Red" ID="requiredFieldValidatorCity" Display="Dynamic" ErrorMessage="Please Enter a City"></asp:RequiredFieldValidator>
</div>

<div class="form-group">
    <telerik:RadLabel runat="server" ID="lblState" Text="State"></telerik:RadLabel><br />
    <telerik:RadComboBox ID="cmbState" runat="server" style="font-size:30px"  MarkFirstMatch="true" Width="63%" Height="120px"></telerik:RadComboBox>
</div>



<div class="form-group">
    <telerik:RadLabel runat="server" ID="lblPhoneNumber" Text="Phone Number"></telerik:RadLabel><br />
    <telerik:RadTextBox runat="server" Width="63%" Height="40px" style="border-radius:20px;font-size:15px;background-color:ghostwhite" ID="txtPhone" Placeholder="Phone Number" NumberType="Number" Minlength="10" MaxLength="10" /><br />
    <asp:RequiredFieldValidator ControlToValidate="txtPhone" ValidationGroup="signUpValidation" ForeColor="Red" ID="requiredFieldValidator3" Display="Dynamic" runat="server" ErrorMessage="Please Enter Phone Number"></asp:RequiredFieldValidator>
</div>

<div class="form-group">
    <telerik:RadLabel runat="server" ID="lblEmail" Text="Email"></telerik:RadLabel><br />
    <telerik:RadTextBox runat="server" Width="63%" Height="40px" InputType="Email" style="border-radius:20px;font-size:15px;background-color:ghostwhite" ID="txtEmail" Placeholder="Email" MaxLength="50" /><br />
    <asp:RequiredFieldValidator ControlToValidate="txtEmail" ValidationGroup="signUpValidation" ForeColor="Red" ID="requiredFieldValidator7" Display="Dynamic" runat="server" ErrorMessage="Please Enter Email"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="signUpValidation" ControlToValidate="txtEmail" Display="Dynamic" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ErrorMessage="Invalid email format" ForeColor="Red"></asp:RegularExpressionValidator>
</div>


<div class="form-group">
    <telerik:RadLabel runat="server" ID="RadLabel2" Text="Date of Birth"></telerik:RadLabel><br />
    <telerik:RadDatePicker runat="server" ID="dpDOB"  DateInput-DisplayDateFormat="MM/dd/yyyy" Width="63%" Height="40px" Placeholder="Date of Birth"  /><br />
    <asp:RequiredFieldValidator ControlToValidate="dpDOB" ValidationGroup="signUpValidation" ForeColor="Red" ID="requiredFieldValidator4" runat="server" ErrorMessage="Please Enter Date of Birth"></asp:RequiredFieldValidator>
</div>

        <div class="form-group" style="margin-left:40%;margin-top:30px;border-radius:20px;display:flex">
            <telerik:RadButton  Width="150px" Height="36px" style="font-size:15px" runat="server" ID="btnAddUser"  Text="Add Member"  ValidationGroup="signUpValidation" OnClick="btnAddUser_Click"  SingleClick="true" SingleClickText="Add Member" />
            <telerik:RadButton Width="150px" Height="36px" style="font-size:15px;margin-left:5px" runat="server" ID="btnCancel" Text="Cancel" ButtonType="LinkButton" NavigateUrl="Dashboard.aspx"></telerik:RadButton>
        </div>
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
                                    <telerik:RadWindow ID="rwSignUpMsg" runat="server" Title= "Add Member Status" Font-Size="Medium" Width="410px" Height="150px"  style="background-color:pink" VisibleOnPageLoad="true">
                                        <ContentTemplate>
                                        <br />
                                            <asp:label ID="lblSignedUp" runat="server" Text="Member Added Sucessfully" Font-Size="Medium"></asp:label>
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </Windows>
                </telerik:RadWindowManager>
</asp:Content>

