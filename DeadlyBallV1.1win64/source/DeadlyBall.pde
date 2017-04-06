/********************************************************************************* //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// <--- WTF is That?
 * Created by Marc Mentha  
 * Date: 20.08.2015
 *
 * Title: Deadly Ball 
 * Version 1.0
 *
 * Special Thanks to:
 *
 * Miranda Kopp
 * Lukas Poncet
 * Andres Anliker
 *
 * Sound: 
 * Title : Title-X
 * Author: poinl
 *
 * Version Hystorie:
 *
 * A lot happened at some Dates
 *
 * There are still some issues 
 *
 *
 **********************************************************************************/

import ddf.minim.*;

// Definition Objekte

KillerBall kreis;
OpferBall opfer;
Gun targeter;
Shot shots;
Shot[] ammo = new Shot[6];
Cursor cursor;
Minim minim;
AudioPlayer theme;
AudioPlayer shot;
AudioPlayer explosion;
AudioPlayer hitsound;
AudioPlayer reload;


// Definition der Variablen
int score = 0;
int pausecounter = 0;
int life = 0;
int selectcounter = 1;
int ammoCounter = 6;
int gameovercounter = 0;
int unlucky = 0;
int unluckypoints = 0;
int totalscore = 0;
int heartbonus = 0;
int hitpointchecker = 0;
int hitpoints = 0;
float shotcounter = 0;
boolean pause = false;
boolean gameOver = false;
boolean badluck = false;
boolean loaded = true;
boolean play = false;
boolean selected = false;
boolean mainmenu = true;
boolean manual = false;
boolean scoreboard = false;


void setup()
{
  size(600, 625);
  kreis = new KillerBall();
  opfer = new OpferBall();
  targeter = new Gun();
  shots = new Shot();
  cursor = new Cursor();
  minim = new Minim(this);
  theme = minim.loadFile("gba1complete.mp3");
  shot = minim.loadFile("Laser2.wav");
  explosion = minim.loadFile("Explosion.wav");
  hitsound = minim.loadFile("Explosion_03.wav");
  reload = minim.loadFile("Explosion_01.wav");


  for (int i = 0; i < ammoCounter; i++)
  {
    ammo[i] = new Shot();
  }  
  theme.loop();
}

