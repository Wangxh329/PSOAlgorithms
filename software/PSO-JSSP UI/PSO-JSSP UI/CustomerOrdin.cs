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
    public partial class CustomerOrdin : Form
    {
        public Form1 myForm;

        public CustomerOrdin()
        {
            InitializeComponent();
        }

        private void dBConnection()
        {
            label6.Text = Form1.username;
            string constr = "Server=IDEA-PC\\MSSQLSERVER2014;user=sa;pwd=sunpig1995#@(;database=PSOJSSP";
            SqlConnection mycon = new SqlConnection(constr);
            try
            {
                mycon.Open();
                SqlDataAdapter myDA;
                DataSet myDS = new DataSet();
                string sql = "select * from customer where 用户名 COLLATE Chinese_PRC_CS_AI ='" + label6.Text + "'";//大小写敏感
                myDA = new SqlDataAdapter(sql, mycon);
                myDA.Fill(myDS, "customer");
                label7.Text = myDS.Tables[0].Rows[0]["密码"].ToString();
                label8.Text = myDS.Tables[0].Rows[0]["安全提示问题"].ToString();
                label9.Text = myDS.Tables[0].Rows[0]["安全答案"].ToString();

                SqlDataAdapter myDA2;
                DataSet myDS2 = new DataSet();
                string sqlCalc = "select * from results where 用户 COLLATE Chinese_PRC_CS_AI ='" + label6.Text + "'";
                myDA2 = new SqlDataAdapter(sqlCalc, mycon);
                myDA2.Fill(myDS2, "results");
                label10.Text = myDS2.Tables[0].Rows.Count.ToString();

                mycon.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void CustomerOrdin_Load(object sender, EventArgs e)
        {
            panel1.Visible = false;
            dBConnection();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            DialogResult result = MessageBox.Show("确认注销退出？", "注销提示", MessageBoxButtons.YesNo);
            if (result == DialogResult.Yes)
            {
                myForm.panel1.Visible = true;
                myForm.panel2.Controls.Clear();
                myForm.toolStripStatusLabel1.Text = "欢迎使用本计算系统,使用前请先登录";
                myForm.button1.Image = Image.FromFile(Application.StartupPath + "\\settings_normal.jpg");
                myForm.button2.Image = Image.FromFile(Application.StartupPath + "\\results_normal.jpg");
                myForm.button3.Image = Image.FromFile(Application.StartupPath + "\\users_normal.jpg");
                myForm.button4.Image = Image.FromFile(Application.StartupPath + "\\exits_normal.jpg");
                myForm.button1.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
                myForm.button2.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
                myForm.button3.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
                myForm.button4.ImageAlign = System.Drawing.ContentAlignment.MiddleCenter;
            }
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            if (textBox1.Text.Length < 6 || textBox1.Text.Length > 12)
            {
                errorProvider1.SetError(textBox1, "密码必须为6-12位");
                errorProvider1.Icon = new Icon(@"D:\My Documents\lenovo\Desktop\毕设\4 程序开发\Icon\wrong.ico");
            }
            else
            {
                errorProvider1.SetError(textBox1, "通过验证");
                errorProvider1.Icon = new Icon(@"D:\My Documents\lenovo\Desktop\毕设\4 程序开发\Icon\yes.ico");
            }
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            if (textBox2.Text != textBox1.Text)
            {
                errorProvider2.SetError(textBox2, "输入密码不一致");
                errorProvider2.Icon = new Icon(@"D:\My Documents\lenovo\Desktop\毕设\4 程序开发\Icon\wrong.ico");
            }
            else
            {
                errorProvider2.SetError(textBox2, "通过验证");
                errorProvider2.Icon = new Icon(@"D:\My Documents\lenovo\Desktop\毕设\4 程序开发\Icon\yes.ico");
            }
        }

        private void button7_Click(object sender, EventArgs e)
        {
            panel1.Visible = true;
            this.label11.Text = "编辑用户信息";
        }

        private void clearChange()
        {
            textBox1.Clear();
            textBox2.Clear();
            textBox3.Clear();
            comboBox1.Text = "";
            textBox1.Focus();
            errorProvider1.Clear();
            errorProvider2.Clear();
        }
        private void button2_Click(object sender, EventArgs e)
        {
            clearChange();
            panel1.Visible = false;
            dBConnection();
            this.label11.Text = "当前用户信息";
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //更新数据库信息
            string constr = "Server=IDEA-PC\\MSSQLSERVER2014;user=sa;pwd=sunpig1995#@(;database=PSOJSSP";
            SqlConnection mycon = new SqlConnection(constr);
            try
            {
                mycon.Open();
                //更新密码
                if (textBox1.Text.Trim() != "" && textBox1.Text == textBox2.Text)
                {
                    string updatePwd = "update customer set 密码='" + textBox1.Text.Trim() + "' where 用户名 COLLATE Chinese_PRC_CS_AI ='" + label6.Text + "'";
                    SqlCommand mycomPwd = new SqlCommand(updatePwd, mycon);
                    mycomPwd.ExecuteNonQuery();
                }
                //更新安全提示问题
                if (comboBox1.Text.Trim() != "")
                {
                    string updateQue = "update customer set 安全提示问题='" + comboBox1.Text.Trim() + "' where 用户名 COLLATE Chinese_PRC_CS_AI ='" + label6.Text + "'";
                    SqlCommand mycomQue = new SqlCommand(updateQue, mycon);
                    mycomQue.ExecuteNonQuery();
                }
                //更新安全答案
                if (textBox3.Text.Trim() != "")
                {
                    string updateAns = "update customer set 安全答案='" + textBox3.Text.Trim() + "' where 用户名 COLLATE Chinese_PRC_CS_AI ='" + label6.Text + "'";
                    SqlCommand mycomAns = new SqlCommand(updateAns, mycon);
                    mycomAns.ExecuteNonQuery();
                }
                mycon.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            //更新完毕，清除内容并显示最新信息
            clearChange();
            panel1.Visible = false;
            this.label11.Text = "当前用户信息";
            dBConnection();
        }
    }
}
