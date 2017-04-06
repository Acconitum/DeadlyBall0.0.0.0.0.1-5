boolean shoot = false;
boolean shotHit = false;
float sc;
float ax = 160;
float ay = 535;
float aax;


class Shot
{
  float sx, sy, ssx, ssy;



  void paintShot()// Zeichnet den Schuss***********************************
  {
    fill(255, 255, 0);
    ellipse(sx, sy, 15, 15);
  }

  void moveShot()// bewegt*************************************************
  {
    sx = xpos + abweichungX;
    sy = ypos + abweichungY;
  }
  void shotFly()//*********************************************************
  {
    sx = sx + abweichungX;
    sy = sy + abweichungY;
    if (sy >= 500)
    {
      shoot = false;
      ammoCounter -= 1;

    }
    if (sx >= 600)
    {
      shoot = false;
      ammoCounter -= 1;

    }
    if (sy <= 0)
    {
      shoot = false;
      ammoCounter -= 1;

    }
    if (sx <= 0)
    {
      shoot = false;
      ammoCounter -= 1;

    }
    
  }
   void hitShot() // Ermittelt ob ein Treffen Mit dem Opferball stattfindet
  {
    if (sx < x)
    {
      ssx = x - sx;
    } else {
      ssx = sx - x;
    }
    if (sy < y)
    {
      ssy = y - sy;
    } else {
      ssy = sy - y;
    }
    sc = sqrt((ssx * ssx) + (ssy * ssy));
    if (sc < radius / 2)
    {
      shotHit = true;
      counter = 50;
      ammoCounter -= 1;
    } // Ende Trefferabrfrage
  }
  void paintAmmo()//*******************************************************
  {
     fill(255, 255, 0);
     ellipse(aax, ay, 15, 30);
  }
}