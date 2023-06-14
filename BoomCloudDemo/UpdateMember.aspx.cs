using BoomCloudDemo.Database;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace BoomCloudDemo
{
    public partial class UpdateMember : System.Web.UI.Page
    {
        string id;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = Request.QueryString["id"];
            if (!IsPostBack)
            {
                AddDataToUpdate(int.Parse(id));
                dpDOB.MaxDate = DateTime.Today;
                rwUpdateMessage.Visible = false;

                using (IDbConnection db = DatabaseConnection.CreateConnection())
                {

                    List<Model.States> statesList = db.Query<Model.States>("usp_GetStates", commandType: CommandType.StoredProcedure).ToList();
                    foreach (Model.States st in statesList)
                    {
                        var item = new RadComboBoxItem();
                        item.Text = st.states;
                        item.Value = st.states;
                        item.Attributes["StateId"] = st.id.ToString();
                        cmbState.Items.Add(item);
                    }
                }
            }
        }

        protected void AddDataToUpdate(int mid)
        {
            using (IDbConnection db = DatabaseConnection.CreateConnection())
            {
                DynamicParameters dynamicParameters = new DynamicParameters();
                dynamicParameters.Add("@id", mid);
             
                Model.UserDetails User = db.QuerySingleOrDefault<Model.UserDetails>("usp_GetById", dynamicParameters, commandType: CommandType.StoredProcedure);
                var stateId = db.QuerySingleOrDefault<string>("SELECT states FROM state WHERE id = @stid", new { stid = User.State_id });
                txtname.Text = User.Name.Trim();
                txtEmail.Text = User.Email;
                txtPhone.Text = User.Phone_number;
                txtPassword.Text = User.Password;
                if ((User.State_id != null) && (User.City != null) && (User.Address != null))
                {
                    cmbState.Text = User.State_id.Trim();
                    txtCity.Text = User.City;
                    txtAddress.Text = User.Address;
                }
                
                dpDOB.SelectedDate = User.DOB;

            }
        }

        protected void btnUpdateMember_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                using (IDbConnection db = DatabaseConnection.CreateConnection())
                {
                    string id = Request.QueryString["id"];
                    try
                    {
                        DynamicParameters dynamicParameters = new DynamicParameters();
                        DateTime date = (DateTime)dpDOB.SelectedDate;
                        string selected_date = date.ToString("dd-MM-yyyy");
                        string stateId = cmbState.SelectedItem.Attributes["StateId"];
                        dynamicParameters.Add("@id", int.Parse(id));
                        dynamicParameters.Add("@Name", txtname.Text);
                        dynamicParameters.Add("@Address", txtAddress.Text);
                        dynamicParameters.Add("@City", txtCity.Text);
                        dynamicParameters.Add("@PhoneNo", txtPhone.Text);
                        dynamicParameters.Add("@Email", txtEmail.Text);
                        dynamicParameters.Add("@State", stateId);
                        dynamicParameters.Add("@DOB", DateTime.Parse(selected_date));
                        dynamicParameters.Add("@Password", txtPassword.Text);
                        db.Execute("usp_UpdateUser", dynamicParameters, commandType: CommandType.StoredProcedure);
                        rwUpdateMessage.Visible = true;
                        ScriptManager.RegisterStartupScript(this, GetType(), "redirect", "setTimeout(function() { window.location.replace('Dashboard.aspx'); }, 1000);", true);
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