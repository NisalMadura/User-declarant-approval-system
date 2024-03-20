﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace User_Account_webForm
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                Session["PreviousPage"] = Request.Url.ToString();
                string userEmail = Session["UserEmail"].ToString();

                string Paycode = Session["PayCode"].ToString();
                lbl_paycode.Text = Paycode;
                Label2.Text = userEmail;



                if (Request.QueryString["docNo"] != null)
                {
                    string docNo = Request.QueryString["docNo"].ToString();
                }
                //string userCode = Request.QueryString["UserCode"];

                if (string.IsNullOrEmpty(Paycode))
                {
                   
                    Response.Redirect("AdminLogin.aspx");
                    return; 
                }
            }
               



            DateTime currentDateTime = DateTime.Now;

            string currentDate = currentDateTime.ToString("yyyy-MM-dd");
            string currentTime = currentDateTime.ToString("HH:mm:ss");
            Label1.Text = $"Date: {currentDate} Time: {currentTime}";
        }

        protected void link_view(object sender, EventArgs e)
        {
            Response.Redirect("admin_Page.aspx");
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

                        Response.Redirect("admin_Page.aspx?docNo=" + docNo);
                    }
                }
               
            
            }
        }

        protected void Button_Click(object sender, EventArgs e)
        {
              Button button = (Button)sender;
              string docNo = button.CommandArgument;

            Response.Redirect("admin_Page.aspx?docNo=" + docNo);
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
                Response.Redirect("admin_Page.aspx?docNo=" + docNo);
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


       

      /*
        protected void btn_rejectedApplication_Command(object sender, CommandEventArgs e)
        {
            Response.Redirect("RejectedApplications.aspx");

        }*/

        

        protected void btn_PendingApplications_Click(object sender, EventArgs e)
        {
            //Response.Redirect("dashboard.aspx");
            string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority);
            Response.Redirect($"{baseUrl}/dashboard.aspx?UserCode={lbl_paycode.Text}");
        }

        protected void btn_ApproveApplications_Click(object sender, EventArgs e)
        {
            string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority);
            Response.Redirect($"{baseUrl}/ApprovedApplications.aspx?UserCode={lbl_paycode.Text}");

        }

        protected void btn_RejectApplications_Click(object sender, EventArgs e)
        {
            string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority);
            Response.Redirect($"{baseUrl}/RejectedApplications.aspx?UserCode={lbl_paycode.Text}");
        }

        protected void btn_ProcessingApplications_Click(object sender, EventArgs e)
        {
            string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority);
            Response.Redirect($"{baseUrl}/ProcessingApplications.aspx?UserCode={lbl_paycode.Text}");

        }

        protected void btn_userstatus_Click(object sender, EventArgs e)
        {
           
            string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority);
            Response.Redirect($"{baseUrl}/ApproveUser.aspx?UserCode={lbl_paycode.Text}");

        }

        protected void btn_logout_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminLogin.aspx");

        }
       
    }
}