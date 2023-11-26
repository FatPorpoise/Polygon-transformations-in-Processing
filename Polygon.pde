//Polygon class

class Polygon{
  PolygonSerializable polygonData;

  Polygon(){
    polygonData = new PolygonSerializable();
  }
  
  Polygon(PolygonSerializable _p){
    polygonData = _p;
  }
  
  void addPoint(float x, float y){
    polygonData.points.add(new PVector(x,y));
  }
  
  void display(){
    if(polygonData.points!=null && polygonData.points.size()>0){
      beginShape();
      for (PVector p : polygonData.points){
        vertex(p.x, p.y);
      }
      vertex(polygonData.points.get(0).x, polygonData.points.get(0).y);
      endShape();
    }
  }

  boolean isPointInsidePolygon(float x, float y) {
    int count = 0;
    int n = polygonData.points.size();
    
    for (int i = 0; i < n; i++) {
      
      if (rayIntersectsSegment(x, y, polygonData.points.get(i), polygonData.points.get((i+1)%n))) {
        count++;
      }
    }
    return count % 2 != 0; // Odd number of intersections means the point is inside
  }
  
  boolean rayIntersectsSegment(float x, float y, PVector p1, PVector p2) {
    if ((p1.y > y && p2.y > y) || (p1.y < y && p2.y < y) || (p1.x < x && p2.x < x)) {
      return false;
    }
    if(p1.x <= x && p2.x <= x){
      return true;
    }
    if((p2.x - p1.x)==0){
      if(x <= p1.x) return true;
      return false;
    }
    float m = (p2.y - p1.y) / (p2.x - p1.x);
    float b = p1.y - m * p1.x;
    float _x = (y - b)/m;
    if(x<_x){
      return true;
    }
    return false;
  }
  
    void translate(float x, float y){
    for (PVector p : polygonData.points){
      p.x+=x;
      p.y+=y;
    }
  }
  void rotate(float angle, float centerX, float centerY){
    float angleRad = radians(angle);
    PMatrix rotMatrix = new PMatrix2D();
    rotMatrix.translate(centerX, centerY);
    rotMatrix.rotate(angleRad);
    rotMatrix.translate(-centerX, -centerY);
    PVector tempVector = new PVector();
    for (PVector p : polygonData.points){
      rotMatrix.mult(p,tempVector);
      p.set(tempVector);
    }
  }
  void scale(float factor, float centerX, float centerY){
    PMatrix scaleMatrix = new PMatrix2D();
    scaleMatrix.translate(centerX, centerY);
    scaleMatrix.scale(factor);
    scaleMatrix.translate(-centerX, -centerY);
    PVector tempVector = new PVector();
    for (PVector p : polygonData.points){
      scaleMatrix.mult(p,tempVector);
      p.set(tempVector);
    }
  }
}
