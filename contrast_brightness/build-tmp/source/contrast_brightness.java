import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class contrast_brightness extends PApplet {

PImage img;
boolean floppy = true;
int r,g,b;
int[] pix;

public void setup() {
	
	img = loadImage("image_example.JPG");
	doResize();
	surface.setResizable(true);
}

public void draw() {
	if(floppy) {
		image(img, 0, 0);
		floppy = !floppy;
	}
}

public void doResize() {
	surface.setSize(img.width, img.height);
	img.loadPixels();
	pix = img.pixels;
	//println(pix);
	for (int i = 0; i < pix.length; i++) {
		//print(pix[i]);
		//r = int(random(pix[i]%255)*(pix[i]%255));
		pix[i] = color((int)(random(pix[i]%255)*(pix[i]%255)));
		//println("        " + pix[i]);
	}
	save("data/contrast.jpg");
	updatePixels();
}
  public void settings() { 	size(100, 100, P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "contrast_brightness" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
