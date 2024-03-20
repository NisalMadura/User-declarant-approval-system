using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Windows;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Data;
using System.Net.Mail;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Configuration;
using System.Net;

namespace User_Account_webForm
{
    public partial class User_Acc : System.Web.UI.Page
    {
        private object dataGridView1;

        protected void Page_Load(object sender, EventArgs e)
        {
            string guid = Request.QueryString["guid"];
            string authemail = Request.QueryString["email"];
            DateTime currentDate = DateTime.Now;

           // string adminEmail = Session["UserEmail"].ToString();
         
          //  string adminPhone = Session["Phone"].ToString();
           // lbl_Phone.Text = "0778978678";

            txt_authdate.Text = currentDate.ToString(); 

            txt_authemail.Text = authemail;
         
            if (!IsPostBack)
            {
                Panel1.Visible = false;
                Panel2.Visible = false;

                if (!string.IsNullOrEmpty(Request.QueryString["guid"]))
                {

                    if (IsUserAccessValid(guid))
                    {
                        /*Session["guid"] = guid;
                        if (Session["guid"] != null && Session["guid"].ToString() == guid)
                        {


                            Session.Remove("guid");
                        }*/

                    }
                    else
                    {
                        Response.Redirect("VerifyPage.aspx");
                    }
                }
                else
                {
                    Response.Redirect("VerifyPage.aspx");
                }
                string script = @"<script>
                            Swal.fire({
                                title: 'Note',
                                text: 'Please enter the company details.',
                                icon: 'Information',
                                confirmButtonText: 'OK',
                                 customClass: {
                                    popup: 'swal-font-size'
                                }
                              
                            });
                         </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);

                return;
            }
            if (Request.QueryString["status"] == "1")
            {
                
                Guid documentGuid = new Guid(Request.QueryString["guid"]);
                bool isCodeCorrect = true; 
                UpdateVerificationStatus(documentGuid, isCodeCorrect);

                
            }
            else
            {
                Response.Redirect("TimeOutPage.aspx");
            }
        }

        private bool IsUserAccessValid(string guid)
        {
            //  string connectionString = @"Data Source=DESKTOP-FI935L9\MSSQLSERVER01;Initial Catalog=db_useraccount;Integrated Security=True";
            string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;


            string AuthEmailll = (string)Session["email"];
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT Status, ValidTill,ApplicationStatus FROM VerificationTable WHERE Guid = @Guid";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Guid", guid);

                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                int status = Convert.ToInt32(reader["Status"]);
                                DateTime validTill = Convert.ToDateTime(reader["ValidTill"]);
                                string ApplicationStatus = Convert.ToString(reader["ApplicationStatus"]);

