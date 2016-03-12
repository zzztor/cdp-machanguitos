using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Drawing;

class Program
{
    static void Main(string[] args)
    {
        //Cargamos la capa GIS
        Bitmap gis = new Bitmap(@"C:\4.png");
        //Cargamos la capa problema
        Bitmap problem = new Bitmap(@"C:\output30000.png");
        int x, y, p, n, m, paux, naux, maux;
        p = 0;
        n = 0;
        m = 0;
        paux = 0;
        naux = 0;
        maux = 0;

        for (x = 0; x < gis.Width; x++)
        {
            for (y = 0; y < gis.Height; y++)
            {
                Color gisValues = gis.GetPixel(x, y); // gisValue.A , gisValue.R , gisValue.G , gisValue.B
                Color problemValues = problem.GetPixel(x, y);
                if (gisValues.R == 0){ // Si es agua sumamos
                    m += problemValues.R;
                    p += problemValues.G;
                    n += problemValues.B;
                }
                maux += problemValues.R;
                paux += problemValues.G;
                naux += problemValues.B;

            }
        }
        string lines = "m:" + m + "\r\np:" + p + "\r\nn:" + n + "\r\nmaux:" + maux + "\r\npaux:" + paux + "\r\nnaux:" + naux;
        System.IO.StreamWriter file = new System.IO.StreamWriter(@"C:\results.txt");
        file.WriteLine(lines); // Escribimos el output en un fichero
        file.Close();

    }
}