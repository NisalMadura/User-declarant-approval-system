<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="User_Account_webForm.AdminLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">

        .auto-style1 {
            height: 117px;
            margin-top: 0px;
        }
        .auto-style36 {
            margin-left: auto;
            margin-right: auto;
        }
                        
         .auto-style36 {
            display: block;
            /* Center the image horizontally */
            max-width: 100%; /* Make the image responsive */
            height: 84px; /* Preserve the image's aspect ratio */
            border-style: none;
            border-color: inherit;
            border-width: 0;
            margin-top: 15px;
            width: 267px;
            margin-left: auto;
            margin-right: auto;
            margin-bottom: 0;
        }
        
        .auto-style40 {
    text-align: center;
    border-style: ridge;
    padding: 20px;
    max-width: 800px; /* Set maximum width for responsiveness */
    /* Limit width based on viewport */
    margin: 0 auto; /* Center the panel horizontally */
    background-color: #D7E3DF;
}
}
        .auto-style42 {
    text-align: center;
    font-size: large;
    font-weight: bolder;
    font-family: Cambria;
    margin: 0;
}
        .auto-style4,
.auto-style46 {
    margin: 5px; /* Add spacing between elements */
}

                
       
.auto-style43 {
    display: block;
    color: #fff;
    border-radius: 3px;
    text-decoration: none;
    transition: background-color 0.3s;
    margin: 0 auto; /* Center the button horizontally */
    margin-top: 36px;
    padding: 10px 20px;
    background-color: #73b4ca;
    max-width: 112px; /* Set maximum width for responsiveness */
    width: 80%; /* Limit width based on viewport */
    cursor: pointer; /* Add cursor style for consistency */
}

        .auto-style2 {
            height: 45px;
            margin-top: 0px;
        }
       .auto-style45 {
    font-size: smaller;
    font-weight: bold;
    color: #990000;
    margin: 10px 0; /* Add spacing */
}
        .auto-style39 {
            height: 48px;
            margin-top: 250px;
        }
         .auto-style46 {
            margin-left: 0px;
            margin-top: 25px;
        }
          .background-image {
            background-image: url('../Uploadadmin/Invest3.jpg');
            background-repeat: no-repeat;
            background-size: cover;
        }

    </style>
</head>
<body class="background-image">
    <form id="form2" runat="server">
     
        <div class="auto-style1" style="background-color: #8C7777">
            <img alt="" class="auto-style36" src="../Uploadadmin/BOI1.png" style="border-style: none; padding: 0px; page-break-inside: avoid; max-width: 100%;" border="0" /></div><br><br><br><br>
        <asp:Panel ID="Panel2" runat="server" BackColor="#D7E3DF" BorderStyle="Ridge" CssClass="auto-style40" Height="257px" Width="546px">
            <p class="auto-style42" style="font-size: large; font-weight: bolder; font-family: Cambria;">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;PayCode :
                <asp:TextBox ID="txt_Paycode" runat="server" BorderStyle="None" CssClass="auto-style4" Height="25px"  TextMode="Number" Width="218px"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
            <p class="auto-style42" style="font-size: large; font-weight: bolder; font-family: Cambria;">
                &nbsp;&nbsp;&nbsp;Password:
                <asp:TextBox ID="txt_Password" runat="server" BorderStyle="None" CssClass="auto-style46" Height="25px" TextMode="Password" Width="218px"></asp:TextBox>
                &nbsp;<asp:Button ID="btn_submit" runat="server" BackColor="#006600" BorderStyle="None" CssClass="auto-style43" Height="45px" OnClick="btn_submit_Click" Text="Submit" Width="112px" />
                <asp:TextBox ID="txt_adminName" runat="server" BorderStyle="None" CssClass="auto-style4" Height="25px" TextMode="Number" Visible="False" Width="218px"></asp:TextBox>
            </p>
            <p class="auto-style2" style="font-size: x-large; font-weight: bolder;">
                <asp:Label ID="lbl_Error" runat="server" BackColor="#D7E3DF" BorderStyle="None" CssClass="auto-style45" EnableTheming="True" Font-Bold="True" Font-Size="Smaller" ForeColor="#990000" Height="17px" Width="331px"></asp:Label>
            </p>
        </asp:Panel>
        <div class="content-wrapper">
      <footer class="auto-style39" style="background-color: #8C7777; color: #000000; text-align: center;">
    <strong>
          <br />
        All rights reserved. & Copyright &copy; 2023 BOI IT Department.
    </strong>
    All rights reserved.
</footer>
            </div>
        
    </form>
    
        <div>
        </div>
    
</body>
</html>
