int B_MASK = 255;
int G_MASK = 255<<8;
int R_MASK = 255<<16;

//String 

class Colors {
	float contrast_red, contrast_green, contrast_blue;
	float brightness_red, brightness_green, brightness_blue;
	int red, green, blue;

	public Colors (int info) {
		//int r, g, b;
		red = (info & R_MASK)>>16;
		green = (info & G_MASK)>>8;
		blue = info & B_MASK;

		contrast_red = contrastCalculation(red);
		contrast_green = contrastCalculation(green);
		contrast_blue = contrastCalculation(blue);

		brightness_red = brightnessCalculator(red);
		brightness_green = brightnessCalculator(green);
		brightness_blue = brightnessCalculator(blue);
	}

	float contrastCalculation(int color_value) {
		return color_value * contrast_rand;
	}

	float brightnessCalculator(int color_value) {
		return color_value + brightness_rand;
	}
}

Colors[] colors;
PImage img;
boolean floppy = true;
float contrast_rand, brightness_rand;
int r,g,b;
int[] pix;

void setup() {
	size(100, 100, P2D);
	img = loadImage("image_example.JPG");
	colors = new Colors[img.width*img.height];
	contrast_rand = random(1.1, 2);
	brightness_rand = random(1, 100);
	println(contrast_rand + "    " + brightness_rand);
	doResize();
	image(img, 0, 0);
	surface.setResizable(true);
	//println(R_MASK + "    " + G_MASK + "    " + B_MASK);
}

void draw() {
	image(img, 0, 0);
	change_contrast_or_brightness("contrast");
	img = loadImage("image_example.JPG");
	image(img, 0, 0);
	change_contrast_or_brightness("brightness");
	exit();
}

void doResize() {
	surface.setSize(img.width, img.height);
}

void change_contrast_or_brightness(String method) {
	img.loadPixels();
	for (int i = 0; i < img.pixels.length; i++) colors[i] = new Colors(img.pixels[i]);
	if(method.equals("contrast")) {
		println("contrast");
		for (int i = 0; i < img.pixels.length; i++) 
			img.pixels[i] = color(colors[i].contrast_red, colors[i].contrast_green, colors[i].contrast_blue);
	}
	else if(method.equals("brightness")) {
		println("brightness");
		for (int i = 0; i < img.pixels.length; i++) 
			img.pixels[i] = color(colors[i].brightness_red, colors[i].brightness_green, colors[i].brightness_blue);
	}
	img.updatePixels();
	save("data/" + method + ".jpg");
}
