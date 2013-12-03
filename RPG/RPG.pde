Player p;
boolean[] keys;
boolean[] keys2;
float SPACE_SIZE;
PFont font;
ArrayList<Enemy> enemies;
ArrayList<AttackIcon> atkIcons;
ArrayList<Dialog> dialogs;
ArrayList<Space> spaces;
boolean battle;
boolean mouseJustPressed;
boolean runOnce;
boolean runOnce2;
boolean skipDialog;
PVector mouseLoc;
int fontSize;
String[] map;
String[] healingPotion;
String[] bronzeDagger;
String[] strToSave;
ArrayList<Item> inventory;
float carryCapacity;
boolean inMainMenu;
float r1;
float r2;
float r3;
boolean increaseR1;
boolean increaseR2;
boolean increaseR3;
boolean firstBattle;

int WORLD_SIZE_X;
int WORLD_SIZE_Y;

float CAMERA_ZOOM = 1.0;

void setup()
{
  size(500, 500, OPENGL);
  smooth();
  frameRate(60);
  //rectMode(CENTER);
  font = loadFont("AngsanaNew-48.vlw");
  fontSize = int(width * .075);
  textFont(font, fontSize);
  keys = new boolean[5];
  keys2 = new boolean[4];
  SPACE_SIZE = width * 0.05;
  runOnce = true;
  runOnce2 = true;
  mouseJustPressed = false;
  strToSave = new String[] {
    "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", 
    "xoooooooooooooooooooooooooooooooox", 
    "xoooooooooooooooooooooooooooooooox", 
    "xoooooooooooooooooooooooooooooooox", 
    "xoooooooooooooooooooooooooooooooox", 
    "xoooooooooooooooooooooooooooooooox", 
    "xooooooooooooooooooooxooooooooooox", 
    "xooooooooooooxoooooooooxooooooooox", 
    "xoooooooooooooooeoxooooooooeooooox", 
    "xooooooooooooxooooooooeooxooooooox", 
    "xooooooooooxoooxooxooxooooooooooox", 
    "xoooooooooxooooosooooooxoxooooooox", 
    "xoooooooooxooeoxoooexoooooooooooox", 
    "xooooooeoooxooooxoooxooxoeooooooox", 
    "xooooooooooooxoeooxooxooooooooooox", 
    "xooooooooooxoooooooxoooxooooooooox", 
    "xooooooooxooooxoxxoeooooooooooooox", 
    "xooooooooooeooooooooxoooooooooooox", 
    "xooooooooooooxoexoxoooooooooooooox", 
    "xooooooooooooooooxooooooooooooooox", 
    "xoooooooooooooooooooooooooooooooox", 
    "xoooooooooooooooooooooooooooooooox", 
    "xoooooooooooooooooooooooooooooooox", 
    "xoooooooooooooooooooooooooooooooox", 
    "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  };
  saveStrings("RPG Map", strToSave);
  map = loadStrings("RPG Map");
  strToSave = new String[] {
    "0-Name-1", 
    "Bronze Dagger", 
    "2-Consume-3", 
    "false", 
    "4-Passive-5", 
    "true", 
    "6-Cost-7", 
    "75", 
    "8-Player Heatlh Add (mh = max health...h = health)-9", 
    "5", 
    "10-Plyer Health Set (mh = max health...h = health)-11", 
    "h", 
    "12-Visible In Combat-13", 
    "false", 
    "14-Player Damage Add (d = damage)-15", 
    "1", 
    "16-Player Damage Set (d = damage)-17", 
    "d", 
    "18-Hands-19", 
    "1", 
    "20-Apply Effect Once-21", 
    "true"
  };
  saveStrings("Healing Potion", strToSave);
  healingPotion = loadStrings("Healing Potion");
  strToSave = new String[] {
    "0-Name-1", 
    "Healing Potion", 
    "2-Consume-3", 
    "true", 
    "4-Passive-5", 
    "false", 
    "6-Cost-7", 
    "50", 
    "8-Player Heatlh Add (mh = max health...h = health)-9", 
    "5", 
    "10-Plyer Health Set (mh = max health...h = health)-11", 
    "h", 
    "12-Visible In Combat-13", 
    "true", 
    "14-Player Damage Add (d = damage)-15", 
    "0", 
    "16-Player Damage Set (d = damage)-17", 
    "d", 
    "18-Hands-19", 
    "0", 
    "20-Apply Effect Once-21", 
    "true"
  };
  saveStrings("Bronze Dagger", strToSave);
  bronzeDagger = loadStrings("Bronze Dagger");
  WORLD_SIZE_Y = map.length;
  WORLD_SIZE_X = map[0].length();
  //inMainMenu = true;
  r1 = random(255);
  r2 = random(255);
  r3 = random(255);
  if (random(-1, 1) > 0)
    increaseR1 = true;
  else
    increaseR1 = false;
  if (random(-1, 1) > 0)
    increaseR2 = true;
  else
    increaseR2 = false;
  if (random(-1, 1) > 0)
    increaseR3 = true;
  else
    increaseR3 = false;
  restart();
}

void mainMenu()
{
  int rChangeMin = 0;
  int rChangeMax = 10;
  //frameRate(60);
  background(r1, r2, r3);
  if (r1 <= 0)
    increaseR1 = true;
  else if (r1 >= 255)
    increaseR1 = false;
  if (increaseR1)
    r1 += random(rChangeMin, rChangeMax);
  else
    r1 -= random(rChangeMin, rChangeMax);
  if (r2 <= 0)
    increaseR2 = true;
  else if (r2 >= 255)
    increaseR2 = false;
  if (increaseR2)
    r2 += random(rChangeMin, rChangeMax);
  else
    r2 -= random(rChangeMin, rChangeMax);
  if (r3 <= 0)
    increaseR3 = true;
  else if (r3 >= 255)
    increaseR3 = false;
  if (increaseR3)
    r3 += random(rChangeMin, rChangeMax);
  else
    r3 -= random(rChangeMin, rChangeMax);
  fill(r3 * 2, r2 - r1 + r3, r1 / 2);
  ellipse(width / 2, height / 2, width * .25, width * .1);
  fill(r2 + (r1 / 2), r3 / 3 + r2, r1 * 1.5);
  textFont(font, fontSize * .75);
  textAlign(CENTER, CENTER);
  text("NEW GAME", width / 2, height / 2);
}

void restart()
{
  firstBattle = true;
  battle = false;
  inventory = new ArrayList<Item>();
  carryCapacity = 100;
  enemies = new ArrayList<Enemy>();
  spaces = new ArrayList<Space>();
  for (int x = 0; x < WORLD_SIZE_X; x ++)
    for (int y = 0; y < WORLD_SIZE_Y; y ++)
    {
      if (map[y].charAt(x) != 'x')
        spaces.add(new Space(new PVector(x * SPACE_SIZE, y * SPACE_SIZE), color(0, 255, 0)));
    }
  for (int y = 0; y < WORLD_SIZE_Y; y ++)
    for (int x = 0; x < WORLD_SIZE_X; x ++)
    {
      if (map[y].charAt(x) == 'e')
      {
        if (enemies.size() == 0)
        {
          Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 115, 115, 115, 115, width * .2, 1, 2, 20, width * .15, 0);
          e.loot.add(new Item(healingPotion));
          //e.loot.add(new Item(bronzeDagger));
          //e.loot.add(new Item(bronzeDagger));
          //e.loot.add(new Item(bronzeDagger));
          //e.loot.add(new Item(bronzeDagger));
          //e.loot.add(new Item(bronzeDagger));
          //inventory.addAll(e.loot);
          enemies.add(e);
        }
        else if (enemies.size() == 1)
        {
          Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 125, -1, 125, -1, width * .2, 1, 3, 20, width * .15, 0);
          enemies.add(e);
        }
        else if (enemies.size() == 2)
        {
          Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 125, -1, 125, -1, width * .2, 1, 3, 20, width * .15, 15);
          enemies.add(e);
        }
        else if (enemies.size() == 3)
        {
          Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 125, -1, 125, -1, width * .2, 1, 3, 20, width * .15, 0);
          enemies.add(e);
        }
        else if (enemies.size() == 4)
        {
          Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 110, -1, 110, -1, width * .2, 1, 4, 20, width * .15, 10);
          enemies.add(e);
        }
        else if (enemies.size() == 5)
        {
          Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 110, -1, 110, -1, width * .2, 1, 4, 20, width * .15, 0);
          e.loot.add(new Item(bronzeDagger));
          enemies.add(e);
        }
        else if (enemies.size() == 6)
        {
          Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 115, 115, 115, 115, width * .2, 1, 2, 20, width * .15, 0);
          enemies.add(e);
        }
        else if (enemies.size() == 7)
        {
          Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 115, 115, 115, 115, width * .2, 1, 2, 20, width * .15, 25);
          enemies.add(e);
        }
        else if (enemies.size() == 8)
        {
          Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 110, -1, 110, -1, width * .2, 1, 4, 20, width * .15, 15);
          enemies.add(e);
        }
      }
      else if (map[y].charAt(x) == 's')
        p = new Player(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 25, 1, 10);
    }

  atkIcons = new ArrayList<AttackIcon>();
  //inventory.add(new Item(bronzeDagger));
  dialogs = new ArrayList<Dialog>();
  dialogs.add(new Dialog(new String[] {
    "You find yourself in a forest glade with no|memories of a past that you might have had. There|is a pile of loot infront of you, and a few dozen|men and women dressed like mages lie dead in a|circle around you.|", 
    "Their bodies look so flimsy that you could|probably break them between two fingers.|Especially the women. There is a thought in your|mind that you did not choose to think of... and its|not the one about breaking women.|", 
    "It is that there is an evil king that wants to conquer|every human settlement in the world. {Hold w, a,|s,or d to move until you get to the king's castle,|which the thought told you is to the west. Also,|watch out for enemies (red dots)!|", 
    "If you are in their vision radius, they will pursue|you until you leave the radius. If they reach your|position, a battle will start! There will be another|tutorial, however.} You feel a burning desire to|break something.|"
  }
  ));
}

