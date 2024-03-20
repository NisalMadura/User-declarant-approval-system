<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="User_Account_webForm.AdminLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">

        .auto-style1 {
            height: 118px;
            margin-top: 0px;
        }
        .auto-style36 {
            margin-left: auto;
            margin-right: auto;
        }
                        
        .auto-style36 {
            vertical-align: middle;
            width: 263px;
            height: 85px;
            border-style: none;
            border-color: inherit;
            border-width: 0;
            margin-left: 536px;
            margin-top: 23px;
            margin-right: 188px;
        }
        
        .auto-style40 {
            margin-left: 353px;
            margin-top: 62px;
        }
        .auto-style42 {
            height: 195px;
            margin-top: 70px;
            width: 636px;
        }
        .auto-style4 {
            margin-left: 5px;
        }
                
        .auto-style43 {
            display: inline-block;
            color: #fff;
            border-radius: 3px;
            text-decoration: none;
            transition: background-color 0.3s;
            margin-left: 269px;
            margin-top: 36px;
            padding: 10px 20px;
            background-color: #73b4ca;
        }
        .auto-style2 {
            height: 45px;
            margin-top: 0px;
        }
        .auto-style45 {
            margin-left: 179px;
            margin-top: 0px;
        }
        .auto-style39 {
            height: 58px;
            margin-top: 38px;
        }
         .auto-style46 {
            margin-left: 0px;
            margin-top: 25px;
        }
          .background-image {
            background-image: url('/Upload/Invest.jpg');
            background-repeat: no-repeat;
            background-size: cover;
        }

    </style>
</head>
<body class="background-image">
    <form id="form2" runat="server">
     
        <div class="auto-style1" style="background-color: #789CBC">
            <img alt="" class="auto-style36" src="/Upload/BOI1.png" style="border-style: none; padding: 0px; page-break-inside: avoid; max-width: 100%;" border="0" /><asp:Panel ID="Panel1" runat="server">
            </asp:Panel>
        </div>
        <asp:Panel ID="Panel2" runat="server" BackColor="#D7E3DF" BorderStyle="Ridge" CssClass="auto-style40" Height="320px" Width="637px">
            <p class="auto-style42" style="font-size: large; font-weight: bolder; font-family: Cambria;">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PayCode :
                <asp:TextBox ID="txt_Paycode" runat="server" BorderStyle="None" CssClass="auto-style4" Height="25px"  TextMode="Number" Width="218px"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Password:
                <asp:TextBox ID="txt_Password" runat="server" BorderStyle="None" CssClass="auto-style46" Height="25px" TextMode="Password" Width="218px"></asp:TextBox>
                &nbsp;<asp:Button ID="btn_submit" runat="server" BackColor="#006600" BorderStyle="None" CssClass="auto-style43" Height="45px"  Text="Submit" Width="112px" OnClick="btn_submit_Click" />
                <asp:TextBox ID="txt_adminName" runat="server" BorderStyle="None" CssClass="auto-style4" Height="25px" TextMode="Number" Visible="False" Width="218px"></asp:TextBox>
            </p>
            <p class="auto-style2" style="font-size: x-large; font-weight: bolder;">
                <asp:Label ID="lbl_Error" runat="server" BackColor="#D7E3DF" BorderStyle="None" CssClass="auto-style45" EnableTheming="True" Font-Bold="True" Font-Size="Smaller" ForeColor="#990000" Height="17px" Width="331px"></asp:Label>
            </p>
        </asp:Panel>
        <p>
            &nbsp;</p>
             <footer class="auto-style39" style="background-color: #789CBC; color: #000000;">
            <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                 <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Copyright &copy;    2023 BOI IT Department</strong>
                    All rights reserved.
            <div class="float-right d-none d-sm-inline-block">
      </div>
  </footer>
        
    </form>
    
        <div>
        </div>
    
</body>
</html>