                                return ((DateTime.Now <= validTill) && ApplicationStatus != "1");
                            }
                            else
                            {
                               
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

        



        protected void Button2_Click(object sender, EventArgs e)
        {
            


            Button2.Enabled = false;

            {
                //Insert user and declarant details into the SQL database
                // string connectionString = @"Data Source=DESKTOP-FI935L9\MSSQLSERVER01;Initial Catalog=db_useraccount;Integrated Security=True";
                string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;
               

                try
                {
                    string TIN = txt_tin.Text;
                    string CHANo = txt_chano.Text;
                    string DeclarantName = txt_declarantname.Text;
                    string Address = txt_address.Text;
                    string AuthName = txt_authname.Text;
                    string AuthEmail = txt_authemail.Text;
                    string AuthContactNo = txt_contactno.Text;
                   // string AuthDate = txt_authdate.Text;
                    DateTime currentDate = DateTime.Now;
                   

                    int docnu = 0;

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        using (SqlCommand command = new SqlCommand("InsertDeclarant", connection))
                        {
                            command.CommandType = CommandType.StoredProcedure;

                            // Parameters for tbl_declarant table 
                            command.Parameters.AddWithValue("@TIN", TIN);
                            command.Parameters.AddWithValue("@CHA_No", CHANo);
                            command.Parameters.AddWithValue("@declarant_name", DeclarantName);
                            command.Parameters.AddWithValue("@Address", Address);
                            command.Parameters.AddWithValue("@auth_name", AuthName);
                            command.Parameters.AddWithValue("@auth_email",AuthEmail);
                            command.Parameters.AddWithValue("@auth_contactno", AuthContactNo);
                            command.Parameters.AddWithValue("@auth_date", currentDate);
                          



                            
                            SqlParameter docno = new SqlParameter("@DOCNO", SqlDbType.Int);
                            docno.Direction = ParameterDirection.Output;
                            command.Parameters.Add(docno);

                            connection.Open();
                            command.ExecuteNonQuery();

                            docnu = int.Parse(docno.Value.ToString());
                           

                           

                            connection.Close();


                        }
                        foreach (GridViewRow row in GridView1.Rows)
                        {
                            string Uname = row.Cells[0].Text;
                            string email = row.Cells[1].Text;
                            string contactNo = row.Cells[2].Text;
                            string userId = row.Cells[3].Text;

                            string verificationToken = Guid.NewGuid().ToString();
                            string baseUril = Request.Url.GetLeftPart(UriPartial.Authority);
                            string verificationLink = $"{baseUril}/User_Account_webForm/VerifyEmail.aspx?token={verificationToken}&userId={userId}&docNo={docnu}&email={email}";

                            SendVerificationEmail(email, verificationLink);


                            using (SqlCommand command = new SqlCommand("InsertUserDetails", connection))
                            {
                                command.CommandType = CommandType.StoredProcedure;

                                command.Parameters.AddWithValue("@UserName", Uname);
                                command.Parameters.AddWithValue("@Email", email);
                                command.Parameters.AddWithValue("@contact_no", contactNo);
                                command.Parameters.AddWithValue("@UserID", userId);
                                command.Parameters.AddWithValue("@DOCNO", docnu);

                                connection.Open();
                                command.ExecuteNonQuery();
                                connection.Close();

                            }

                           using (SqlCommand command = new SqlCommand("INSERT INTO  tbl_UserVerifyEmail (DOCNO,UserID,VerificationToken,ValidTill) VALUES (@DOCNO, @UserID,@VerificationToken,@ValidTill)", connection))
                           {


                                command.Parameters.AddWithValue("@DOCNO", docnu);
                                command.Parameters.AddWithValue("@UserID", userId);
                                command.Parameters.AddWithValue("@VerificationToken", verificationToken);
                                command.Parameters.AddWithValue("@ValidTill", DateTime.Now.AddDays(3));

                                connection.Open();
                                command.ExecuteNonQuery();
                                connection.Close();

                           }

                        }
                            string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority);
                            string docNo = docnu.ToString();
                            Guid uniqueGuid = Guid.NewGuid();
                            string uniqueGuidString = uniqueGuid.ToString();
                            DateTime expirationTime = DateTime.Now.AddDays(2);
                          //  long unixTimestamp = ((DateTimeOffset)expirationTime).ToUnixTimeSeconds();
                            string uniqueLink = $"{baseUrl}/User_Account_webForm/PdfUploadNew.aspx?docno={docNo}&guid={uniqueGuidString}&TIN={TIN}&DeclarantName={DeclarantName}";

                            
                          
                                using (SqlCommand command = new SqlCommand("INSERT INTO VerificationLink (DOCNO,Guid,ValidTill) VALUES (@DOCNO,@Guid,@ValidTill)", connection))
                                {
                                    command.Parameters.AddWithValue("@DOCNO",docNo);
                                    command.Parameters.AddWithValue("@Guid", uniqueGuid);
                                    command.Parameters.AddWithValue("@ValidTill", DateTime.Now.AddDays(2));
                                    connection.Open();
                                    command.ExecuteNonQuery();
                                    connection.Close();

                                }




                            using (MemoryStream memStream = new MemoryStream())
                            {
                                
                                Document document = new Document();
                                PdfWriter writer = PdfWriter.GetInstance(document, memStream);

                                document.Open();
                                Paragraph spaceBetweenTitleAnd = new Paragraph(" ");
                                spaceBetweenTitleAnd.SpacingAfter = 30f;
                                document.Add(spaceBetweenTitleAnd);

                                // Add logo to PDF
                                /*  iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(Server.MapPath("/Upload/BOI1.png"));
                                  logo.Alignment = Element.ALIGN_CENTER;
                                  logo.ScaleToFit(100f, 100f);
                                  document.Add(logo);*/

                                Paragraph userAccountsTitle = new Paragraph();
                                userAccountsTitle.Alignment = Element.ALIGN_CENTER;
                                userAccountsTitle.Add(new Chunk("User Accounts", new Font(Font.FontFamily.HELVETICA, 20f, Font.BOLD)));
                                userAccountsTitle.SpacingAfter = 5f;
                                document.Add(userAccountsTitle);

                                // Declerant title
                                Paragraph declerantTitle = new Paragraph();
                                declerantTitle.Alignment = Element.ALIGN_CENTER;
                                declerantTitle.Add(new Chunk("For Declarant", new Font(Font.FontFamily.HELVETICA, 16f, Font.BOLD)));
                                declerantTitle.SpacingAfter = 10f;
                                document.Add(declerantTitle);


                                Paragraph spaceBetweenTitleAndTin = new Paragraph(" ");
                                spaceBetweenTitleAndTin.SpacingAfter = 120f;
                                document.Add(spaceBetweenTitleAndTin);

                                
                                Paragraph tinParagraph = new Paragraph();
                                tinParagraph.MultipliedLeading = -2.0f; 
                                tinParagraph.Add(new Chunk("Tin          : ", new Font(Font.FontFamily.HELVETICA, 12f, Font.BOLD)));
                                tinParagraph.Add(new Chunk(txt_tin.Text));
                                

                                
                                Paragraph chaNoParagraph = new Paragraph();
                                chaNoParagraph.MultipliedLeading = -2.0f; 
                                chaNoParagraph.Add(new Chunk("CHA No  : ", new Font(Font.FontFamily.HELVETICA, 12f, Font.BOLD)));
                                chaNoParagraph.Add(new Chunk(txt_chano.Text));
                               

                                
                                Paragraph declarantNameParagraph = new Paragraph();
                                declarantNameParagraph.MultipliedLeading = -2.0f; 
                                declarantNameParagraph.Add(new Chunk("Name      : ", new Font(Font.FontFamily.HELVETICA, 12f, Font.BOLD)));
                                declarantNameParagraph.Add(new Chunk(txt_declarantname.Text));
                               

                                
                                Paragraph addressParagraph = new Paragraph();
                                addressParagraph.MultipliedLeading = -2.0f; 
                                addressParagraph.Add(new Chunk("Address  : ", new Font(Font.FontFamily.HELVETICA, 12f, Font.BOLD)));
                                addressParagraph.Add(new Chunk(txt_address.Text));
                                


                                document.Add(addressParagraph);
                                document.Add(declarantNameParagraph);
                                document.Add(chaNoParagraph);
                                document.Add(tinParagraph);


                                
                                Paragraph spaceAfterTable6 = new Paragraph(" "); 
                                spaceAfterTable6.SpacingAfter = 40f; 
                                document.Add(spaceAfterTable6);


                                Paragraph spaceAfterTable = new Paragraph(" ");
                                spaceAfterTable.SpacingAfter = 20f;
                                document.Add(spaceAfterTable);

                                PdfPTable table2 = new PdfPTable(4);
                                table2.WidthPercentage = 100;

                                table2.SetWidths(new float[] { 25f, 40f, 15f, 20f });


                                table2.AddCell(new PdfPCell(new Phrase("User Name", new Font(Font.FontFamily.HELVETICA, 12f, Font.BOLD))));
                                table2.AddCell(new PdfPCell(new Phrase("Email", new Font(Font.FontFamily.HELVETICA, 12f, Font.BOLD))));
                                table2.AddCell(new PdfPCell(new Phrase("Contact No", new Font(Font.FontFamily.HELVETICA, 12f, Font.BOLD))));
                                table2.AddCell(new PdfPCell(new Phrase("UserID", new Font(Font.FontFamily.HELVETICA, 12f, Font.BOLD))));

                                foreach (GridViewRow gridViewRow in GridView1.Rows)
                                {
                                    string uname = gridViewRow.Cells[0].Text;
                                    string Email = gridViewRow.Cells[1].Text;
                                    string contact = gridViewRow.Cells[2].Text;
                                    string UserId = gridViewRow.Cells[3].Text;
                                    
                                    
                                    table2.AddCell(uname);
                                    table2.AddCell(Email);
                                    table2.AddCell(contact);
                                    table2.AddCell(UserId);
                                }

                                int remainingRows = 4 - GridView1.Rows.Count;
                                for (int i = 0; i < remainingRows; i++)
                                {
                                    table2.AddCell("");
                                    table2.AddCell("");
                                    table2.AddCell("");
                                    table2.AddCell("");
                                }

                                document.Add(table2);

                                Paragraph spaceAfterTable2 = new Paragraph(" "); 
                                spaceAfterTable2.SpacingAfter = 110f; 
                                document.Add(spaceAfterTable2);

                                 Paragraph authnameParagraph = new Paragraph();
                                authnameParagraph.MultipliedLeading = -2.0f; 
                                authnameParagraph.Add(new Chunk("Auth Name : ", new Font(Font.FontFamily.HELVETICA, 12f, Font.BOLD)));
                                authnameParagraph.Add(new Chunk(txt_authname.Text));

                                Paragraph authemailParagraph = new Paragraph();
                                authemailParagraph.MultipliedLeading = -2.0f; 
                                authemailParagraph.Add(new Chunk("Auth Email : ", new Font(Font.FontFamily.HELVETICA, 12f, Font.BOLD)));
                                authemailParagraph.Add(new Chunk(txt_authemail.Text));

                                Paragraph authtelParagraph = new Paragraph();
                                authtelParagraph.MultipliedLeading = -2.0f;
                                authtelParagraph.Add(new Chunk("Auth Tel     : ", new Font(Font.FontFamily.HELVETICA, 12f, Font.BOLD)));
                                authtelParagraph.Add(new Chunk(txt_contactno.Text));

                                Paragraph authdateParagraph = new Paragraph();
                                authdateParagraph.MultipliedLeading = -2.0f; 
                                authdateParagraph.Add(new Chunk("Auth Date  : ", new Font(Font.FontFamily.HELVETICA, 12f, Font.BOLD)));
                                authdateParagraph.Add(new Chunk(txt_authdate.Text));

                              
                                document.Add(authdateParagraph);
                                document.Add(authtelParagraph);
                                document.Add(authemailParagraph);
                                document.Add(authnameParagraph);




                                Paragraph spaceAfterTable7 = new Paragraph(" ");
                                spaceAfterTable7.SpacingAfter = 50f;
                                document.Add(spaceAfterTable7);


                                Paragraph companySeal = new Paragraph("Company Seal:");
                                companySeal.Alignment = Element.ALIGN_LEFT;
                                companySeal.Font = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 16f);
                                companySeal.SpacingBefore = 60f;
                                document.Add(companySeal);

                                // Add Date field
                                Paragraph date = new Paragraph("Date: " + DateTime.Now.ToString("dd/MM/yyyy"));
                                date.Alignment = Element.ALIGN_RIGHT;
                                date.SpacingAfter = 30f;
                                document.Add(date);

                                Paragraph spaceAfterTable8 = new Paragraph(" ");
                                spaceAfterTable8.SpacingAfter = 50f;
                                document.Add(spaceAfterTable8);

                                Paragraph rights = new Paragraph("********All rights reserved.*********");
                                rights.Alignment = Element.ALIGN_CENTER;
                                rights.SpacingAfter = 150f;
                                document.Add(rights);

                                document.Close();

                              
                          


                                   string tempFilePath = Path.GetTempFileName() +docNo+ ".pdf";
                                   File.WriteAllBytes(tempFilePath, memStream.ToArray());


                            //  string tempFilePath = Path.GetTempFileName();
                            //  pdfDocument.Save(tempFilePath);
                            string fromEmailAddress = ConfigurationManager.AppSettings["SMTPUsername"];
                            string smtpPassword = ConfigurationManager.AppSettings["SMTPPassword"];
                                    MailMessage message = new MailMessage();
                                    message.From = new MailAddress(fromEmailAddress);
                                    message.To.Add(new MailAddress(txt_authemail.Text));
                                    message.Subject = "User Registration for declarant portal";

                            message.Body = $"Dear Sir/Madam, \n\n " +
                                       $"Please follow the instructions below to resubmit the PDF document with the company stamp.\n" +
                                       $"Note that the link will valid only {DateTime.Now.AddDays(2)}.\n\n\n" +
                                       $"1) Download the attach document.\n" +
                                       $"2) Print it on company letterhead and sign as an authorized user.\n" +
                                       $"3) Upload the scanned documents using the provided link.\n" +
                                       $" {uniqueLink}\n\n" +
                                       $"Thank you.\n\n" +
                                       $"Please do not reply to this mail, as this is an automated mail, For any assistance, contact our support team.\n " +
                                       $"Email-ITHelpdesk@gmail.com\n" +
                                       $"TEL-011-2427308";
                                                

                             

                                    Attachment attachment = new Attachment(tempFilePath);
                                    message.Attachments.Add(attachment);

                            // System.Net.Mail.SmtpClient smtpClient = new System.Net.Mail.SmtpClient("smtp.gmail.com", 587);
                            // smtpClient.EnableSsl = true;
                            SmtpClient smtpClient = new SmtpClient();
                            smtpClient.UseDefaultCredentials = bool.Parse(ConfigurationManager.AppSettings["UseDefaultCredentials"]);
                            smtpClient.Host = ConfigurationManager.AppSettings["SMTPHost"];
                            smtpClient.Port = int.Parse(ConfigurationManager.AppSettings["SMTPPort"]);
                            smtpClient.Credentials = new System.Net.NetworkCredential(fromEmailAddress,smtpPassword);


                            smtpClient.Send(message);
                                

                                string docNumber = docNo;
                                InsertDocument(docNumber);
                            
                            }



                        string loadingScript = @"
                             <script>
                             Swal.fire({
                             title: 'Please wait...',
                             html: 'Your application is being processed. <i class=\'fas fa-spinner fa-spin\'></i>',
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
                        text: 'Thank you for submitting your application for a user account on the Declarant Portal. Please check your email for further instructions and next steps...',
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

                        string connectionone = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;
                        Guid documentGuid = new Guid(Request.QueryString["guid"]);
                        using (SqlConnection connectionupdate = new SqlConnection(connectionone))
                        {
                           

                            using (SqlCommand command = new SqlCommand("UPDATE VerificationTable SET ApplicationStatus = 1 WHERE Guid = @Guid", connectionupdate))
                            {
                              
                                command.Parameters.AddWithValue("@Guid", documentGuid);

                                connectionupdate.Open();
                                command.ExecuteNonQuery();
                                connectionupdate.Close();


                            }
                       
                     

                            
                        }
                    }
                }
                catch (SqlException ex)
                {
                 // Display error message to the user
                 // lbl_error.Text = "An error occurred: " + ex.Message;
                    string script = @"<script>
                            Swal.fire({
                                title: 'Error',
                                text: 'Please try again....',
                                icon: 'error',
                                confirmButtonText: 'OK',
                                 customClass: {
                                    popup: 'swal-font-size'
                                }
                              
                            });
                         </script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script);

                    return;
                }


                txt_name.Text = "";
                txt_email.Text = "";
                txt_contact.Text = "";
                txt_userId.Text = "";
                txt_tin.Text = "";
                txt_chano.Text = "";
                txt_declarantname.Text = "";
                txt_address.Text = "";
                txt_authname.Text = "";
                txt_authemail.Text = "";
                txt_contactno.Text = "";
                txt_authdate.Text = "";


                lbl_sucessmessage.Text="";
                lbl_usermessage.Text = "";
                lbl_usererror.Text = "";
                GridView1.DataSource = null;
                GridView1.DataBind();
            }

        }

        private void InsertDocument(string docNumber)
        {
            DateTime currentDate = DateTime.Now;

            string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string insertQuery = "INSERT INTO  DocumentStatus (DOCNO, Status,Date) VALUES (@DOCNO,@Status,@currentDate)";

                using (SqlCommand command = new SqlCommand(insertQuery, connection))
                {
                    command.Parameters.AddWithValue("@DOCNO", docNumber);
                    command.Parameters.AddWithValue("@Status", 0);
                    command.Parameters.AddWithValue("@CurrentDate", currentDate);

                    command.ExecuteNonQuery();
                }
            }
        }

        private void UpdateVerificationStatus(Guid documentGuid, bool isCodeCorrect)
        {
            
            string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("UPDATE VerificationTable SET Status = @Status WHERE Guid = @Guid", connection))
                {
                    command.Parameters.AddWithValue("@Status", isCodeCorrect ? 1 : 0);
                    command.Parameters.AddWithValue("@Guid", documentGuid);

                    connection.Open();
                    command.ExecuteNonQuery();

                }
            }
        }
        private void AddFormField(PdfPTable table, string label, string value)
         {
           
            PdfPCell labelCell = new PdfPCell(new Phrase(label));
            PdfPCell valueCell = new PdfPCell(new Phrase(value));

          
            labelCell.Border = PdfPCell.BOTTOM_BORDER;
            valueCell.Border = PdfPCell.BOTTOM_BORDER;

          
            table.AddCell(labelCell);
            table.AddCell(valueCell);
        }

        protected void btn_adduser_Click(object sender, EventArgs e)
        {
            

            if (string.IsNullOrEmpty(txt_name.Text) || string.IsNullOrEmpty(txt_email.Text) || string.IsNullOrEmpty(txt_contact.Text) || string.IsNullOrEmpty(txt_userId.Text))
            {
            //    lbl_usermessage.Visible = false;
                lbl_usererror.Text = "Please fill in all details correctly.";
                return;

            }

            {

            try
            {
                
                string name = txt_name.Text;
                string email = txt_email.Text;
                string contactNo = txt_contact.Text;
                string userId = txt_userId.Text;
                string TIN = txt_tin.Text;
                    
                        bool isEmailExists = IsEmailExists(email);

                    if (isEmailExists)
                    {
                        lbl_usererror.Text = "Please note that a user with the same email already exists.";
                        lbl_usermessage.Text = "";
                        lbl_usererror.Visible = true;
                        return; 
                    }



                    bool isTINAndUserIdExists = IsTINAndUserIdExists(TIN,userId);

                    if (isTINAndUserIdExists)
                    {
                        lbl_usererror.Text = "Please note that a user with the same userId already exists.";
                        lbl_usermessage.Text = "";
                        lbl_usererror.Visible = true;
                        return;
                    }

                // Create a DataTable to hold the user details
                DataTable dt = new DataTable();
                if (Session["users"] != null)
                {
                    dt = (DataTable)Session["users"];
                }
                else
                {
                    dt.Columns.Add("UserName", typeof(string));
                    dt.Columns.Add("Email", typeof(string));
                    dt.Columns.Add("contact_no", typeof(string));
                    dt.Columns.Add("UserID", typeof(string));
                }

                   

           
                DataRow dr = dt.NewRow();
                dr["UserName"] = name;
                dr["Email"] = email;
                dr["contact_no"] = contactNo;
                dr["UserID"] = userId;
                dt.Rows.Add(dr);

                Session["users"] = dt;
                GridView1.DataSource = dt;
                GridView1.DataBind();

                lbl_usererror.Visible = false;

                lbl_usermessage.Text = "User Added sucussfully!";
                

                    
                }
                catch (SqlException ex)
            {
                  //  lbl_usererror.Text = "An error occurred: " + ex.Message;
                  lbl_usererror.Text = "Invalid input. Please try again.";
              
            }
            
            txt_name.Text = "";
            txt_email.Text = "";
            txt_contact.Text = "";
            txt_userId.Text = "";

            }
        }

        private bool IsEmailExists(string email)
        {
            // string connectionString = @"Data Source=DESKTOP-FI935L9\MSSQLSERVER01;Initial Catalog=db_useraccount;Integrated Security=True";
            string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;


            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM tbl_user_details WHERE Email = @Email";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Email", email);
                connection.Open();
                int count = (int)command.ExecuteScalar();
                return count > 0;
            }
        }
        private bool IsTINAndUserIdExists(string TIN, string userId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM ISDeclarantLogin WHERE ForTIN = @ForTIN AND UserID = @UserID";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@ForTIN", TIN);
                command.Parameters.AddWithValue("@UserID", userId);
                connection.Open();
                int count = (int)command.ExecuteScalar();
                return count > 0;
            }
        }


        private void SendVerificationEmail(string email, string verificationLink)
        {
            string fromEmailAddress = ConfigurationManager.AppSettings["SMTPUsername"];
            string smtpPassword = ConfigurationManager.AppSettings["SMTPPassword"];

            MailMessage message = new MailMessage();
            message.From = new MailAddress(fromEmailAddress);
            message.To.Add(new MailAddress(email));
            message.Subject = "Email Verification for declarant portal";
            message.Body = $"Dear Sir/Madam, \n\n " +
                $"You are nominated as a BOI user on the Declarant Portal. Please verify your email address using the link below to proceed with the account approval process by the Board of Investments (BOI)." +
                $"Upon email verification and BOI approval, you will receive your username and password to access the Declarant Portal.\n\n" +
                $"{ verificationLink}\n\n" +
                $" Thank you.\n" +
                $" Please do not reply to this mail, as this is an automated mail, For any assistance, contact our support team.\n " +
                $"Email- ITHelpdesk@gmail.com \n" +
                $" TEL- 011-2313234";


            using (SmtpClient smtpClient = new SmtpClient())
            {
           
                smtpClient.UseDefaultCredentials = bool.Parse(ConfigurationManager.AppSettings["UseDefaultCredentials"]);
                smtpClient.Host = ConfigurationManager.AppSettings["SMTPHost"];
                smtpClient.Port = int.Parse(ConfigurationManager.AppSettings["SMTPPort"]);
                //smtpClient.EnableSsl = bool.Parse(ConfigurationManager.AppSettings["EnableSSL"]);
                smtpClient.Credentials = new System.Net.NetworkCredential(fromEmailAddress, smtpPassword);

                smtpClient.Send(message);
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
           
            int rowIndex = e.RowIndex;
            DataTable dt = (DataTable)Session["users"];
            dt.Rows.RemoveAt(rowIndex);
            Session["users"] = dt;
            GridView1.DataSource = dt;
            GridView1.DataBind();
            lbl_usermessage.Text = "User deleted successfully!";
         
        }



        protected void btn_userclear_Click(object sender, EventArgs e)
            {
                txt_name.Text = "";
                txt_email.Text = "";
                txt_contact.Text = "";
                txt_userId.Text = "";

                lbl_usermessage.Text = "";
            }

        protected void Buttonclear_Click(object sender, EventArgs e)
        {
            txt_name.Text = "";
            txt_email.Text = "";
            txt_contact.Text = "";
            txt_userId.Text = "";
            txt_tin.Text = "";
            txt_chano.Text = "";
            txt_declarantname.Text = "";
            txt_address.Text = "";
            txt_authname.Text = "";
            txt_authemail.Text = "";
            txt_contactno.Text = "";
            txt_authdate.Text = "";

            lbl_sucessmessage.Text = "";
            lbl_usermessage.Text = "";
            lbl_usererror.Text = "";
            GridView1.DataSource = null;
            GridView1.DataBind();
        }

       

     

        protected void btn_TinVerify_Click(object sender, EventArgs e)
        {
            string tinText = txt_tin.Text.Trim();
            string chanoText = txt_chano.Text.Trim();
            string declarantName = txt_declarantname.Text.Trim();
            string companyAddress = txt_address.Text.Trim();

            if (string.IsNullOrEmpty(tinText) || string.IsNullOrEmpty(chanoText) ||
        string.IsNullOrEmpty(declarantName) || string.IsNullOrEmpty(companyAddress))
            {
                string script1 = @"<script>
                            Swal.fire({
                                title: 'Error',
                                text: 'Please fill all details correctly.',
                                icon: 'error',
                                confirmButtonText: 'OK',
                                 customClass: {
                                    popup: 'swal-font-size'
                                }
                              
                            });
                         </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script1);

                return;
            }
           
            if (tinText.Length != 9 || !int.TryParse(tinText, out int ForTIN))
            {

                txt_tin.ForeColor = System.Drawing.Color.Black;
                txt_tin.Text = "";
                txt_tin.Attributes["placeholder"] = "Invalid TIN (9 digits required)";
                

                return;
            }

            // string connectionString = @"Data Source=DESKTOP-FI935L9\MSSQLSERVER01;Initial Catalog=db_useraccount;Integrated Security=True";
            string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString3"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM ISDeclarant WHERE ForTIN = @ForTIN";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@ForTIN", ForTIN);
                connection.Open();
                int count = (int)command.ExecuteScalar();

                if (count > 0)
                {
                    txt_tin.ForeColor = System.Drawing.Color.DarkGreen;
                    btn_adduser.Visible = true;
                    Button2.Visible = true;
                    Buttonclear.Visible = true;
                }
                else
                {
                    txt_tin.ForeColor = System.Drawing.Color.Purple;
                    Button2.Visible = false;
                    Buttonclear.Visible = false;
                    btn_adduser.Visible = false;
                   
                    string script2 = @"<script>
                            Swal.fire({
                                title: 'Error',
                                text: 'Please ensure you have registered your TIN with the BOI IS department before proceeding to fill out this declarant form.',
                                icon: 'error',
                                confirmButtonText: 'OK',
                                 customClass: {
                                    popup: 'swal-font-size'
                                }
                              
                            });
                         </script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script2);

                    return;
                }
            }
            txt_tin.ReadOnly = true;
            txt_tin.Visible = true;
            Panel1.Visible = true;
            btn_TinVerify.Visible = false;

            string script = @"<script>
                            Swal.fire({
                                title: 'Note',
                                text: 'Please enter the user details.',
                                icon: 'Information',
                                confirmButtonText: 'OK',
                                 customClass: {
                                    popup: 'swal-font-size'
                                }
                              
                            });
                         </script>";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script);

            return;

            
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btn_next(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count == 0)
            {
               
            }
            else
            {
                Panel2.Visible = true;
                btn_Next.Visible = false;
               string errorScript = @"<script>
                    document.addEventListener('DOMContentLoaded', function() {
                    Swal.fire({
                        title: 'Note',
                        text: 'Please Enter the Authorized person details.',
                        icon: 'information',
                        confirmButtonText: 'OK',
                        customClass: {
                            popup: 'swal-font-size'
                        }
                    });
                });
             </script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "errorAlert", errorScript);

            
            }
        }
    }
}


           
    
