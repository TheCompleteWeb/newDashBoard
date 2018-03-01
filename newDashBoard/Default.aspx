<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href ="StyleSheet.css" rel = "stylesheet" />
    <script src="Scripts/jquery-1.12.4.js"></script>
    <script src="Scripts/jquery-ui-1.12.1.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div ID ="dvDiv" class = "Element" style="position:absolute">
           <asp:CheckBox ID="chkDetailsView" 
               AutoPostBack ="true"
               Checked="false"
               runat="server" OnCheckedChanged="chkDetailsView_CheckedChanged" />Show Details
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                <asp:Panel ID="dvPanel" runat="server" Visible ="false">
               <asp:DetailsView ID="dvDetailsView" runat="server" AllowPaging="True" AutoGenerateRows="False" DataKeyNames="EmpID" DataSourceID="employeesTableDataSource">
                   <Fields>
                   
                       <asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" ReadOnly="True" SortExpression="EmpID" />
                       <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                       <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                       <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" />
                   </Fields>
                </asp:DetailsView>     
                </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
           
        </div> 
        <asp:SqlDataSource ID="employeesTableDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mydbaseConnectionString %>" DeleteCommand="DELETE FROM [EmployeesTable] WHERE [EmpID] = @EmpID" InsertCommand="INSERT INTO [EmployeesTable] ([FirstName], [LastName]) VALUES (@FirstName, @LastName)" SelectCommand="SELECT [EmpID], [FirstName], [LastName] FROM [EmployeesTable]" UpdateCommand="UPDATE [EmployeesTable] SET [FirstName] = @FirstName, [LastName] = @LastName WHERE [EmpID] = @EmpID">
            <DeleteParameters>
                <asp:Parameter Name="EmpID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
                <asp:Parameter Name="EmpID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
    <script>
        $("#dvDiv").draggable();
        $(window).on('beforeunload', function () {
            var pos = $("#dvDiv").position();
            localStorage.setItem("dvDiv", JSON.stringify(pos))

        })

        var topLeft = JSON.parse(localStorage.getItem("dvDiv"))
        $("#dvDiv").css(topLeft);
    </script>
</body>
</html>
