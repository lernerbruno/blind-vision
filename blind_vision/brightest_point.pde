void brightest_point() {
 PVector loc = opencv.max();
  
  stroke(255, 0, 0);
  strokeWeight(4);
  noFill();
  ellipse(loc.x, loc.y, 10, 10); 
}
