using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace User_Account_webForm
{
    public partial class VerifyEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string docNo = Request.QueryString["docno"];
            string verificationToken = Request.QueryString["verificationToken"];
            string userId=Request.QueryString["userId"];
            // string email=Request.QueryString["email"];

            Label3.Text = docNo;
            Label4.Text = verificationToken;
            Label5.Text = userId;
            // Label6.Text = email;

            if (!IsPostBack)
            {
                string email = Request.QueryString["email"];
                if (!string.IsNullOrEmpty(email))
                {
                    emailLabel.Text = email;
                }
            }



        }


        protected void btn_VerifyEmail_Click(object sender, EventArgs e)
        {


            //string connectionString = @"Data Source=DESKTOP-FI935L9\MSSQLSERVER01;Initial Catalog=db_useraccount;Integrated Security=True";
            string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString1"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string sql = "UPDATE tbl_user_details SET VerificationStatus = @VerificationStatus WHERE DOCNO = @DOCNO AND UserID = @UserID";

                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@VerificationStatus", "Verified");
                        command.Parameters.AddWithValue("@DOCNO", Label3.Text);
                        command.Parameters.AddWithValue("@UserID", Label5.Text);

                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                
               
                    string successScript = @"
                        <script>
                        setTimeout(function () {
                        Swal.fire({
                        title: 'Done!',
                        text: 'Email Successfully Verify!',
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


            catch (Exception ex)
                {
                    // Handle or log the exception here
                    // For debugging purposes, you can output the exception message to check for any specific errors
                    
                string script = @"<script>
                            Swal.fire({
                                title: 'Error',
                                text: 'Email is already verified....',
                                icon: 'error',
                                confirmButtonText: 'OK',
                                 customClass: {
                                    popup: 'swal-font-size'
                                }
                              
                            });
                         </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);

            }


        }

    
        
    }
}