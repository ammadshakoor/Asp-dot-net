Linq to SQL Queries:

This query is a simple join between table Units(stock) and saleunit(sale or stock out) fetch data and bind with gridview

var db = new RBEnterDataClassesDataContext();
            var q = (from dp in db.SaleUnits
                     join ds in db.Units on dp.Unit_ID equals ds.UnitId
                     where dp.Company == DropDownListSearch.SelectedValue
                     orderby dp.Date
                     select new
                     {
                         dp.SUnitId,
                         dp.Date,
                         dp.Bill,
                         dp.Company,
                         dp.Payment,
                         dp.S_Units,
                         ds.Category,
                         ds.Name
                     }).ToList();

            GridView1.DataSource = q;
            GridView1.DataBind();