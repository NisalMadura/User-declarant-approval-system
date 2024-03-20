<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="User_Acc.aspx.cs" Inherits="User_Account_webForm.User_Acc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

	
    <style>
       
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
        .center {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
        }
        table {
            margin-top: 20px;
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }

         .approve-btn {
           background-color: green;
           color: white;
           border: none;
           padding: 8px 16px;
           border-radius: 4px;
           cursor: pointer;
          }
        .auto-style1 {
            margin-top: 0px;
        }
        .auto-style3 {
            height: 205px;
        }
        .auto-style4 {
            height: 37px;
        }
        .auto-style5 {
            width: 71px;
            margin-left: 154px;
        }
        .auto-style10 {
            margin-left: 6px;
        }
        .auto-style11 {
            margin-left: 8px;
            width: 50px;
        }
        .auto-style16 {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 116px;
            width: 1160px;
            margin-left: 0px;
        }
        .auto-style19 {
            width: 96%;
            height: 137px;
            margin-top: 78px;
            margin-bottom: 14px;
        }
        .auto-style20 {
            width: 158px;
        }
        .auto-style24 {
            margin-left: 0px;
        }
        
        .btn {
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
        background-color: skyblue;
        
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
        .btn-clear {
        
        border-radius: 5px;
        padding: 10px 20px;
        border: none;
        cursor: pointer;
        
         }
        .submit-button {
        background-color: #4CAF50;
        color: #fff;
        border-radius: 5px;
        padding: 10px 20px;
        border: none;
        cursor: pointer;
        }
    
        .error {
         color: red;
        }

        .modern-textbox {
             height: 34px;
             width: 1366px;
             border: none;
             font-weight: bold;
             color: #CC0000;
  
}

        .auto-style27 {
            margin-right: 0px;
            margin-top: 0;
        }
        .auto-style30 {
            width: 268px;
        }
        .auto-style31 {
            height: 66px;
            width: 267px;
        }
        .auto-style32 {
            width: 268px;
            height: 66px;
        }
        .auto-style34 {
            width: 158px;
            height: 66px;
        }

        .auto-style35 {
            width: 137px;
            height: 49px;
        }
        .swal2-popup {
            font-size: 18px;
        }
        .drag-drop-box {
            border: 2px dashed #ccc;
            padding: 20px;
            text-align: center;
        }
        
        #uploaded-files {
            margin-top: 20px;
        }
        
        .uploaded-file {
            margin-bottom: 10px;
        }
    

    


        .auto-style36 {
            width: 210px;
        }
        .auto-style37 {
            height: 66px;
            width: 210px;
        }
        .auto-style38 {
            width: 267px;
        }
        .auto-style39 {
            margin-left: 17px;
        }
        .auto-style40 {
            margin-left: 5px;
        }
        .auto-style41 {
            margin-right: 0px;
            margin-top: 103px;
        }
        .auto-style42 {
            margin-left: 0px;
            margin-top: 44px;
        }
    

    


        .auto-style43 {
            margin-left: 28px;
        }
    

    


        .auto-style46 {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            width: 684px;
        }
        .auto-style47 {
            width: 694px;
        }
    

    


        .auto-style48 {
            margin-top: 25px;
            margin-bottom: 0;
        }
    

    


        .auto-style49 {
            width: 202px;
        }
        .auto-style50 {
            width: 202px;
            height: 66px;
        }
    

    


        .auto-style51 {
            margin-left: 0;
            margin-top: 25px;
        }
    
        .tinTextBox {
           border: 3px solid green;
         }
        .errorTextBox {
           border: 3px solid red;
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
            margin-left: 1066px;
            margin-top: 8px;
        }

        /* Base styles */
body {
    font-family: Arial, Helvetica, sans-serif;
    line-height: 1.6;
    margin: 0;
    padding: 0;
    background-color: #f2f2f2;
}

/* Center content */
.center {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
}

/* Main table styles */
table {
    margin-top: 20px;
    border-collapse: collapse;
    width: 100%;
}

