using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BoomCloudDemo.Database;
using BoomCloudDemo.Model;
using Dapper;
using Telerik.Web.UI;

namespace BoomCloudDemo
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (!IsPostBack)
            {
                dpFromDate.MaxDate = DateTime.Today;
                dpEndDate.MaxDate = DateTime.Today;
                rwDeleteMessage.Visible = false;
                rwUnableDelete.Visible = false;
            }
        }
        protected void customValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime startDate = (DateTime)dpFromDate.SelectedDate;
            DateTime endDate = (DateTime)dpEndDate.SelectedDate;

            args.IsValid = startDate < endDate;
        }

        protected void btnRedirect_Click(object sender, EventArgs e)
        {
            Response.Redirect("Members.aspx");
        }

        protected void employeeTable_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "UpdateRow")
            {
                GridEditableItem editeditem = e.Item as GridEditableItem;
                int id = Int32.Parse(editeditem["id"].Text);
                Response.Redirect("UpdateMember.aspx?id=" + id);
            }

            else if (e.CommandName == "DeleteRow")
            {
                GridDataItem item = e.Item as GridDataItem;
                int id = Convert.ToInt32(item.GetDataKeyValue("id"));
                int sid = (int)Session["id"];
                if (sid != id)
                {
                    rwDeleteMessage.VisibleOnPageLoad = true;
                    rwDeleteMessage.Visible = true;
                    btnYes.CommandArgument = id.ToString();
                    btnYes.Click += btnYes_Click;
                }

                rwUnableDelete.Visible = true;



            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                using (IDbConnection db = DatabaseConnection.CreateConnection())
                {
                    DynamicParameters dynamicParameters = new DynamicParameters();
                    DateTime fromDate = (DateTime)dpFromDate.SelectedDate;
                    DateTime endDate = (DateTime)dpEndDate.SelectedDate;
                    string fDate = fromDate.ToString("dd-MM-yyyy");
                    string eDate = endDate.ToString("dd-MM-yyyy");
                    dynamicParameters.Add("@SDOB", DateTime.Parse(fDate));
                    dynamicParameters.Add("@EDOB", DateTime.Parse(eDate));
                    var users = db.Query<UserDetails>("usp_GetByDate", dynamicParameters, commandType: CommandType.StoredProcedure);

                    userGrid.DataSource = users;
                    userGrid.DataBind();
                }
            }
        }

        protected void userGrid_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            using (IDbConnection db = DatabaseConnection.CreateConnection())
            {
                DynamicParameters dynamicParameters = new DynamicParameters();
                var allUsers = db.Query<UserDetails>("usp_GetAll", dynamicParameters, commandType: CommandType.StoredProcedure);

                userGrid.DataSource = allUsers;
            }
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(btnYes.CommandArgument);
            using (IDbConnection db = DatabaseConnection.CreateConnection())
            {

                DynamicParameters dynamicParameters = new DynamicParameters();
                dynamicParameters.Add("@Id", id);
                dynamicParameters.Add("@Success", dbType: DbType.Int32, direction: ParameterDirection.Output, size: 50000000);
                db.Query("usp_DeleteUser", dynamicParameters, commandType: CommandType.StoredProcedure);
                int userPresent = dynamicParameters.Get<int>("@Success");
                if (userPresent == 1)
                {
                    Response.Redirect("Dashboard.aspx");
                }
                rwDeleteMessage.VisibleOnPageLoad = false;
            }
        }

        protected void btnNo_Click(object sender, EventArgs e)
        {
            rwDeleteMessage.VisibleOnPageLoad = false;
            rwDeleteMessage.Visible = false;
        }


    }
}