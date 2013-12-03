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
    "It is that there is an evil king that wants to conquer|every human settlement in the world. You feel a|powerful desire to break something.|"
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
          e.fight();
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

class AttackIcon
{
  PVector loc;
  float maxSize, size;
  int lifeLength, age, DAMAGE;
  boolean active, bad;

  AttackIcon(PVector loc, int lifeLength, int DAMAGE, boolean bad)
  {
    this.DAMAGE = DAMAGE;
    maxSize = width * 0.075;
    this.lifeLength = lifeLength;
    age = 0;
    maxSize = width * .075;
    this.loc = loc;
    active = true;
    this.bad = bad;
    size = 1;
  }

  void show()
  {
    stroke(127);
    if (bad)
      fill(255, 0, 0);
    else
      fill(0, 255, 0);
    //println(fillColor);
    float lifeLeft = lifeLength - age;
    float fractionOfLife = lifeLeft / lifeLength;
    size = fractionOfLife * maxSize;
    ellipse(loc.x, loc.y, size, size);
  }

  void run()
  {
    age ++;
    if (active && age > lifeLength)
    {
      active = false;
      atkIcons.remove(this);
      if (!bad)
        p.hp -= DAMAGE;
    }
  }
}

class Dialog
{
  String[] strings;
  int currentPart;
  boolean active;

  Dialog(String[] strings)
  {
    this.strings = strings;
    currentPart = 0;
    active = true;
  }

  void show()
  {
    fill(255);
    rectMode(CORNERS);
    rect(0, p.loc.y + (height / 2) - (height * .425), width * 2, p.loc.y + (height / 2));
    fill(0);
    textAlign(LEFT, TOP);
    String[] lines = new String[7];
    for (int i = 0; i < lines.length; i ++)
      lines[i] = "";
    int currentLine = 0;
    int lastLineEnd = 0;
    for (int i = 0; i < strings[currentPart].length(); i ++)
    {
      if (strings[currentPart].charAt(i) == '|')
      {
        lines[currentLine] = strings[currentPart].substring(lastLineEnd, i);
        currentLine ++;
        lastLineEnd = i + 1;
      }
    }
    for (int i = 0; i < lines.length; i ++)
    {
      for (int i2 = 0; i2 < 4; i2 ++)
        text(lines[i], p.loc.x - (width / 2), p.loc.y + (height / 2) - (height * .375) + (fontSize * i) - (fontSize / 2));
    }
  }

  void run()
  {
    if (skipDialog)
    {
      skipDialog = false;
      currentPart ++;
      if (currentPart >= strings.length)
      {
        dialogs.remove(this);
        active = false;
      }
    }
  }
}

class Enemy
{
  PVector loc;
  float SIZE, MIN_ICON_SPREAD, SIGHT_RADIUS;
  int defense, defenseTimer, defenseStay, offense, offenseTimer, offenseStay, DAMAGE, hp, maxHP, SPEED, moveTimer, gold;
  ArrayList loot;
  boolean explored;

  Enemy(PVector loc, int defense, int offense, int defenseStay, int offenseStay, float MIN_ICON_SPREAD, int DAMAGE, int maxHP, int SPEED, float SIGHT_RADIUS, int gold)
  {
    this.loc = loc;
    SIZE = width * 0.05;
    this.defense = defense;
    this.offense = offense;
    defenseTimer = 0;
    offenseTimer = 0;
    this.defenseStay = defenseStay;
    this.offenseStay = offenseStay;
    this.MIN_ICON_SPREAD = MIN_ICON_SPREAD;
    this.DAMAGE = DAMAGE;
    this.maxHP = maxHP;
    hp = maxHP;
    this.SPEED = SPEED;
    loot = new ArrayList();
    this.SIGHT_RADIUS = SIGHT_RADIUS;
    this.gold = gold;
    explored = false;
  }

  void show()
  {
    stroke(0);
    fill(255, 0, 0);
    //println(fillColor);
    ellipse(loc.x, loc.y, SIZE, SIZE);
    noStroke();
    fill(255, 0, 0, 75);
    ellipse(loc.x, loc.y, SIGHT_RADIUS, SIGHT_RADIUS);
  }

