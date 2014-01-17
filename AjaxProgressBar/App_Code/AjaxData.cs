using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for AjaxData
/// </summary>
public class AjaxData
{
    private static int status = 0;

	public AjaxData()
	{
        status = 0;
	}

    public static string AjaxProcess()
    {
        string retValue = "Started";
        status = 0;
        for(int i=1;i<=100;i++)
        {
            System.Threading.Thread.Sleep(100);
            status++;
        }

        retValue = "Completed Successfully !";
        return retValue;
    }

    public static int AjaxStatus()
    {
        return status;
    }

}