<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="admin_Page.aspx.cs" Inherits="User_Account_webForm.admin_Page" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

	
    <style>
        .approved-users {
    color: green;
}

.rejected-users {
    color: red;
}

.additional-comments {
    color: skyblue;
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
            margin-top: 13px;
            margin-left: 0px;
        }
        .auto-style3 {
            height: 205px;
        }
        .auto-style4 {
            height: 37px;
        }
        .auto-style9 {
            margin-left: 172px;
        }
        .auto-style10 {
            margin-left: 6px;
        }
        .auto-style23 {
            margin-left: 0px;
        }
        .auto-style24 {
            margin-left: 0px;
            width: 35px;
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
     .submit-button {
        background-color: #4CAF50;
        color: #fff;
        border-radius: 5px;
        padding: 10px 20px;
        border: none;
        cursor: pointer;
     }
    .clear-button {
        background-color: #f2f2f2;
        color: #000;
        border-radius: 5px;
        padding: 10px 20px;
        border: none;
        cursor: pointer;
    }

        .auto-style25 {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 68px;
            margin-left: 0px;
            width: 570px;
        }

        .auto-style27 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background-color: #4CAF50;
            color: #fff;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
            margin-top: 0px;
        }

        .auto-style28 {
            width: 113px;
            height: 43px;
            margin-left: 0px;
            left: auto;
        }

        .auto-style29 {
            margin-top: 20px;
            margin-left: 0;
        }
         .swal2-popup {
        font-size: 18px; 
    }

        .auto-style31 {
            margin-left: 2px;
            font-weight: bold;
        }
        .auto-style32 {
            width: 100%;
            margin-left: 0px;
        }

        .auto-style33 {
            margin-left: 4px;
        }
        .auto-style34 {
            margin-left: 11;
        }
        .auto-style35 {
            width: 618px;
        }

        .auto-style36 {
            height: 68px;
        }

        .auto-style37 {
            width: 563px;
        }

        .auto-style39 {
            width: 77px;
            height: 76px;
            margin-left: 48px;
            margin-top: 0px;
        }

        .auto-style40 {
            width: 787px;
            height: 86px;
            margin-left: 11px;
        }

        .auto-style41 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background-color: #4CAF50;
            color: #fff;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
            margin-left: 36px;
            margin-top: 0px;
        }

        </style>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js">
    </script>
   <%--  <script>
             function hideApproveButton() {
             var btnApprove = document.getElementById('btn_approveuser');
             btnApprove.style.display = 'none';
  
             localStorage.setItem('buttonVisible', 'false');
  
              return true;
              }

              window.onload = function() {
              var btnApprove = document.getElementById('btn_approveuser');
              var buttonVisible = localStorage.getItem('buttonVisible');
  
              if (buttonVisible === 'false') {
                    btnApprove.style.display = 'none';
              } else 

              {
              btnApprove.style.display = 'block';
              }
              };

    </script>--%>
 <!-- JavaScript function to show Sweet Alert -->

    <script>

    function showSweetAlert() {
        Swal.fire({
            title: 'Confirmation',
            text: 'Are you sure you want to approve this user?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes',
            cancelButtonText: 'No',
        }).then((result) => {
            if (result.isConfirmed) {
                approveUser();
            }
        });
    }

    function approveUser() {
        <%= ClientScript.GetPostBackEventReference(btn_approveuser, "") %>;
    }
</script>
     <script>
    function showSweetAlert2() {
        Swal.fire({
            title: 'Confirmation',
            text: 'Are you sure you want to reject this?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes',
            cancelButtonText: 'No',
        }).then((result) => {
            if (result.isConfirmed) {
                rejectUser();
            }
        });
    }

    function rejectUser() {
        <%= ClientScript.GetPostBackEventReference(btn_reject, "") %>;
    }
</script>





<body>
    <div class="auto-style25">
        <h1 style="font-family: Arial, Helvetica, sans-serif; color: #003366; text-decoration: blink; font-weight: bold; font-size: x-large;" class="auto-style37">
            <img alt="" class="auto-style28" src="/Upload/BOI1.png" style="text-align: left" />Application For The User Accounts</h1>
        <h1 style="font-family: Arial, Helvetica, sans-serif; color: #003366; text-decoration: blink; font-weight: bold; font-size: x-large;">
            &nbsp;</h1>
        <p style="font-family: Arial, Helvetica, sans-serif; color: #003366; text-decoration: blink; font-weight: bold; font-size: x-large;">&nbsp;</p>
    </div>
    <div class="center">
        <table class="auto-style3">
            <thead>
                <tr>
                    <th colspan="2" class="auto-style4" style="font-family: Arial, Helvetica, sans-serif; font-size: medium; color: #FFFFFF; background-color: #003366; font-weight: bold;">Declarant Company Details</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="auto-style35">TIN</td>
                    <td>
                        <asp:TextBox ID="txt_tin2" runat="server" BorderStyle="None" ReadOnly="True" Font-Bold="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style35">CHA No</td>
                    <td>
                        <asp:TextBox ID="txt_chano2" runat="server" BorderStyle="None" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style35">Company Name</td>
                    <td>
                        <asp:TextBox ID="txt_declarantname2" runat="server" BorderStyle="None" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style35">Company Address</td>
                    <td>
                        <asp:TextBox ID="txt_address2" runat="server" BorderStyle="None" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
   
        <br />
    