  void run()
  {
    if (loc.dist(p.loc) <= p.SIGHT_RADIUS / 2)
      explored = true;
    moveTimer ++;
    if (moveTimer > SPEED && loc.dist(p.loc) <= SIGHT_RADIUS / 2)
    {
      moveTimer = 0;
      PVector direction = PVector.sub(p.loc, loc);
      float horizonatalDirection = min(PVector.angleBetween(direction, new PVector(1, 0)), PVector.angleBetween(direction, new PVector(-1, 0)));
      float verticalDirection = min(PVector.angleBetween(direction, new PVector(0, 1)), PVector.angleBetween(direction, new PVector(0, -1)));
      if (min(horizonatalDirection, verticalDirection) == horizonatalDirection)
      {
        if (horizonatalDirection == PVector.angleBetween(direction, new PVector(1, 0)))
          loc.x += SPACE_SIZE;
        else
          loc.x -= SPACE_SIZE;
      }
      else
      {
        if (verticalDirection == PVector.angleBetween(direction, new PVector(0, 1)))
          loc.y += SPACE_SIZE;
        else
          loc.y -= SPACE_SIZE;
      }
    }
    if (loc.dist(p.loc) == 0)
    {
      camera(width / 2, height / 2, (height/2.0) / tan(PI*30.0 / 180.0) * CAMERA_ZOOM, width / 2, height / 2, 0, 0, 1, 0);
      atkIcons.clear();
      battle = true;
    }
  } 

  void fight()
  {
    if (p.hp <= 0)
      restart();
    if (hp <= 0)
    {
      battle = false;
      p.gold += gold;
      inventory.addAll(loot);
      enemies.remove(this);
    }
    defenseTimer ++;
    if (defenseTimer > defense)
    {
      defenseTimer = 0;
      atkIcons.add(new AttackIcon(new PVector(random(SIZE / 2, width - (SIZE / 2)), random(SIZE / 2, height - (SIZE / 2))), defenseStay, DAMAGE, false));
      if (atkIcons.size() > 1)
      {
        AttackIcon a = atkIcons.get(atkIcons.size() - 1);
        AttackIcon a2 = atkIcons.get(atkIcons.size() - 2);
        while (a.loc.dist (a2.loc) < MIN_ICON_SPREAD)
        {
          atkIcons.remove(a);
          atkIcons.add(new AttackIcon(new PVector(random(SIZE / 2, width - (SIZE / 2)), random(SIZE / 2, height - (SIZE / 2))), defenseStay, DAMAGE, false));
          a = atkIcons.get(atkIcons.size() - 1);
          a2 = atkIcons.get(atkIcons.size() - 2);
        }
      }
    }
    offenseTimer ++;
    if (offenseTimer > offense && offense != -1)
    {
      offenseTimer = 0;
      atkIcons.add(new AttackIcon(new PVector(random(SIZE / 2, width - (SIZE / 2)), random(SIZE / 2, height - (SIZE / 2))), defenseStay, DAMAGE, true));
      if (atkIcons.size() > 1)
      {
        AttackIcon a = atkIcons.get(atkIcons.size() - 1);
        AttackIcon a2 = atkIcons.get(atkIcons.size() - 2);
        while (a.loc.dist (a2.loc) < MIN_ICON_SPREAD)
        {
          atkIcons.remove(a);
          atkIcons.add(new AttackIcon(new PVector(random(SIZE / 2, width - (SIZE / 2)), random(SIZE / 2, height - (SIZE / 2))), defenseStay, DAMAGE, true));
          a = atkIcons.get(atkIcons.size() - 1);
          a2 = atkIcons.get(atkIcons.size() - 2);
        }
      }
    }
    if (mouseJustPressed && atkIcons.size() > 0 && !keys[4])
    {
      int collisionTests = atkIcons.size();
      for (int i = 0; i < atkIcons.size(); i ++)
      {
        AttackIcon a = atkIcons.get(i);
        //mouseLoc = PVector.mult(new PVector(mouseX * CAMERA_ZOOM, mouseY * CAMERA_ZOOM), 1);
        //println(a.loc.dist(new PVector(mouseX, mouseY)));
        if (a.loc.dist(new PVector(mouseX, mouseY)) <= a.size / 2 && !keys[4])
        {
          a.active = false;
          atkIcons.remove(a);
          if (!a.bad && !keys[4])
          {
            hp -= p.damage;
            break;
          }
          else if (!keys[4])
          {
            p.hp -= DAMAGE;
            break;
          }
        }
        else if (!keys[4])
          collisionTests --;
      }
      if (collisionTests == 0 && !keys[4])
      {
        p.hp -= DAMAGE;
        println("MISS");
      }
      mouseJustPressed = false;
    }
    rectMode(CORNERS);
    //fill(0);
    //rect(0, height - 25, width, height);
    float playerHPFraction = float(p.hp) / p.maxHP;
    float enemyHPFraction = float(hp) / maxHP;
    //println(hpFraction);
    //println("HP: " + p.hp);
    //println("MAX HP: " + p.maxHP);
    stroke(127);
    fill(255, 0, 0);
    rect(0, height * .025, width * enemyHPFraction, 0);
    fill(0, 255, 0);
    rect(0, height - (height * .025), width * playerHPFraction, height);
  }
}

class Item
{
  PVector loc;
  String[] item;
  String name;
  int cost, playerHealthAdd, playerDamageAdd, hands;
  boolean passive, consume, visibleInCombat, effectApplied, applyEffectOnce;
  float SIZE;
  //int remainingTime, USE_TIMER_DEADLINE;

