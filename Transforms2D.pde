//Main

ArrayList<Polygon> allPolygons = new ArrayList<Polygon>();
Polygon currentPolygon, focusedPolygon;
String mode = "select";
int currentVertex = 0, maxVerticies = 0;

void setup() {
  size(1200, 800);
  surface.setLocation(displayWidth/2 - width/2, displayHeight/2 - height/2);
  gui();
  noFill();
}

void draw() {
  background(210);
  if(currentPolygon!=null){
    currentPolygon.display();
  }
  for (Polygon polygon : allPolygons){
    if(polygon!=null)
    polygon.display();
  }
}
