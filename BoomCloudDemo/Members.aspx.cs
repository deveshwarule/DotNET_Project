using System;
using Telerik.Web.UI;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dapper;
using System.Data;
using BoomCloudDemo.Database;
using BoomCloudDemo.Model;

namespace BoomCloudDemo
{
    public partial class Members : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dpDOB.MaxDate = DateTime.Today;    
                rwEmailExist.Visible = false;
                rwSignUpMsg.Visible = false;

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

        protected void btnAddUser_Click(object sender, EventArgs e)
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
                            string stateId = cmbState.SelectedItem.Attributes["StateId"];
                            string selected_date = date.ToString("dd-MM-yyyy");
                            dynamicParameters.Add("@Name", txtname.Text);
                            dynamicParameters.Add("@Address", txtAddress.Text);
                            dynamicParameters.Add("@City", txtCity.Text);
                            dynamicParameters.Add("@State", stateId.Trim());
                            dynamicParameters.Add("@Password", string.Empty);
                            dynamicParameters.Add("@Phone_number", txtPhone.Text);
                            dynamicParameters.Add("@Email", txtEmail.Text);
                            dynamicParameters.Add("@DOB", DateTime.Parse(selected_date));
                            db.Execute("usp_AddMember", dynamicParameters, commandType: CommandType.StoredProcedure);
                            rwSignUpMsg.Visible = true;
                            ScriptManager.RegisterStartupScript(this, GetType(), "redirect", "setTimeout(function() { window.location.replace('Dashboard.aspx'); }, 1000);", true);
                        }
                        catch (Exception ex)
                        {

                        }
                    }
                }
            }
        }
    }
}