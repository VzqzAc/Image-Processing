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

Colors[] colors;
PImage img;
//boolean floppy = true;
float contrast_rand, brightness_rand;
int r,g,b, max_pixel;
int[] pix;

public void setup() {
	
	img = loadImage("image_example.JPG");
	colors = new Colors[img.width*img.height];
	pix = new int[img.width * img.height];
	contrast_rand = random(1.1f, 2);
	brightness_rand = random(1, 100);
	println(contrast_rand + "    " + brightness_rand);
	doResize();
	image(img, 0, 0);
	surface.setResizable(true);
	//println(R_MASK + "    " + G_MASK + "    " + B_MASK);
}

public void draw() {
	image(img, 0, 0);
	change_contrast_or_brightness("contrast");
	img = loadImage("image_example.JPG");
	image(img, 0, 0);
	change_contrast_or_brightness("brightness");
	img = loadImage("image_example.JPG");
	image(img, 0, 0);
	change_contrast_or_brightness("inversion");
	exit();
}

public void doResize() {
	surface.setSize(img.width, img.height);
}

public void change_contrast_or_brightness(String method) {
	img.loadPixels();
	for (int i = 0; i < img.pixels.length; i++) {
		colors[i] = new Colors(img.pixels[i], contrast_rand, brightness_rand);
		pix[i] = img.pixels[i];
	}
	if(method.equals("contrast")) {
		max_pixel = max(pix);
		println("contrast");
		for (int i = 0; i < img.pixels.length; i++) 
			img.pixels[i] = color(colors[i].contrast_red, colors[i].contrast_green, colors[i].contrast_blue);
	}
	else if(method.equals("brightness")) {
		println("brightness");
		for (int i = 0; i < img.pixels.length; i++) 
			img.pixels[i] = color(colors[i].brightness_red, colors[i].brightness_green, colors[i].brightness_blue);
	}
	else if(method.equals("inversion")) {
		println("inversion");
		for (int i = 0; i < img.pixels.length; i++) {
			colors[i].inversionCalculator(max_pixel);
			img.pixels[i] = color(colors[i].inversion_red, colors[i].inversion_green, colors[i].inversion_blue);
		}
	}
	img.updatePixels();
	save("data/" + method + ".jpg");
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
