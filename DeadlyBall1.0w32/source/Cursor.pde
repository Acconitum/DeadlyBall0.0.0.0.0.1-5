boolean cdown = false;
boolean cup = false;
boolean cselect = false;

class Cursor
{
  float cx = 180;
  float cy = 280;
  float scx = 420;
  float scy = 290;

  void paintMain() // ************************************ Konstrucktor ******************************************
  {
    fill(255, 255, 0);
    rect(cx, cy, 30, 10);
    triangle(cx + 30, cy - 10, cx + 30, cy + 20, cx + 50, cy + 5);
  }

  void paintScore()
  {
    fill(255, 255, 0);
    rect(scx, scy, 15, 5);
    triangle(scx + 15, scy - 5, scx + 15, scy + 10, scx + 25, scy + 2.5);
  }

  void moveCursorDown()// ******************************* Pefilnachuntenfunktion **********************************
  {
    if (scoreboard)
    {
      if (scy >= 370)
      {
        scy = 290;
        selectcounter = 3;
      } else {
        scy += 40;
        selectcounter += 1;
      }
    }

    if (mainmenu)
    {
      if ( cy >= 430)
      {
        cy = 280;
        selectcounter = 1;
      } else {
        cy += 75;
        selectcounter += 1;
      }
    }
    cdown = false;
  }
  void moveCursorUp()// ********************** Pfeilnachobenfunktion ************************************************
  {
    if (scoreboard)
    {
      if (scy <= 290)
      {
        scy = 370;
        selectcounter = 3;
      } else {
        scy -= 40;
        selectcounter -= 1;
      }
    }

    if (mainmenu)
    {
      if (cy <= 280)
      {
        cy = 430;
        selectcounter = 3;
      } else {
        cy -= 75;
        selectcounter -= 1;
      }
    }
    cup = false;
  }
  void select()// ****************************** Auswahl **************************************************************
  {
    switch (selectcounter)
    {
    case 1:
      mainmenu = false;
      resetGame();
      play = true;    
      selected = false;
      scoreboard = false;
      selectcounter = 1;
      scy = 290;
      break;

    case 2:
      if (scoreboard)
      {
        mainmenu = true;
        selectcounter = 1;
        scoreboard = false;
        selected = false;
        selectcounter = 1;
        scy = 290;
        resetGame();
        break;
      } else {
        mainmenu = false;
        manual = true;
        selected = false;
        selectcounter = 1;
        break;
      }

    case 3:
      theme.close();
      shot.close();
      explosion.close();
      minim.stop();
      //super.stop();    
      exit();
      break;
    }
  }

  void resetGame() // ****************************** Resetet das Spiel **************************************************
  {
    xpos = 15;
    ypos = 15;
    xspeed = 4;
    yspeed = 4;
    life = 0;
    ammoCounter = 6;
    gameovercounter = 0;
    unlucky = 0;
    unluckypoints = 0;
    totalscore = 0;
    heartbonus = 0;
    hitpointchecker = 0;
    hitpoints = 0;
    shotcounter = 0;
    score = 0;
    counter = 50;
    targetcounter = 1;
    badluck = false;
    abweichung = 1;
    nachRechts = true;
    nachUnten = true;
  }
}