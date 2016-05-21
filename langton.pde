//OPTIONS
int delay = 0; //frames between each tick
boolean randDir = true; //should ants have random direction?

boolean[][] cells; //the actual cell, and the holding cell
int cellSize = 3; //size of each square in pixels
int numSquaresPerRow, numSquaresPerColumn;

int steps = 0;

int lastRecordedTime = 0;
boolean pause = true;

color taken = color(255, 255, 255);
color empty = color(0);
color antColor = color(255, 0, 0);

ArrayList<Ant> ants = new ArrayList<Ant>();
//known "bugs" huehuheueuh: clicking on the same spot multiple times while paused will stack ants

PFont f, fsmall;

void setup() {
  size(1800, 900);

  f = createFont("Arial", 30, true);
  fsmall = createFont("Arial", 20, true);
  textAlign(TOP);            

  numSquaresPerRow = height/cellSize;
  numSquaresPerColumn = width/cellSize;
  cells = new boolean[numSquaresPerRow][numSquaresPerColumn];

  fill(empty);
  stroke(empty);
  rect(0, 0, width, height);

  clearGrid();
}

void draw() { 
  if (!pause) {
    if (millis()-lastRecordedTime>delay) { //delays between iterations so that one can see the individual generations
      iteration();
      lastRecordedTime = millis();
    }
  } else {
    redrawGrid();

    for (Ant a : ants) {
      drawAnt(a);
    }

    fill(taken);
    textFont(f);
    text("Paused", 15, 30);
    text("Step: " + steps, 15, 60);

    textFont(fsmall);
    text("Reset [R]", 15, 120);
    text("Pause/unpause [SPACE]", 15, 140);
    text("Spawn ant [Mouse]", 15, 160);
  }
}

void mouseClicked() {
  int mouseRow = int(map(mouseY, 0, height, 0, numSquaresPerRow));
  int mouseCol = int(map(mouseX, 0, width, 0, numSquaresPerColumn)); 

  ants.add(new Ant(mouseRow, mouseCol, randDir? int(random(4))*90 : 0, numSquaresPerRow, numSquaresPerColumn));
  drawAnt(ants.get(ants.size()-1));
}

void iteration() {
  if (ants.size() == 0)
    return;

  for (Ant a : ants) {
    //color the cell from which the ant has left
    cells[a.r][a.c] = !cells[a.r][a.c];
    fill(cells[a.r][a.c]? taken : empty);
    rect(a.c*cellSize, a.r*cellSize, cellSize, cellSize);

    a.move(cells[a.r][a.c]);
    drawAnt(a);
  }

  steps++;
}

void drawAnt(Ant a) {
  fill(antColor);
  rect(a.c*cellSize, a.r*cellSize, cellSize, cellSize);
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    clearGrid();
    ants.clear();

    fill(empty);
    stroke(empty);
    rect(0, 0, width, height);

    steps = 0;
  }

  if (key == ' ') {
    pause = !pause;

    if (!pause) {     //redraw to erase "paused" text
      redrawGrid();
      for (Ant a : ants) {
        drawAnt(a);
      }
    }
  }
}

void redrawGrid() {
  fill(empty);
  rect(0, 0, width, height);
  fill(taken);
  for (int r=0; r<numSquaresPerRow; r++) {
    for (int c=0; c<numSquaresPerColumn; c++) {
      if (cells[r][c])
        rect(c*cellSize, r*cellSize, cellSize, cellSize);
    }
  }
}

void clearGrid() {
  for (int r=0; r<numSquaresPerRow; r++) 
    for (int c=0; c<numSquaresPerColumn; c++) 
      cells[r][c] = false;
}