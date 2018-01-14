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
    public partial class Results : Form
    {
        public Results()
        {
            InitializeComponent();
        }

        private SqlDataAdapter pagingDA;
        private DataSet pagingDS = new DataSet();
        private int startVal = 0;//起始值
        private int valPerPage = 15;//每页显示的最多内容
        private int totalValNumber;//总条数
        private int currentPage = 1;//当前页

        private void Results_Load(object sender, EventArgs e)
        {
            string constr = "Server=IDEA-PC\\MSSQLSERVER2014;user=sa;pwd=sunpig1995#@(;database=PSOJSSP";
            SqlConnection mycon = new SqlConnection(constr);
            try
            {
                mycon.Open();
                //根据权限显示不同信息
                string sql;
                if (Form1.username == "admin")
                {
                    sql = "select * from results";
                }
                else
                {
                    string name = Form1.username;
                    sql = "select * from results where 用户 COLLATE Chinese_PRC_CS_AI = '" + name + "'";
                }
                pagingDA = new SqlDataAdapter(sql, mycon);
                pagingDA.Fill(pagingDS, "results");
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
            pagingDA.Fill(pagingDS, startVal, valPerPage, "results");
            bindingSource1.DataSource = pagingDS.Tables[0];
            bindingNavigator1.BindingSource = bindingSource1;//导航器前半部分显示当前页上的信息
            dataGridView1.DataSource = bindingSource1;
            dataGridView1.Columns[0].Visible = false;//隐藏id列
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

        private void toolStripComboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (toolStripComboBox1.SelectedItem.ToString() == "取消筛选")
            {
                loadData();
            }
            else
            {
                DataView dv;
                DataSet pagingDS2 = new DataSet();
                pagingDA.Fill(pagingDS2, "results");
                string sql = "调度算例='" + toolStripComboBox1.SelectedItem.ToString() + "'";
                dv = new DataView(pagingDS2.Tables[0], sql, "[最优值(秒)] Asc", DataViewRowState.CurrentRows);
                dataGridView1.DataSource = dv;
            }
        }

        private void toolStripComboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (toolStripComboBox2.SelectedItem.ToString() == "取消筛选")
            {
                loadData();
            }
            else
            {
                DataView dv;
                DataSet pagingDS3 = new DataSet();
                pagingDA.Fill(pagingDS3, "results");
                string sql = "调度算法='" + toolStripComboBox2.SelectedItem.ToString() + "'";
                dv = new DataView(pagingDS3.Tables[0], sql, "[最优值(秒)] Asc", DataViewRowState.CurrentRows);
                dataGridView1.DataSource = dv;
            }
        }

        public static string imagePath;
        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int col = dataGridView1.CurrentCell.ColumnIndex;
            if (col == dataGridView1.Columns.Count - 1)
            {
                //获取当前单元格内容
                string cell = dataGridView1.CurrentCell.Value.ToString();
                //string path = @"D:\My Documents\lenovo\Desktop\毕设\4 程序开发\PSO-JSSP UI\PSO-JSSP UI\bin\x64\Debug\" + cell;
                string path = "\\" + cell;//使用相对路径,从程序根目录加载图片
                imagePath = path;
                GanttImage myGantt = new GanttImage();
                myGantt.Show();
            }
        }
    }
}
