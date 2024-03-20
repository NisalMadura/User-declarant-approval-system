using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace User_Account_webForm
{
    public partial class ApprovedApplications : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               
            }
            DateTime currentDateTime = DateTime.Now;

            string currentDate = currentDateTime.ToString("yyyy-MM-dd");
            string currentTime = currentDateTime.ToString("HH:mm:ss");
            Label1.Text = $"Date: {currentDate} Time: {currentTime}";

        }

        protected void dashboad_gridview_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                if (int.TryParse(e.CommandArgument.ToString(), out int rowIndex))
                {
                    if (rowIndex >= 0 && rowIndex < dashboad_gridview.Rows.Count)
                    {
                        GridViewRow row = dashboad_gridview.Rows[rowIndex];
                        string docNo = row.Cells[1].Text;

                        Response.Redirect("./admin_Page.aspx?docNo=" + docNo);
                    }
                }


            }
        }
        protected void Button_Click(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            string docNo = button.CommandArgument;

            Response.Redirect("./admin_Page.aspx?docNo=" + docNo);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string docNo = txtSearch.Text.Trim();

            bool docNoExists = false;
            foreach (GridViewRow row in dashboad_gridview.Rows)
            {
                if (row.Cells[1].Text == docNo)
                {
                    docNoExists = true;
                    break;
                }
            }

            if (docNoExists)
            {
                Response.Redirect("./admin_Page.aspx?docNo=" + docNo);
            }
            else
            {
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

        protected void btn_userstatus_Click(object sender, EventArgs e)
        {

       
           Response.Redirect("./ApproveUser.aspx");


        }


        protected void btn_pendingapplications_Click(object sender, EventArgs e)
        {
            string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority);
            Response.Redirect("./dashboard.aspx");

        }

        protected void btn_approvedapplications_Click(object sender, EventArgs e)
        {
            
            string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority);
            Response.Redirect("./ApprovedApplications.aspx");
        }

        protected void btn_rejectapplications_Click(object sender, EventArgs e)
        {
            string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority);
            Response.Redirect("./RejectedApplications.aspx");
        }

        protected void btn_processapplications_Click(object sender, EventArgs e)
        {
            string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority);
            Response.Redirect("./ProcessingApplications.aspx");
        }
    }
}