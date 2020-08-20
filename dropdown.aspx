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

// important note point 
When you bind data from one dropdown to another it's create errors fetch the first on the top, for avoid error use this code,
After bind Data enter this line start with dropdown name and copy further and in Select product you write what you want.
DropDownListName.Items.Insert(0, new ListItem("Select Product", "0"));
