ArrayList<Face> deal_with_faces(Rectangle[] faces, int[] depth) {
   detected_faces = new ArrayList<Face>();

  for (int i = 0; i < faces.length; i++) {
    int middlePoint_x = faces[i].x + faces[i].width/2;  
    int middlePoint_y = faces[i].y + faces[i].height/2;  
    int offset = middlePoint_x + middlePoint_y * kinect.width;
    int d = depth[offset];
    int position = middlePoint_x - kinect.width/2;

    ellipse(middlePoint_x, middlePoint_y, 10, 10);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    Face detected_face = new Face(d, position);
    detected_faces.add(detected_face);
 
    String s = "Distance: " + d;
    textSize(10);
    text(s, 10, 10, 70, 80);
    fill(255, 255, 255);
  }

  return detected_faces;
}
