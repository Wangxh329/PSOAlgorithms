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
    public partial class CustomerAdmin : Form
    {
        public Form1 myForm;

        public CustomerAdmin()
        {
            InitializeComponent();
        }

        private SqlDataAdapter pagingDA;
        private DataSet pagingDS = new DataSet();
        private int startVal = 0;//起始值
        private int valPerPage = 15;//每页显示的最多内容
        private int totalValNumber;//总条数
        private int currentPage = 1;//当前页

        private SqlConnection getConnection()
        {
            string constr = "Server=IDEA-PC\\MSSQLSERVER2014;user=sa;pwd=sunpig1995#@(;database=PSOJSSP";
            SqlConnection mycon = new SqlConnection(constr);
            return mycon;
        }

        private void CustomerAdmin_Load(object sender, EventArgs e)
        {
            SqlConnection mycon = getConnection();
            try
            {
                mycon.Open();
                string sql = "select * from customer";
                pagingDA = new SqlDataAdapter(sql, mycon);
                pagingDA.Fill(pagingDS, "customer");
                mycon.Close();
                totalValNumber = pagingDS.Tables[0].Rows.Count;
                //总页数计算
                int totalPageNumber = (totalValNumber % valPerPage == 0) ? (totalValNumber / valPerPage) : (totalValNumber / valPerPage + 1);
                toolStripLabel1.Text = "/" + totalPageNumber;
                loadData();
                //隔行显示不同颜色
                this.dataGridView1.RowsDefaultCellStyle.BackColor = Color.White;
                this.dataGridView1.AlternatingRowsDefaultCellStyle.BackColor = Color.Lavender;//奇数行颜色
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void loadData()
        {
            currentPage = startVal / valPerPage + 1;
            toolStripTextBox1.Text = currentPage.ToString();
            pagingDS.Clear();//新填充原表格的一部分
            pagingDA.Fill(pagingDS, startVal, valPerPage, "customer");
            bindingSource1.DataSource = pagingDS.Tables[0];
            bindingNavigator1.BindingSource = bindingSource1;//导航器前半部分显示当前页上的信息
            dataGridView1.DataSource = bindingSource1;
            //单击进入编辑模式
            this.dataGridView1.EditMode = DataGridViewEditMode.EditOnEnter;
        }

        private void toolStripButton1_Click(object sender, EventArgs e)
        {
            startVal = startVal - valPerPage;
            if (startVal < 0)
            {
                MessageBox.Show("已经是第一页");
                startVal = 0;
                return;
            }
            loadData();
        }

        private void toolStripButton2_Click(object sender, EventArgs e)
        {
            startVal = startVal + valPerPage;
            if (startVal > totalValNumber - 1)
            {
                MessageBox.Show("已经是最后一页");
                startVal = startVal - valPerPage;
                return;
            }
            loadData();
        }

        private void dataGridView1_RowPrePaint(object sender, DataGridViewRowPrePaintEventArgs e)
        {
            if (e.RowIndex > dataGridView1.Rows.Count - 1) return;
            //系统存储2种颜色
            Color oldForeColor = new Color();
            Color oldBackColor = new Color();
            var row = dataGridView1.Rows[e.RowIndex];
            if (row == dataGridView1.CurrentRow)//第一次操作时存储颜色
            {
                if (row.DefaultCellStyle.ForeColor != Color.White)
                {
                    oldForeColor = row.DefaultCellStyle.ForeColor;
                    row.DefaultCellStyle.ForeColor = Color.White;
                }
                if (row.DefaultCellStyle.BackColor != Color.Blue)
                {
                    oldBackColor = row.DefaultCellStyle.BackColor;
                    row.DefaultCellStyle.BackColor = Color.Blue;
                }
            }
            else
            {
                row.DefaultCellStyle.ForeColor = oldForeColor;
                row.DefaultCellStyle.BackColor = oldBackColor;
            }
        }

        private void dataGridView1_RowPostPaint(object sender, DataGridViewRowPostPaintEventArgs e)
        {
            //rowbounds:当前行前的单元格的左上角点
            Rectangle myrec = new Rectangle(e.RowBounds.Location.X, e.RowBounds.Location.Y, dataGridView1.RowHeadersWidth, e.RowBounds.Height);
            TextRenderer.DrawText(e.Graphics, (e.RowIndex + 1).ToString(), dataGridView1.RowHeadersDefaultCellStyle.Font, myrec, dataGridView1.RowHeadersDefaultCellStyle.ForeColor, TextFormatFlags.VerticalCenter | TextFormatFlags.HorizontalCenter);
        }

        private void dataGridView1_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {
            SqlConnection mycon = getConnection();
            try
            {
                mycon.Open();
                string mystr1 = dataGridView1.Columns[e.ColumnIndex].HeaderText + "='" + dataGridView1.CurrentCell.Value.ToString() + "'";//获取输入内容
                string mystr2 = dataGridView1.Rows[e.RowIndex].Cells[0].Value.ToString();//获取更改位置
                string updateSql = "update customer set " + mystr1 + " where 用户名 COLLATE Chinese_PRC_CS_AI = '" + mystr2 + "'";
                SqlCommand mycom = new SqlCommand(updateSql, mycon);
                mycom.ExecuteNonQuery();
                loadData();
                mycon.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void toolStripButton3_Click(object sender, EventArgs e)
        {
            if (toolStripButton3.Text == "筛选常用用户")
            {
                DataView dv;
                DataSet pagingDS2 = new DataSet();
                pagingDA.Fill(pagingDS2, "customer");
                dv = new DataView(pagingDS2.Tables[0], "计算次数>=5", "计算次数 Desc", DataViewRowState.CurrentRows);
                dataGridView1.DataSource = dv;
                toolStripButton3.Text = "取消筛选";
            }
            else
            {
                loadData();
                toolStripButton3.Text = "筛选常用用户";
            }
        }

        private void toolStripButton4_Click(object sender, EventArgs e)
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
    }
}
