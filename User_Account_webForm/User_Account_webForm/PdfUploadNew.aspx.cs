using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Windows;
using System.Data;
using System.Configuration;
using System.Net.Mail;
using System.Net;

namespace User_Account_webForm
{
    public partial class PdfUpload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string docNo = Request.QueryString["docno"];
                lbl_docNo.Text = docNo;
                string TIN = Request.QueryString["TIN"];
                lbl_tin.Text = TIN;
                string DeclarantName = Request.QueryString["DeclarantName"];
                lbl_declarantName.Text = DeclarantName;

                string guid = Request.QueryString["guid"];
               
                    if (!string.IsNullOrEmpty(Request.QueryString["guid"]))
                    {

                        if (IsUserAccessValid(guid))
                        {

                        }
                        else
                        {
                            Response.Redirect("TimeOutPage.aspx");
                        }
                    }
                    else
                    {
                        Response.Redirect("TimeOutPage.aspx");
                    }
                

            }
            
            
        }
        private bool IsUserAccessValid(string guid)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT ValidTill FROM VerificationLink WHERE Guid = @Guid";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Guid", guid);

                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                DateTime validTill = Convert.ToDateTime(reader["ValidTill"]);

                                return (DateTime.Now <= validTill);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                
            }

            return false;
        }

        private bool IsPdfFile(HttpPostedFile file)
        {
            // Check the content type to ensure it's a PDF
            if (file.ContentType.ToLower() == "application/pdf")
            {
                return true;
            }

            // Check the file extension to ensure it's a PDF
            string fileExtension = Path.GetExtension(file.FileName).ToLower();
            if (fileExtension == ".pdf")
            {
                return true;
            }

            return false;
        }

        protected void btn_upload_Click(object sender, EventArgs e)
        {
            //string connectionString = @"Data Source=DESKTOP-FI935L9\MSSQLSERVER01;Initial Catalog=db_useraccount;Integrated Security=True";
            string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;
            string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority);
            string uniqueLink = $"{baseUrl}/User_Account_webForm/AdminLogin.aspx?adminstatus=1";



            HttpFileCollection uploadedFiles = Request.Files;

            for (int i = 0; i < uploadedFiles.Count; i++)
            {
                HttpPostedFile file = uploadedFiles[i];

                if (file.ContentLength > 0)
                {
                    if (IsPdfFile(file))
                    {
                        if (file.ContentLength <= 200 * 1024)
                        {
                            byte[] fileData = null;
                            using (var binaryReader = new BinaryReader(file.InputStream))
                            {
                                fileData = binaryReader.ReadBytes(file.ContentLength);
                            }
                            string fileName = Path.GetFileName(file.FileName);

                            using (SqlConnection connection = new SqlConnection(connectionString))
                            {
                                string sql = "INSERT INTO PdfFiles (FilePath, FileData, DOCNO) VALUES (@FilePath, @FileData, @DOCNO)";
                                using (SqlCommand command = new SqlCommand(sql, connection))
                                {
                                    command.Parameters.AddWithValue("@FilePath", fileName);
                                    command.Parameters.AddWithValue("@FileData", fileData);
                                    command.Parameters.AddWithValue("@DOCNO", lbl_docNo.Text);
                                    connection.Open();
                                    command.ExecuteNonQuery();
                                    connection.Close();

                                    string loadingScript = @"
                                <script>
                                    Swal.fire({
                                    title: 'Please wait...',
                                    html: 'Your application is being processed.... <i class=\'fas fa-spinner fa-spin\'></i>',
                                    allowOutsideClick: false,
                                    allowEscapeKey: false,
                                    showConfirmButton: false,
                                    customClass: {
                                    popup: 'swal-font-size'
                                    },
                                    onBeforeOpen: () => {
                                    Swal.showLoading();
                                    }
                                    });
                                </script>
                            ";
                                    ClientScript.RegisterStartupScript(this.GetType(), "loadingAlert", loadingScript);

                                    string successScript = @"
                                <script>
                                setTimeout(function () {
                                Swal.fire({
                                title: 'Done!',
                                text: ' Documents uploaded successfully.Please contact BOI for further processing.',
                                icon: 'success',
                                confirmButtonText: 'OK',
                                customClass: {
                                popup: 'swal-font-size'
                                }
                                }).then(function () {
                                window.location.href = 'TimeOutPage.aspx'; 
                                });
                                }, 3000); 
                                </script>
                            ";

                                    ClientScript.RegisterStartupScript(this.GetType(), "successAlert", successScript);
                                }
                            }
                        }
                        else
                        {
                            // File size exceeds 200KB
                            string errorMessage = "File size exceeds the limit of 200KB.";

                            string errorScript = $@"<script>
                        document.addEventListener('DOMContentLoaded', function() {{
                            Swal.fire({{
                                title: 'Error',
                                text: '{errorMessage}',
                                icon: 'error',
                                confirmButtonText: 'OK',
                                customClass: {{
                                    popup: 'swal-font-size'
                                }}
                            }});
                        }});
                    </script>";
                            ClientScript.RegisterStartupScript(this.GetType(), "errorAlert", errorScript);
                        }
                    }
                    else
                    {
                        // Not a PDF file
                        string errorMessage = "Please upload PDF files only.";

                        string errorScript = $@"<script>
                    document.addEventListener('DOMContentLoaded', function() {{
                        Swal.fire({{
                            title: 'Error',
                            text: '{errorMessage}',
                            icon: 'error',
                            confirmButtonText: 'OK',
                            customClass: {{
                                popup: 'swal-font-size'
                            }}
                        }});
                    }});
                </script>";
                        ClientScript.RegisterStartupScript(this.GetType(), "errorAlert", errorScript);
                    }
                }
            }



           
            string fromEmailAddress = ConfigurationManager.AppSettings["SMTPUsername"];
            string smtpPassword = ConfigurationManager.AppSettings["SmtpPassword"];

            List<string> callListAdminEmails = GetCallListAdminEmails();
            MailMessage message1 = new MailMessage();
            message1.From = new MailAddress(fromEmailAddress);

            foreach (string email in callListAdminEmails)
            {
                message1.To.Add(new MailAddress(email));
            }

            message1.Subject = "Application For User Registration For Declarant Portal";

            message1.Body = $"Dear Administrator, \n\n" +
                $"New Declarant user registration application has been received.\n\n" +
                $"TIN-{lbl_tin.Text}\n" +
                $"Reference No-{lbl_docNo.Text}\n" +
                $"Company Name-{lbl_declarantName.Text}\n\n" +
                $"{uniqueLink}\n" +
                $"Please review a document and providing your approval.\n\n" +
                $"Thank you.";

            // SmtpClient smtpClient1 = new SmtpClient("smtp.gmail.com", 587);
            // smtpClient1.EnableSsl = true;
            // smtpClient1.Credentials = new System.Net.NetworkCredential(SmtpUser1,smtpPassword1);
            SmtpClient smtpClient1 = new SmtpClient();

     
            smtpClient1.UseDefaultCredentials = bool.Parse(ConfigurationManager.AppSettings["UseDefaultCredentials"]);
            smtpClient1.Host = ConfigurationManager.AppSettings["SMTPHost"];
            smtpClient1.Port = int.Parse(ConfigurationManager.AppSettings["SMTPPort"]);
            smtpClient1.Credentials = new System.Net.NetworkCredential(fromEmailAddress, smtpPassword);

            try
            {
                smtpClient1.Send(message1);
                string docNumber = lbl_docNo.Text;
                DateTime currentDate = DateTime.Now;
                UpdateDocumentStatus(docNumber, 1, currentDate);
            }
            catch (Exception ex)
            {
               Label1.Text= "Error sending email ";
            }

        }
        public List<string> GetCallListAdminEmails()
        {
            List<string> callListAdminEmails = new List<string>();

            string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString4"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string getUserCodesQuery = "SELECT UserCode FROM UsrUserGroup WHERE GroupCode = 'Dec_Admin'";
                using (SqlCommand getUserCodesCmd = new SqlCommand(getUserCodesQuery, connection))
                {
                    using (SqlDataReader userCodeReader = getUserCodesCmd.ExecuteReader())
                    {
                        List<string> userCodes = new List<string>();
                        while (userCodeReader.Read())
                        {
                            userCodes.Add(userCodeReader.GetString(0));
                        }
                        userCodeReader.Close();


                        if (userCodes.Count > 0)
                        {
                            string getEmailsQuery = $"SELECT Email FROM UsrUser WHERE UserCode IN ({string.Join(",", userCodes.Select(c => "'" + c + "'"))})";
                            using (SqlCommand getEmailsCmd = new SqlCommand(getEmailsQuery, connection))
                            {
                                using (SqlDataReader emailReader = getEmailsCmd.ExecuteReader())
                                {
                                    while (emailReader.Read())
                                    {
                                        string email = emailReader.GetString(0);
                                        callListAdminEmails.Add(email);
                                    }
                                }
                            }
                        }
                    }
                }
            }

            return callListAdminEmails;
        }


        private void UpdateDocumentStatus(string docNumber, int status, DateTime currentDate)
        {

            string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string updateQuery = "UPDATE DocumentStatus SET Status = @Status,Date = @CurrentDate WHERE DOCNO = @DOCNO";

                using (SqlCommand command = new SqlCommand(updateQuery, connection))
                {
                    command.Parameters.AddWithValue("@Status", status);
                    command.Parameters.AddWithValue("@DOCNO", docNumber);
                    command.Parameters.AddWithValue("@CurrentDate", currentDate);

                    command.ExecuteNonQuery();
                }
            }
        }

       

    }
}




