void beep_distance(int[] depth) {
  int close_record = 4500;
  int rX = 0;
  int rY = 0;
  
  int maxThreshold = 1000;
  int minThreshold = 350;
  
  for ( int x = 0; x < kinect.width; x++ ) {
    for ( int y = 0; y < kinect.height; y++ ) {
      int offset = x + y*kinect.width;
      int d = depth[offset];
      
      if ( d < close_record ) {
         close_record = d; 
         rX = x;
         rY = y;
      }
        
      if (close_record < maxThreshold) {
        // If value of trigger is equal to the computer clock and if not all 
        // notes have been played yet, the next note gets triggered.
        if ((millis() > trigger) ) {
          float amplitude = map(d, maxThreshold, minThreshold, 0, 1);
          duration = map(d, minThreshold, maxThreshold, 100, 200);
         
          triOsc.play(midiToFreq(distance_note), amplitude);
          env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);
      
          trigger = millis() + duration;
        }   
      }
    }
  }
  
  fill(255, 0, 0);
  strokeWeight(4.0);
  stroke(0);
  ellipse(rX, rY, 16, 16);
}
