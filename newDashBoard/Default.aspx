<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href ="StyleSheet.css" rel = "stylesheet" />
    <script src="Scripts/jquery-1.12.4.js"></script>
    <script src="Scripts/jquery-ui-1.12.1.js"></script>
    <style type="text/css">
        #form1 {
            height: 377px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div ID ="dvDiv" class = "Element" style="position:absolute; top: 141px; left: 11px;">
           <asp:CheckBox ID="chkDetailsView" 
               AutoPostBack ="true"
               Checked="false"
               runat="server" OnCheckedChanged="chkDetailsView_CheckedChanged" />Show Details
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                <asp:Panel ID="dvPanel" runat="server" Visible ="false">
               <asp:DetailsView ID="dvEmployees" runat="server" AllowPaging="True" AutoGenerateRows="False" DataKeyNames="EmpID" DataSourceID="employeesTableDataSource">
                   <Fields>
                   
                       <asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" ReadOnly="True" SortExpression="EmpID" />
                       <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                       <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                       <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" />
                   </Fields>
                </asp:DetailsView>  <br />   
                    <asp:GridView ID="GridView1" runat="server" DataSourceID="salesTableDataSource" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID">
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                            <asp:BoundField DataField="EmpID" HeaderText="EmpID" SortExpression="EmpID" />
                            <asp:TemplateField HeaderText="DateSold" SortExpression="DateSold">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("DateSold") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("DateSold", "{0:d}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="MonthOnly" HeaderText="MonthOnly" SortExpression="MonthOnly" />
                            <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Amount") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Amount", "{0:c}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
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
        <asp:SqlDataSource ID="salesTableDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mydbaseConnectionString %>" DeleteCommand="DELETE FROM [SalesTable] WHERE [ID] = @ID" InsertCommand="INSERT INTO [SalesTable] ([EmpID], [DateSold], [MonthOnly], [Amount]) VALUES (@EmpID, @DateSold, @MonthOnly, @Amount)" SelectCommand="SELECT [ID], [EmpID], [DateSold], [MonthOnly], [Amount] FROM [SalesTable] WHERE ([EmpID] = @EmpID)" UpdateCommand="UPDATE [SalesTable] SET [EmpID] = @EmpID, [DateSold] = @DateSold, [MonthOnly] = @MonthOnly, [Amount] = @Amount WHERE [ID] = @ID">
            <DeleteParameters>
                <asp:Parameter Name="ID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="EmpID" Type="Int32" />
                <asp:Parameter DbType="Date" Name="DateSold" />
                <asp:Parameter Name="MonthOnly" Type="String" />
                <asp:Parameter Name="Amount" Type="Decimal" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="dvEmployees" Name="EmpID" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="EmpID" Type="Int32" />
                <asp:Parameter DbType="Date" Name="DateSold" />
                <asp:Parameter Name="MonthOnly" Type="String" />
                <asp:Parameter Name="Amount" Type="Decimal" />
                <asp:Parameter Name="ID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
        
        <script>
            $("#dvDiv").draggable();
            $(window).on('beforeunload', function () {
                var pos = $("#dvDiv").position();
                localStorage.setItem("dvDiv", JSON.stringify(pos))

            })

            var topLeft = JSON.parse(localStorage.getItem("dvDiv"))
            $("#dvDiv").css(topLeft);
    </script>
    </form>
    </body>
</html>
