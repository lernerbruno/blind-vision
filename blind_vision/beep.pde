void beep_distance(int[] depth) {
  int close_record = 4500;
  int avgX = 0;
  int avgY = 0;
  int points_count = 0;
  
  int maxThreshold = 1000;
  int minThreshold = 350;
  
  for ( int x = 0; x < kinect.width; x++ ) {
    for ( int y = 0; y < kinect.height; y++ ) {
      int offset = x + y*kinect.width;
      int d = depth[offset];
      
      if ( d < close_record ) {
         close_record = d; 
         avgX += x;
         avgY += y;
         points_count ++;
      }
    }
  }
    
  if (points_count > 0) {
    avgX = avgX / points_count;
    avgY  = avgY / points_count;
    fill(255, 100, 0);
    strokeWeight(4.0);
    stroke(0);
    ellipse(avgX, avgY, 16, 16);
      
    // If value of trigger is equal to the computer clock and if not all 
    // notes have been played yet, the next note gets triggered.
    if ((millis() > trigger) ) {
      //float amplitude = map(close_record, maxThreshold, minThreshold, 0, 1);
      duration = map(close_record, minThreshold, maxThreshold, 100, 200);
     
      triOsc.play(midiToFreq(distance_note), .8);
      env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);
  
      trigger = millis() + duration;
    }   
 
  }
}

// This function calculates the respective frequency of a MIDI note
float midiToFreq(int note) {
  return (pow(2, ((note-69)/12.0)))*440;
}
