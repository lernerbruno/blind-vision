color track_color = color(25, 45, 85);
color second_track_color = color(40,70,110);
int threshold = 30;

Final detect_color(PImage img, color track_color, int[] depth) {
  float avgX = 0;
  float avgY = 0;
  int count = 0;
  
  for (int x = 0; x < img.width; x++ ) {
     for (int y = 0; y < img.height; y++) {
       int loc = x + y * img.width;
       color current_color = img.pixels[loc];
       float r1 = red(current_color);
       float g1 = green(current_color);
       float b1 = blue(current_color);
       float r2 = red(track_color);
       float g2 = green(track_color);
       float b2 = blue(track_color);
       float r3 = red(second_track_color);
       float g3 = green(second_track_color);
       float b3 = blue(second_track_color);
       
       
       float color_distance = dist(r1, g1, b1, r2, g2, b2);
       float other_color_distance = dist(r1, g1, b1, r3, g3, b3);
       
       if (color_distance < threshold || other_color_distance < threshold) {
        avgX += x;
        avgY += y;
        count ++;
       }
     }
  }
  
  if (count > 0) {
     avgX = avgX / count;
     avgY  = avgY / count;
     fill(0, 255, 0);
     strokeWeight(4.0);
     stroke(0);
     ellipse(avgX, avgY, 16, 16);
  }
  
  int offset = int(avgX + avgY * kinect.width);
  int d = depth[offset];
     
  Final final_dest = new Final(avgX - img.width/2, d, avgX, avgY);
  return final_dest;
}
