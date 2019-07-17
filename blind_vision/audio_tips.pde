int audio_counter = 0;
int FREQUENCY = 20;
void text_to_speech(Data data) {
   String message = "";
   
   ArrayList<Face> faces = data.faces;
   if (faces != null && faces.size() != 0) {
     message = faces.size() > 1 ? "There are " + faces.size() + " people. " : "There is 1 person. ";  
     
     int closest = 2000;
     String closest_position = "";
     for (Face face : faces) {
        int distance = face.distance;
        String position = face.position > 0 ? "right" : "left";
        
        if (distance < closest) {
          closest = distance;
          closest_position = position; 
        }
      }
      
     String person = faces.size() > 1 ?  "The closest one" : "It";
     message += person + " is " + str(closest/10) + " centimeters from you, to your " + closest_position;
     
     textSize(20);
     fill(255, 255, 255);
     text(message, 100, 100, 270, 280);
     
     if (audio_counter % FREQUENCY == 2) {
       tts.speak(message);
     }
     audio_counter ++;
   }
} //<>// //<>//
