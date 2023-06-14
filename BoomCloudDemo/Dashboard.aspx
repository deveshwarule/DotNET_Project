    <%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.Master" CodeBehind="Dashboard.aspx.cs" Inherits="BoomCloudDemo.Dashboard" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <style>
            .corner-button {
                margin-top:6%;
                margin-left:15%
            }
            .demo {
                margin-top: 10%;
                margin-left: 38%;
                display: flex;
            }

            .datepicker-wrapper {
                position: relative;
                margin-bottom: 10px;
                width:180px
            }

            .datepicker-label {
                position: absolute;
                bottom: -18px;
                left: 0;
            }
            body {
                border: 1px solid black;
            }
            .usertable{
                margin-left:21%;
                margin-right:10px
            }
        </style>
    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server">
    <div class="container">
            <div class="demo" runat="server" id="containerDiv">
                <div class="datepicker-wrapper">
                    <telerik:RadLabel runat="server" ID="lblStartDate" Text="Start Date"></telerik:RadLabel><br />
                    <telerik:RadDatePicker runat="server" ID="dpFromDate" DateInput-DisplayDateFormat="MM/dd/yyyy" Width="100%" Height="26px"/><br />
                    <asp:RequiredFieldValidator ControlToValidate="dpFromDate" ValidationGroup="valSearch" ForeColor="Red" ID="requiredFieldValidator1" Display="Dynamic" runat="server" ErrorMessage="*Required"></asp:RequiredFieldValidator>
                </div>
                <div class="datepicker-wrapper">
                    <telerik:RadLabel runat="server" style="margin-left:14px" ID="lblEndDate" Text="End Date"></telerik:RadLabel>
                    <telerik:RadDatePicker runat="server" ID="dpEndDate" DateInput-DisplayDateFormat="MM/dd/yyyy" Width="100%" Height="26px" style="margin-left:15px"></telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ControlToValidate="dpEndDate" ValidationGroup="valSearch" ForeColor="Red" ID="requiredFieldValidator2" style="margin-left:10px" Display="Dynamic" runat="server" ErrorMessage="*Required"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ControlToValidate="dpEndDate" ValidationGroup="valSearch" ForeColor="Red" ID="customValidator1" Display="Dynamic" runat="server" ErrorMessage="End Date must be greater than Start Date" OnServerValidate="customValidator1_ServerValidate"></asp:CustomValidator>
                </div>
                <div>
                     <telerik:RadButton ID="RadButton1"  RenderMode="Lightweight" style="margin-left:49%;margin-top:20px" ValidationGroup="valSearch"  runat="server" Text="Search" OnClick="btnSearch_Click" SingleClick="true"></telerik:RadButton>
                </div>
            </div>
            <telerik:RadButton ID="btnRedirect" runat="server" style="margin-left:20%" Text="Add Member +" OnClick="btnRedirect_Click" CssClass="corner-button"></telerik:RadButton>
        </div>
        <br />
        <br />
        <br />
        <h2 style="color:black;margin-left:21%">User Details</h2>
        <div >
            <telerik:RadGrid ID="userGrid" runat="server" AllowPaging="True" OnItemCommand="employeeTable_ItemCommand"  PageSize="10" AllowSorting="True"   CssClass="usertable" HeaderStyle-Font-Bold="true" AutoGenerateColumns="False"  OnNeedDataSource="userGrid_NeedDataSource">
                <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                <MasterTableView DataKeyNames="id" AllowCustomSorting="true" AllowSorting="true">
                    <RowIndicatorColumn ShowNoSortIcon="False">
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn ShowNoSortIcon="False">
                    </ExpandCollapseColumn>
                    <Columns>
                        <telerik:GridBoundColumn DataField="id" DataType="System.Int32" FilterControlAltText="Filter id column" HeaderText="Id" ReadOnly="True" AllowSorting="True" SortExpression="id" UniqueName="id" />
                        <telerik:GridBoundColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" AllowSorting="True" UniqueName="Name" />
                        <telerik:GridBoundColumn DataField="Email" FilterControlAltText="Filter Email column" HeaderText="Email" SortExpression="Email" AllowSorting="True" UniqueName="Email" />
                        <telerik:GridBoundColumn DataField="Phone_Number" FilterControlAltText="Filter Phone_Number column" HeaderText="Phone_Number" SortExpression="Phone_Number" AllowSorting="True" UniqueName="Phone_Number" />
                        <telerik:GridBoundColumn DataField="DOB" DataType="System.DateTime" FilterControlAltText="Filter DOB column" HeaderText="DOB" SortExpression="DOB" AllowSorting="True" UniqueName="DOB" DataFormatString="{0:MM-dd-yyyy}" />
                        <telerik:GridBoundColumn DataField="Address" FilterControlAltText="Filter Address column" HeaderText="Address" ShowNoSortIcon="False" SortExpression="Address" AllowSorting="True" UniqueName="Address"></telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="City" FilterControlAltText="Filter City column" HeaderText="City" ShowNoSortIcon="False" SortExpression="City" AllowSorting="True" UniqueName="City"></telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="State_id" FilterControlAltText="Filter State column" HeaderText="State" ShowNoSortIcon="False" SortExpression="State" AllowSorting="True" UniqueName="State_id"></telerik:GridBoundColumn>
                        <telerik:GridButtonColumn Text="Update" UniqueName="Update" ButtonType="PushButton" CommandName="UpdateRow" ButtonCssClass="btn btn-warning" >
                                 <ItemStyle Font-Bold="True" ForeColor="Blue" />
                            </telerik:GridButtonColumn>
                            <telerik:GridButtonColumn Text="Delete" UniqueName="Delete" ButtonType="PushButton" CommandName="DeleteRow" ButtonCssClass="btn btn-danger" ><ItemStyle ForeColor="Red" />
