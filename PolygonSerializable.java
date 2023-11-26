//Polygon class code outside of pApplet, for serialization purpose

import java.io.Serializable;
import processing.core.PVector;
import java.util.ArrayList;
class PolygonSerializable implements Serializable {
  ArrayList<PVector> points;
  PolygonSerializable(){
    points = new ArrayList<PVector>();
  }
}
