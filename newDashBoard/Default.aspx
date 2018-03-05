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
       <asp:DropDownList 
           ID="ThemeList"
           runat="server"
           AutoPostBack="true">
           <asp:ListItem>Azure</asp:ListItem>
           <asp:ListItem>Bisque</asp:ListItem>
       </asp:DropDownList>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div id="dvDiv" class="Element" style="position: absolute">
            <asp:CheckBox
                ID="chkDetailsView"
                AutoPostBack="true"
                Checked="false"
                runat="server" 
                OnCheckedChanged="chkDetailsView_CheckedChanged" />Show Details
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <asp:Panel ID="dvPanel" Visible="false" runat="server">
                        <asp:DetailsView
                            ID="dvEmployees"
                            runat="server" 
                            AllowPaging="True" 
                            AutoGenerateRows="False" 
                            DataKeyNames="EmpID"  
                            DataSourceID="employeesTableDataSource" OnItemDeleted="dvEmployees_ItemDeleted">
                            <Fields>
                                <asp:BoundField DataField="EmpID" HeaderText="Employee ID" InsertVisible="False" ReadOnly="True" SortExpression="EmpID" />
                                <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                                <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" />
                            </Fields>
                        </asp:DetailsView>

                        <div id ="SummaryDiv">
                             <asp:GridView ID="gvSummary" runat="server" AutoGenerateColumns="False" DataSourceID="sqlSummarySalesTable">
                            <Columns>
                                <asp:TemplateField HeaderText="Total Sales" SortExpression="Column1">
                                    <EditItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Column1") %>'></asp:Label>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Column1", "{0:C}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="EmpID" HeaderText="EmpID" SortExpression="EmpID" />
                            </Columns>
                        </asp:GridView>
                        </div>
                            <asp:SqlDataSource ID="sqlSummarySalesTable" runat="server" ConnectionString="<%$ ConnectionStrings:mydbaseConnectionString %>" SelectCommand=" select sum(Amount), EmpID from SalesTable where EmpID=@EmpID
group by EmpID">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="dvEmployees" Name="EmpID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                       <div id="SalesDiv">
                        <asp:GridView ID="gvSales"  
                            runat="server" 
                            AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="salesTableDataSource" AllowPaging="True" AllowSorting="True" 
                            OnRowDeleted="gvSales_RowDeleted" 
                            OnRowUpdated="gvSales_RowUpdated">
                            <Columns>
                                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                                <asp:BoundField DataField="EmpID" HeaderText="EmpID" SortExpression="EmpID" />
                                <asp:TemplateField 
                                    HeaderText="DateSold" 
                                    SortExpression="DateSold">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" 
                                            runat="server" 
                                            Text='<%# Bind("DateSold") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label 
                                            ID="Label1" 
                                            runat="server" 
                                            Text='<%# Bind("DateSold","{0:d}") %>'>

                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="MonthOnly" HeaderText="MonthOnly" SortExpression="MonthOnly" />
                                <asp:TemplateField 
                                    HeaderText="Amount" 
                                    SortExpression="Amount">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox2" 
                                            runat="server" 
                                            Text='<%# Bind("Amount") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" 
                                            runat="server" 
                                            Text='<%#Bind("Amount","{0:C}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                       </div>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:SqlDataSource
                ID="employeesTableDataSource"
                runat="server" ConnectionString="<%$ ConnectionStrings:mydbaseConnectionString %>" DeleteCommand="DELETE FROM [EmployeesTable] WHERE [EmpID] = @EmpID" InsertCommand="INSERT INTO [EmployeesTable] ([FirstName], [LastName]) VALUES (@FirstName, @LastName)" SelectCommand="SELECT [EmpID], [FirstName], [LastName] FROM [EmployeesTable]" UpdateCommand="UPDATE [EmployeesTable] SET [FirstName] = @FirstName, [LastName] = @LastName WHERE [EmpID] = @EmpID">
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
        </div>

        <div id ="divSticky" class ="Element" style="position:absolute">
            <textarea id="txtSticky" cols="20" rows="10" style="background-color:yellow" spellcheck="true">

            </textarea>
        </div>

        <asp:Menu ID ="PrintMenu" runat="server" style="font-family:Arial; position:absolute">
            <Items>
                <asp:MenuItem Text="Print">
                    <asp:MenuItem Text="Summary Grid"></asp:MenuItem>
                    <asp:MenuItem Text="Sales Records"></asp:MenuItem>
                </asp:MenuItem>
            </Items>
        </asp:Menu>
        
    </form>
    <script>

        $("#dvDiv").draggable()
        $("#divSticky").draggable()
        $(window).on('beforeunload', function () {
            var pos = $("#dvDiv").position()
            var color = $("#ThemeList Option:Selected").text()
            localStorage.setItem('dvDiv', JSON.stringify(pos))
            localStorage.setItem('dvDivColor', color)

            var stickyPos = $('#divSticky').position()
            localStorage.setItem('StickyPosition', JSON.stringify(stickyPos))

            var text = $("#txtSticky").val();
            localStorage.setItem('StickyText', text)
        });
        var topLeft = JSON.parse(localStorage.getItem('dvDiv'))
        var backColor = localStorage.getItem('dvDivColor')
        var stickPos = JSON.parse(localStorage.getItem('StickyPosition'))
        var text = localStorage.getItem('StickyText')
        $("#ThemeList").val(backColor)
        $("#dvDiv").css(topLeft)
        $("#dvDiv").css("background-color", backColor)
        $("#divSticky").css(stickPos)
        $("#txtSticky").val(text)

        $("li>a").click(function () {
            if ($(this).text() == 'Sales Records')
            {
                var contents = document.getElementById("SalesDiv").innerHTML;
                var printWindow = window.open("", "", "width=500, height=500");
                printWindow.document.write(contents);
                printWindow.print()
                printWindow.close()
            }
            if ($(this).text() == 'Summary Grid') {
                var contents = document.getElementById("SummaryDiv").innerHTML;
                var printWindow = window.open("", "", "width=500, height=500");
                printWindow.document.write(contents);
                printWindow.print()
                printWindow.close()
            }
        })
    </script>
</html>
