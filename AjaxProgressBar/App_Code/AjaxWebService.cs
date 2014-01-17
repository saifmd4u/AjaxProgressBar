using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;

/// <summary>
/// Summary description for AjaxWebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class AjaxWebService : System.Web.Services.WebService {

    public AjaxWebService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }

    [WebMethod, ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string ProcessRequest()
    {
        return AjaxData.AjaxProcess();
    }

    [WebMethod, ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int ProcessStatus()
    {
        return AjaxData.AjaxStatus();
    }
    

}
