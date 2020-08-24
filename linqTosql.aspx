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

// Update Record using Linq query 
// select using Id of table and update the record..

using (var db = new RBEnterDataClassesDataContext())
                        {
                            var d = (from p in db.Units
                                     where p.UnitId == w
                                     select p.Units).SingleOrDefault();
                            var cal = Convert.ToInt32(d) - Convert.ToInt32(TxtUnits.Text);

                            var query = (from p in db.Units
                                         where p.UnitId == w
                                         select p).First();

                            query.Units = Convert.ToInt32(cal);
                            query.Total = Convert.ToInt32(TxtPrice.Text) * Convert.ToInt32(cal);
                            db.SubmitChanges();
                        }



// Sharing of amount in startup/business 
    // dirtibute amount process one-time not auto
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        

        // Account update of the person who get money
        using (var dc = new DataClassesDashboardJPDataContext())
        {
            var q = (from z in dc.Users
                     where z.Username == Session["userLogin"].ToString()
                     select z.User_ID).SingleOrDefault();
            // select overall-balance to distribute after distribute balance equal to zero 
            var r = (from z in dc.Accounts
                     where z.Depart == "HR"
                     orderby z.Acc_ID descending
                     select z.O_Balance).First().ToString();

            var hr = (Convert.ToInt32(r) / 100) * 50; // hr aquire 50% sharing of Net profit;

            var sap = (Convert.ToInt32(r) / 100) * 10; // sap aquire 10% sharing of Net profit;

            var invest = (Convert.ToInt32(r) / 100) * 40;// invest aquire 40% sharing of Net profit;

            // money out from before executing distibution
            var rr = (from z in dc.Accounts
                     where z.Depart == "HR" && z.Desc == "Profit"
                     orderby z.Acc_ID descending
                     select z.O_Balance).First().ToString();
            var up = Convert.ToInt32(r) - Convert.ToInt32(rr);
            Account exe = new Account
            {
                User_Id = q,
                Depart = "HR",
                Date = Convert.ToString(DateTime.Now),
                Desc = "Profit",
                Money_Out = Convert.ToInt32(rr),
                O_Balance = Convert.ToInt32(up),
                Acc_Identity_Num = 1005
            };
            dc.Accounts.InsertOnSubmit(exe);
            dc.SubmitChanges();

            if (hr != 0)
            {
                LblHR.Text = hr.ToString();
                // money transfer to HRrrrrrr........
                var f = (from z in dc.Accounts
                         where z.Depart == "HR"
                         orderby z.Acc_ID descending
                         select z.O_Balance).First().ToString();
                if (f == null)
                {
                    Account acc = new Account
                    {
                        User_Id = q,
                        Depart = "HR",
                        Money_In = Convert.ToInt32(hr),
                        Date = Convert.ToString( DateTime.Now),
                        O_Balance = Convert.ToInt32(hr),
                        Desc = "Net",
                        Acc_Identity_Num = 1005
                    };
                    dc.Accounts.InsertOnSubmit(acc);
                    dc.SubmitChanges();
                }
                else
                {
                    int bal = Convert.ToInt32(f) + Convert.ToInt32(hr);
                    Account acc = new Account
                    {
                        User_Id = q,
                        Depart = "HR",
                        Money_In = Convert.ToInt32(hr),
                        Date = Convert.ToString(DateTime.Now),
                        O_Balance = Convert.ToInt32(bal),
                        Desc = "Net",
                        Acc_Identity_Num = 1005
                    };
                    dc.Accounts.InsertOnSubmit(acc);
                    dc.SubmitChanges();
                }
                if (sap != 0)
                {
                    LblSap.Text = sap.ToString();
                    try
                    {
                        // money transfer to Saplogics......
                        var s = (from z in dc.Accounts
                                 where z.Depart == "Saplogics"
                                 orderby z.Acc_ID descending
                                 select z.O_Balance).First().ToString();
                        if (s == null)
                        {
                            Account acc = new Account
                            {
                                User_Id = q,
                                Depart = "Saplogics",
                                Money_In = Convert.ToInt32(sap),
                                Date = Convert.ToString(DateTime.Now),
                                O_Balance = Convert.ToInt32(sap),
                                Desc = "Profit",
                                Acc_Identity_Num = 1006
                            };
                            dc.Accounts.InsertOnSubmit(acc);
                            dc.SubmitChanges();
                        }
                        else
                        {
                            int bal1 = Convert.ToInt32(s) + Convert.ToInt32(sap);
                            Account acc = new Account
                            {
                                User_Id = q,
                                Depart = "Saplogics",
                                Money_In = Convert.ToInt32(sap),
                                Date = Convert.ToString(DateTime.Now),
                                O_Balance = Convert.ToInt32(bal1),
                                Desc = "Profit",
                                Acc_Identity_Num = 1006
                            };
                            dc.Accounts.InsertOnSubmit(acc);
                            dc.SubmitChanges();
                        }
                    }
                    catch (Exception)
                    {
                        Account acc = new Account
                        {
                            User_Id = q,
                            Depart = "Saplogics",
                            Money_In = Convert.ToInt32(sap),
                            Date = Convert.ToString(DateTime.Now),
                            O_Balance = Convert.ToInt32(sap),
                            Desc = "Profit",
                            Acc_Identity_Num = 1006
                        };
                        dc.Accounts.InsertOnSubmit(acc);
                        dc.SubmitChanges();
                    }
                    
                    if (invest != 0)
                    {
                        LblInvest.Text = invest.ToString();

                        try
                        {
                            // money transfer to Investorsss........
                            var i = (from z in dc.Accounts
                                     where z.Depart == "Investor" && z.Desc == "Profit"
                                     orderby z.Acc_ID descending
                                     select z.O_Balance).First().ToString();
                            if (i == null)
                            {
                                Account acc = new Account
                                {
                                    User_Id = q,
                                    Depart = "Investor",
                                    Money_In = Convert.ToInt32(invest),
                                    Date = Convert.ToString(DateTime.Now),
                                    O_Balance = Convert.ToInt32(invest),
                                    Desc = "Profit",
                                    Acc_Identity_Num = 1004
                                };
                                dc.Accounts.InsertOnSubmit(acc);
                                dc.SubmitChanges();
                            }
                            else
                            {
                                int bal11 = Convert.ToInt32(i) + Convert.ToInt32(invest);
                                Account acc = new Account
                                {
                                    User_Id = q,
                                    Depart = "Investor",
                                    Money_In = Convert.ToInt32(invest),
                                    Date = Convert.ToString(DateTime.Now),
                                    O_Balance = Convert.ToInt32(invest),
                                    Desc = "Profit",
                                    Acc_Identity_Num = 1004
                                };
                                dc.Accounts.InsertOnSubmit(acc);
                                dc.SubmitChanges();
                            }
                        }
                        catch (Exception)
                        {
                            Account acc = new Account
                            {
                                User_Id = q,
                                Depart = "Investor",
                                Money_In = Convert.ToInt32(invest),
                                Date = Convert.ToString(DateTime.Now),
                                O_Balance = Convert.ToInt32(invest),
                                Desc = "Profit",
                                Acc_Identity_Num = 1004
                            };
                            dc.Accounts.InsertOnSubmit(acc);
                            dc.SubmitChanges();
                        }
                    }
                    else
                    {
                        LblInvest.Text = "0";
                    }
                }
                else
                {
                    LblSap.Text = "0";
                }
            }
            else
            {
                LblHR.Text = "0";
            }
        }
        GridDisplayDashAccStatus();
    }
