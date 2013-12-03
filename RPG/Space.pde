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

