
// Definition globale Variablen

int targetcounter = 1;
boolean targetR = false;
boolean targetL = false;
float tx, ty;
float abweichungX = 15;
float abweichungY = 0;

// Anfang Klasse Targeter

class Gun
{
  float tx = xpos;
  float ty = ypos + abweichungY;


  void paintTargeter()//**********************************************
  {

    fill(255, 0, 0);
    ellipse(tx, ty, 15, 15);
  }// Ende Paint

  void moveTargeter()//***********************************************
  {
    tx = xpos + abweichungX;
    ty = ypos + abweichungY;
  }

  void update()//*****************************************************
  {
    switch(targetcounter)
    {
    case 1:
      abweichungX = 15;
      abweichungY = 0;
      break;

    case 2:
      abweichungX = 9;
      abweichungY = -9;
      break;

    case 3:
      abweichungX = 0;
      abweichungY = -15;
      break;

    case 4:
      abweichungX = -9;
      abweichungY = -9;
      break;

    case 5:
      abweichungX = -15;
      abweichungY = 0;
      break;

    case 6:
      abweichungX = -9;
      abweichungY = 9;
      break;

    case 7:
      abweichungX = 0;
      abweichungY = +15;
      break;

    case 0:
      abweichungX = 9;
      abweichungY = 9;
      break;
    }
  }// Ende MoveRight
} // Ende Klasse