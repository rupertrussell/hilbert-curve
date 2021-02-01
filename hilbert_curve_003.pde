/*
  // thomas diewald
 // https://www.openprocessing.org/sketch/386016
 // hilbert curve - quick and short example
 // 16.11.2010
 
 // Fork by Rupert Russell
 // last updated: 20210202
 
 */

int levels = 6; // recursion depth
int count = 0; // save counter
void setup() {
  size(10600, 10600);
  // noLoop();
}

void draw() {
  // levels = mouseX/95;
  println(levels);

  // noStroke(); fill(255, 10); 
  // rect(0,0, width, height);

  Vector c[] = hilbert( new Vector(width/2, height/2, 0), width/2, levels, 0, 1, 2, 3); // hilbert(center, side-length, recursion depth, start-indices)

  // strokeWeight(width/95-levels); 
  stroke(map(mouseX, 0, width, 0, 255), map(mouseY, 0, height, 0, 100), map(mouseX, 0, mouseY, 0, 100));

  strokeWeight(7 - levels);

  for (int i = 0; i < c.length-1; i++)
    line(c[i].x, c[i].y, c[i+1].x, c[i+1].y);
}

Vector[] hilbert( Vector c_, float side, int iterations, int index_a, int index_b, int index_c, int index_d ) { 
  Vector c[] = new Vector[4];
  c[index_a] = new Vector(  c_.x - side/2, c_.y - side/2, 0  );
  c[index_b] = new Vector(  c_.x + side/2, c_.y - side/2, 0  );
  c[index_c] = new Vector(  c_.x + side/2, c_.y + side/2, 0  );
  c[index_d] = new Vector(  c_.x - side/2, c_.y + side/2, 0  );

  if ( --iterations >= 0) {
    Vector tmp[] = new Vector[0];
    tmp = (Vector[]) concat(tmp, hilbert ( c[0], side/2, iterations, index_a, index_d, index_c, index_b  ));
    tmp = (Vector[]) concat(tmp, hilbert ( c[1], side/2, iterations, index_a, index_b, index_c, index_d  ));
    tmp = (Vector[]) concat(tmp, hilbert ( c[2], side/2, iterations, index_a, index_b, index_c, index_d  ));
    tmp = (Vector[]) concat(tmp, hilbert ( c[3], side/2, iterations, index_c, index_b, index_a, index_d  ));
    return tmp;
  }
  return c;
}

class Vector {
  float x, y, z;
  Vector( float x, float y, float  z) {
    this.x = x; 
    this.y = y; 
    this.z = z;
  }
}

void keyPressed() {
  switch(key) {
  case '0':
    count++;
    save("hilbert_"+ count + ".png");
    break;  
  case '1': 
    levels = 1;
    break;
  case '2': 
    levels = 2;
    break;
  case '3': 
    levels = 3;
    break;
  case '4': 
    levels = 4;
    break;
  case '5': 
    levels = 5;
    break;
  case '6': 
    levels = 6;
    break;
  default:             // Default executes if the case labels
    println("None");   // don't match the switch parameter
    break;
  }
}
