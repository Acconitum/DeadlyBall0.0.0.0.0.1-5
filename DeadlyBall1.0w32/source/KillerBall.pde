
// Definition globale Variablen

int klaenge = 30;
int unluckytimer;
float xpos = 15, ypos = 15;
float xspeed = 4, yspeed = 4;
float abweichung = 1;
boolean nachRechts = true;
boolean nachUnten = true;

class KillerBall
{
  float mx, my, sx, sy, ssx, ssy;



  boolean bringer = false;


  void paint() // konstruiert den Ball************************************
  {
    fill(0, 255, 0);
    ellipse(xpos, ypos, klaenge, klaenge);
  }

  void move() // bewegt den Ball*****************************************
  {
    if (nachRechts && nachUnten)
    {
      xpos += xspeed;
      ypos += yspeed;
    }

    if (!nachRechts && !nachUnten)
    {
      xpos -= xspeed;
      ypos -= yspeed;
    }

    if (!nachUnten && nachRechts)
    {
      xpos += xspeed;
      ypos -= yspeed;
    }
    if (nachUnten && !nachRechts)
    {
      xpos -= xspeed;
      ypos += yspeed;
    }
    if (ypos >= 485)
    {
      nachUnten = false;
      yspeed = yspeed + abweichung;
    }
    if (ypos <= 15)
    {
      nachUnten = true;
      yspeed = yspeed - abweichung;
    }
    if (xpos >= 585)
    {
      nachRechts = false;
      xspeed = xspeed - abweichung;
    } 
    if (xpos <= 15)
    {
      nachRechts = true;
      xspeed = xspeed + abweichung;
    }
  } // move Ende
  void life1()// Zeichnet Herze?!*****************************************
  {
    fill(255, 0, 0);
    noStroke();
    triangle(460.5, 535, 491.5, 535, 476, 558);
    triangle(461, 535, 491, 535, 476, 520);
    ellipse(468, 527, 22, 22);
    ellipse(484, 527, 22, 22);
  }
  void life2()
  {
    fill(255, 0, 0);
    noStroke();
    triangle(510.5, 535, 541.5, 535, 526, 558);
    triangle(511, 535, 542, 535, 526, 520);
    ellipse(518, 527, 22, 22);
    ellipse(534, 527, 22, 22);
  }
  void life3()
  {
    fill(255, 0, 0);
    noStroke();
    triangle(560.5, 535, 591.5, 535, 576, 558);
    triangle(561, 535, 591, 535, 576, 520);
    ellipse(568, 527, 22, 22);
    ellipse(584, 527, 22, 22);
  }
  void unlucky()// HA, Ha=)*****************************************************
  {
    unluckytimer += 1;
    fill(255, 255, 0);
    textSize(40);
    if (unluckytimer > 5)
    {
      text("UNLUCKY =)", 170, 250);
    }
    if (unluckytimer == 45)
    {
      badluck = false;
      unluckytimer = 0;
      unlucky += 1;
    }
  }
  void lifeBringer()//************************************************************
  {

    if (score > 0)
    {
      if (score % 14 == 0)
      {
        bringer = true;
      }
      if (score % 15 == 0 && bringer)
      {
        if (life == 0)
        {
          bringer = false;
        }
        if (life == 1)
        {
          life = 0;
          bringer = false;
        }
        if (life == 2)
        {
          life = 1;
          bringer = false;
        }
      }
    }
  }
}