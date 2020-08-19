Button OnClick Event

// user select category from dropdownlistcat and click button to filter data and bind filter data with grid/list view

protected void BtnSearchBy_Click(object sender, EventArgs e)
    {
        var db = new RBEnterDataClassesDataContext();
        var q = from dp in db.Employees
                where dp.Company == DropDownListSearch.SelectedValue
                select dp;

        GridView1.DataSource = q;
        GridView1.DataBind();
    }