<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PdfUploadNew.aspx.cs" Inherits="User_Account_webForm.PdfUpload" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .file-upload-container {
            border: 2px dashed #ccc;
            padding: 20px;
            text-align: center;
        }

        .uploaded-files {
            margin-top: 50px;
            display: flex;
            flex-wrap: wrap;
        }

        .uploaded-file {
            margin: 5px;
            display: flex;
            align-items: center;

        }
        .file-name {
            margin-right: 10px;
        }
        .delete-button {
            margin-left: 10px;
            border: none;
            cursor: pointer;
        }
       
        .auto-style4 {
            height: 436px;
        }
        .auto-style7 {
    border: 1px inset #808080;
    background-color: #CCCCFF;
    text-align: center;
    padding: 20px;
    margin: 0 auto; /* Center the container horizontally */
    max-width: 784px; /* Set maximum width for responsiveness */
    width: 80%; /* Limit width based on viewport */
            height: 173px;
        }
       .auto-style8 {
    text-align: center;
    background-color: #FFFFFF;
    color: #808080;
    padding: 10px;
    position: absolute;
    bottom: 0;
    width: 100%;
    height: 48px; /* Set the desired footer height */
}
     
       /* Add these styles to your existing CSS */
.auto-style27 {
    border: none;
    background-color: #4CAF50;
    color: #fff;
    border-radius: 5px;
    padding: 10px 20px;
    cursor: pointer;
    display: block;
    margin: 0 auto; /* Center the button horizontally */
    margin-top: 19px;
    width: 95px;
}

        .auto-style47 {
            width: 694px;
        }
    
        .red-button {
            background-color: darkred;
            color: white;
            border:none;
        }
        .wrong-mark {
            color: red;
            font-size: 20px;
        }

   
        

       h1, .h1 {
          font-size: 2.5rem;
        }

       h1, .h1 {
         font-size: calc(1.375rem + 1.5vw);
        }

        h6, .h6, h5, .h5, h4, .h4, h3, .h3, h2, .h2, h1, .h1 {
           margin-top: 0;
           margin-bottom: 0.5rem;
           font-weight: 500;
           line-height: 1.2;
         }

        *,
        *::before,
        *::after {
           box-sizing: border-box;
         }

        .auto-style48 {
            vertical-align: middle;
            width: 106px;
            height: 44px;
        }
        /* Add these styles to your existing CSS */
.auto-style1 {
    border: 2px dashed #ccc;
    padding: 20px;
    text-align: center;
    margin: 0 auto; /* Center the container horizontally */
    max-width: 785px; /* Set maximum width for responsiveness */
    width: 80%; /* Limit width based on viewport */
    margin-top: 26px;
    margin-bottom: 11px;
    background-color: #CCCCFF;
    color: #000000;
}

.auto-style9 {
    vertical-align: middle;
    margin-right: 10px;
    max-height: 24px;
}

.auto-style13 {
    font-size: larger;
}

    </style>
</head>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>

<body>
    <form id="form1" runat="server" class="auto-style4">
        <div class="center" style="color: #FF0000">
        <h1 style="margin: inherit; font-style: inherit; color: #003366; font-family: Arial, Helvetica, sans-serif; text-decoration: blink; font-size: x-large; font-weight: bold;" class="auto-style47"><img alt="" class="auto-style48" src="./Upload/BOI1.png" />User Registration For Declarant Portal</h1>
            <br />
            <br />&nbsp;&nbsp; Reference No - <asp:Label ID="lbl_docNo" runat="server" Text="Label" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
            <asp:Label ID="lbl_declarantName" runat="server" Text="Label" Font-Bold="True" ForeColor="#CC0000" Visible="False"></asp:Label>
            <br />
            &nbsp;&nbsp; TIN- <asp:Label ID="lbl_tin" runat="server" Text="Label" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
            <br />
            <br />&nbsp;&nbsp; Note -:<br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -Please upload the document with a stamp and any other required documents specified by the BOI IS department.<br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -Please Upload Below 200KB PDF Only.&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            &nbsp;<div class="auto-style1" style="border: 1px inset #999999; background-color: #CCCCFF; color: #000000;">
                <label for="pdf_upload" class="auto-style13">
                <img class="auto-style9" src="./Upload/upload_23785.png" />&nbsp;&nbsp;&nbsp;&nbsp; Upload File</label>
                <input type="file" id="pdf_upload" runat="server" multiple />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="pdf_upload" ErrorMessage="Please select a PDF file" Display="Dynamic" ForeColor="Red" ValidationGroup="FileUploadValidationGroup" />
                 &nbsp;&nbsp; &nbsp;&nbsp;<asp:Label ID="lbl_status" runat="server"></asp:Label>
            </div>
        </div>
        <div>
            <div id="uploaded-files" class="auto-style7" style="border: 1px inset #808080; background-color: #CCCCFF">
                <%-- The uploaded file display area --%>
            </div>
        </div>

    <script>
        var fileUploadInput = document.getElementById('pdf_upload');
        var uploadedFilesContainer = document.getElementById('uploaded-files');

        fileUploadInput.addEventListener('change', handleFileUpload, false);

        function handleFileUpload(e) {
            var files = e.target.files;

            
            for (var i = 0; i < files.length; i++) {
                var file = files[i];
                displayFile(file);
                
            }
        }

        function displayFile(file) {
            var fileDisplay = document.createElement('div');
            fileDisplay.classList.add('uploaded-file');

            
            var fileName = document.createElement('p');
            fileName.textContent = file.name;
            fileName.classList.add('file-name');

           
            var deleteButton = document.createElement('button');
            deleteButton.textContent = '✕';
            deleteButton.classList.add('red-button');
            deleteButton.classList.add('right-button');
            deleteButton.classList.add('delete-button');
            deleteButton.addEventListener('click', function () {
                fileDisplay.remove();
            });

            fileDisplay.appendChild(fileName);
            fileDisplay.appendChild(deleteButton);

            uploadedFilesContainer.appendChild(fileDisplay);
        }
    </script>
        <script type ="text/javascript">  
  
          windowwindow.onload = window.history.forward(0);  
    
       </script>  
        
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
  
        
        <asp:Button ID="btn_upload" runat="server" BackColor="#339933" BorderColor="#339933" CssClass="auto-style27" Font-Bold="True" Height="39px" Text="Upload" Width="95px" OnClick="btn_upload_Click" />
    </form>
    <p>
        &nbsp;</p>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <footer class="auto-style8">
    <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Copyright &copy; 2023 BOI IT Department.</strong>
    All rights reserved.
</footer>

    </body>

</html>
