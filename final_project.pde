/**
* This program allows users to create a multi-colored mosaic by simply mousing over the grid! 
* 
* Citation - much of this code was addapted using source code from: 
* forum.processing.org/two/discussion/22122/how-to-check-whether-mouse-pointer-is-currently-on-the-line-drawn-inside-canvas-or-not
* 
* @author Irene Lunt
* @version 21 Dec. 2020
*/



// Variable declaration
ArrayList<PShape> tiles;
int TILE_SIZE = 30;
int GRID_L = 720; 
int GRID_W = 240;
Integer[] colors = {#A8C3DE, #EEE5FF, #0D082E, #023B27, #E8C9DA, #E8C9DA, #51897D, 
                      #AD576D, #B97034, #5A3823};


void setup() {
  size(720, 240);
  background(131, 110, 92); // a brown, representing wood
  stroke(131, 110, 92);
  strokeWeight(1.5); 
  
  tiles = createTiles();
}
 
void draw() {
  if (keyCode != UP) {
  // pressing the UP key will suspend interactivity
  // pressing any other key will resume 
  for (PShape s : tiles) {
    s.beginShape();
    if (mouseOver(s.getVertex(0), s.getVertex(2))) {
      // when the mouse position is somewhere within a given tile object
      int tile_color = colors[int(random(colors.length))]; 
      s.fill(tile_color); 
    } else {
      s.fill(500); 
    }
    s.endShape();
    shape(s, 0, 0);
    }
  }
}

ArrayList<PShape> createTiles() {
  ArrayList<PVector> points = new ArrayList<PVector>();
  float x = 0; 
  float y = 0; 
  int tiles_across = GRID_L / 30; 
  int tiles_down = GRID_W / 30; 
  
  // stores the top left vertex of each individual tile  as a PVector
  for (int i = 0; i < tiles_across; i++) {
    x = i * TILE_SIZE; 
    for (int j = 0; j < tiles_down; j++) {
      y = j * TILE_SIZE;
      points.add(new PVector(x, y));
    }
  }
  PShape s;
  ArrayList<PShape> tiles = new ArrayList<PShape>();
  for (int a = 0; a < points.size(); a++) {
    // creates all 19200 tiles that will fill the grid 
    s = createShape();
    s.beginShape();
    PVector p = points.get(a);
    // starting with the top left vertex, creates a 30x30 tile
    s.vertex(p.x, p.y);
    s.vertex(p.x + TILE_SIZE, p.y);
    s.vertex(p.x + TILE_SIZE, p.y + TILE_SIZE);
    s.vertex(p.x, p.y + TILE_SIZE); 
    s.endShape();
    tiles.add(s); // adds each individual tile the ArrayList of tile objects
  }
  return tiles;
}
 
boolean mouseOver(PVector a, PVector b) {
  // true if mouse is over a tile, false if not
  return checkDist(a.x, a.y, b.x, b.y, mouseX, mouseY);
}

// determines if one point is within the distance of two other points
boolean checkDist(float x1, float y1, float x2, float y2, float px, float py) {
  float d1 = dist(px, py, x1, y1);
  float d2 = dist(px, py, x2, y2);
  float diag = dist(x1, y1, x2, y2); // diagonal length across a tile
  if (d1 < diag && d2 < diag) {
    // means point must be somewhere within the tile since max. dist from either 
    // vertex would be diag
    return true;
  }
  return false;
}
