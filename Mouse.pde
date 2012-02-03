class Mouse{
 
 PVector pos;
 PVector vel;
  
  Rectangle mouserect;
  
  Mouse(){
    
   pos = new PVector(mouseX, mouseY);
   vel = new PVector(mouseX - pmouseX, mouseY - pmouseY);
    mouserect = new Rectangle(mouseX, mouseY, 10, 10);
    
    
  }
  
  boolean hits(Rectangle target){
   
   return (mouserect.intersects(target)); 
   
  }
  
  void display(){
   
   
    
  }
  
  
  
}