</telerik:GridButtonColumn>

                    </Columns>
                    <EditFormSettings>
                        <EditColumn ShowNoSortIcon="False">
                        </EditColumn>
                    </EditFormSettings>
                    <PagerStyle AlwaysVisible="True" />
                </MasterTableView>
                <HeaderStyle Font-Bold="True" />
                 <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
            </telerik:RadGrid>
            <telerik:RadWindowManager ID="SignUpRadWindow" Behaviors="Close" runat="server" Behavior="Close" Skin="Vista">
            <Windows>
            <telerik:RadWindow ID="rwDeleteMessage" runat="server" Title="Warning" Font-Size="Medium" Width="260%" Height="50%" VisibleOnPageLoad="true" Behaviors="Close">
                <ContentTemplate>
                    <br />
                    <div style="margin-left:30px">
                    <asp:Label ID="lblMessage" runat="server" Text="You Really want to Delete?" Font-Size="Medium"></asp:Label>
                    <br />
                        <asp:Button ID="btnYes" style="margin-left:10px;margin-top:20px" Width="60" runat="server" Text="Yes" OnClick="btnYes_Click"   />
                        <asp:Button ID="btnNo"  style="margin-left:5px;margin-top:20px" Width="60" runat="server" Text="No" OnClick="btnNo_Click" />
                    </div>
                </ContentTemplate>
            </telerik:RadWindow>
            </Windows>
    </telerik:RadWindowManager>
            <telerik:RadWindowManager ID="RadWindowManager1" Behaviors="Close" runat="server" Behavior="Close" Skin="Vista">
            <Windows>
            <telerik:RadWindow ID="rwUnableDelete" runat="server" Title="Warning" Font-Size="Medium" Width="380%" Height="160%" VisibleOnPageLoad="true" Behaviors="Close">
                <ContentTemplate>
                    <br />
                    <div style="margin-left:30px">
                    <asp:Label ID="Label1" runat="server" Text="User is Logged in unable to Delete" Font-Size="Medium"></asp:Label>
                    </div>
                </ContentTemplate>
            </telerik:RadWindow>
            </Windows>
    </telerik:RadWindowManager>

        </div>
    </telerik:RadAjaxPanel>
</asp:Content>

