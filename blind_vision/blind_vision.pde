import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;
import processing.sound.*;

// Oscillator and envelope 
TriOsc triOsc;
Env env; 

// Times and levels for the ASR envelope
float attackTime = 0.001;
float sustainTime = 0.004;
float sustainLevel = 0.2;
float releaseTime = 0.2;

// Set the duration between the notes
float duration = 200;
int[] midiSequence = { 
  60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72
}; 
int note_repeat = 60;

// Set the note trigger
float trigger = 0; 

// An index to count up the notes
int note = 0; 

Kinect kinect;
PImage img;

float minThreshold = 420;
float maxThreshold = 750;

void settings() {
  size(640, 480);
}

void setup() {
  //kinect initialization
  kinect = new Kinect(this); 
  kinect.initDepth();
  kinect.initVideo();
  img = createImage(kinect.width, kinect.height, RGB);
    
  // Create triangle wave and envelope 
  triOsc = new TriOsc(this);
  env  = new Env(this);
}

void draw() {
  background(0); 
  img.loadPixels();
  
  int[] depth = kinect.getRawDepth();
  PImage color_image = kinect.getVideoImage();
  int closeRecord = 4500;
  int rX = 0;
  int rY = 0;
  
  for ( int x = 0; x < kinect.width; x++ ) {
    for ( int y = 0; y < kinect.height; y++ ) {
      int offset = x + y*kinect.width;
      int d = depth[offset];
      
      if(d > minThreshold && d < maxThreshold && x> 50 && y > 50) {
        float green = map(d, minThreshold, maxThreshold, 0, 255); 
        img.pixels[offset] = color(40,255 - green,200);
        
        if ( d < closeRecord ) {
         closeRecord = d; 
         rX = x;
         rY = y;
        }
         // If value of trigger is equal to the computer clock and if not all 
        // notes have been played yet, the next note gets triggered.
        if ((millis() > trigger) ) {
          float amplitude = map(d, minThreshold, maxThreshold, 0, 1);
          duration = map(d, minThreshold, maxThreshold, 50, 200);
          //float sustainTime = map(d, minThreshold, maxThreshold, 0.004, 0.01);
          
          // midiToFreq transforms the MIDI value into a frequency in Hz which we use 
          //to control the triangle oscillator with an amplitute of 0.8
          triOsc.play(midiToFreq(note_repeat), amplitude);
      
          // The envelope gets triggered with the oscillator as input and the times and 
          // levels we defined earlier
          env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);
      
          // Create the new trigger according to predefined durations and speed
          trigger = millis() + duration;
        }
        
      } else {
        img.pixels[offset] = color(0,0,0);
      }
    }
  }
  
  img.updatePixels();
  image(img, 0, 0);
  image(color_image, 0, 0);
  
  fill(150, 0, 255);
  //ellipse(avgX, avgY, 64, 64);
  fill(255);
  ellipse(rX, rY, 32, 32);
  
  
  //fill(255);
  //textSize(32);
  //text(minThreshold + " " + maxThreshold, 10, 64);
}

// This function calculates the respective frequency of a MIDI note
float midiToFreq(int note) {
  return (pow(2, ((note-69)/12.0)))*440;
}
