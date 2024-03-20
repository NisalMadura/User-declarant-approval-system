<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VerifyEmail.aspx.cs" Inherits="User_Account_webForm.VerifyEmail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Email Verification</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            margin-top: 0;
        }

        .btn-verify-email {
            display: block;
            width: 200px;
            margin: 0 auto;
            margin-top: 30px;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .btn-verify-email:hover {
            background-color: #0056b3;
        }

        .hidden {
            display: none;
        }
        .auto-style1 {
            display: block;
            margin-top: 0px;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
            margin-left: auto;
            margin-right: auto;
            margin-bottom: 0;
        }
        .auto-style2 {
            height: 40px;
            margin-top: 3px;
        }
        .auto-style3 {
            height: 28px;
            margin-top: 12px;
        }
    </style>
</head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>
<body style="height: 294px; margin-top: 124px;">
    <form id="form1" runat="server">
        <div class="container">
            <asp:Label ID="Label3" runat="server" Text="Label" Visible="False" CssClass="hidden"></asp:Label>
            <asp:Label ID="Label4" runat="server" Text="Label" Visible="False" CssClass="hidden"></asp:Label>
            <asp:Label ID="Label5" runat="server" Text="Label" Visible="False" CssClass="hidden"></asp:Label>
              <asp:Label ID="Label6" runat="server" Text="Label" Visible="False" CssClass="hidden"></asp:Label>

            <h1>Please Verify Your Email</h1>

            <div>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; You&#39;re almost here! We need to confirm Email </div>

            <div class="auto-style3">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="emailLabel" runat="server" Font-Bold="True" ></asp:Label>
            &nbsp;
            </div>

            <div class="auto-style2">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Just click on the Verify button and verify Email account.
            </div>

            <asp:Button ID="btn_VerifyEmail" runat="server" Text="Verify Email" CssClass="auto-style1" OnClick="btn_VerifyEmail_Click" BackColor="#339933" Font-Bold="True" Height="62px" />
        </div>
    </form>
</body>
</html>