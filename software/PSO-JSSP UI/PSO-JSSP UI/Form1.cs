using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace PSO_JSSP_UI
{

    public partial class Form1 : Form
    {
        public static string username;

        public Form1()
        {
            InitializeComponent();
        }

        private SqlConnection getConnection()
        {
            string constr = "Server=IDEA-PC\\MSSQLSERVER2014;user=sa;pwd=sunpig1995#@(;database=PSOJSSP";
            SqlConnection mycon = new SqlConnection(constr);
            return mycon;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            toolStripStatusLabel1.Text = "欢迎使用本计算系统,使用前请先登录";
            toolStripStatusLabel2.Text = DateTime.Now.ToString();
            this.panel2.Visible = false;
            this.panel1.Visible = true;
            groupBox1.Visible = true;
            groupBox2.Visible = false;
            textBox1.Focus();
            button1.Image = Image.FromFile(Application.StartupPath + "\\settings_normal.jpg");
            button2.Image = Image.FromFile(Application.StartupPath + "\\results_normal.jpg");
            button3.Image = Image.FromFile(Application.StartupPath + "\\users_normal.jpg");
            button4.Image = Image.FromFile(Application.StartupPath + "\\exits_normal.jpg");
            button1.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
            button2.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
            button3.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
            button4.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            toolStripStatusLabel2.Text = DateTime.Now.ToString();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Settings paraSetting = new Settings();
            paraSetting.myForm = this;
            paraSetting.TopLevel = false;//取消顶级控件属性
            this.panel2.Controls.Add(paraSetting);
            paraSetting.FormBorderStyle = FormBorderStyle.None;//去掉边框
            paraSetting.Show();
            paraSetting.BringToFront();//页面置顶
            button1.Image = Image.FromFile(Application.StartupPath + "\\settings_selected.jpg");
            button2.Image = Image.FromFile(Application.StartupPath + "\\results_normal.jpg");
            button3.Image = Image.FromFile(Application.StartupPath + "\\users_normal.jpg");
            button4.Image = Image.FromFile(Application.StartupPath + "\\exits_normal.jpg");
            button1.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
            button2.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
            button3.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
            button4.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            button1.Image = Image.FromFile(Application.StartupPath + "\\settings_normal.jpg");
            button2.Image = Image.FromFile(Application.StartupPath + "\\results_normal.jpg");
            button3.Image = Image.FromFile(Application.StartupPath + "\\users_normal.jpg");
            button4.Image = Image.FromFile(Application.StartupPath + "\\exits_selected.jpg");
            button1.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
            button2.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
            button3.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
            button4.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
            DialogResult result = MessageBox.Show("PSO-JSSP by Wangxh\nAll Rights Reserved.2017\n感谢您的使用！退出请注意保存数据！\n确认退出？", "退出提示", MessageBoxButtons.YesNo);
            if (result == DialogResult.Yes) this.Close();
        }

        private void clearInput()
        {
            textBox1.Clear();
            textBox2.Clear();
            textBox1.Focus();
            radioButton1.Checked = false;
            radioButton2.Checked = false;
        }
        private Boolean checkName(string name)
        {
            SqlConnection mycon = getConnection();
            try
            {
                mycon.Open();
                SqlDataAdapter myDA;
                DataSet myDS = new DataSet();
                string sql = "select 用户名 from customer";
                myDA = new SqlDataAdapter(sql, mycon);
                myDA.Fill(myDS, "customerName");
                for (int i = 0; i < myDS.Tables[0].Rows.Count; i++)
                {
                    if (name == myDS.Tables[0].Rows[i]["用户名"].ToString()) return true;
                }
                mycon.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return false;
        }
        private string checkPwd(string name)
        {
            SqlConnection mycon = getConnection();
            SqlDataAdapter myDA;
            DataSet myDS = new DataSet();
            string sql = "select 密码 from customer where 用户名 COLLATE Chinese_PRC_CS_AI ='" + name + "'";//大小写敏感
            myDA = new SqlDataAdapter(sql, mycon);
            myDA.Fill(myDS, "customer");
            return myDS.Tables[0].Rows[0]["密码"].ToString();
        }
        private void button5_Click(object sender, EventArgs e)
        {
            SqlConnection mycon = getConnection();
            try
            {
                mycon.Open();
                //与数据库信息匹配检查
                if (radioButton1.Checked || radioButton2.Checked)
                {
                    string name = textBox1.Text;
                    string pwd = textBox2.Text;
                    if (checkName(name))
                    {
                        if (name == "admin" && radioButton1.Checked)
                        {
                            if (pwd == checkPwd(name))
                            {
                                MessageBox.Show("登录成功，欢迎使用本系统！", "管理员账户");
                                this.panel1.Visible = false;
                                this.panel2.Visible = true;
                                this.toolStripStatusLabel1.Text = "登录成功！当前用户为" + name;
                                username = name;
                                clearInput();
                            }
                            else
                            {
                                MessageBox.Show("用户名或密码错误，请重新输入", "登录错误");
                                clearInput();
                            }
                        }
                        else if (radioButton2.Checked)
                        {
                            if (pwd == checkPwd(name))
                            {
                                MessageBox.Show("登录成功，欢迎使用本系统！", "普通用户账户");
                                this.panel1.Visible = false;
                                this.panel2.Visible = true;
                                this.toolStripStatusLabel1.Text = "登录成功！当前用户为" + name;
                                username = name;
                                clearInput();
                            }
                            else
                            {
                                MessageBox.Show("用户名或密码错误，请重新输入", "登录错误");
                                clearInput();
                            }
                        }
                        else
                        {
                            MessageBox.Show("用户身份选择有误，请重新选择", "登录错误");
                            clearInput();
                        }
                    }
                    else
                    {
                        MessageBox.Show("用户名不存在", "错误提示");
                        clearInput();
                    }
                }
                else
                {
                    MessageBox.Show("请选择账户类型：管理员或普通用户", "错误提示");
                    clearInput();
                }
                mycon.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void clearName()
        {
            textBox5.Clear();
            textBox5.Focus();
            errorProvider1.Clear();
        }
        private void clearPwd()
        {
            textBox6.Clear();
            textBox3.Clear();
            errorProvider2.Clear();
            errorProvider3.Clear();
        }
        private void button7_Click(object sender, EventArgs e)
        {
            //将信息写入数据库
            SqlConnection mycon = getConnection();
            try
            {
                mycon.Open();
                //判断合法：用户名
                if (textBox5.Text.Trim().Length >= 4 && textBox5.Text.Trim().Length <= 10)
                {
                    if (traversalName(textBox5.Text.Trim()))
                    {
                        //判断合法：密码
                        if (textBox6.Text.Trim().Length >= 6 && textBox6.Text.Trim().Length <= 12)
                        {
                            if (textBox3.Text.Trim() == textBox6.Text.Trim())
                            {
                                //判断合法：安全提示问题
                                if (comboBox1.Text.Trim() != "")
                                {
                                    //判断合法：安全答案
                                    if (textBox4.Text.Trim() != "")
                                    {
                                        //写入信息
                                        string inName = textBox5.Text.Trim();
                                        string inPwd = textBox6.Text.Trim();
                                        string inQue = comboBox1.Text.Trim();
                                        string inAns = textBox4.Text.Trim();
                                        string insert = "insert customer (用户名,密码,安全提示问题,安全答案,计算次数) values('" + inName + "','" + inPwd + "','" + inQue + "','" + inAns + "',0)";
                                        SqlCommand mycom = new SqlCommand(insert, mycon);
                                        mycom.ExecuteNonQuery();
                                        MessageBox.Show("注册成功");
                                        clearName();
                                        clearPwd();
                                        comboBox1.Text = "";
                                        textBox4.Clear();
                                    }
                                    else
                                    {
                                        MessageBox.Show("请输入安全答案");
                                        textBox4.Focus();
                                    }
                                }
                                else
                                {
                                    MessageBox.Show("请选择安全提示问题");
                                    comboBox1.Focus();
                                }
                            }
                            else
                            {
                                MessageBox.Show("输入密码不一致");
                                clearPwd();
                                textBox6.Focus();
                            }
                        }
                        else
                        {
                            MessageBox.Show("密码必须为6-12位");
                            clearPwd();
                            textBox6.Focus();
                        }
                    }
                    else
                    {
                        MessageBox.Show("该用户名已存在");
                        clearName();
                    }
                }
                else
                {
                    MessageBox.Show("用户名必须为4-10位");
                    clearName();
                } 
                mycon.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        //遍历数据库，防止用户名重复 不重复为true,重复为false
        private Boolean traversalName(string name)
        {
            SqlConnection mycon = getConnection();
            try
            {
                mycon.Open();
                SqlDataAdapter myDA;
                DataSet myDS = new DataSet();
                string sql = "select 用户名 from customer";
                myDA = new SqlDataAdapter(sql, mycon);
                myDA.Fill(myDS, "customerName");
                for (int i = 0; i < myDS.Tables[0].Rows.Count; i++)
                {
                    if (name == myDS.Tables[0].Rows[i]["用户名"].ToString()) return false;
                }
                mycon.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return true;
        }

        private void textBox5_TextChanged(object sender, EventArgs e)
        {
            if (textBox5.Text.Trim().Length < 4 || textBox5.Text.Trim().Length > 10 || !traversalName(textBox5.Text.Trim()))
            {
                errorProvider1.SetError(textBox5, "用户名必须为4-10位,或用户名已存在");
                errorProvider1.Icon = new Icon(@"D:\My Documents\lenovo\Desktop\毕设\4 程序开发\Icon\wrong.ico");
            }
            else
            {
                errorProvider1.SetError(textBox5, "通过验证");
                errorProvider1.Icon = new Icon(@"D:\My Documents\lenovo\Desktop\毕设\4 程序开发\Icon\yes.ico");
            }
        }

        private void textBox6_TextChanged(object sender, EventArgs e)
        {
            if (textBox6.Text.Trim().Length < 6 || textBox6.Text.Trim().Length > 12)
            {
                errorProvider2.SetError(textBox6, "密码必须为6-12位");
                errorProvider2.Icon = new Icon(@"D:\My Documents\lenovo\Desktop\毕设\4 程序开发\Icon\wrong.ico");
            }
            else
            {
                errorProvider2.SetError(textBox6, "通过验证");
                errorProvider2.Icon = new Icon(@"D:\My Documents\lenovo\Desktop\毕设\4 程序开发\Icon\yes.ico");
            }
        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {
            if (textBox3.Text.Trim() != textBox6.Text.Trim())
            {
                errorProvider3.SetError(textBox3, "输入密码不一致");
                errorProvider3.Icon = new Icon(@"D:\My Documents\lenovo\Desktop\毕设\4 程序开发\Icon\wrong.ico");
            }
            else
            {
                errorProvider3.SetError(textBox3, "通过验证");
                errorProvider3.Icon = new Icon(@"D:\My Documents\lenovo\Desktop\毕设\4 程序开发\Icon\yes.ico");
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            textBox5.Clear();
            textBox6.Clear();
            textBox3.Clear();
            textBox4.Clear();
            comboBox1.Text = "";
            textBox5.Focus();
            groupBox1.Visible = true;
            groupBox2.Visible = false;
            errorProvider1.Clear();
            errorProvider2.Clear();
            errorProvider3.Clear();
        }

        private void label5_Click(object sender, EventArgs e)
        {
            groupBox1.Visible = false;
            groupBox2.Visible = true;
            textBox5.Focus();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Results resultData = new Results();
            resultData.TopLevel = false;//取消顶级控件属性
            this.panel2.Controls.Add(resultData);
            resultData.FormBorderStyle = FormBorderStyle.None;//去掉边框
            resultData.Show();
            resultData.BringToFront();//页面置顶
            button1.Image = Image.FromFile(Application.StartupPath + "\\settings_normal.jpg");
            button2.Image = Image.FromFile(Application.StartupPath + "\\results_selected.jpg");
            button3.Image = Image.FromFile(Application.StartupPath + "\\users_normal.jpg");
            button4.Image = Image.FromFile(Application.StartupPath + "\\exits_normal.jpg");
            button1.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
            button2.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
            button3.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
            button4.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (username == "admin")
            {
                CustomerAdmin adminCus = new CustomerAdmin();
                adminCus.myForm = this;
                adminCus.TopLevel = false;//取消顶级控件属性
                this.panel2.Controls.Add(adminCus);
                adminCus.FormBorderStyle = FormBorderStyle.None;//去掉边框
                adminCus.Show();
                adminCus.BringToFront();//页面置顶
            }
            else
            {
                CustomerOrdin ordinCus = new CustomerOrdin();
                ordinCus.myForm = this;
                ordinCus.TopLevel = false;//取消顶级控件属性
                this.panel2.Controls.Add(ordinCus);
                ordinCus.FormBorderStyle = FormBorderStyle.None;//去掉边框
                ordinCus.Show();
                ordinCus.BringToFront();//页面置顶
            }
            button1.Image = Image.FromFile(Application.StartupPath + "\\settings_normal.jpg");
            button2.Image = Image.FromFile(Application.StartupPath + "\\results_normal.jpg");
            button3.Image = Image.FromFile(Application.StartupPath + "\\users_selected.jpg");
            button4.Image = Image.FromFile(Application.StartupPath + "\\exits_normal.jpg");
            button1.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
            button2.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
            button3.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
            button4.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
        }

        private void button8_Click(object sender, EventArgs e)
        {
            DialogResult result = MessageBox.Show("PSO-JSSP by Wangxh\nAll Rights Reserved.2017\n感谢您的使用！退出请注意保存数据！\n确认退出？", "退出提示", MessageBoxButtons.YesNo);
            if (result == DialogResult.Yes) this.Close();
        }
    }
}
