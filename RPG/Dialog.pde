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
    if (!battle)
      rect(0, p.loc.y + (height / 2) - (height * .425), width * 2, p.loc.y + (height / 2));
    else
      rect(0, height - (height * .425), width * 2, height);
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
      {
        if (!battle)
          text(lines[i], p.loc.x - (width / 2), p.loc.y + (height / 2) - (height * .375) + (fontSize * i) - (fontSize / 2));
        else
          text(lines[i], 0, height - (height * .375) + (fontSize * i) - (fontSize / 2));
      }
    }
  }

  void run()
  {
    if (skipDialog)
    {
      skipDialog = false;
      currentPart ++;
      if (currentPart > strings.length - 1)
      {
        active = false;
        dialogs.remove(this);
      }
    }
  }
}

