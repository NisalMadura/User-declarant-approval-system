<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TimeOutPage.aspx.cs" Inherits="User_Account_webForm.TimeOutPage" %>

  

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Session Timeout</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 400px;
            margin: 100px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
        }

        p {
            color: #777;
            margin-bottom: 30px;
        }

        .btn {
            display: inline-block;
            background-color: #4CAF50;
            color: #fff;
            padding: 10px 20px;
            border-radius: 3px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #45a049;
        }

    </style>
    
    <script type ="text/javascript">  
  
    windowwindow.onload = window.history.forward(0);  
    
    </script>  

</head>
  
<body>


    <form id="form1" runat="server">
        <div class="container">
            <h1>Session Timeout</h1>
            <p>Your session has expired. Please log in again.</p>
            <a href="VerifyPagenew.aspx" class="btn">Log In</a>
        </div>
    </form>
    
</body>
</html>