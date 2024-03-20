<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VerifyPagenew.aspx.cs" Inherits="User_Account_webForm.VerifyPage" %>


    <title></title>


    
    <style type="text/css">
        .auto-style1 {
            height: 129px;
            margin-top: 0px;
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
        .btn-verify {
            display: inline-block;
            background-color: #0099CC;
            color: #fff;
            padding: 10px 20px;
            border-radius: 3px;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        .auto-style39 {
    text-align: center; /* Center-align the text horizontally */
    padding: 15px 0; /* Add padding for spacing */
    background-color: #789CBC;
    color: #000000;
    margin-top: 210px;
            height: 35px;
        }

         .background-image {
            background-image: url('./Upload/back2.jpeg');
            background-repeat: no-repeat;
            background-size: cover;
        }
        /* Responsive Styles */
   
       

.auto-style40 {
    margin: 0 auto; 
    margin-top: 5%; 
    max-width: 80%; 
    padding: 20px; 
    box-sizing: border-box; 
    background-color: #D7E3DF;
    border-style: ridge;
}

       .auto-style42 {
    text-align: center;
    font-size: large;
    font-weight: bolder;
    margin-bottom: 10px;
            height: 96px;
        }

.email-label {
    display: block;
   
    max-width: 100%;
    text-align: center;
}
       
       
        .auto-style45 {
           text-align: center;
    font-size: smaller;
    font-weight: bold;
    font-family: Arial, Helvetica, sans-serif;
    color: #990000;
    margin-top: 10px;
        }
        .auto-style4 {
    box-sizing: border-box;
    width: 100%;
    max-width: 300px; /* Set maximum width for the textbox */
    margin: 0 auto; /* Center the textbox horizontally */
    padding: 3px;
}

.auto-style43 {
    display: block;
    color: #fff;
    border-radius: 3px;
    text-decoration: none;
    transition: background-color 0.3s;
    margin-top: 20px;
    padding: 10px 20px;
    background-color: #73b4ca;
    max-width: 200px;
    width: 100%;
    margin: 0 auto;
}

.auto-style46 {
    font-size: small;
    font-weight: bolder;
    font-family: Arial, Helvetica, sans-serif;
    color: #FF0000;
    margin-top: 10px;
}

.auto-style2 {
    font-size: x-large;
    font-weight: bolder;
    width: 100%;
    text-align: center;
    margin-top: 10px;
    color: #990000;
}
        


        </style>
    <script src = "https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>
    <script type="text/javascript">
        function disableButton() {
            var btnSubmit = document.getElementById('<%= btn_submit.ClientID %>');
            
            btnSubmit.disabled = true;
            btnSubmit.style.display = 'none';
           
        setTimeout(function() {
            btnSubmit.disabled = false;
            btnSubmit.style.display = 'block';

        }, 60000); 
    }
    </script>
    </head>
<body class="background-image">
    <form id="form1" runat="server">
     
        <div class="auto-style1" style="background-color: #789CBC">
            <img alt="" class="auto-style36" src="./Upload/BOI1.png" style="border-style: none; padding: 0px; page-break-inside: avoid; max-width: 100%;" border="0" /><asp:Panel ID="Panel1" runat="server">
            </asp:Panel>
        </div>
        <asp:Panel ID="Panel2" runat="server" BackColor="#D7E3DF" BorderStyle="Ridge" CssClass="auto-style40" Height="290px" Width="771px">
            <p class="auto-style42" style="font-size: large; font-weight: bolder;">
                E-mail :
                <asp:TextBox ID="txt_Email" runat="server" CssClass="auto-style4" Height="25px" Width="218px" TextMode="Email" BorderStyle="None"></asp:TextBox><br><br>
                <asp:Button ID="btn_submit" runat="server" BackColor="#0099CC" CssClass="auto-style43" OnClick="btn_submit_Click" Text="Verify" Width="112px" Height="45px" BorderStyle="None" />
            </p>
            <p class="auto-style46" style="font-size: small; font-weight: bolder; font-family: Arial, Helvetica, sans-serif; color: #FF0000;">
                &nbsp;&nbsp; Note-This page needs to be verified by an enterprise-authorized person using their email.</p>
            <p class="auto-style2" style="font-size: x-large; font-weight: bolder;">
                <asp:Label ID="lbl_Error" runat="server" BackColor="#D7E3DF" BorderStyle="None" CssClass="auto-style45" EnableTheming="True" Font-Bold="True" Font-Size="Smaller" ForeColor="#990000" Height="17px" Width="215px"></asp:Label>
            </p>
        </asp:Panel>
        <p>
            &nbsp;</p>
             <footer class="auto-style39" style="background-color: #789CBC; color: #000000;">
            <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                 <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Copyright &copy;    2023 BOI IT Department.</strong>
                    All rights reserved.
            <div class="float-right d-none d-sm-inline-block">
      </div>
  </footer>
        </p>
    </form>
</body>
</html>
