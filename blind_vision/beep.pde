void beep_distance(int[] depth) {
  int avgX = 0;
  int avgY = 0;
  int avgZ = 0;
  int points_count = 0;
  int alert_treshold = 800;
  
  for ( int x = 0; x < kinect.width; x++ ) {
    for ( int y = 0; y < kinect.height; y++ ) {
      int offset = x + y*kinect.width;
      int d = depth[offset];
      
      if ( d < alert_treshold ) {
         avgX += x;
         avgY += y;
         avgZ += d;
         points_count ++;
      }
    }
  }
    
  if ( points_count > 0 ) {
    avgX = avgX / points_count;
    avgY  = avgY / points_count;
    avgZ  = avgZ / points_count;
    
    fill(255, 100, 0);
    strokeWeight(4.0);
    stroke(0);
    ellipse(avgX, avgY, 16, 16);
    String s = "Average Distance for close points: " + avgZ;
    textSize(10);
    text(s, 400, 0, 800, 400);
    fill(255, 255, 255);
  }
  
   // If value of trigger is equal to the computer clock 
    if ((millis() > trigger && points_count > 0 ) ) {
      if (avgZ < 500) {
        duration = 0;  
      }
      
      if (avgZ >= 500 && avgZ < 700) {
        duration = 500;  
      }
      
      if (avgZ >= 700 && avgZ < 740) {
        duration = 1000;  
      }
      
      if (avgZ >= 740) {
        duration = 2000;  
      }
     
      triOsc.play(midiToFreq(distance_note), .8);
      env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);
  
      trigger = millis() + duration;
    }  
}

// This function calculates the respective frequency of a MIDI note
float midiToFreq(int note) {
  return (pow(2, ((note-69)/12.0)))*440;
}
