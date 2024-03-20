using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace User_Account_webForm
{
    public partial class ApproveUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string docNo = txtSearch.Text.Trim();

            foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.Cells[0].Text == docNo)
                {
                    // Display the matching row
                    row.Visible = true;
                    row.CssClass = "highlight-row";
                }
                else
                {
                    // Hide non-matching rows
                    row.Visible = false;
                }
            }
            if (GridView1.Visible = GridView1.Rows.Cast<GridViewRow>().Any(row => row.Visible))

            {
                // At least one matching row is found
                // You can redirect to the ApproveUser.aspx page if needed
            }
            else
            {
                // No matching row is found
                string script = @"<script>
                            Swal.fire({
                                title: 'Error',
                                text: 'Document Number Not Valid',
                                icon: 'error',
                                confirmButtonText: 'OK',
                                customClass: {
                                    popup: 'swal-font-size'
                                }
                            }).then(function() {
                                // Go back to the previous page
                                window.history.back();
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
                txtSearch.Text = "";
            }
        }
       
        protected void btn_back_Click(object sender, EventArgs e)
        {
            string previousPage = Session["PreviousPage"] as string;

            if (!string.IsNullOrEmpty(previousPage))
            {
                Response.Redirect(previousPage);
            }
            else
            {

            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string TIN = txtSearch0.Text.Trim();

            foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.Cells[4].Text == TIN)
                {
                    // Display the matching row
                    row.Visible = true;
                    row.CssClass = "highlight-row";
                }
                else
                {
                    // Hide non-matching rows
                    row.Visible = false;
                }
            }

            if (GridView1.Visible = GridView1.Rows.Cast<GridViewRow>().Any(row => row.Visible))
            {
                // At least one matching row is found
                // You can redirect to the ApproveUser.aspx page if needed
            }
            else
            {
                // No matching row is found
                string script = @"<script>
                            Swal.fire({
                                title: 'Error',
                                text: 'TIN Number Not Valid',
                                icon: 'error',
                                confirmButtonText: 'OK',
                                customClass: {
                                    popup: 'swal-font-size'
                                }
                            }).then(function() {
                                // Go back to the previous page
                                window.history.back();
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
                txtSearch.Text = "";
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
