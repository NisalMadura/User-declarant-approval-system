﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApproveUser.aspx.cs" Inherits="User_Account_webForm.ApproveUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        /* Add these styles to your existing CSS */
.text-container {
    text-align: center;
}

.auto-style2 {
    font-family: Arial, Helvetica, sans-serif;
    color: #003366;
    text-decoration: blink;
    font-weight: normal;
    margin: 0;
    padding: 20px 0; /* Add vertical spacing */
}

        .auto-style3 {
            margin-left: 816px;
        }
        
        
      .main-footer {
    text-align: center;
    background-color: #FFFFFF;
    color: #808080;
    padding: 10px;
    position: absolute;
    bottom: 0;
    width: 100%;
}

        
.gridview-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

.auto-style4 {
    width: 100%;
    table-layout: fixed;
    border-collapse: collapse;
            margin-left: 175px;
            margin-right: 75px;
        }

    </style>                
</head>
<body>
    <form id="form1" runat="server">
        <div class="text-container">
        <h1 class="auto-style2">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;User Status
    </h1>
</div>

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="lblSearch" runat="server" Text="Search Document Number:" Font-Bold="True"></asp:Label>
    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="lblSearch0" runat="server" Text="Search TIN Number:" Font-Bold="True"></asp:Label>
    <asp:TextBox ID="txtSearch0" runat="server"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search" />



            <div>
    
</div>

            <br />
        
        <div class="gridview-container">
        <asp:GridView ID="GridView1" runat="server" Height="211px" Width="912px" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" CssClass="auto-style4" DataKeyNames="UserID" DataSourceID="SqlDataSource7" ForeColor="#333333" GridLines="None" PageSize="50" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="DOCNO" HeaderText="ReferenceNo" SortExpression="DOCNO" HeaderStyle-HorizontalAlign="Left" >
              
<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
              
                </asp:BoundField>
              
                <asp:BoundField DataField="UserID" HeaderText="UserID" ReadOnly="True" SortExpression="UserID" HeaderStyle-HorizontalAlign="Left">
<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:BoundField>
                <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" HeaderStyle-HorizontalAlign="Left" >
<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:BoundField>
                <asp:BoundField DataField="User_status" HeaderText="User_status" SortExpression="User_status" HeaderStyle-HorizontalAlign="Left">
<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:BoundField>
                <asp:BoundField DataField="TIN" HeaderText="TIN" SortExpression="TIN" HeaderStyle-HorizontalAlign="Left" >
<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:BoundField>
                <asp:BoundField DataField="declarant_name" HeaderText="Company Name" SortExpression="declarant_name" HeaderStyle-HorizontalAlign="Left" >
<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:BoundField>
                <asp:BoundField DataField="ApprovalDateTime" HeaderText="Approval DateTime" SortExpression="ApprovalDateTime" />
            </Columns>
            <EditRowStyle BackColor="#7C6F57" />
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" BorderStyle="None" />
            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#E3EAEB" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F8FAFA" />
            <SortedAscendingHeaderStyle BackColor="#246B61" />
            <SortedDescendingCellStyle BackColor="#D4DFE1" />
            <SortedDescendingHeaderStyle BackColor="#15524A" />
        </asp:GridView></div>
        <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:db_useraccountConnectionString1 %>" SelectCommand="SELECT tbl_user_details.DOCNO, tbl_user_details.UserID, tbl_user_details.UserName, tbl_user_details.User_status, tbl_declarant.TIN, tbl_declarant.declarant_name, tbl_user_details.ApprovalDateTime FROM tbl_user_details INNER JOIN tbl_declarant ON tbl_user_details.DOCNO = tbl_declarant.DOCNO ORDER BY tbl_user_details.DOCNO DESC"></asp:SqlDataSource>
        <br />
        <br />
        
            &nbsp;
        <div class="button-container">
    <asp:Button ID="btn_back" runat="server" BackColor="#999999" BorderColor="#999999" CssClass="auto-style3" Font-Bold="True" Height="35px" OnClick="btn_back_Click" Text="Back" Width="133px" />
</div>

        <br />
        <br />
        <br />
        <br />
        <div class="content-wrapper">
      <footer class="auto-style39" style="background-color: #FFFFFF; color: #000000; text-align: center;">
    <strong>
          <br />
        All rights reserved. & Copyright &copy; 2023 BOI IT Department.
    </strong>
    All rights reserved.
</footer>
            </div>
     
      
      
    </form>
</body>
</html>
