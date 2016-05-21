//OPTIONS
int delay = 0; //frames between each tick
boolean randDir = true; //should ants have random direction?

boolean[][] cells; //the actual cell, and the holding cell
int cellSize = 5; //size of each square in pixels
int numSquaresPerRow, numSquaresPerColumn;

int step = 0;

int lastRecordedTime = 0;
boolean pause = false;

color taken = color(255, 255, 255);
color empty = color(0);
color antColor = color(255, 0, 0);

ArrayList<Ant> ants = new ArrayList<Ant>();
//known "bugs" huehuheueuh: clicking on the same spot multiple times while paused will stack ants

PFont f;   

void setup() {
  size(1500, 800);

  f = createFont("Arial", 30, true);
  textFont(f);
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
    text("Paused", 15, 30);
    text("Step: " + step, 15, 60);
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

  step++;
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

    step = 0;
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
  for (int r=0; r<numSquaresPerRow; r++) {
    for (int c=0; c<numSquaresPerColumn; c++) {
      fill(cells[r][c]? taken : empty);
      rect(c*cellSize, r*cellSize, cellSize, cellSize);
    }
  }
}

void clearGrid() {
  for (int r=0; r<numSquaresPerRow; r++) 
    for (int c=0; c<numSquaresPerColumn; c++) 
      cells[r][c] = false;
}