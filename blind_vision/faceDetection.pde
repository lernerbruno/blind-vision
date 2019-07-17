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
int leftMid;
int midRight;
ArrayList<Face> detected_faces;

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

ArrayList<Face> deal_with_faces(Rectangle[] faces, int[] depth) {
   detected_faces = new ArrayList<Face>();

  for (int i = 0; i < faces.length; i++) {
    int middlePoint_x = faces[i].x + faces[i].width/2;  
    int middlePoint_y = faces[i].y + faces[i].height/2;  
    int offset = middlePoint_x + middlePoint_y*kinect.width;
    int d = depth[offset];
    int angle = middlePoint_x - kinect.width/2;

    ellipse(middlePoint_x, middlePoint_y, 10, 10);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    Face detected_face = new Face(d, angle);
    detected_faces.add(detected_face);
 
    String s = "Distance: " + d;
    textSize(10);
    text(s, 10, 10, 70, 80);
    fill(255, 255, 255);
  }
  return detected_faces;
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
  detected_faces = deal_with_faces(faces, depth);
  
  // Draw regions
  line(kinect.width/2, kinect.height, kinect.width/2, 0);
}
