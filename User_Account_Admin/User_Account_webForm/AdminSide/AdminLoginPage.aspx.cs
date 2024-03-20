using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace User_Account_webForm
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

      

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string paycode = txt_Paycode.Text;
            string password = txt_Password.Text;
            Session["PayCode"] = paycode;

            if (ValidateAdminCredentials(paycode, password))
            {
                string email = GetEmail(paycode); 
                Session["UserEmail"] = email;

                string Phone = GetContactNumber(paycode);
                Session["Phone"] = Phone;

               // string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority);
                Response.Redirect("./dashboard.aspx");
                
            }
            else
            {
                lbl_Error.Text = "Incorrect paycode or password.";
            }
        }
        private bool ValidateAdminCredentials(string paycode, string password)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString4"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT Password FROM UsrUser WHERE UserCode = @UserCode";
                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@UserCode", paycode);

                string storedHashedPassword = (string)cmd.ExecuteScalar();
                string inputHashedPassword = MPass(paycode, password);

                if (storedHashedPassword != inputHashedPassword)
                {
                    return false; 
                }

                string groupCodeQuery = "SELECT COUNT(*) FROM UsrUserGroup WHERE UserCode = @UserCode AND GroupCode = 'Dec_Admin'";
                SqlCommand groupCodeCmd = new SqlCommand(groupCodeQuery, connection);
                groupCodeCmd.Parameters.AddWithValue("@UserCode", paycode);

                int rowCount = (int)groupCodeCmd.ExecuteScalar();

                if (rowCount > 0)
                {
                    return true; 
                }

                return false; 
            }
        }
        private String GetEmail(string paycode)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString4"].ConnectionString;
            string email = "";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT Email FROM UsrUser WHERE UserCode = @UserCode";
                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@UserCode", paycode);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        email = reader["Email"].ToString();
                    }
                }
            }

            return email;
        }
        private String GetContactNumber(string paycode)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["db_useraccountConnectionString4"].ConnectionString;
            string contactNumber = "";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT Phone FROM UsrUser WHERE UserCode = @UserCode";
                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@UserCode", paycode);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        contactNumber = reader["Phone"].ToString();
                    }
                }
            }
            return contactNumber;
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

    
      /*  private void UpdateValidTimeForAdmin(SqlConnection connection, string paycode, DateTime validTime)
        {
            string updateQuery = "UPDATE AdministratorLogin SET ValidTime = @ValidTime WHERE Paycode = @Paycode";
            SqlCommand cmd = new SqlCommand(updateQuery, connection);
            cmd.Parameters.AddWithValue("@ValidTime", validTime);
            cmd.Parameters.AddWithValue("@Paycode", paycode);
            cmd.ExecuteNonQuery();
        }*/
    }
}


