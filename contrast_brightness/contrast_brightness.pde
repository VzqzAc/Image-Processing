int B_MASK = 255;
int G_MASK = 255<<8;
int R_MASK = 255<<16;

class Colors {
	float new_red, new_green, new_blue;
	int red, green, blue;
	public Colors (int info) {
		info *= -1;
		int r, g, b;
		red = (info & R_MASK)>>16;
		green = (info & G_MASK)>>8;
		blue = info & B_MASK;

		new_red = (red);
		new_green = (green);
		new_blue = (blue);
	}

}

Colors[] colors;
PImage img;
boolean floppy = true;
int r,g,b;
int[] pix;

void setup() {
	size(100, 100, P2D);
	img = loadImage("image_example.JPG");
	colors = new Colors[img.width*img.height];
	doResize();
	surface.setResizable(true);
	//println(R_MASK + "    " + G_MASK + "    " + B_MASK);
}

void draw() {
	if(floppy) {
		image(img, 0, 0);
		floppy = !floppy;
		save("data/contrast.jpg");
	}
}

void doResize() {
	surface.setSize(img.width, img.height);
	img.loadPixels();
	for (int i = 0; i < img.pixels.length; i++) {
		colors[i] = new Colors(img.pixels[i]);
		img.pixels[i] = color(colors[i].new_red, colors[i].new_green, colors[i].new_blue);
		//pix[i] = color((int)(random(pix[i]%255)*(pix[i]%255)));
		//println(colors[i].new_red + "   " + colors[i].new_green + "   " + colors[i].new_blue);
	}
	updatePixels();
}
