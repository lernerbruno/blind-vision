class Face {
   int distance;
   int position;
   int x;
   int y;
   int w;
   int h;
   
   Face(int dist, int pos, int x_, int y_ , int width_, int height_) {
       x = x_;
       y = y_;
       w = width_;
       h = height_;
       distance = dist;
       position = pos;
   }
   
   int center_x()
   {
      return x + w /2; 
   }
   int center_y()
   {
      return y + h / 2; 
   }
   
   boolean isInside(int x_c, int y_c)
   {
     return (x <= x_c && x_c >= x + w && y <= y_c && y_c >= y + h);
   }
}
