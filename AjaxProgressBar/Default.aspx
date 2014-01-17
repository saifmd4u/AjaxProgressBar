<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="js/jquery-1.4.1.js"></script>
    <script type="text/javascript" src="js/ui/jquery-ui.min.js"></script>	         
    <script type="text/javascript" src="js/plugins/jquery.countdown.min.js"></script>	 
    <link type="text/css" href="css/jquery-ui-1.8.4.custom.css" rel="stylesheet" />
    <link type="text/css" href="css/Site.css" rel="stylesheet" />
            
</head>
<body>
    <form id="form1" runat="server">
    <table class="ui-widget ui-widget-content" width="100%" cellpadding="10px" cellspacing="10px" border="0">
        <tr>
            <td>
                <input id="btnAjax" type="button" value="Process Ajax call" />
            </td>            
        </tr>
    </table>
    <div style="visibility:hidden">    
    <div id="dialog-message" title="Processing">
		<center>
			<span class="ui-icon ui-icon-circle-check" style="float:left; margin:0 7px 50px 0;"></span>Please wait while items are processed.<br /><br />            
            <div id="processProgress"></div>
			<div id="elapsedTime"></div>
             <div id="processResult"></div>
		</center>
    </div>
    </div>
    </form>
    <script type="text/javascript">

        var processCompleted = 0;

        $().ready(function () {

            $("#btnAjax")
            .unbind("click")
            .bind("click", function () {
                ShowModalDialog();
                $("#processProgress").progressbar({
                    value: processCompleted
                });
                CallAjaxService();
            });


        });

        function CallAjaxService() {
            $.ajax({
                url: "AjaxWebService.asmx/ProcessRequest",
                data: "{}", // For empty input data use "{}",
                dataType: "json",
                type: "POST",
                contentType: "application/json",
                complete: function (jsondata, stat) {
                    if (stat == "success") {
                        response = JSON.parse(jsondata.responseText).d;
                        $("#processResult").html(response);
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                }
            });
        }

        function CallAjaxServiceStatus() {
            $.ajax({
                url: "AjaxWebService.asmx/ProcessStatus",
                data: "{}", // For empty input data use "{}",
                dataType: "json",
                type: "POST",
                contentType: "application/json",
                complete: function (jsondata, stat) {
                    if (stat == "success") {
                        response = JSON.parse(jsondata.responseText).d;
                        processCompleted = response;
                        ShowProgress();
                        //$("#exportProgress").html(response);

                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                }
            });
        }

        function ShowModalDialog() {

            $("#dialog-message").dialog("destroy");
            $('#elapsedTime').countdown('destroy');

            $("#dialog-message").dialog({
                modal: true,
                open: function (event, ui) {
                    var startYear = new Date();
                    startYear = new Date();
                    $('#elapsedTime').countdown({
                        since: startYear,
                        format: 'HMS',
                        compact: true,
                        description: '',
                        onTick: CallAjaxServiceStatus
                    });
                },
                buttons: {
                    Cancel: function () {
                        processCancel = 1;
                    }
                }
            });
        }

        function ShowProgress() {
            $("#processProgress").progressbar({                
                value:  processCompleted
            });

            if (processCompleted == 100)
            {
                $('#elapsedTime').countdown('destroy');
            }
        }

    </script>
</body>
</html>
