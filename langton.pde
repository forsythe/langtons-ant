boolean[][] cells; //the actual cell, and the holding cell
int cellSize = 60; //size of each square in pixels

int delay = 100; //frames between each tick
int lastRecordedTime = 0;

int numSquaresPerRow, numSquaresPerColumn;

color taken = color(255, 255, 255);
color empty = color(0);


void setup() {
  size(600, 300);
  numSquaresPerRow = height/cellSize;
  numSquaresPerColumn = width/cellSize;
  cells = new boolean[numSquaresPerRow][numSquaresPerColumn];

  //stroke(255, 255, 255);

  for (int r = 0; r < numSquaresPerRow; r++) {
    for (int c = 0; c < numSquaresPerColumn; c++) {
      cells[r][c] = false;
    }
  }
}

void draw() { //gets called over and over 
  for (int r = 0; r < numSquaresPerRow; r++) {
    for (int c = 0; c < numSquaresPerColumn; c++) {
      fill(cells[r][c]? taken : empty);
      stroke(cells[r][c]? taken : empty);
      rect(c*cellSize, r*cellSize, cellSize, cellSize);
    }
  }

  if (millis()-lastRecordedTime>delay) { //delays between iterations so that one can see the individual generations
    iteration();
    lastRecordedTime = millis();
  }
}

void mouseClicked() {
  int mouseRow = int(map(mouseY, 0, height, 0, numSquaresPerRow));
  int mouseCol = int(map(mouseX, 0, width, 0, numSquaresPerColumn)); 
  if (mouseButton == LEFT) {
    cells[mouseRow][mouseCol] = !cells[mouseRow][mouseCol];
  } else if (mouseButton == RIGHT) {
  }
}

void iteration() {
  print(mouseY, mouseX, "\n");

  int mouseRow = int(map(mouseY, 0, height, 0, numSquaresPerRow));
  int mouseCol = int(map(mouseX, 0, width, 0, numSquaresPerColumn));

  print("--", mouseRow, mouseCol, "\n");
}

void keyPressed() {
  if (key=='r' || key == 'R') { //basically copied the code from the draw
    for (int r=0; r<numSquaresPerRow; r++) {
      for (int c=0; c<numSquaresPerColumn; c++) {
        cells[r][c] = false; // Save state of each cell
      }
    }
  }
}