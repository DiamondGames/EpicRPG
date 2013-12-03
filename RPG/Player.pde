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

