using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace PSO_JSSP_UI
{
    public partial class GanttImage : Form
    {
        public GanttImage()
        {
            InitializeComponent();
        }

        private void GanttImage_Load(object sender, EventArgs e)
        {
            pictureBox1.SizeMode = PictureBoxSizeMode.Zoom;
            //pictureBox1.Image = Image.FromFile(Results.imagePath);
            pictureBox1.Image = Image.FromFile(Application.StartupPath + Results.imagePath);
        }
    }
}
