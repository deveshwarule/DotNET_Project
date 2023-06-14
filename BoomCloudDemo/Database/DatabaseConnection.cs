using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace BoomCloudDemo.Database
{
    public class DatabaseConnection
    {
        public static IDbConnection CreateConnection()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            IDbConnection connection = new System.Data.SqlClient.SqlConnection(connectionString);
            return connection;
        }
    }
}