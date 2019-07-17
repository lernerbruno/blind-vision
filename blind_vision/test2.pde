//import gab.opencv.*;
//import org.openkinect.freenect.*;
//import org.openkinect.freenect2.*;
//import org.openkinect.processing.*;
//import org.openkinect.tests.*;
//import processing.sound.*;

//Kinect kinect;
//OpenCV opencv;
//PImage img;

//void settings() {
//  size(640, 480);
//}


//void setup() {
//  opencv = new OpenCV(this, 720, 480);
  
//  opencv.startBackgroundSubtraction(5, 3, 0.5);
    
//  //kinect initialization
//  kinect = new Kinect(this); 
//  kinect.initDepth();
//  kinect.initVideo();
//  img = createImage(kinect.width, kinect.height, RGB);  
//}

//void draw() {  
//  PImage color_image = kinect.getVideoImage();

//  opencv.loadImage(color_image);
  
//  opencv.updateBackground();
  
//  opencv.dilate();
//  opencv.erode();

//  noFill();
//  stroke(255, 0, 0);
//  strokeWeight(3);
//  for (Contour contour : opencv.findContours()) {
//    contour.draw();
//  }
//}

////void movieEvent(PImage m) {
////  m.read();
//}
