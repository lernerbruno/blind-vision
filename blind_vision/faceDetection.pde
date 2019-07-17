import gab.opencv.*;
import java.awt.Rectangle;
import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

OpenCV opencv;
Rectangle[] faces;
Kinect kinect;
PImage img;

void settings() {
  size(640, 480);
}

void setup() {  
  //kinect initialization
  kinect = new Kinect(this); 
  kinect.initDepth();
  kinect.initVideo();
  img = createImage(kinect.width, kinect.height, RGB);
 
}

void draw() {
  PImage img = kinect.getVideoImage();
  int[] depth = kinect.getRawDepth();
  opencv = new OpenCV(this, img);   
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  
  faces = opencv.detect();
  image(img, 0, 0);

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
}
