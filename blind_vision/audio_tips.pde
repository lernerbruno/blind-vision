
void text_to_speech(Data data) {
   String message = "";
   
   ArrayList<Face> faces = data.faces;
   if (faces != null) {
     if (faces.size() != 0) {
       message = faces.size() > 1 ? "There are " + faces.size() + " people. " : "There is 1 person. ";  
     }
        
     for (Face face : faces) {
        int distance = face.distance;
        String position = face.position > 0 ? "right" : "left";
        
        message += "One person is " + str(distance/1000) + "meters from you, to your " + position; 
      }
     
     textSize(10);
     
     tts.speak(message);
     text(message, 100, 100, 270, 280); //<>//
     fill(255, 255, 255);
   }
    //<>// //<>//
}