th, td {
    padding: 8px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

th {
    background-color: #f2f2f2;
}

/* Form elements */
input[type="text"], input[type="email"], input[type="tel"] {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

/* Buttons */
.btn, .btn-add, .btn-clear, .submit-button {
    display: inline-block;
    padding: 10px 20px;
    margin: 5px;
    font-size: 14px;
    font-weight: bold;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    cursor: pointer;
    border: none;
    border-radius: 4px;
    color: #fff;
}

.btn {
    background-color: skyblue;
}

.btn-add {
    background-color: green;
}

.btn-clear {
    background-color: gray;
    color: white;
}

.submit-button {
    background-color: #4CAF50;
}

/* Error messages */
.error {
    color: red;
}

/* Responsive styles */
@media (max-width: 768px) {
    /* Adjust font size for smaller screens */
    body {
        font-size: 14px;
    }

    /* Center the logo on smaller screens */
    .auto-style46 {
        width: 100%;
    }

    /* Adjust the table width */
    .auto-style19 {
        width: 100%;
    }

    /* Adjust the buttons on smaller screens */
    .auto-style52 {
        margin-left: 0;
    }

    /* Hide the blinking effect on smaller screens */
    .blinking-button {
        animation: none;
    }
}


        </style>
    <script src = "https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.css">

    <!-- Font Awesome for the loading spinner -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <script type="text/javascript">
            function alertme() {

                swal("", "Please wait.... ", "success");

                window.setTimeout(function () {

                    
                    window.location.href ="TimeOutPage.aspx";

                }, 3000);

            }

        </script>


<body>

    <div class="auto-style46">
        <h1 style="margin: inherit; font-style: inherit; color: #003366; font-family: Arial, Helvetica, sans-serif; text-decoration: blink; font-size: x-large; font-weight: bold;" class="auto-style47"><img alt="" class="auto-style35" src="./Upload/BOI1.png" />User Registration For Declarant Portal</h1></div>
    <div class="center">
        <table class="auto-style3">
            <thead>
                <tr>
                    <th colspan="2" class="auto-style4" style="font-style: inherit; color: #FFFFFF; background-color: #003366; font-weight: bold; font-size: medium; font-family: Arial, Helvetica, sans-serif;">Declarant Company Details</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>TIN</td>
                    <td>
                        <asp:TextBox ID="txt_tin" runat="server" ValidationGroup=" g2" Font-Bold="True" Width="1217px" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="TINrequired" runat="server" ControlToValidate="txt_tin" ErrorMessage="TIN is required" CssClass="error" ></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="TINValidate" runat="server" ControlToValidate="txt_tin" ErrorMessage="TIN must be a 9-digit number" ValidationExpression="^\d{9}$" CssClass="error" ValidationGroup="TINValidate"></asp:RegularExpressionValidator>
                        
                    </td>
                </tr>
                <tr>
                    <td>CHA No</td>
                    <td>
                        <asp:TextBox ID="txt_chano" runat="server" ValidationGroup="g2"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="CHANorequired" runat="server" ControlToValidate="txt_chano" ErrorMessage="CHA NO is required" CssClass="error"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="CHAValidator" runat="server" ControlToValidate="txt_chano" ErrorMessage="CHA NO must be a number" ValidationExpression="\d+" CssClass="error"></asp:RegularExpressionValidator>

                    </td>
                </tr>
                <tr>
                    <td>Company Name</td>
                    <td>
                        <asp:TextBox ID="txt_declarantname" runat="server" ValidationGroup=" g2"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="Namerequired" runat="server" ControlToValidate="txt_declarantname" ErrorMessage="Name is required" CssClass="error"></asp:RequiredFieldValidator>

                        </td>
                </tr>
                <tr>
                    <td>Company Address</td>
                    <td>
                        <asp:TextBox ID="txt_address" runat="server" ValidationGroup=" g2"></asp:TextBox>
                       <asp:RequiredFieldValidator ID="addressrequired" runat="server" ControlToValidate="txt_address" ErrorMessage="Address is required" CssClass="error"></asp:RequiredFieldValidator>

                        <asp:Button ID="btn_TinVerify" runat="server" BackColor="#996633" BorderStyle="None" Font-Bold="True" ForeColor="White" OnClick="btn_TinVerify_Click" Text="Next" ValidationGroup="g2" CssClass="btn-add blinking-button" />

                    </td>
                </tr>
            </tbody>
        </table>
    </div>
   
             <asp:Panel ID="Panel1" runat="server">    
<div class="center">
        <table class="auto-style4">
            <thead>
                <tr>
                    <th colspan="2" style="border-style: inherit; font-style: inherit; color: #FFFFFF; white-space: normal; background-color: #003366; line-height: normal; font-family: Arial, Helvetica, sans-serif; font-weight: bold; font-size: medium;">Details of Users</th>
                </tr>
            </thead>
            
        </table>
    </div>
    <div class="auto-style16">
        <table class="auto-style19">
            <thead>
                <tr>
                    <th style="font-family: Arial, Helvetica, sans-serif; background-color: #C0C0C0" class="auto-style36">Name(Initial,Last Name)</th>
                    <th style="font-family: Arial, Helvetica, sans-serif; background-color: #C0C0C0" class="auto-style38">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E-mail Address</th>
                    <th class="auto-style30" style="font-family: Arial, Helvetica, sans-serif; background-color: #C0C0C0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Contact Tel.No</th>
                    <th class="auto-style49" style="font-family: Arial, Helvetica, sans-serif; background-color: #C0C0C0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UserID*</th>
                    <th class="auto-style20" style="font-family: Arial, Helvetica, sans-serif; background-color: #C0C0C0"></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="auto-style37">
                        <asp:TextBox ID="txt_name" runat="server" Width="177px" ValidationGroup="g2" Height="25px" CssClass="auto-style48"></asp:TextBox>
<asp:RegularExpressionValidator ID="regexValidator" runat="server" ControlToValidate="txt_name"
    ValidationExpression="^[a-zA-Z\s]+$" ErrorMessage="Only letters are allowed" ValidationGroup="g2" ForeColor="Red"></asp:RegularExpressionValidator>


                    </td>
                    <td class="auto-style31">
                        <asp:TextBox ID="txt_email" runat="server" CssClass="auto-style27" Height="25px" Width="223px" ValidationGroup="g2"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="emailValidator" runat="server" ControlToValidate="txt_email" ErrorMessage="Please enter a valid email address" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" Display="Dynamic" ForeColor="Red" />

                        </td>
                    <td class="auto-style32">
                        <asp:TextBox ID="txt_contact" runat="server" Height="25px" Width="217px" TextMode="Phone" ValidationGroup="g2"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="contactValidator" runat="server" ControlToValidate="txt_contact" ErrorMessage="Please enter valid contact number" ValidationExpression="^\d{10}$" Display="Dynamic" forecolor="Red"/>

                    </td>
                    <td class="auto-style50">
                        <asp:TextBox ID="txt_userId" runat="server" ValidationGroup="g2" Height="25px" Width="213px" CssClass="auto-style51"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="userIdValidator" runat="server" ControlToValidate="txt_userId"
                        ValidationExpression="^[a-zA-Z\s]+$" ErrorMessage="Only letters are allowed" ValidationGroup="g2" ForeColor="Red"></asp:RegularExpressionValidator>

                    </td><div>
                  <td class="auto-style34">
                      <asp:Button ID="btn_adduser" runat="server"  Text="ADD" CssClass="btn-add" OnClick="btn_adduser_Click" ValidationGroup="g2" />

                &nbsp;&nbsp;&nbsp;
                      </div>
                </tr>
            </tbody>
           
        </table>
        
    </div>

            <asp:Label ID="lbl_usermessage" runat="server" BackColor="#F2F2F2" BorderStyle="None" ForeColor="#006600" Font-Bold="True" CssClass="auto-style41" Height="16px" Width="207px"></asp:Label>
         
            <asp:Label ID="lbl_usererror" runat="server" BorderStyle="None" ForeColor="#CC0000" Font-Bold="True" CssClass="auto-style42" Height="17px"></asp:Label>
           




                 <asp:Label ID="lbl_adminEmail" runat="server" Visible="False"></asp:Label>
                 <asp:Label ID="lbl_Phone" runat="server" Visible="False"></asp:Label>
           




            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="UserID" CssClass="auto-style1" Height="16px" Width="1158px" ForeColor="#333333" GridLines="None" BackColor="Black" OnRowDeleting="GridView1_RowDeleting">
                <AlternatingRowStyle BackColor="lightgray" ForeColor="#333333" />
                <Columns>
                    <asp:BoundField DataField="UserName" HeaderText="Name" SortExpression="UserName" />
                    <asp:BoundField DataField="Email" HeaderText="E-mail Address" SortExpression="Email" />
                    <asp:BoundField DataField="contact_no" HeaderText="Contact Tel.No" SortExpression="contact_no" />
                    <asp:BoundField DataField="UserID" HeaderText="UserID" ReadOnly="True" SortExpression="UserID" />
                     
                    <asp:CommandField ButtonType="Button" HeaderText="Action" ShowDeleteButton="True" ShowHeader="True" >
           
    
                     
                    <ControlStyle BackColor="#CC0000" ForeColor="White" />
                    </asp:CommandField>
           
    
                     
                </Columns>
                <EditRowStyle BackColor="#CCCCCC" />
                <FooterStyle BackColor="#003366" ForeColor="White" Font-Bold="True" BorderColor="#003366" />
                <HeaderStyle BackColor="gray" Font-Bold="True" ForeColor="black"  />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle ForeColor="#333333" BackColor="#CCCCCC" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:db_useraccountConnectionString %>" SelectCommand="SELECT [UserName], [Email], [contact_no], [UserID] FROM [tbl_user_details] WHERE ([DOCNO] = @DOCNO)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="DOCNO" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
    <div>
        <asp:Button ID="btn_Next" runat="server" BackColor="#996633" BorderStyle="None" CssClass="auto-style52" Font-Bold="True" ForeColor="White" OnClick="btn_next" Text="Next" ValidationGroup="g2" />
    </asp:Panel>
     <br />  <asp:Panel ID="Panel2" runat="server">
  <label for="authorized-by" style="font-weight: bold">Authorized by</label>
        <br />
     <br />
        &nbsp;&nbsp;&nbsp;&nbsp;<label for="authorized-name" class="auto-style11">Name</label>&nbsp;&nbsp;
     <asp:TextBox ID="txt_authname" runat="server" CssClass="auto-style24" Width="224px" ValidationGroup="g1" ></asp:TextBox>
     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_authname" ErrorMessage="Name is required" Text="Name is required" CssClass="error"></asp:RequiredFieldValidator>

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<label for="authorized-contactno" class="auto-style24"> Contact No:<asp:TextBox ID="txt_contactno" runat="server" Width="222px" TextMode="Phone" ValidationGroup="g1" CssClass="auto-style40"></asp:TextBox>
          <asp:RequiredFieldValidator ID="RequiredcontactValidator" runat="server" ControlToValidate="txt_contactno" ErrorMessage="Contact No is required" Text="Contact No is required" CssClass="error"></asp:RequiredFieldValidator>

        </label>


     <br />
     <br />

  <label for="authorized-name0" class="auto-style10" >&nbsp;&nbsp;&nbsp;&nbsp;Date:</label><asp:TextBox ID="txt_authdate" runat="server" Width="224px" ValidationGroup="g1" CssClass="auto-style43" ReadOnly="True" TextMode="DateTime" Height="33px"></asp:TextBox>
          <asp:RequiredFieldValidator ID="RequiredDateValidator" runat="server" ControlToValidate="txt_authdate" ErrorMessage="Date is required" Text="Date is required" CssClass="error"></asp:RequiredFieldValidator>


     <label for="authorized-Email" class="auto-style5">E-mail:</label><asp:TextBox ID="txt_authemail" runat="server" CssClass="auto-style39" Width="224px" TextMode="Email" ValidationGroup="g1" ReadOnly="True"></asp:TextBox>
          <asp:RequiredFieldValidator ID="RequiredEmailValidator" runat="server" ControlToValidate="txt_authemail" ErrorMessage="Email is required" Text="Email is required" CssClass="error"></asp:RequiredFieldValidator>

        &nbsp
     
     <br />
     <br />
        &nbsp;
     
     <br />
     <br /> <br />
     <br />
     </div>
     <br />
     <br />
       <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <asp:Button ID="Buttonclear" runat="server" CssClass="btn-clear" Height="59px" OnClick="Buttonclear_Click" Text="Clear" Width="207px" BackColor="Gray" BorderStyle="None" Font-Bold="True" Font-Overline="False" ForeColor="White"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
     <asp:Button ID="Button2" runat="server" CssClass="submit-button blinking-button" OnClientClick="alertme()" Height="59px" OnClick="Button2_Click" Text="Apply" Width="201px" BackColor="Green" BorderStyle="None" Font-Bold="True" Font-Overline="False" ForeColor="White"/>
           
           <%--  --%>
           <br /></div>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="lbl_sucessmessage" runat="server" ForeColor="#006600" Font-Bold="True"></asp:Label>
    
    <br />
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

     <asp:Label ID="lbl_error" runat="server" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
    
     <br /> </asp:Panel>
    </body>
</asp:Content>
