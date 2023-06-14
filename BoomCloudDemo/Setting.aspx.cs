using BoomCloudDemo.Database;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BoomCloudDemo
{
    public partial class Setting : System.Web.UI.Page
    {

        int i;
        protected void Page_Load(object sender, EventArgs e)
        {
            i = (int)Session["id"];
            if (!IsPostBack)
            {
                AddDataToUpdate(i);
                rwUpdateMessage.Visible = false;
            }
        }

        protected void AddDataToUpdate(int mid)
        {
            using (IDbConnection db = DatabaseConnection.CreateConnection())
            {
                DynamicParameters dynamicParameters = new DynamicParameters();
                dynamicParameters.Add("@id", mid);
                Model.UserDetails User = db.QuerySingleOrDefault<Model.UserDetails>("usp_GetById", dynamicParameters, commandType: CommandType.StoredProcedure);
                txtname.Text = User.Name.Trim();
                txtEmail.Text = User.Email;
                txtPhone.Text = User.Phone_number;
                txtPassword.Attributes["Value"] = User.Password;
            }
        }
        

        protected void btnUpdateMember_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                using (IDbConnection db = DatabaseConnection.CreateConnection())
                {
                    try
                    {
                        DynamicParameters dynamicParameters = new DynamicParameters();
                        dynamicParameters.Add("@id", Session["id"]);
                        dynamicParameters.Add("@Name", !string.IsNullOrEmpty(txtname.Text) ? txtname.Text : string.Empty);
                        dynamicParameters.Add("@Phone_number", txtPhone.Text);
                        dynamicParameters.Add("@Email", txtEmail.Text);
                        dynamicParameters.Add("@Password", txtPassword.Text);
                        db.Execute("usp_UpdateSetting", dynamicParameters, commandType: CommandType.StoredProcedure);
                        rwUpdateMessage.Visible = true;
                        ScriptManager.RegisterStartupScript(this, GetType(), "redirect", "setTimeout(function() { window.location.replace('Setting.aspx'); }, 1000);", true);
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }

                }
            }
        }
    }
}