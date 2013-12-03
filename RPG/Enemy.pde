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

