class Faces
{
  ArrayList<Face> newFacesArr;
  ArrayList<Face> oldFacesArr;
  Faces(Rectangle[] faces, int[] depth, Faces oldFaces)
  {
    oldFacesArr = new ArrayList<Face>();
    newFacesArr = new ArrayList<Face>();

    for (int i = 0; i < faces.length; i++) {
      int middlePoint_x = faces[i].x + faces[i].width/2;  
      int middlePoint_y = faces[i].y + faces[i].height/2;  
      int offset = middlePoint_x + middlePoint_y * kinect.width;
      int d = depth[offset];
      int position = middlePoint_x - kinect.width/2;

      ellipse(middlePoint_x, middlePoint_y, 10, 10);
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
      Face detected_face = new Face(d, position, faces[i].x, faces[i].y, faces[i].width, faces[i].height);
      addFace(oldFaces, detected_face);
      String s = "Distance: " + d;
      textSize(10);
      text(s, 10, 10, 70, 80);
      fill(255, 255, 255);
    }
  }
  void addFace(Faces oldFaces, Face face)
  {
    if (oldFaces == null) 
    {
      newFacesArr.add(face);
      return;
    }
    boolean add = true;
    for (int i = 0; i < oldFaces.oldFacesArr.size(); i++)
    {
      if (!oldFaces.oldFacesArr.get(i).isInside(face.center_x(), face.center_y())) 
      {
        if (add) oldFacesArr.add(face);
        add = false;
      }
    }
    for (int i = 0; i < oldFaces.newFacesArr.size(); i++)
    {
      if (!oldFaces.newFacesArr.get(i).isInside(face.center_x(), face.center_y())) 
      {
        if (add) oldFacesArr.add(face);
        add = false;
      }
    }
    if (add) newFacesArr.add(face);
}
}
