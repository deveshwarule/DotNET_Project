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
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                welcomeMessage.Text = " Hello " + Session["username"];
            }
            using (IDbConnection db = DatabaseConnection.CreateConnection())
            {
                    DynamicParameters dynamicParameters = new DynamicParameters();
                    dynamicParameters.Add("@Username", Session["username"]);
                    Model.UserDetails User = db.QuerySingleOrDefault<Model.UserDetails>("usp_GetByName", dynamicParameters, commandType: CommandType.StoredProcedure);
                    Session["id"] = User.id;
            }
            if (!IsPostBack)
            {
                if (Request.QueryString["logout"] != null)
                {
                    Session.Clear(); 
                    Session.Abandon(); 
                    Response.Redirect("SignOut.aspx");
                }
            }
        }
    }
}