//Input/Output

void outputFileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    
  } else {
    println("User selected " + selection.getAbsolutePath());
    try {
      ObjectOutputStream outputStream = new ObjectOutputStream(new FileOutputStream(selection.getAbsolutePath()));
      for (Polygon polygon : allPolygons) {
        outputStream.writeObject(polygon.polygonData);
      }
      outputStream.close();
      println("Objects serialized and saved to " + selection.getName());
    } catch (IOException e) {
      println("Serialization failed. " + e.getMessage());
      JOptionPane.showMessageDialog(null, "Error serializing: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
    }
  }
}

void inputFileSelected(File selection) {
  if (selection == null) {
    println("No file selected for deserialization.");
  } else {
    try {
      ObjectInputStream inputStream = new ObjectInputStream(new FileInputStream(selection.getAbsolutePath()));
      ArrayList<PolygonSerializable> deserializedPolygons = new ArrayList<>();

      while (true) {
        try {
          PolygonSerializable deserializedPolygon = (PolygonSerializable) inputStream.readObject();
          deserializedPolygons.add(deserializedPolygon);
        } catch (EOFException e) {
          break; // End of file reached
        }
      }
      inputStream.close();

      if (deserializedPolygons.isEmpty()) {
        println("No objects found in the selected file.");
      } else {
        println("Objects deserialized from " + selection.getName());
        allPolygons = new ArrayList<Polygon>();
        for(PolygonSerializable polygonSerializable : deserializedPolygons){
          allPolygons.add(new Polygon(polygonSerializable));
        }
        focusedPolygon = allPolygons.get(0);
      }
    } catch (InvalidClassException e) {
      println("The selected file does not contain valid serialized objects of the expected class. " + e.getMessage());
      JOptionPane.showMessageDialog(null, "Deserialization failed. " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
      
    }
    catch (IOException e) {
      println("Deserialization failed. " + e.getMessage());
      JOptionPane.showMessageDialog(null, "Deserialization failed. " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
      
    }
    catch (ClassNotFoundException e) {
      println("Class not found. " + e.getMessage());
      JOptionPane.showMessageDialog(null,"Class not found. " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
      
    }
  }
}
