import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class DeadlyBall extends PApplet {

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


public void setup()
{
  
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

public void draw()
{
  if (mainmenu) // *************************************Hauptmen\u00fc***********************************
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
    text("Press 's' to select", 220, 520);
    text("Move Cursor with Arrow UP/ DOWN", 120, 560);
    //triangle(93, 510, 93, 485, 30, 500);
    //triangle(93, 510, 93, 485, 160, 500);
    //triangle(80, 500, 105, 500, 93, 560);
    //triangle(80, 500, 105, 500, 93, 440); // <---- h\u00e4sslicher Button
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
    } // Ende Hauptmen\u00fc
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


    fill(255, 0, 255);
    textSize(20);
    text("Press 's' = go back to Mainmenu", 135, 560);
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
    hitpointchecker = PApplet.parseInt(score / shotcounter * 100);
    text(hitpointchecker, 280, 300);

    // abfrage wie hoch die trefferquote ist und wie viele punkte daf\u00fcr man kriegt ---> hitpoints
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

    // abfrage ob es mit den unluckypoints und mit dem score auf ein leben gerreicht h\u00e4tte. wenn ja 5 punkte = heartbonus;
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
    text("Press 's' to select", 220, 520);
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
public void keyReleased()
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
  if (key == 's')
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
  }

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
    if (keyCode== ENTER)
    {
    }
  }
} // Ende Keyreleased
boolean cdown = false;
boolean cup = false;
boolean cselect = false;

class Cursor
{
  float cx = 180;
  float cy = 280;
  float scx = 420;
  float scy = 290;

  public void paintMain() // ************************************ Konstrucktor ******************************************
  {
    fill(255, 255, 0);
    rect(cx, cy, 30, 10);
    triangle(cx + 30, cy - 10, cx + 30, cy + 20, cx + 50, cy + 5);
  }

  public void paintScore()
  {
    fill(255, 255, 0);
    rect(scx, scy, 15, 5);
    triangle(scx + 15, scy - 5, scx + 15, scy + 10, scx + 25, scy + 2.5f);
  }

  public void moveCursorDown()// ******************************* Pefilnachuntenfunktion **********************************
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
  public void moveCursorUp()// ********************** Pfeilnachobenfunktion ************************************************
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
  public void select()// ****************************** Auswahl **************************************************************
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

  public void resetGame() // ****************************** Resetet das Spiel **************************************************
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


  public void paintTargeter()//**********************************************
  {

    fill(255, 0, 0);
    ellipse(tx, ty, 15, 15);
  }// Ende Paint

  public void moveTargeter()//***********************************************
  {
    tx = xpos + abweichungX;
    ty = ypos + abweichungY;
  }

  public void update()//*****************************************************
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


  public void paint() // konstruiert den Ball************************************
  {
    fill(0, 255, 0);
    ellipse(xpos, ypos, klaenge, klaenge);
  }

  public void move() // bewegt den Ball*****************************************
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
  public void life1()// Zeichnet Herze?!*****************************************
  {
    fill(255, 0, 0);
    noStroke();
    triangle(460.5f, 535, 491.5f, 535, 476, 558);
    triangle(461, 535, 491, 535, 476, 520);
    ellipse(468, 527, 22, 22);
    ellipse(484, 527, 22, 22);
  }
  public void life2()
  {
    fill(255, 0, 0);
    noStroke();
    triangle(510.5f, 535, 541.5f, 535, 526, 558);
    triangle(511, 535, 542, 535, 526, 520);
    ellipse(518, 527, 22, 22);
    ellipse(534, 527, 22, 22);
  }
  public void life3()
  {
    fill(255, 0, 0);
    noStroke();
    triangle(560.5f, 535, 591.5f, 535, 576, 558);
    triangle(561, 535, 591, 535, 576, 520);
    ellipse(568, 527, 22, 22);
    ellipse(584, 527, 22, 22);
  }
  public void unlucky()// HA, Ha=)*****************************************************
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
  public void lifeBringer()//************************************************************
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

  public void spawn() // Zeichnet Ball********************************************
  {

    fill(0, 0, 200);
    ellipse(x, y, radius, radius);
  } // Ende Paint

  public void randomspawn() // Generiert Zuf\u00e4llig X- und Y-Koordinaten************
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


  public void hit() // Ermittelt ob ein Treffen Mit dem Killerball stattfindet****
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
  public void opferHitAnimation() //Demn\u00e4chst im Kino*****************************
  {
  }
}
boolean shoot = false;
boolean shotHit = false;
float sc;
float ax = 160;
float ay = 535;
float aax;


class Shot
{
  float sx, sy, ssx, ssy;



  public void paintShot()// Zeichnet den Schuss***********************************
  {
    fill(255, 255, 0);
    ellipse(sx, sy, 15, 15);
  }

  public void moveShot()// bewegt*************************************************
  {
    sx = xpos + abweichungX;
    sy = ypos + abweichungY;
  }
  public void shotFly()//*********************************************************
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
   public void hitShot() // Ermittelt ob ein Treffen Mit dem Opferball stattfindet
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
  public void paintAmmo()//*******************************************************
  {
     fill(255, 255, 0);
     ellipse(aax, ay, 15, 30);
  }
}
  public void settings() {  size(600, 625); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DeadlyBall" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
