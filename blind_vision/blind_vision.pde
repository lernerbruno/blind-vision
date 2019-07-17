import gab.opencv.*;
import java.awt.Rectangle;
import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;
import processing.sound.*;
import guru.ttslib.*;
 
TTS tts;

// Oscillator and envelope 
TriOsc triOsc;
Env env; 
float attackTime = 0.001;
float sustainTime = 0.004;
float sustainLevel = 0.2;
float releaseTime = 0.2;
float duration = 200;
int distance_note = 60;
float trigger = 0; 

OpenCV opencv;
Rectangle[] faces;
Kinect kinect;
PImage img;
ArrayList<Face> detected_faces;
int threshold = 25;
color track_color = color(0, 0, 0);

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
  
  tts = new TTS();
}

//void detect_traffic_light(PImage img) {
//  detect_color()
  
//}



void detect_color(PImage img, color track_color) {
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
       
       float color_distance = dist(r1, g1, b1, r2, g2, b2);
       
       if (color_distance < threshold) {
        avgX += x;
        avgY += y;
        count ++;
       }
     }
  }
  
  if (count > 0) {
     avgX = avgX / count;
     avgY  = avgY / count;
     fill(0, 0, 0);
     strokeWeight(4.0);
     stroke(0);
     ellipse(avgX, avgY, 16, 16);
  }
}

void draw() {
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  
  PImage img = kinect.getVideoImage();
  int[] depth = kinect.getRawDepth();
  opencv = new OpenCV(this, img);   
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  
  faces = opencv.detect();
  image(img, 0, 0);

  detected_faces = deal_with_faces(faces, depth);
  detect_color(img, track_color);
  beep_distance(depth);
  Data data = new Data(detected_faces);
  //text_to_speech(data);
  
  
  
  line(kinect.width/2, kinect.height, kinect.width/2, 0);
}

// This function calculates the respective frequency of a MIDI note
float midiToFreq(int note) {
  return (pow(2, ((note-69)/12.0)))*440;
}
