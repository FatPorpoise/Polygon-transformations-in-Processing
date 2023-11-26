 //Mouse events
PVector clickPosition = new PVector(0,0), previousP1 = new PVector(0,0), previousP2 = new PVector(0,0);

void mousePressed()
{
  if(mode=="add" && currentVertex<maxVerticies){
    currentPolygon.addPoint(mouseX,mouseY);
    if(++currentVertex == maxVerticies){
      allPolygons.add(currentPolygon);
      mode = "select";
      newButton.show();
    }
  }
  else if(mode =="select"){
    focusedPolygon = null;
    for(Polygon poly : allPolygons){
      if(poly.isPointInsidePolygon(mouseX,mouseY)){
        focusedPolygon = poly;
        break;
      }
    }
  }
}

void mouseDragged() 
{
  if(mode =="select" && focusedPolygon !=null){
    focusedPolygon.translate(mouseX-pmouseX, mouseY-pmouseY);
  }
}

void mouseWheel(MouseEvent event) {
  if(mode =="select" && focusedPolygon !=null){
    if(mouseButton == LEFT )
      focusedPolygon.rotate(event.getCount()*10,mouseX,mouseY);
    else if(mouseButton == RIGHT){
      if(event.getCount()==1)
        focusedPolygon.scale(1.25,mouseX,mouseY);
      else
        focusedPolygon.scale(0.8,mouseX,mouseY);
    }
  }
}

//keyboard
void keyPressed() {
  noLoop();
  if (keyCode == 112) {
    selectOutput("Select a file to write to:", "outputFileSelected");
  }else  if (keyCode == 113) {
    selectInput("Select a file to read from:", "inputFileSelected");
  }
  loop();
}

//gui
void new_polygon(){
  newButton.hide();
  pointNumField.show();
  pointNumField.setFocus(true);
}

void number_of_points(String value){
  int pointNum = isPosInteger(value);
  if (pointNum>2){
    currentPolygon = new Polygon();
    maxVerticies = pointNum;
    currentVertex = 0;
    mode = "add";
  }else{
    newButton.show();
  }
  pointNumField.hide();
}

int isPosInteger(String s) {
  try {
    int parsed = Integer.parseInt(s);
    return parsed;
  } catch (NumberFormatException e) {
    return 0;
  }
}
