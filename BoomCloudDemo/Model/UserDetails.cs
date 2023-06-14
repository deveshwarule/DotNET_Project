using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BoomCloudDemo.Model
{
    public class UserDetails
    {
        public int id { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State_id { get; set; }
        public string Phone_number { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public DateTime DOB { get; set; }
    }


}