void draw()
{
  if (inMainMenu)
  {
    mainMenu();
    return;
  }
  //mouseLoc = PVector.div(new PVector(mouseX, mouseY), CAMERA_ZOOM);
  background(0);
  if (!battle)
  {
    camera(p.loc.x, p.loc.y, (height/2.0) / tan(PI*30.0 / 180.0) * CAMERA_ZOOM, p.loc.x, p.loc.y, 0, 0, 1, 0);
    fill(0, 255, 0);
    stroke(0);
    for (int i = 0; i < spaces.size(); i ++)
    {
      Space s = spaces.get(i);
      s.run();
      if (s.explored)
        s.show();
    }
    for (int i = 0; i < enemies.size(); i ++)
    {
      Enemy e = enemies.get(i);
      if (e.explored)
        e.show();
      if (dialogs.size() == 0)
        e.run();
    }
    if (dialogs.size() == 0)
      p.run();
    p.show();
    textAlign(LEFT, TOP);
    fill(127);
    text("HP: " + p.hp + " / " + p.maxHP, p.loc.x - (width / 2), p.loc.y - (height / 2));
    //text("Damage: "+ p.damage, p.loc.x - (width / 2), p.loc.y - (height / 2) + fontSize);
    text("Gold: " + p.gold, p.loc.x - (width / 2), p.loc.y - (height / 2) + fontSize * 1);
  }
  else
  {
    for (int i = 0; i < atkIcons.size(); i ++)
    {
      AttackIcon a = atkIcons.get(i);
      if (a.active)
      {
        a.show();
        if (dialogs.size() == 0)
          a.run();
      }
    }
    if (dialogs.size() == 0)
      for (int i = 0; i < enemies.size(); i ++)
      {
        Enemy e = enemies.get(i);
        if (e.loc.dist(p.loc) == 0)
        {
          if (firstBattle)
          {
            dialogs.add(new Dialog(new String[] {
              "{Click on the green circles before they dissappear to damage the enemy.|}"
            }
            ));
          }
          if (dialogs.size() == 0)
            e.fight();
          firstBattle = false;
        }
      }
  }
  for (int i = 0; i < dialogs.size(); i ++)
  {
    Dialog d = dialogs.get(i);
    d.run();
    if (d.active)
      d.show();
  }
  for (int index = 0; index < inventory.size(); index ++)
  {
    Item i = inventory.get(index);
    if (i.passive && !(i.hands > 0 && p.hands > 2))
      i.run();
    if (keys[4])
      i.show();
  }
}

