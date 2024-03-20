﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="User_Account_webForm.dashboard" %>

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


        .auto-style28 {
            height: 836px;
        }
        .swal2-popup {
        font-size: 18px; 
    }
  
        .btn-add {
        display: inline-block;
        padding: 6px 12px;
        margin-bottom: 0;
        font-size: 14px;
        font-weight: 400;
        line-height: 1.42857143;
        text-align: center;
        white-space: nowrap;
        vertical-align: middle;
        cursor: pointer;
        background-image: none;
        border: 1px solid transparent;
        border-radius: 4px;
        color: #fff;
        background-color: green;
        
        }

        @media screen and (max-width: 768px) {
            
            .auto-style28 {
                height: auto;
            }

            }
}

        .auto-style31 {
            margin-top: 30px;
            width: 1231px;
        }

        .auto-style32 {
            margin-left: 79px;
            margin-top: 16px;
            margin-right: 0px;
        }

        * {
           box-sizing: border-box;
         }

        .auto-style48 {
            vertical-align: middle;
            width: 120px;
            height: 44px;
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

        .auto-style51 {
            height: 40px;
            margin-top: 0px;
        }

        .auto-style52 {
            display: inline-block;
            padding: 6px 12px;
            margin-bottom: 0;
            font-size: 14px;
            font-weight: 400;
            line-height: 1.42857143;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            cursor: pointer;
            background-image: none;
            border: 1px solid transparent;
            border-radius: 4px;
            color: #fff;
            background-color: green;
            margin-left: 377px;
        }
        /* General styles for the buttons */
.btn-container {
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
}

.btn-container .btn {
    flex: 1;
    max-width: 207px;
    margin: 0 5px;
    padding: 8px 0;
    font-size: 16px;
    font-weight: bold;
    text-align: center;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

/* Specific styles for each button */
.pending-button {
    background-color: #FF9900;
}

.approved-button {
    background-color: #009900;
}

.rejected-button {
    background-color: #990000;
}

.processing-button {
    background-color: #990099;
}

.view-button {
    background-color: #6699FF;
}

/* Responsive adjustments */
@media screen and (max-width: 768px) {
    .btn-container {
        flex-direction: column;
    }

    .btn {
        max-width: none;
        margin: 5px 0;
    }
}

    </style>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>
   

</head>
<body class="background-image">
    <form id="form1" runat="server" class="auto-style28">
        <h1 class="auto-style49" style="font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif; font-weight: bold; font-size: xx-large;"><img alt="" class="auto-style48" src="/Upload/BOI1.png" />Declarant User Administration&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label1" runat="server" Font-Names="Cambria" Font-Size="Large" Text="Label"></asp:Label>
&nbsp;&nbsp; 
            <asp:Button ID="btn_logout" runat="server" BackColor="#666699" BorderColor="#99CCFF" CssClass="auto-style52 " OnClick="btn_logout_Click" Text="LogOut" Width="116px" BorderStyle="None" Height="34px" Font-Bold="True" style="margin-left: 21px" />

            <asp:Label ID="Label2" runat="server" Font-Size="Smaller" Text="Label" Visible="False"></asp:Label>

        </h1>
            <div class="auto-style51" style="font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif; font-size: large; font-weight: bold; color: #003366;">
    
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btn_pendingApplication" runat="server" BackColor="#FF9900" BorderColor="#99CCFF" CssClass="auto-style52 blinking-button" OnClick="btn_PendingApplications_Click" Text="Pending Applications" Width="178px" BorderStyle="None" Height="35px"  OnClientClick="startBlinking();" Font-Bold="True" style="margin-left: 21px" />

&nbsp;
            <asp:Button ID="btn_approvedApplication" runat="server" BackColor="#009900" BorderColor="#99CCFF" CssClass="auto-style52" OnClick="btn_ApproveApplications_Click" Text="Approved Applications" Width="185px" BorderStyle="None" Height="35px" Font-Bold="True" style="margin-left: 0px" />

            <asp:Button ID="btn_rejectedApplication" runat="server" BackColor="#990000" BorderColor="#99CCFF" CssClass="auto-style52 " OnClick="btn_RejectApplications_Click" Text="Rejected Applications" Width="178px" BorderStyle="None" Height="35px" Font-Bold="True" style="margin-left: 6px" />

            <asp:Button ID="btn_processApplication" runat="server" BackColor="#990099" BorderColor="#99CCFF" CssClass="auto-style52 " OnClick="btn_ProcessingApplications_Click" Text="Processing Applications" Width="197px" BorderStyle="None" Height="35px" Font-Bold="True" style="margin-left: 6px" />

            <asp:Button ID="btn_userstatus" runat="server" BackColor="#6699FF" BorderColor="#99CCFF" CssClass="auto-style52" OnClick="btn_userstatus_Click" Text="View Existing User Details" Width="207px" BorderStyle="None" Height="35px" Font-Bold="True" style="margin-left: 6px" />

</div>
        <div class="auto-style31" style="font-family: Cambria; color: #003366; font-size: large; font-weight: bold">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblSearch" runat="server" Text="Search Document Number:" Font-Bold="True" Font-Names="Cambria"></asp:Label>
            <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
            &nbsp;&nbsp;&nbsp;
            <asp:Label ID="lbl_paycode" runat="server" Text="Label" Visible="False"></asp:Label>
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pending Applications<br />
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
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:db_useraccountConnectionString1 %>" SelectCommand="SELECT D.TIN, D.DOCNO, D.declarant_name, CASE WHEN O.ForName = 'new tin' THEN 'New TIN' ELSE O.ForName END AS ForName, DocumentStatus.Date FROM tbl_declarant AS D INNER JOIN DocumentStatus ON D.DOCNO = DocumentStatus.DOCNO LEFT OUTER JOIN Onaccount.dbo.ISDeclarant AS O ON D.TIN = O.ForTIN WHERE (DocumentStatus.Status = 1) ORDER BY D.DOCNO DESC"></asp:SqlDataSource>
    </form>
</body>
</html>
