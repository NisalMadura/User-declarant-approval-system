using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using System.Data;
using System.Net.Mail;
using System.Text;
using System.Configuration;

namespace User_Account_webForm
{
    public partial class admin_Page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                 


                if (Request.QueryString["DOCNO"] != null)
                {
                    string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;

                    string docNo = Request.QueryString["DOCNO"];
          

                    if (IsDocNumberApproved(docNo))
                    {
                        btn_approveuser.Visible = false;
                        btn_approveuser.Enabled = false;
                        btn_reject.Visible = false;
                        btn_reject.Enabled = false;
                    }
                    else
                    {
                        btn_approveuser.Visible = true;
                        btn_approveuser.Enabled = true;
                    }

                                  

                    string query = "SELECT DOCNO,TIN, CHA_No, declarant_name, Address, auth_name, auth_email, auth_contactno, auth_date FROM tbl_declarant WHERE DOCNO = @docNo";

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                          SqlCommand command = new SqlCommand(query, connection);
                          command.Parameters.AddWithValue("@DOCNO", docNo);
                       
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        if (reader.Read())
                        {
                         lbl_docno.Text = reader["DOCNO"].ToString();
                         txt_tin2.Text = reader["TIN"].ToString();
                         txt_chano2.Text = reader["CHA_No"].ToString();
                         txt_declarantname2.Text = reader["declarant_name"].ToString();
                         txt_address2.Text = reader["Address"].ToString();
                         txt_authname2.Text = reader["auth_name"].ToString();
                         txt_authemail2.Text = reader["auth_email"].ToString();
                         txt_contactno2.Text = reader["auth_contactno"].ToString();
                         txt_authdate2.Text = reader["auth_date"].ToString();

                            string tin = reader["TIN"].ToString();
                            bool isDuplicateTIN = CheckDuplicateTIN(tin);

                            // Set the color of the text box based on the duplicate TIN check
                            txt_tin2.ForeColor = isDuplicateTIN ? System.Drawing.Color.Green : System.Drawing.Color.Purple;

                        }
                     reader.Close();
                 }
               
                 }
               

            }
        }
        private bool CheckDuplicateTIN(string ForTIN)
        {
            //string connectionString = @"Data Source=DESKTOP-FI935L9\MSSQLSERVER01;Initial Catalog=db_useraccount;Integrated Security=True";
            string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString6"].ConnectionString;

            string query = "SELECT COUNT(*) FROM ISDeclarant WHERE ForTIN = @ForTIN";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@ForTIN", ForTIN);

                connection.Open();
                int count = (int)command.ExecuteScalar();

                return count > 0;
            }
        }


        private bool IsDocNumberApproved(string docNo)
        {
            // Retrieve the status from the database based on the specific doc number
            string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;

            string query = "SELECT User_status FROM tbl_user_details WHERE DOCNO = @DOCNO AND User_status IN (N'Approved', N'Reject')";


            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@DOCNO", docNo);
                    connection.Open();

                    object result = command.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        return true;
                    }
                }
            }

            return false;
        }

        protected void btn_approveuser_Click(object sender, EventArgs e)
        {
            List<string> approvedUserIDs = new List<string>();
            List<string> approvedUsers = new List<string>();
            List<string> rejectedUsers = new List<string>();

            foreach (GridViewRow row in GridView1.Rows)
            {
                CheckBox status = (row.Cells[3].FindControl("CheckBox1") as CheckBox);
                string UserID = (row.Cells[2].Text);
                string userName = (row.Cells[0].Text);
                string userEmail = (row.Cells[1].Text);
                int insertionStatus;
                string password = MPass(UserID,txt_tin2.Text.Substring(3,6)+UserID.Substring(0,3) );
                string Userpass = txt_tin2.Text.Substring(3, 6) + UserID.Substring(0, 3);
                DateTime currentDate = DateTime.Now;
                string sitelink = "https://application.boi.lk/declaweb/main.aspx";

                if (status.Checked)
                {
                    updaterow(UserID, "Approved");
                    insertionStatus = 1;

                    approvedUserIDs.Add(UserID);
                    approvedUsers.Add($"Name: {userName}");

                    using (MailMessage usermessage = new MailMessage())
                    {
                        string fromEmailAddress = ConfigurationManager.AppSettings["SMTPUsername"];
                        usermessage.From = new MailAddress(fromEmailAddress);
                        usermessage.To.Add(new MailAddress(userEmail));
                        usermessage.Subject = "Account Approval";
                        usermessage.Body = $"Dear Sir/Madam,\n\n Your user account request submitted under Reference No {lbl_docno.Text} hase been approved.Please find details below.\n " +
                                           $"User name: {userName}\n " +
                                           $"User ID: {UserID}\n" +
                                           $" password: {Userpass}\n\n" +
                                           $" {sitelink}\n\n" +
                                           $" Thank you.\n" +
                                           $" Please do not reply to this mail, as this is an automated mail, For any assistance, contact our support team.\n " +
                                           $"Email-ITHelpdesk@boi.lk \n" +
                                           $" TEL-011-2427308\n";
                                          


                        string smtpPassword1 = ConfigurationManager.AppSettings["SMTPPassword"];
                        string smtpHost = ConfigurationManager.AppSettings["SmtpHost"];
                        int smtpPort = int.Parse(ConfigurationManager.AppSettings["SmtpPort"]);

                    
                        SmtpClient smtpClient = new SmtpClient();
                        smtpClient.UseDefaultCredentials = bool.Parse(ConfigurationManager.AppSettings["UseDefaultCredentials"]);
                        smtpClient.Host = ConfigurationManager.AppSettings["SMTPHost"];
                        smtpClient.Port = int.Parse(ConfigurationManager.AppSettings["SMTPPort"]);
                        smtpClient.Credentials = new System.Net.NetworkCredential(fromEmailAddress, smtpPassword1);
                        smtpClient.Send(usermessage);

                    }
                    /*---------------------*/
                    string InsertconnectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString6"].ConnectionString;


             try
                {
                        string fromEmailAddress = ConfigurationManager.AppSettings["SMTPUsername"];
                        using (SqlConnection connection = new SqlConnection(InsertconnectionString))
                    {
                        using (SqlCommand command = new SqlCommand("InsertISDeclarantLogin", connection))
                        {
                            command.CommandType = CommandType.StoredProcedure;
                            command.Parameters.AddWithValue("@ForTIN", txt_tin2.Text);
                            command.Parameters.AddWithValue("@UserID", UserID);
                            command.Parameters.AddWithValue("@UserName", userName);
                            command.Parameters.AddWithValue("@Email", userEmail);
                            command.Parameters.AddWithValue("@Phone", txt_contactno2.Text);
                            command.Parameters.AddWithValue("@GroupCode", "CHA");
                            command.Parameters.AddWithValue("@Password", password);
                            command.Parameters.AddWithValue("@Status", insertionStatus);

                            connection.Open();
                            command.ExecuteNonQuery();
                        }
                    }
                        string loadingScript = @"
                       <script>
                       Swal.fire({
                       title: 'Please wait...',
                       html: 'Your request is being processed.... <i class=\'fas fa-spinner fa-spin\'></i>',
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

                        string successScript = @"<script>
                        document.addEventListener('DOMContentLoaded', function() {
                        Swal.fire({
                        title: 'Success',
                        text: 'User Approved Successfully....',
                        icon: 'success',
                        confirmButtonText: 'OK',
                        customClass: {
                            popup: 'swal-font-size'
                         }
                               });
                              }, 3000);
                    </script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "successAlert", successScript);

                    SqlDataSource4.DataBind();
                    GridView1.DataBind();
                    ClientScript.RegisterStartupScript(GetType(), "HideApproveButtonScript", "hideApproveButton();", true);
                    btn_approveuser.Visible = false;
                    btn_approveuser.Enabled = false;
                    btn_reject.Visible = false;
                    btn_reject.Enabled = false;
                }
                catch (Exception ex)
                {
                    string errorScript = @"<script>
                    document.addEventListener('DOMContentLoaded', function() {
                    Swal.fire({
                        title: 'Error',
                        text: 'User approved already. Please check again...',
                        icon: 'error',
                        confirmButtonText: 'OK',
                        customClass: {
                            popup: 'swal-font-size'
                        }
                    });
                    });
                   </script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "errorAlert", errorScript);
                    btn_approveuser.Visible = false;
                    btn_reject.Visible = false;

                }
              }


                /*------------------------------*/   
                else
                {
                    string fromEmailAddress = ConfigurationManager.AppSettings["SMTPUsername"];
                    updaterow(UserID, "Reject");
                    insertionStatus = 0;

                    rejectedUsers.Add($"Name: {userName}");

                    using (MailMessage userrejectmessage = new MailMessage())
                    {
                        userrejectmessage.From = new MailAddress(fromEmailAddress);
                        userrejectmessage.To.Add(new MailAddress(userEmail));
                        userrejectmessage.Subject = "Account Reject";
                        userrejectmessage.Body = $"Dear Sir/Madam,\n\n Your application submitted under Reference No {lbl_docno.Text} has been rejected." +
                           
                            $"Please reach out to the {txt_authname2.Text} for further assistance.\n\n" +
                            $"Thank you.\n\n" +
                            $"Please do not reply to this mail, as this is an automated mail";

                        string smtpPassword1 = ConfigurationManager.AppSettings["SMTPPassword"];
                        string smtpHost = ConfigurationManager.AppSettings["SmtpHost"];
                        int smtpPort = int.Parse(ConfigurationManager.AppSettings["SmtpPort"]);


                       
                        using (SmtpClient smtpClientreject = new SmtpClient(smtpHost, smtpPort))
                        {
                            var Credentials = new System.Net.NetworkCredential(fromEmailAddress, smtpPassword1);
                            
                            smtpClientreject.UseDefaultCredentials = false;
                            smtpClientreject.Credentials = Credentials;
                            smtpClientreject.Send(userrejectmessage);
                        }
                    }
                }


                
                string userconnectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(userconnectionString))
                {
                    connection.Open();
                    string updateQuery = "UPDATE tbl_user_details SET ApprovalDateTime = @ApprovalDateTime WHERE UserID = @UserID";
                    using (SqlCommand updateCommand = new SqlCommand(updateQuery, connection))
                    {
                        updateCommand.Parameters.AddWithValue("@ApprovalDateTime", currentDate);
                        updateCommand.Parameters.AddWithValue("@UserID", UserID);
                        updateCommand.ExecuteNonQuery();
                    }
                }
            }

            // Send approval and rejection report email
            using (MailMessage authmessage = new MailMessage())
            {
                string fromEmailAddress = ConfigurationManager.AppSettings["SMTPUsername"];
                authmessage.From = new MailAddress(fromEmailAddress);
                authmessage.To.Add(new MailAddress(txt_authemail2.Text));
                authmessage.Subject = "User Account Approval and Rejection Report";


              
                StringBuilder bodyBuilder = new StringBuilder();
                bodyBuilder.AppendLine($"Dear Sir/Madam,");
                if (approvedUsers.Count > 0)
                {
                    bodyBuilder.AppendLine("<p><span style='color: green;'>The following users have been approved:</span></p>\n\n");
                    bodyBuilder.AppendLine("<ul>");

                foreach (string user in approvedUsers)
                {
                    bodyBuilder.AppendLine($"<li>{user}</li>");
                }
                    bodyBuilder.AppendLine("</ul>");
                }

                bodyBuilder.AppendLine();
                if (rejectedUsers.Count > 0)
                {
                    bodyBuilder.AppendLine("<p><span style='color: red;'>The following users have been rejected:</span></p>\n\n");
                    bodyBuilder.AppendLine("<ul>");
                    bodyBuilder.AppendLine();


                    foreach (string user in rejectedUsers)
                {
                    bodyBuilder.AppendLine($"<li>{user}</li>");
                }
                     bodyBuilder.AppendLine("</ul>");
                     bodyBuilder.AppendLine();

                }

                string Note = TextArea1.Value.Trim();

                if (!string.IsNullOrEmpty(Note))
                {
                    bodyBuilder.AppendLine();
                    bodyBuilder.AppendLine("<p><span style='color:black;'>Special Notes:</span></p>\n\n");
                    bodyBuilder.AppendLine($"<p>{Note}</p>\n\n");

                }

                bodyBuilder.AppendLine();
                bodyBuilder.AppendLine();  
                bodyBuilder.AppendLine("Thank you.");
                



                authmessage.Body = bodyBuilder.ToString();
                authmessage.IsBodyHtml = true;
                string smtpPassword1 = ConfigurationManager.AppSettings["SMTPPassword"];
               
                SmtpClient smtpClient = new SmtpClient();
                smtpClient.UseDefaultCredentials = bool.Parse(ConfigurationManager.AppSettings["UseDefaultCredentials"]);
                smtpClient.Host = ConfigurationManager.AppSettings["SMTPHost"];
                smtpClient.Port = int.Parse(ConfigurationManager.AppSettings["SMTPPort"]);
                smtpClient.Credentials = new System.Net.NetworkCredential(fromEmailAddress, smtpPassword1);
                smtpClient.Send(authmessage);
            }
            string text = TextArea1.Value;
            Session["LabelText"] = text;

            TextArea1.Visible = false;

          
            lbl_comment.Text = text;

            string docNumber = lbl_docno.Text;
            DateTime currentDate2 = DateTime.Now;
            UpdateDocumentapproveStatus(docNumber, 2, currentDate2);


        }


        public string MPass(string mUser, string mPword)
        {
            long m_temp;
            int userlen = mUser.Length;
            int passlen = mPword.Length;
            int i;
            long mPass = 0;

            if (userlen >= passlen)
            {
                for (i = 0; i < userlen; i++)
                {
                    if (i < passlen)
                    {
                        m_temp = Math.Abs((int)mUser[i] - (int)mPword[i]);
                        mPass = (mPass + m_temp * 3) + 5;
                    }
                    else
                    {
                        m_temp = Math.Abs((int)mUser[i] - (int)'S');
                        mPass = (mPass + m_temp * 3) + 5;
                    }
                }
            }
            else
            {
                for (i = 0; i < passlen; i++)
                {
                    if (i < userlen)
                    {
                        m_temp = Math.Abs((int)mUser[i] - (int)mPword[i]);
                        mPass = (mPass + m_temp * 3) + 5;
                    }
                    else
                    {
                        m_temp = Math.Abs((int)'S' - (int)mPword[i]);
                        mPass = (mPass + m_temp * 3) + 5;
                    }
                }
            }

            return mPass.ToString();
            
        }
        
        protected void CheckBox_CheckedChanged(object sender, EventArgs e)
        {

            CheckBox checkbox = (CheckBox)sender;
            GridViewRow row = (GridViewRow)checkbox.NamingContainer;
            Label statusLabel = (Label)row.FindControl("StatusLabel");

            if (checkbox.Checked)
            {
                statusLabel.Text = "Approved";
                statusLabel.ForeColor = System.Drawing.Color.Green;
                
            }
            else
            {
                statusLabel.Text = "Pending";
            }
           
        }



        private void updaterow(string UserID, string approval)
        {

            string mycon = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;

            string updatedata = "UPDATE tbl_user_details SET User_status = @Approval WHERE UserID = @UserID";

            using (SqlConnection con = new SqlConnection(mycon))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand(updatedata, con))
                {
                    cmd.Parameters.AddWithValue("@Approval", approval);
                    cmd.Parameters.AddWithValue("@UserID", UserID);
                    cmd.ExecuteNonQuery();
                }
                con.Close();
                
            }
            
        }
       protected void lblVerificationStatus_DataBinding(object sender, EventArgs e)
        {
            Label lblVerificationStatus = (Label)sender;
            bool verificationStatus = Convert.ToBoolean(lblVerificationStatus.Text);
            lblVerificationStatus.Text = verificationStatus ? "Verified" : "Not Verified";
        }

       protected string GetVerificationStatus(object verificationStatus)
        {
         
            object verificationStatusValue = Eval("VerificationStatus");
            string status;
            if (Convert.IsDBNull(verificationStatusValue))
            {
                
                status = "Not Verified"; 

            }
            else
            {
                status = "Verified";
            }

            return status;
        }



        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        protected void link_download(object sender, EventArgs e)
        {
           
                LinkButton linkButton = sender as LinkButton;
                GridViewRow gridrow = linkButton.NamingContainer as GridViewRow;
                string fileName = GridView2.DataKeys[gridrow.RowIndex].Value.ToString();
    
                byte[] fileData;
                string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string sql = "SELECT FileData FROM PdfFiles WHERE PdfNO = @PdfNo";
                    SqlCommand command = new SqlCommand(sql, connection);
                    command.Parameters.AddWithValue("@PdfNo", fileName);
                    fileData = (byte[])command.ExecuteScalar();
                    connection.Close();
                }

                
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", "attachment;filename=\"" + fileName+".pdf" + "\"");
                Response.BinaryWrite(fileData);
                Response.End();
            
            
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

           
            string mycon = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;


            int selectedDocno = 1;


            using (SqlConnection connection = new SqlConnection(mycon))
            {
                connection.Open();

                string query = @"SELECT d.*, ud.UserName, ud.Email, ud.contact_no, ud.User_status
                             FROM tbl_declarant d
                             INNER JOIN tbl_user_details ud ON d.DOCNO = ud.DOCNO
                             WHERE d.DOCNO = @SelectedDocno";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@SelectedDocno", selectedDocno);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            
                        }
                    }
                }
            }
          
        }

       

        protected void btn_back_Click(object sender, EventArgs e)
        {


                Response.Redirect("./dashboard.aspx");
        }
        
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            foreach (GridViewRow user in GridView1.Rows)
            {

                Label lblveri = (Label)user.FindControl("lblVerificationStatus");
                CheckBox lblveristat = (CheckBox)user.FindControl("CheckBox1");
                
              

            

            }
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
        private void UpdateDocumentapproveStatus(string docNumber, int status, DateTime currentDate2)
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
                    command.Parameters.AddWithValue("@CurrentDate", currentDate2);

                    command.ExecuteNonQuery();
                }
            }
        }

        protected void btn_rejectuser_Click(object sender, EventArgs e)
        {


            string fromEmailAddress = ConfigurationManager.AppSettings["SMTPUsername"];
            string smtpPassword1 = ConfigurationManager.AppSettings["SMTPPassword"];
            List<string> rejectedUserEmails = new List<string>();

            foreach (GridViewRow row in GridView1.Rows)
            {
                string UserID = (row.Cells[2].Text);
                CheckBox status = (row.Cells[3].FindControl("CheckBox1") as CheckBox);
                updaterow(UserID, "Reject");

                string userEmail = (row.Cells[1].Text);
                rejectedUserEmails.Add(userEmail);
           
             
                string docNumber = lbl_docno.Text;
                DateTime currentDate = DateTime.Now;
                UpdateDocumentStatus(docNumber, 3, currentDate);
                ClientScript.RegisterStartupScript(GetType(), "HideApproveButtonScript", "hideApproveButton();", true);
                btn_reject.Visible = false;
                btn_reject.Enabled = false;

                string updateconnectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;


                using (SqlConnection connection = new SqlConnection(updateconnectionString))
                {
                    connection.Open();
                    string updateQuery = "UPDATE tbl_user_details SET ApprovalDateTime = @ApprovalDateTime WHERE UserID = @UserID";
                    using (SqlCommand updateCommand = new SqlCommand(updateQuery, connection))
                    {
                        updateCommand.Parameters.AddWithValue("@ApprovalDateTime", currentDate);
                        updateCommand.Parameters.AddWithValue("@UserID", UserID);
                        updateCommand.ExecuteNonQuery();
                    }
                }
            }
            
            try
            {
                using (MailMessage userrejectmessage = new MailMessage())
            {
                userrejectmessage.From = new MailAddress(fromEmailAddress);
                userrejectmessage.To.Add(new MailAddress(txt_authemail2.Text));
                foreach (string userEmail in rejectedUserEmails)
                {
                    userrejectmessage.CC.Add(new MailAddress(userEmail));
                }

                userrejectmessage.Subject = "Application Rejection";
                    userrejectmessage.Body = $"Dear Sir/Madam,\n\n Your application submitted under Reference No {lbl_docno.Text} has been rejected." +
                                       $"Please contact our support team through the email address provided below.\n\n" +
                                       $" Thank you.\n" +
                                       $" Please do not reply to this mail, as this is an automated mail\n" +
                                       $"Email-ITHelpdesk@boi.lk \n" +
                                       $" TEL-011-2427308\n";
                                  

                    
               

                    SmtpClient smtpClient = new SmtpClient();
                    smtpClient.UseDefaultCredentials = bool.Parse(ConfigurationManager.AppSettings["UseDefaultCredentials"]);
                    smtpClient.Host = ConfigurationManager.AppSettings["SMTPHost"];
                    smtpClient.Port = int.Parse(ConfigurationManager.AppSettings["SMTPPort"]);
                    smtpClient.Credentials = new System.Net.NetworkCredential(fromEmailAddress, smtpPassword1);
                    smtpClient.Send(userrejectmessage);
                }

                btn_reject.Visible = false;
                btn_reject.Enabled = false;
                btn_approveuser.Visible = false;


                
                string loadingScript = @"
        <script>
        Swal.fire({
            title: 'Please wait...',
            html: 'Your request is being processed.... <i class=\'fas fa-spinner fa-spin\'></i>',
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

                // Wait for a few seconds before showing the success message
                string successScript = @"
    <script>
        setTimeout(function () {
            Swal.fire({
                title: 'Done!',
                text: 'User Rejected Successfully..',
                icon: 'success',
                confirmButtonText: 'OK',
                customClass: {
                    popup: 'swal-font-size'
                }
            });
        }, 3000); 
    </script>
              ";
                ClientScript.RegisterStartupScript(this.GetType(), "successAlert", successScript);

            }
            catch (Exception ex)
            {

               
                
           string errorScript = @" < script >
            document.addEventListener('DOMContentLoaded', function() {
                    Swal.fire({
                        title: 'Error',
                    text: 'Please try again..',
                    icon: 'error',
                    confirmButtonText: 'OK',
                    customClass:
                        {
                            popup: 'swal-font-size'
                    }
                    });
                });
        </ script > ";
                ClientScript.RegisterStartupScript(this.GetType(), "errorAlert", errorScript);
            }

            

        }

        protected void btn_deletePdf_Click(object sender, EventArgs e)
        {

            string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string sql = "DELETE FROM PdfFiles WHERE DOCNO = @DOCNO";
                using (SqlCommand command = new SqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@DOCNO",lbl_docno.Text);
                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                }
            }
            string pdfdeletesuccessScript = @"<script>
                        document.addEventListener('DOMContentLoaded', function() {
                        Swal.fire({
                        title: 'Success',
                        text: 'PDFs Deleted Successfully....',
                        icon: 'success',
                        confirmButtonText: 'OK',
                        customClass: {
                            popup: 'swal-font-size'
                         }
                               });
                              }, 3000);
                    </script>";
            ClientScript.RegisterStartupScript(this.GetType(), "successAlert", pdfdeletesuccessScript);

        }

        protected void btn_resensLink_Click(object sender, EventArgs e)
        {
            string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority);
            string uniqueLink = $"{baseUrl}/User_Account_Admin/AdminSide/PdfUploadPage.aspx?docno={lbl_docno.Text}&TIN={txt_tin2.Text}&DeclarantName={txt_declarantname2.Text}";

            string fromEmailAddress = ConfigurationManager.AppSettings["SMTPUsername"];
            string smtpPassword = ConfigurationManager.AppSettings["SMTPPassword"];
            MailMessage message = new MailMessage();
            message.From = new MailAddress(fromEmailAddress);
            message.To.Add(new MailAddress(txt_authemail2.Text));
            message.Subject = "User Registration for declarant portal";

            message.Body = $"Dear Sir/Madam, \n\n " +
                       $"Please follow the instructions below to resubmit the PDF document with the company stamp.\n" +
                      
                       $"1) Download the attach document.\n" +
                       $"2) Print it on company letterhead and sign as an authorized user.\n" +
                       $"3) Upload the scanned documents using the provided link.\n" +
                       $" {uniqueLink}\n\n" +
                       $"Thank you.\n\n" +
                       $"Please do not reply to this mail, as this is an automated mail, For any assistance, contact our support team.\n " +
                       $"Email-ITHelpdesk@gmail.com\n" +
                       $"TEL-011-2427308";

            SmtpClient smtpClient = new SmtpClient();
            smtpClient.UseDefaultCredentials = bool.Parse(ConfigurationManager.AppSettings["UseDefaultCredentials"]);
            smtpClient.Host = ConfigurationManager.AppSettings["SMTPHost"];
            smtpClient.Port = int.Parse(ConfigurationManager.AppSettings["SMTPPort"]);
            smtpClient.Credentials = new System.Net.NetworkCredential(fromEmailAddress, smtpPassword);


            smtpClient.Send(message);

            string emailsuccessScript = @"<script>
                        document.addEventListener('DOMContentLoaded', function() {
                        Swal.fire({
                        title: 'Success',
                        text: 'Link Send Successfully....',
                        icon: 'success',
                        confirmButtonText: 'OK',
                        customClass: {
                            popup: 'swal-font-size'
                         }
                               });
                              }, 3000);
                    </script>";
            ClientScript.RegisterStartupScript(this.GetType(), "successAlert", emailsuccessScript);
        }
    }
    }



















    