<div class="center">
        <table class="auto-style32">
            <thead>
                <tr>
                    <th colspan="2" style="font-family: Arial, Helvetica, sans-serif; font-weight: bold; font-size: medium; color: #FFFFFF; background-color: #003366">Details of Users<asp:Label ID="lbl_docno" runat="server" Text="Label" Visible="False"></asp:Label>
                    </th>
                </tr>
            </thead>
            
        </table>
    </div>
   
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="UserID" CssClass="auto-style1" Height="16px" Width="1144px" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" DataSourceID="SqlDataSource4" OnRowDataBound="GridView1_RowDataBound">
                <AlternatingRowStyle BackColor="lightgray" ForeColor="#284775" />
                <Columns>
                     <asp:BoundField DataField="UserName" HeaderText="Name" SortExpression="UserName" />
                    <asp:BoundField DataField="Email" HeaderText="E-mail Address" SortExpression="Email" />
                    <asp:BoundField DataField="UserID" HeaderText="UserID" ReadOnly="True" SortExpression="UserID" />
             <asp:TemplateField HeaderText="E-mail Verification Status">
            <ItemTemplate>
                <asp:Label ID="lblVerificationStatus" runat="server" Text='<%# GetVerificationStatus(Eval("VerificationStatus")) %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
                     <asp:TemplateField HeaderText="Approve Status">
                         <ItemTemplate>
                             <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="true" OnCheckedChanged="CheckBox_CheckedChanged"/>
                             <asp:Label ID="StatusLabel" runat="server"></asp:Label>
                         </ItemTemplate>
                     </asp:TemplateField>
                     
            
                   
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                <HeaderStyle BackColor="gray" Font-Bold="True" ForeColor="black"  />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle ForeColor="#333333" BackColor="#CCCCCC" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:db_useraccountConnectionString1 %>" SelectCommand="SELECT [UserName], [Email], [contact_no], [UserID], [VerificationStatus] FROM [tbl_user_details] WHERE ([DOCNO] = @DOCNO)" OnSelecting="SqlDataSource4_Selecting">
                <SelectParameters>
                    <asp:ControlParameter ControlID="lbl_docno" Name="DOCNO" PropertyName="Text" Type="Int32" />
                </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lbl_approve" runat="server" Font-Bold="True" ForeColor="#006600"></asp:Label>
    <asp:Label ID="lbl_adminEmail" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lbl_Phone" runat="server" Visible="False"></asp:Label>
 <div class="auto-style36">
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
     <label for="authorized-by" class="auto-style31">Support Documents</label><br />
     <br />
     </div>


    
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="PdfNo" DataSourceID="SqlDataSource5" CssClass="auto-style23" Width="1138px">
        <Columns>
            <asp:BoundField DataField="FilePath" HeaderText="File Name" SortExpression="FilePath" />
       <asp:TemplateField HeaderText="File">
                 <ItemTemplate>
                     <asp:LinkButton ID="LinkButton1" runat="server" Text="Download to view" OnClick="link_download" BackColor="Green" ForeColor="White"> </asp:LinkButton>
                    
                 </ItemTemplate>
             </asp:TemplateField>
            </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:db_useraccountConnectionString1 %>" SelectCommand="SELECT [FilePath], [FileData], [PdfNo] FROM [PdfFiles] WHERE ([DOCNO] = @DOCNO)">
        <SelectParameters>
            <asp:ControlParameter ControlID="lbl_docno" Name="DOCNO" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

  
    

    <br />

  
    

  <label for="authorized-by" class="auto-style33" style="font-weight: bold">Authorized by</label><br />
  &nbsp;<br />
    <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

  <label for="authorized-name" class="auto-style24">Name:</label>
  &nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="txt_authname2" runat="server" CssClass="auto-style23" Width="258px" BorderStyle="None" ReadOnly="True"></asp:TextBox>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

  &nbsp;&nbsp;
     <label for="authorized-Email" class="auto-style23">E-mail :<asp:TextBox ID="txt_authemail2" runat="server" Width="268px" BorderStyle="None" ReadOnly="true"></asp:TextBox>
     </label>
     <br />
     <br />
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

     <label for="authorized-name0" class="auto-style10">Date&nbsp; :</label><asp:TextBox ID="txt_authdate2" runat="server" Width="201px" BorderStyle="None" ReadOnly="True" CssClass="auto-style34" TextMode="DateTime"></asp:TextBox>
     <label for="authorized-contactno" class="auto-style9">Contact No :<asp:TextBox ID="txt_contactno2" runat="server" Width="222px" BorderStyle="None" ReadOnly="True"></asp:TextBox>
     </label><br />
     <br />
     &nbsp;
    <asp:Label ID="Label1" runat="server" ForeColor="Red" Text="Please provide a message in the comment box to be sent to the authorized person."></asp:Label>
<img class="auto-style39" src="/Upload//comm.png" /><br />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="lbl_comment" runat="server"></asp:Label>
    <br />
&nbsp;<textarea id="TextArea1" runat="server" class="auto-style40" name="S1" cols="12" placeholder="Drop Your Feedback..." ></textarea>
    <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
<asp:Button ID="btn_approveuser" runat="server" ClientIDMode="Static" CssClass="auto-style27" Height="53px" OnClick="btn_approveuser_Click" Text="Approve" Width="189px"  OnClientClick="showSweetAlert(); return false;"/>
     
    <asp:Button ID="btn_reject" runat="server" BackColor="#CC0000" ClientIDMode="Static" CssClass="auto-style41" Height="53px" OnClick="btn_rejectuser_Click" OnClientClick="showSweetAlert2(); return false;" Text="Reject" Width="189px" />
     
    <br />
     <br /> 
     <br />
 
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="btn_back" runat="server" BackColor="#CCCCCC" BorderColor="#CCCCCC" CssClass="auto-style29" Font-Bold="True" Height="38px" OnClick="btn_back_Click" Text="Back" Width="111px" />


    
    <br />
    </div>

</asp:Content>
