ControlP5 cp5;
Button newButton;
Textfield pointNumField;
void gui(){
  PFont font = createFont("Arial",10,true);
  cp5 = new ControlP5(this);
  newButton = cp5.addButton("new_polygon")
   .setPosition(10,10)
   .setSize(200,50)
   .setFont(font)
   ;
  pointNumField = cp5.addTextfield("number_of_points")
   .setPosition(10,10)
   .setSize(200,50)
   .setFont(font)
   .hide()
   ;
}
