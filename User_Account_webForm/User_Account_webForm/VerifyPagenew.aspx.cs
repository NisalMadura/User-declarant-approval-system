using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace User_Account_webForm
{
    public partial class VerifyPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //verificationCodeSection.Visible = false;
                //txt_Verification.Visible = false;
                
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            try
            {
                string email = txt_Email.Text.Trim();
               // string phonenumber=txt_phone.Text.Trim();

                if (string.IsNullOrEmpty(email))
                {
                    lbl_Error.Text = "Please enter your email.";
                }

                Guid documentGuid = Guid.NewGuid();

                Random random = new Random();
                int verificationCode = random.Next(1000, 9999);

                Session["VerificationCode"] = verificationCode;
                Session["Email"] = email;
                Session["DocumentGuid"] = documentGuid;

                SendEmail(email, verificationCode.ToString(), documentGuid.ToString());
                // SendSMS(phonenumber, verificationCode.ToString());
                string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand("INSERT INTO VerificationTable (VerificationCode,Guid,ValidTill,Status) VALUES (@VerificationCode, @Guid,@ValidTill,@Status)", connection))
                    {
                        command.Parameters.AddWithValue("@VerificationCode", verificationCode);
                        command.Parameters.AddWithValue("@Guid", documentGuid);
                        command.Parameters.AddWithValue("@ValidTill", DateTime.Now.AddDays(1));
                        command.Parameters.AddWithValue("@Status", 0);
                        connection.Open();
                        command.ExecuteNonQuery();


                    }
                }
               // txt_Verification.Visible = false;
                // lbl_Error.Text = "Verification Code send to your Email.";
                string successScript = @"<script>
                document.addEventListener('DOMContentLoaded', function() {
                Swal.fire({
                    title: 'Done!',
                    text: 'You will now receive a confirmation email to the address you provided. Please check your inbox for further instructions.',
                    icon: 'success',
                    confirmButtonText: 'OK',
                    customClass: {
                        popup: 'swal-font-size'
                    }
                });
                disableButton();     
            });
         </script>";

                
               

                ClientScript.RegisterStartupScript(this.GetType(), "successAlert", successScript);
                
            }
            catch (Exception ex)
            {
                lbl_Error.Text = "Please check again."+ex.Message;
            }


        }

     /*   protected void btn_verification_Click(object sender, EventArgs e)
        {
            try
            {
                string enteredCode = txt_Verification.Text.Trim();

              
                int storedCode = (int)Session["VerificationCode"];
                string email = (string)Session["Email"];
                Guid documentGuid = (Guid)Session["DocumentGuid"];

                if (string.IsNullOrEmpty(enteredCode))
                {
                    lbl_Error.Text="Please enter the verification code.";
                }
                bool isCodeCorrect = enteredCode == storedCode.ToString();
                int verificationStatus = isCodeCorrect ? 1 : 0;
                UpdateVerificationStatus(documentGuid,isCodeCorrect);

                if (isCodeCorrect)
                {


                    string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority);
                    string redirectUrl = $"{baseUrl}/User_Acc.aspx?guid={documentGuid}&email={email}&status=1";
                    Response.Redirect(redirectUrl);
                    Session["VerificationStatus"] = 1;

                    //Response.Redirect("User_Acc.aspx?documentGuid=" + documentGuid.ToString());
                    // string connectionString = @"Data Source=DESKTOP-FI935L9\MSSQLSERVER01;Initial Catalog=db_useraccount;Integrated Security=True";
                    //string connectionString = @"Data Source=10.0.2.27;Initial Catalog=db_useraccount;User ID=sa;Password=abc@123";
                  /*   string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        using (SqlCommand command = new SqlCommand("INSERT INTO VerificationTable (VerificationCode,Guid,ValidTill,Status) VALUES (@VerificationCode, @Guid,@ValidTill,@Status)", connection))
                        {
                            command.Parameters.AddWithValue("@VerificationCode", storedCode);
                            command.Parameters.AddWithValue("@Guid", documentGuid);
                            command.Parameters.AddWithValue("@ValidTill", DateTime.Now.AddDays(2));
                            command.Parameters.AddWithValue("@Status", verificationStatus);
                            connection.Open();
                            command.ExecuteNonQuery();
                           

                        }
                    }
                   // Response.Redirect("User_Acc.aspx?documentGuid=" + documentGuid.ToString());
                   
                }
                else
                {
                    
                    lbl_Error.Text = "Invalid verification code.";
                }
            }
            catch (Exception ex)
            {
               
               lbl_Error.Text = "Please try again.";
            }
        }*/
        private void UpdateVerificationStatus(Guid documentGuid, bool isCodeCorrect)
        {
            //string connectionString = @"Data Source=DESKTOP-FI935L9\MSSQLSERVER01;Initial Catalog=db_useraccount;Integrated Security=True";
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

       private void SendEmail(string email, string verificationCode, string guid)
        {
            // Create and configure the mail message
            string fromEmailAddress = ConfigurationManager.AppSettings["SMTPUsername"];
            string smtpPassword = ConfigurationManager.AppSettings["SMTPPassword"];
            MailMessage message = new MailMessage();
            message.From = new MailAddress(fromEmailAddress); 
            message.To.Add(email);
            message.Subject = "Email Verification";
            message.Body = $"Dear Sir/Madam, \n\n " +
                           $"Thank you for your recent request to register on the BOI Declarant Portal. To proceed with your registration, we require email verification." +
                           $"Please click on the following link to verify your email.\n\n " +
                           $"Note that the link is only valid for 24 hours.\n\n " +                    
                           $"User Account Link: { GetVerificationLink(guid, email)}\n\n\n" +
                           $"Thank you.";


            SmtpClient smtpClient = new SmtpClient();
            smtpClient.UseDefaultCredentials = bool.Parse(ConfigurationManager.AppSettings["UseDefaultCredentials"]);
            smtpClient.Host = ConfigurationManager.AppSettings["SMTPHost"];
            smtpClient.Port = int.Parse(ConfigurationManager.AppSettings["SMTPPort"]);
            //smtpClient.EnableSsl = bool.Parse(ConfigurationManager.AppSettings["EnableSSL"]);
            smtpClient.Credentials = new System.Net.NetworkCredential(fromEmailAddress, smtpPassword);


            smtpClient.Send(message);


           
        }

            
        //phone number send verification code 
        /*
        private void SendSMS(string phonenumber, string verificationCode)
        {
            phonenumber = new string(phonenumber.Where(char.IsDigit).ToArray());

            string countryPrefix = "+94";
            if (!phonenumber.StartsWith(countryPrefix))
            {
                phonenumber = countryPrefix + phonenumber;
            }
            
            string authId = "";
            string authToken = "";
            string sourcePhoneNumber = "";

                var api = new PlivoApi("", "");
                var response = api.Message.Create(
                src: sourcePhoneNumber,
                dst: phonenumber,
                text: $"Your verification code is: {verificationCode}"

            );

            lbl_Success.Text = "Verification Code sent to your mobile phone.";
        }*/
        



        private string GetVerificationLink(string documentGuid,string email)
        {
            string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority);
           // string link = $"{baseUrl}/User_Acc.aspx?guid={documentGuid}&email={email}&status=1";
           
           
            string folder = "User_Account_webForm"; 
            string link = $"{baseUrl}/{folder}/User_Acc.aspx?guid={documentGuid}&email={email}&status=1";

            return link;
        }

      
    }
}