void draw()
{
  if (mainmenu) // *************************************Hauptmenü***********************************
  {
    background(0);
    noStroke();
    fill(0, 0, 255);
    ellipse(100, 80, 180, 180);
    fill(255, 255, 0);
    ellipse(270, 70, 35, 35);
    fill (255, 0, 0);
    textSize(80);
    text("Deadly Ball", 80, 90);
    triangle(80, 150, 80, 100, 200, 100);
    rect(160, 100, 400, 10);
    textSize(40);
    text("Mainmenu", 220, 200);
    fill(0, 255, 0);
    ellipse(520, 80, 60, 60);
    fill(255, 255, 0);    
    text("Play", 270, 300);
    text("Read ...", 270, 375);
    text("Exit", 270, 450);
    fill(255, 0, 255);
    textSize(20);
    text("Press 'Enter' to select", 190, 520);
    text("Move Cursor with Arrow UP/ DOWN", 120, 560);
    textSize(12);
    fill(255,0 ,0);
    text("Copyright by Marc Mentha", 10, 620);
    //triangle(93, 510, 93, 485, 30, 500);
    //triangle(93, 510, 93, 485, 160, 500);
    //triangle(80, 500, 105, 500, 93, 560);
    //triangle(80, 500, 105, 500, 93, 440); // <---- hässlicher Button
    //ellipse(94, 500, 50, 50);
    //fill(0,255,0);
    //text("Click me", 50, 508);
    cursor.paintMain();
    if (cdown)
    {
      cursor.moveCursorDown();
    }
    if (cup)
    {
      cursor.moveCursorUp();
    }
    if (selected)
    {
      cursor.select();
    } // Ende Hauptmenü
  }

  //************************************** the fucking manual ****************************************************
  if (manual)
  {
    background(0);
    noStroke();
    fill(0, 0, 255);
    ellipse(100, 80, 180, 180);
    fill(255, 255, 0);
    ellipse(270, 70, 35, 35);
    fill (255, 0, 0);
    textSize(80);
    text("Deadly Ball", 80, 90);
    triangle(80, 150, 80, 100, 200, 100);
    rect(160, 100, 400, 10);
    textSize(40);
    text("... The f***ing Manual", 80, 200);
    fill(0, 255, 0);
    ellipse(520, 80, 60, 60);
    fill(255, 0, 0);
    textSize(25); //ab hier beginnt die anleitung
    text("Be aware! This game does not like you!", 70, 250);
    fill(255);
    text("Change your guns position with \n'Arrow Left/ Right'. Press 'Spacebar'\nto shoot at the Blue Balls. Reload with\nNumpad 'Zero'. You can change\nthe direction of your shots onflight\nto hit the hard angles. Pause with 'p'.\nGood Luck", 70, 300);

    fill(255, 0, 255);
    textSize(20);
    text("Press 'Enter' = go back to Mainmenu", 115, 580);
    textSize(12);
    fill(255,0 ,0);
    text("Copyright by Marc Mentha", 10, 620);
  }



  // ************************** Hier Beginnt das spiel **********************************************************
  if (!pause && play)
  {
    background(0);
    fill(80);
    rect(0, 500, 625, 500);
    fill(255, 0, 0);
    textSize(40);
    text("Score:", 20, 600);
    text(score, 150, 600);
    text("Shots:", 20, 550);
    text("Lifes:", 345, 550);
    for (int i = 0; i < ammoCounter; i++)
    {
      aax = ax + (30 * i);
      ammo[i].paintAmmo();
    }
    kreis.paint();
    kreis.move();
    targeter.paintTargeter();
    targeter.moveTargeter();
    targeter.update();
    opfer.randomspawn(); 

    if (life == 0)
    {
      kreis.life1();
      kreis.life2();
      kreis.life3();
    }

    if (life == 1)
    {
      kreis.life1();
      kreis.life2();
    }

    if (life == 2)
    {
      kreis.life1();
    }

    kreis.lifeBringer();

    if (life >= 3)
    {
      gameOver = true;
    }

    if (badluck)
    {
      kreis.unlucky();
    }

    if (spawn)
    {
      opfer.spawn(); 
      opfer.hit();
      if (counter > -30 && opferhit)
      {
        badluck = true;
      }
    } 

    if (opferhit)
    {
      life += 1;
      counter = 50;
      hitsound.loop(0);
      spawn = false;
      opferhit = false;
    }
    
    if (!loaded)
    {
       textSize(30);
       fill(255,255,0);
       text("Reload", 20, 50);
    }

    if (shoot && loaded)
    {
      shots.paintShot();
      shots.shotFly();
      shots.hitShot();
    } else {  
      shots.moveShot();
      shoot = false;
    }
    if (shotHit)
    {
      score = score + 1;
      spawn = false;
      shotHit = false;
      shoot = false;
      explosion.loop(0);
    }

    if (ammoCounter == 0)
    {
      loaded = false;
    }
  } // Hier endet das spiel



  //***************************************** Gameoverbildschirm *************************************************
  if (gameOver)
  {
    play = false;
    if (badluck)
    {
      fill(255, 255, 0);
      textSize(40);
      text("UNLUCKY =)", 170, 300);
    }
    fill(255, 0, 0);
    textSize(80);
    text("GAME OVER", 70, 250);
    gameovercounter += 1;
    if (gameovercounter >= 150)
    {
      if (badluck)
      {
        unlucky += 1;
      }
      gameOver = false;
      scoreboard = true;
      selectcounter = 1;
    }
  }// Ende Gamoverbildschirm

  // ********************************************Scoreboard********************************************************
  if (scoreboard)
  {
    background(0);
    noStroke();
    fill(0, 0, 255);
    ellipse(100, 80, 180, 180);
    fill(255, 255, 0);
    ellipse(270, 70, 35, 35);
    fill (255, 0, 0);
    textSize(80);
    text("Deadly Ball", 80, 90);
    triangle(80, 150, 80, 100, 200, 100);
    rect(160, 100, 400, 10);
    textSize(40);
    text("Scoreboard", 135, 200);
    rect(90, 215, 300, 3);
    rect(338, 215, 3, 235);
    textSize(30);
    text("Unlucky", 90, 260);
    text(unlucky, 280, 260);
    text(unlucky * 2, 350, 260);
    text("Hits in %", 90, 300);
    hitpointchecker = int(score / shotcounter * 100);
    text(hitpointchecker, 280, 300);

    // abfrage wie hoch die trefferquote ist und wie viele punkte dafür man kriegt ---> hitpoints
    if (hitpointchecker > 39)
    {
      hitpoints = 1;
    }
    if (hitpointchecker > 59)
    {
      hitpoints = 2;
    }
    if (hitpointchecker > 79)
    {
      hitpoints = 4;
    }
    text(hitpoints, 350, 300);

    // abfrage ob es mit den unluckypoints und mit dem score auf ein leben gerreicht hätte. wenn ja 5 punkte = heartbonus;
    for (int i = 1; i <= unlucky * 2; i++)
    {
      if ( (i + score) % 15 == 0)
      {
        heartbonus = 5;
      }
    }
    text("Heartbonus", 90, 340);
    text(heartbonus, 350, 340);
    text("Score", 90, 380);
    text(score, 350, 380);   
    rect(90, 395, 300, 3);    
    totalscore = score + (unlucky * 2) + heartbonus + hitpoints;
    text("Totalscore", 90, 440);
    text(totalscore, 350, 440);
    fill(0, 255, 0);
    ellipse(520, 80, 60, 60);
    textSize(20);
    fill(255, 255, 0);    
    text("Try again", 450, 300);
    text("Mainmenu", 450, 340);
    text("Exit", 450, 380);
    fill(255, 0, 255);
    textSize(20);
    text("Press 'Enter' to select", 195, 520);
    text("Move Cursor with Arrow UP/ DOWN", 120, 560);
    cursor.paintScore();
    if (cdown)
    {
      cursor.moveCursorDown();
    }
    if (cup)
    {
      cursor.moveCursorUp();
    }
    if (selected)
    {
      cursor.select();
    }
  }// Ende scoreboard
}
//**********************************************Tastenzuweisung**********************************************
void keyReleased()
{
  if (key == ' ')
  {
    shoot = true;
    if (loaded && play)
    {
      shot.loop(0);
      shotcounter = shotcounter + 1;
    }
  }

  if (key == 'p')
  {
    if (!pause)
    {
      pause = true;
    }
    if (pause && pausecounter > 0)
    {
      pause = false;
      pausecounter = -1;
    }
    pausecounter += 1;
  }

  if (key == '0' && play)
  {
    loaded = true;
    ammoCounter = 6;
    reload.loop(0);
  }
  /*if (key == 's' && !play)
  {
    if (mainmenu || scoreboard)
    {
      selected = true;
    }
    if (manual)
    {
      manual = false;
      mainmenu = true;
      selected = false;
      selectcounter = 2;
    }
  }*/

  if (key == CODED)
  {
    if (keyCode == RIGHT)
    {
      targetcounter -=1;
      if (targetcounter < 0)
      {
        targetcounter = 7; 
      }
    }
    if (keyCode == LEFT)
    {
      targetcounter += 1;
      if (targetcounter > 7)
      {
        targetcounter = 0;
      }
    }
    if (keyCode == DOWN && !play)
    {
      cdown = true;
    }
    if (keyCode == UP && !play)
    {
      cup = true;
    }
    
  }
  if (keyCode == ENTER && !play)
    {
      selected = true;
    }
    if (manual)
    {
      manual = false;
      mainmenu = true;
      selected = false;
      selectcounter = 2;
    }
} // Ende Keyreleased