  Item(String[] item)
  {
    this.item = item;
    name = item[1];
    consume = boolean(item[3]);
    passive = boolean(item[5]);
    cost = int(item[7]);
    playerHealthAdd = int(item[9]);
    visibleInCombat = boolean(item[13]);
    playerDamageAdd = int(item[15]);
    hands = int(item[17]);
    applyEffectOnce = boolean(item[21]);
    SIZE = width * .05;
    effectApplied = false;
    loc = new PVector();
    //this.USE_TIMER_DEADL;INE = USE_TIMER_DEADLINE;
    //remainingTime = USE_TIMER_DEADLINE;
  }

  void show()
  {
    int itemNum = 0;
    for (int index = 0; index < inventory.size(); index ++)
    {
      Item i = inventory.get(index);
      if (i == this)
        itemNum = index;
    }
    if (!passive)
    {
      fill(255);
      if (battle)
      {
        loc = new PVector((itemNum * SIZE) + (SIZE / 2), height - (height * .15));
        ellipse((itemNum * SIZE) + (SIZE / 2), height - (height * .15), SIZE, SIZE);
      }
      else
      {
        loc = new PVector(p.loc.x - (width / 2) + ((itemNum * SIZE) + (SIZE / 2)), p.loc.y + (height / 2) - (height * .15));
        ellipse(p.loc.x - (width / 2) + ((itemNum * SIZE) + (SIZE / 2)), p.loc.y + (height / 2) - (height * .15), SIZE, SIZE);
      }
    }
  }

  void run()
  {
    int itemNum = 0;
    for (int index = 0; index < inventory.size(); index ++)
    {
      Item i = inventory.get(index);
      if (i == this)
        itemNum = index;
    }
    if (battle)
      loc = new PVector((itemNum * SIZE) + (SIZE / 2), height - (height * .15));
    else
      loc = new PVector(p.loc.x - (width / 2) + ((itemNum * SIZE) + (SIZE / 2)), p.loc.y + (height / 2) - (height * .15));
    if ((effectApplied && applyEffectOnce) || (p.hands > 2 && hands > 0) || (battle && !visibleInCombat))
      return;
    effectApplied = true;
    p.hands += hands;
    p.hp += playerHealthAdd;
    p.damage += playerDamageAdd;
    if (consume)
      inventory.remove(this);
  }
}

class Player
{
  PVector loc;
  float SIZE, SIGHT_RADIUS;
  int speed, moveTimer, hp, damage, maxHP, hands, gold;

  Player(PVector loc, int speed, int damage, int maxHP)
  {
    this.loc = loc;
    SIZE = width * 0.025;
    this.speed = speed;
    this.damage = damage;
    this.maxHP = maxHP;
    hp = maxHP;
    hands = 0;
    gold = 1000;
    SIGHT_RADIUS = width * .5;
  }

  void show()
  {
    stroke(0);
    fill(255);
    ellipse(loc.x, loc.y, SIZE, SIZE);
    noStroke();
    fill(255, 75);
    ellipse(loc.x, loc.y, SIGHT_RADIUS, SIGHT_RADIUS);
  }

  void run()
  {
    moveTimer ++;
    if (moveTimer > speed)
    {
      moveTimer = 0;
      if (keys[0] && map[int(loc.y / SPACE_SIZE - 1)].charAt(int(loc.x / SPACE_SIZE))!= 'x')
      {
        loc.y -= SPACE_SIZE;
        //keys2[0] = false;
      }
      else if (keys[1] && map[int(loc.y / SPACE_SIZE)].charAt(int(loc.x / SPACE_SIZE + 1))!= 'x')
      {
        loc.x += SPACE_SIZE;
        //keys2[1] = false;
      }
      else if (keys[2] && map[int(loc.y / SPACE_SIZE + 1)].charAt(int(loc.x / SPACE_SIZE))!= 'x')
      {
        loc.y += SPACE_SIZE;
        //keys2[2] = false;
      }
      else if (keys[3] && map[int(loc.y / SPACE_SIZE)].charAt(int(loc.x / SPACE_SIZE - 1))!= 'x')
      {
        loc.x -= SPACE_SIZE;
        //keys2[3] = false;
      }
    }
    if (hp > maxHP)
      hp = maxHP;
  }
}

class Space
{
  PVector loc;
  boolean explored;
  color c;

  Space(PVector loc, color c)
  {
    explored = false;
    this.loc = loc;
    this.c = c;
  }

  void show()
  {
    rectMode(CORNER);
    fill(c);
    stroke(0);
    rect(loc.x, loc.y, SPACE_SIZE, SPACE_SIZE);
  }

  void run()
  {
    if (loc.dist(p.loc) <= p.SIGHT_RADIUS / 2)
      explored = true;
  }
}


