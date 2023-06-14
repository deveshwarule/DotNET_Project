using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BoomCloudDemo.Database;
using Dapper;

namespace BoomCloudDemo
{
    public partial class SignIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                radWindow.Visible = false;
            }
        }

        protected void btnSigninClick(object sender, EventArgs e)
        {
            try
            {
                using (IDbConnection db = DatabaseConnection.CreateConnection())
                {
                    if (Page.IsValid)
                    {
                        DynamicParameters dynamicParameters = new DynamicParameters();
                        dynamicParameters.Add("@Username", txtUserName.Text);
                        dynamicParameters.Add("@Password", txtPassword.Text);
                        dynamicParameters.Add("@Result", dbType: DbType.Int32, direction: ParameterDirection.Output, size: 50000000);
                        db.Execute("usp_UserLogin", dynamicParameters, commandType: CommandType.StoredProcedure);
                        int userPresent = dynamicParameters.Get<int>("@Result");
                        if (userPresent == 1)
                        {
                            Session["username"] = txtUserName.Text.ToString();
                            Response.Redirect("Dashboard.aspx");
                        }
                        else
                        {
                            radWindow.Visible = true;
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        protected void signUp(object sender, EventArgs e)
        {
            Response.Redirect("SignUp.aspx");

        }

    }
}