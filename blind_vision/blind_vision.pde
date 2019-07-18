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
  beep_distance(depth);
  Final final_destination = detect_color(img, track_color, depth);
  
  
  Data data = new Data(detected_faces, final_destination);
  text_to_speech(data);
  
  line(kinect.width/2, kinect.height, kinect.width/2, 0);
}