void keyPressed()
{
  if (key == 'w')
    keys[0] = true;
  else if (key == 'd')
    keys[1] = true;
  else if (key == 's')
    keys[2] = true;
  else if (key == 'a')
    keys[3] = true;
  else if (key == 'i')
    keys[4] = true;
  else if (keyCode == ENTER && runOnce2)
  {
    skipDialog = true;
    runOnce2 = false;
  }
}

void keyReleased()
{
  if (key == 'w')
  {
    keys[0] = false;
    keys2[0] = true;
  }
  else if (key == 'd')
  {
    keys[1] = false;
    keys2[1] = true;
  }
  else if (key == 's')
  {
    keys[2] = false;
    keys2[2] = true;
  }
  else if (key == 'a')
  {
    keys[3] = false;
    keys2[3] = true;
  }
  else if (key == 'i')
    keys[4] = false;
  else if (keyCode == ENTER)
    runOnce2 = true;
  else if (key == 'r')
    restart();
}

void mousePressed()
{
  if (runOnce)
  {
    mouseJustPressed = true;
    runOnce = false;
  }
}

void mouseReleased()
{
  mouseJustPressed = false;
  runOnce = true;
}

void mouseClicked()
{
  if (keys[4])
  {
    for (int index = 0; index < inventory.size(); index ++)
    {
      Item i = inventory.get(index);
      if (i.loc.dist(new PVector(mouseX, mouseY)) <= i.SIZE / 2)
        i.run();
    }
  }
}

