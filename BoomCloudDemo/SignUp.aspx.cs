using BoomCloudDemo.Database;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dapper;

namespace BoomCloudDemo
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rwEmailExist.Visible = false;
                rwSignUpMsg.Visible = false;
                dpDOB.MaxDate = DateTime.Today;
            }
        }

        public bool IsEmailExists(string email)
        {
            using (IDbConnection db = DatabaseConnection.CreateConnection())
            {
                DynamicParameters dynamicParameters = new DynamicParameters();
                dynamicParameters.Add("@Email", email);
                dynamicParameters.Add("@Result", dbType: DbType.Int32, direction: ParameterDirection.Output, size: 50000000);
                db.Execute("usp_UserExist", dynamicParameters, commandType: CommandType.StoredProcedure);
                int userPresent = dynamicParameters.Get<int>("@Result");
                return userPresent.Equals(1);
            }
        }

        protected void btnSignupClick(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string email = txtEmail.Text;
                if (IsEmailExists(email))
                {
                    rwEmailExist.Visible = true;
                }
                else
                {
                    using (IDbConnection db = DatabaseConnection.CreateConnection())
                    {
                        try
                        {
                            DynamicParameters dynamicParameters = new DynamicParameters();
                            DateTime date = (DateTime)dpDOB.SelectedDate;
                            string selected_date = date.ToString("dd-MM-yyyy");
                            dynamicParameters.Add("@Username", txtUsername.Text);
                            dynamicParameters.Add("@Email", txtEmail.Text);
                            dynamicParameters.Add("@Phone_number", txtPhone.Text);
                            dynamicParameters.Add("@DOB", DateTime.Parse(selected_date));
                            dynamicParameters.Add("@Password", txtPassword.Text);
                            db.Execute("usp_AddUser", dynamicParameters, commandType: CommandType.StoredProcedure);
                            rwSignUpMsg.Visible = true;
                            ScriptManager.RegisterStartupScript(this, GetType(), "redirect", "setTimeout(function() { window.location.replace('SignIn.aspx'); }, 1000);", true);
                        }
                        catch (Exception ex)
                        {
                           
                        }
                    }
                }
            }
        }

        protected void customValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime selectedDate;
            if (DateTime.TryParse(dpDOB.SelectedDate.ToString(), out selectedDate))
            {
                DateTime today = DateTime.Today;
                DateTime minDate = today.AddYears(-18);

                args.IsValid = (selectedDate <= today && selectedDate <= minDate);
            }
            else
            {
                args.IsValid = false;
            }
        }
    }
}
