﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RejectedApplications.aspx.cs" Inherits="User_Account_webForm.RejectedApplications" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
         @keyframes blinkAnimation {
        0% {
            opacity: 1;
        }
        50% {
            opacity: 0;
        }
        100% {
            opacity: 1;
        }
    }

    .blinking-button {
        animation: blinkAnimation 5s infinite;
    }
            
            .auto-style28 {
                height: auto;
            }

            
        .auto-style28 {
            height: 836px;
        }
        
        * {
           box-sizing: border-box;
         }

        .auto-style49 {
            font-style: inherit;
            color: #003366;
            font-family: Arial, Helvetica, sans-serif;
            text-decoration: blink;
            font-size: calc(1.375rem + 1.5vw);
            font-weight: 500;
            line-height: 1.2;
            margin-left: inherit;
            margin-right: inherit;
            margin-top: 0;
            margin-bottom: 0.5rem;
            height: 80px;
            width: 1255px;
        }

        .auto-style48 {
            vertical-align: middle;
            width: 120px;
            height: 44px;
        }
        
        .auto-style51 {
            height: 40px;
            margin-top: 0px;
        }

         .button-container {
    margin-top: 20px; /* Adjust as needed */
}

.auto-style52 {
    display: inline-block;
    margin-bottom: 10px; /* Adjust vertical spacing between buttons */
    padding: 6px 12px;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    cursor: pointer;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
    color: #fff;
    background-color: green;
    width: 200px;
}

   


        .auto-style31 {
            margin-top: 30px;
            width: 1231px;
        }

        .auto-style32 {
            margin-left: 79px;
            margin-top: 16px;
        }

        
        .modern-button {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        border-radius: 4px;
        cursor: pointer;
    }


        </style>
</head>
<body>
    <form id="form2" runat="server" class="auto-style28">
        <h1 class="auto-style49" style="font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif; font-weight: bold; font-size: xx-large;"><img alt="" class="auto-style48" src="../Upload/BOI1.png" />Declarant User Administration&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label1" runat="server" Font-Names="Cambria" Font-Size="Large" Text="Label"></asp:Label>
&nbsp;&nbsp; </h1>
<div class="button-container">        
            <asp:Button ID="btn_pendingApplication" runat="server" BackColor="#FF9900" CssClass="auto-style52 " OnClick="btn_pendingapplications_Click" Text="Pending Applications" />


            <asp:Button ID="btn_approvedApplication" runat="server" BackColor="#009900" CssClass="auto-style52 " OnClick="btn_approveapplications_Click" Text="Approved Applications"  />

            <asp:Button ID="btn_rejectedApplication" runat="server" BackColor="#990000" CssClass="auto-style52 blinking-button" OnClick="btn_rejectapplications_Click" Text="Rejected Applications" OnClientClick="startBlinking();" />

            <asp:Button ID="btn_processApplication" runat="server" BackColor="#990099" CssClass="auto-style52" OnClick="btn_processingapplications_Click" Text="Processing Applications"  />

            <asp:Button ID="btn_userstatus" runat="server" BackColor="#6699FF" CssClass="auto-style52" OnClick="btn_userstatus_Click" Text="View Existing User Details"  />

</div>
        <div class="auto-style31" style="font-family: Cambria; color: #003366; font-size: large; font-weight: bold">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblSearch" runat="server" Text="Search Document Number:" Font-Bold="True" Font-Names="Cambria"></asp:Label>
            <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
            &nbsp;&nbsp;&nbsp;
            <asp:Label ID="lbl_paycode" runat="server" Font-Names="Cambria" Font-Size="Large" Text="Label" Visible="False"></asp:Label>
            <br />
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Rejected Applications<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</div>
<asp:GridView ID="dashboad_gridview" runat="server" AutoGenerateColumns="False" OnRowCommand="dashboad_gridview_RowCommand" BackColor="#999999" BorderColor="Silver" BorderWidth="10px" CellPadding="5" CssClass="auto-style32" DataKeyNames="DOCNO" DataSourceID="SqlDataSource1" Height="200px" Width="1150px" Font-Names="Cambria" BorderStyle="None" GridLines="Vertical" >
          
    <Columns>
                <asp:BoundField DataField="TIN" HeaderText="TIN" SortExpression="TIN" HeaderStyle-HorizontalAlign="left">
<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:BoundField>
                <asp:BoundField DataField="DOCNO" HeaderText="Reference No" SortExpression="DOCNO" HeaderStyle-HorizontalAlign="left" InsertVisible="False" ReadOnly="True">
<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:BoundField>
                <asp:BoundField DataField="declarant_name" HeaderText="Company Name" SortExpression="declarant_name" HeaderStyle-HorizontalAlign="left" >
<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:BoundField>
                <asp:BoundField DataField="ForName" HeaderText="Reg Name" NullDisplayText="Not Include" ReadOnly="True" SortExpression="ForName" HeaderStyle-HorizontalAlign="left" >
<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:BoundField>
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" HeaderStyle-HorizontalAlign="left" />
                <asp:TemplateField HeaderText="Action" HeaderStyle-HorizontalAlign="left">
    <ItemTemplate>
        <asp:Button runat="server" Text="View" CommandName="ViewDetails" CommandArgument='<%# Container.DataItemIndex %>' CssClass="modern-button" />
    </ItemTemplate>

      
<HeaderStyle HorizontalAlign="Left"></HeaderStyle>

      
        </asp:TemplateField>

        
            </Columns>
            <EditRowStyle BackColor="#003366" />
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <HeaderStyle BackColor="#003366" Font-Bold="True" ForeColor="White" BorderColor="#003366" BorderStyle="None" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <RowStyle ForeColor="Black" BackColor="Silver" BorderStyle="None" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#007DBB" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#00547E" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:db_useraccountConnectionString1 %>" SelectCommand="SELECT D.TIN, D.DOCNO, D.declarant_name, CASE WHEN O.ForName = 'new tin' THEN 'New TIN' ELSE O.ForName END AS ForName, DocumentStatus.Date FROM tbl_declarant AS D INNER JOIN DocumentStatus ON D.DOCNO = DocumentStatus.DOCNO LEFT OUTER JOIN Onaccount.dbo.ISDeclarant AS O ON D.TIN = O.ForTIN WHERE (DocumentStatus.Status = 3) ORDER BY D.DOCNO DESC"></asp:SqlDataSource>
    </form>
    
        <div>
        </div>
    
</body>
</html>
