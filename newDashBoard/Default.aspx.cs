using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");
    }

    protected void chkDetailsView_CheckedChanged(object sender, EventArgs e)
    {
        if (chkDetailsView.Checked)
            dvPanel.Visible = true;
        else
            dvPanel.Visible = false;
    }
}