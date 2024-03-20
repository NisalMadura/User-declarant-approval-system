<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataGridView.aspx.cs" Inherits="User_Account_webForm.DataGridView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            User Accounts Details</div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:db_useraccountConnectionString %>" DeleteCommand="DELETE FROM [tbl_user_details] WHERE [UserID] = @UserID" InsertCommand="INSERT INTO [tbl_user_details] ([UserName], [Email], [contact_no], [UserID], [User_status]) VALUES (@UserName, @Email, @contact_no, @UserID, @User_status)" SelectCommand="SELECT * FROM [tbl_user_details]" UpdateCommand="UPDATE [tbl_user_details] SET [UserName] = @UserName, [Email] = @Email, [contact_no] = @contact_no, [User_status] = @User_status WHERE [UserID] = @UserID">
            <DeleteParameters>
                <asp:Parameter Name="UserID" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="UserName" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="contact_no" Type="Int32" />
                <asp:Parameter Name="UserID" Type="String" />
                <asp:Parameter Name="User_status" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="UserName" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="contact_no" Type="Int32" />
                <asp:Parameter Name="User_status" Type="String" />
                <asp:Parameter Name="UserID" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="UserID" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" Height="118px" Width="791px">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:BoundField DataField="contact_no" HeaderText="contact_no" SortExpression="contact_no" />
                <asp:BoundField DataField="UserID" HeaderText="UserID" ReadOnly="True" SortExpression="UserID" />
                <asp:BoundField DataField="User_status" HeaderText="User_status" SortExpression="User_status" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
    </form>
</body>
</html>
