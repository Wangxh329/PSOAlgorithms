using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;

using MathWorks.MATLAB.NET.Arrays;
//引用8个MATLAB dll命名空间
using FT06_6c6;
using FT10_10c10;
using FT20_20c5;
using LA01_10c5;
using LA21_15c10;
using LA26_20c10;
using LA31_30c10;
using LA36_15c15;

namespace PSO_JSSP_UI
{
    public partial class Settings : Form
    {
        public Form1 myForm;

        public Settings()
        {
            InitializeComponent();
        }

        private SqlConnection getConnection()
        {
            string constr = "Server=IDEA-PC\\MSSQLSERVER2014;user=sa;pwd=sunpig1995#@(;database=PSOJSSP";
            SqlConnection mycon = new SqlConnection(constr);
            return mycon;
        }

        public string ganttAdress;
        public string finishTime;
        private void calcMATLAB(string benchmark, string algorithm)
        {
            double genum = (Double)numericUpDown2.Value;
            double psize = (Double)numericUpDown1.Value;
            double w = (Double)numericUpDown3.Value;
            double c1 = (Double)numericUpDown4.Value;
            double c2 = (Double)numericUpDown5.Value;
            double run = (Double)numericUpDown6.Value;
            MWArray[] results = new MWArray[6];
            MWArray[] inputs = new MWArray[]{(MWArray)genum, (MWArray)psize, (MWArray)w, (MWArray)c1, (MWArray)c2, (MWArray)run};

            switch (benchmark)
            {
                case "FT06(6×6)":
                    this.label22.Text = "55";
                    FT06 myFT06 = new FT06();
                    if (algorithm == "标准离散粒子群(DPSO)算法") myFT06.mainPSO_6c6(6, ref results, inputs);
                    else if (algorithm == "协同粒子群(CPSO)算法") myFT06.mainCPSO_6c6(6, ref results, inputs);
                    break;
                case "FT10(10×10)":
                    this.label22.Text = "930";
                    FT10 myFT10 = new FT10();
                    if (algorithm == "标准离散粒子群(DPSO)算法") myFT10.mainPSO_10c10(6, ref results, inputs);
                    else if (algorithm == "协同粒子群(CPSO)算法") myFT10.mainCPSO_10c10(6, ref results, inputs);
                    break;
                case "FT20(20×5)":
                    this.label22.Text = "1165";
                    FT20 myFT20 = new FT20();
                    if (algorithm == "标准离散粒子群(DPSO)算法") myFT20.mainPSO_20c5(6, ref results, inputs);
                    else if (algorithm == "协同粒子群(CPSO)算法") myFT20.mainCPSO_20c5(6, ref results, inputs);
                    break;
                case "LA01(10×5)":
                    this.label22.Text = "666";
                    LA01 myLA01 = new LA01();
                    if (algorithm == "标准离散粒子群(DPSO)算法") myLA01.mainPSO_10c5(6, ref results, inputs);
                    else if (algorithm == "协同粒子群(CPSO)算法") myLA01.mainCPSO_10c5(6, ref results, inputs);
                    break;
                case "LA21(15×10)":
                    this.label22.Text = "1046";
                    LA21 myLA21 = new LA21();
                    if (algorithm == "标准离散粒子群(DPSO)算法") myLA21.mainPSO_15c10(6, ref results, inputs);
                    else if (algorithm == "协同粒子群(CPSO)算法") myLA21.mainCPSO_15c10(6, ref results, inputs);
                    break;
                case "LA26(20×10)":
                    this.label22.Text = "1218";
                    LA26 myLA26 = new LA26();
                    if (algorithm == "标准离散粒子群(DPSO)算法") myLA26.mainPSO_20c10(6, ref results, inputs);
                    else if (algorithm == "协同粒子群(CPSO)算法") myLA26.mainCPSO_20c10(6, ref results, inputs);
                    break;
                case "LA31(30×10)":
                    this.label22.Text = "1784";
                    LA31 myLA31 = new LA31();
                    if (algorithm == "标准离散粒子群(DPSO)算法") myLA31.mainPSO_30c10(6, ref results, inputs);
                    else if (algorithm == "协同粒子群(CPSO)算法") myLA31.mainCPSO_30c10(6, ref results, inputs);
                    break;
                case "LA36(15×15)":
                    this.label22.Text = "1268";
                    LA36 myLA36 = new LA36();
                    if (algorithm == "标准离散粒子群(DPSO)算法") myLA36.mainPSO_15c15(6, ref results, inputs);
                    else if (algorithm == "协同粒子群(CPSO)算法") myLA36.mainCPSO_15c15(6, ref results, inputs);
                    break;
                default:
                    MessageBox.Show("请选择有效的调度算例");
                    break;
            }

            finishTime = DateTime.Now.ToString();
            MWNumericArray exc = results[0] as MWNumericArray;
            MWNumericArray min = results[1] as MWNumericArray;
            MWNumericArray wre = results[2] as MWNumericArray;
            MWNumericArray are = results[3] as MWNumericArray;
            MWNumericArray t = results[4] as MWNumericArray;
            MWArray filename=results[5] as MWArray;
            ganttAdress = filename.ToString();
            this.label26.Text = exc.ToString();
            this.label23.Text = min.ToString();
            this.label25.Text = wre.ToString();
            this.label24.Text = are.ToString();
            this.label27.Text = t.ToString();
            this.label28.Text = "计算完成！";
        }
        private void button1_Click(object sender, EventArgs e)
        {
            SqlConnection mycon = getConnection();
            //try
            //{
                mycon.Open();
                if (comboBox1.Text.Trim() != "")
                {
                    if (comboBox2.Text.Trim() != "")
                    {
                        //根据不同选择调用不同MATLAB函数
                        calcMATLAB(comboBox1.Text.Trim(), comboBox2.Text.Trim());
                        //将参数及调度结果写入数据库
                        string benchmark = comboBox1.Text.Trim();
                        string algorithm = "";
                        if (comboBox2.Text.Trim() == "标准离散粒子群(DPSO)算法") algorithm = "PSO";
                        else if (comboBox2.Text.Trim() == "协同粒子群(CPSO)算法") algorithm = "CPSO";
                        int psize = (Int32)numericUpDown1.Value;
                        int gennum = (Int32)numericUpDown2.Value;
                        decimal w = numericUpDown3.Value;
                        decimal c1 = numericUpDown4.Value;
                        decimal c2 = numericUpDown5.Value;
                        int run = (Int32)numericUpDown6.Value;
                        int knownBest = int.Parse(label22.Text);
                        int best = int.Parse(label23.Text);
                        decimal are = decimal.Parse(label24.Text);
                        decimal wre = decimal.Parse(label25.Text);
                        decimal exc = decimal.Parse(label26.Text);
                        string time = this.label27.Text;
                        string headtext = "(调度算例,调度算法,种群规模,迭代次数,惯性权重W,认知因子C1,社会因子C2,运行次数,[已知最优值(秒)],[最优值(秒)],[平均相对误差(%)],[最差相对误差(%)],[寻优速率(代)],[平均计算时间(秒)],调度完成时间,用户,显示调度甘特图)";
                        string insert = "insert results " + headtext + " values('" + benchmark + "','" + algorithm + "'," + psize + "," + gennum + "," + w + "," + c1 + "," + c2 + "," + run + "," + knownBest + "," + best + "," + are + "," + wre + "," + exc + ",'" + time + "','" + finishTime + "','" + Form1.username + "','" + ganttAdress + "')";
                        SqlCommand mycom = new SqlCommand(insert, mycon);
                        mycom.ExecuteNonQuery();

                        //更新customer表中对应用户的计算次数
                        string update = "update customer set 计算次数+=1 where 用户名='" + Form1.username + "'";
                        SqlCommand mycom2 = new SqlCommand(update, mycon);
                        mycom2.ExecuteNonQuery();
                    }
                    else
                    {
                        MessageBox.Show("请选择一个调度算法");
                        comboBox2.Focus();
                    }
                }
                else
                {
                    MessageBox.Show("请选择一个调度算例");
                    comboBox1.Focus();
                }
                mycon.Close();
            //}
            //catch (Exception ex)
            //{
            //    MessageBox.Show(ex.Message);
            //}
        }

        private void Settings_Load(object sender, EventArgs e)
        {
            this.label22.Text = "";
            this.label23.Text = "";
            this.label24.Text = "";
            this.label25.Text = "";
            this.label26.Text = "";
            this.label27.Text = "";
            this.label28.Text = "准备就绪！";
        }

        private void button1_MouseDown(object sender, MouseEventArgs e)
        {
            if (comboBox1.Text.Trim() != "" && comboBox2.Text.Trim() != "") this.label28.Text = "正在计算...";
        }
    }
}
