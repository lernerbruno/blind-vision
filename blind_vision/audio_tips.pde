import processing.net.*;

Server myServer;
int val = 0;
int audio_counter = 0;
int FREQUENCY = 40;
String message = "";
int destination_counter = 0;
int DESTINATION_FREQUENCY = 50;
int server_count = 0;
int SERVER_FREQUENCY = 50;

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
   
   
   Tuple final_destination_coordinates = new Tuple(data.final_destination.x, data.final_destination.y);
   float final_destination_pos = data.final_destination.final_destination_pos;
   int final_destination_d = data.final_destination.distance;
   
    if (destination_counter % DESTINATION_FREQUENCY == 2) {
       message = "The destination is " + str(final_destination_d/10) + " centimeters from you. ";
          
       thread("speak");
     }
     destination_counter ++;
     
     if (server_count % SERVER_FREQUENCY == 5) {
         ServerData server_data = new ServerData(faces_position, final_destination_coordinates);
         String server_message = "[";
         int faces_pos_size = faces_position.size();
         int i = 0;
         for (Tuple t : faces_position) {
             server_message += "(" + t.x + "," + t.y + ")";
             if (i == faces_pos_size - 1) {
               server_message += "]";
             } else {
               server_message += ",";
             }
             i++;
         }
         print(server_message);
         myServer.write(server_message);
     }
     server_count ++;
}

void speak() {
   tts.speak(message);
}
