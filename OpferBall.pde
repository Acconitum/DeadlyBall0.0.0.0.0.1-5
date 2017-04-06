 //<>//
// Definition globale Variablen

int counter = 50;
boolean spawn = false;
boolean rspawn = false;
boolean opferhit = false;
float c, radius, x, y;

// Anfang Klasse Opferball
class OpferBall
{
  // Definiton Variablen
  float ax, ay;

  void spawn() // Zeichnet Ball********************************************
  {

    fill(0, 0, 200);
    ellipse(x, y, radius, radius);
  } // Ende Paint

  void randomspawn() // Generiert Zufällig X- und Y-Koordinaten************
  {
    counter -=1;
    if (counter == 0)
    {
      rspawn = true;
    }    
    if (rspawn)
    {
      x = random(30, 560);
      y = random(30, 460);
      radius = 50;      
      spawn = true;
      rspawn = false;
    }
  } // Ende Zufallsgenerator


  void hit() // Ermittelt ob ein Treffen Mit dem Killerball stattfindet****
  {
    if (x < xpos)
    {
      ax = xpos - x;
    } else {
      ax = x - xpos;
    }
    if (y < ypos)
    {
      ay = ypos - y;
    } else {
      ay = y - ypos;
    }
    c = sqrt((ax * ax) + (ay * ay));
    if (c - 15 < radius / 2)
    {
      opferhit = true;
     
    } // Ende Trefferabrfrage
  }
  void opferHitAnimation() //Demnächst im Kino*****************************
  {
  }
}