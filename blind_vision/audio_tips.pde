import http.requests.*;

int val = 0;
int audio_counter = 0;
int FREQUENCY = 40;
String message = "";
int destination_counter = 0;
int DESTINATION_FREQUENCY = 50;
int server_count = 0;
int SERVER_FREQUENCY = 10;

void text_to_speech(Data data) {
   message = "";
   ArrayList<Face> faces = data.faces;
   ArrayList<Tuple> faces_position = new ArrayList<Tuple>();
   if (faces != null && faces.size() != 0) {
     message = faces.size() > 1 ? "Watch out! There are " + faces.size() + " people. " : "Watch out! There is 1 person. ";  
     
     int closest = 2000;
     String closest_position = "";
     for (Face face : faces) {
        int distance = face.distance;
        String position = face.position > 0 ? "right" : "left";
        faces_position.add(new Tuple(face.x, face.y)); 
        
        if (distance < closest) {
          closest = distance;
          closest_position = position; 
        }
      }
      
     if (closest == 2000) {
      return;  //<>// //<>//
     }
     String person = faces.size() > 1 ?  "The closest one" : "It";
     message += person + " is " + str(closest/10) + " centimeters from you, to your " + closest_position;
     
     textSize(20);
     fill(255, 255, 255);
     text(message, 100, 100, 270, 280);

     if (audio_counter % FREQUENCY == 2) {
       thread("speak");
     }
     audio_counter ++;
   }
   
   float final_destination_pos = data.final_destination.final_destination_pos;
   int final_destination_d = data.final_destination.distance;
   
    if (destination_counter % DESTINATION_FREQUENCY == 2) {
      if (final_destination_d < 700) {
        message = "You go to your destination";
        return;
      }
      if (final_destination_pos < 100 && final_destination_pos > -100)
        message = "The destination is " + str(final_destination_d/10) + " centimeters in front of you. Go straight";   
      else if(final_destination_pos < 0)  message = "The destination is in " + str(final_destination_d/10) + " centimeters. Go to your left. ";
      else  message = "The destination is " + str(final_destination_d/10) + " centimeters. Go to your right.";
       thread("speak");
     }
     destination_counter ++;
     if (server_count % SERVER_FREQUENCY == 0) {
         int faces_pos_size = faces_position.size();
         String server_message_faces = "";
         if (faces_pos_size != 0){
           server_message_faces = "[";
           
           int i = 0;
           for (Tuple t : faces_position) {
               server_message_faces += "(" + t.x + "," + t.y + ")";
               if (i == faces_pos_size - 1) {
                 server_message_faces += "]";
               } else {
                 server_message_faces += ",";
               }
               i++;
           }  
         }
         
         String server_message_final = "(" + data.final_destination.x + "," + data.final_destination.y + "," + data.final_destination.distance + ")";
         String faces_qs = faces_pos_size > 0 ? "&faces=" + server_message_faces : "";
         GetRequest get = new GetRequest("http://192.168.1.83:5000/kinect?final_destination=" + server_message_final + faces_qs);
         get.send();
         println("Reponse Content: " + get.getContent());
     }  
     server_count ++;
}

void speak() {
   tts.speak(message);
}
