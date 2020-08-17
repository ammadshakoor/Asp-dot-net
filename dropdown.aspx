Dropdown OnChanged/OnSelected Event

// user select category from dropdownlistcat and auto bind data to dropdownname
    protected void DropDownListCat_SelectedIndexChanged(object sender, EventArgs e)
    {
        using(var db = new RBEnterDataClassesDataContext())
        {
            var q = from p in db.Units
                    where p.Category == DropDownListCat.SelectedValue
                    select p.Name;


            DropDownListName.DataSource = q;
            DropDownListName.DataBind();

            DropDownListName.Items.Insert(0, new ListItem("Select Product", "0"));
        }
    }