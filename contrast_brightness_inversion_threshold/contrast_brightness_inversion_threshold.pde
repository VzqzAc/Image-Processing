Colors[] colors;
PImage img;
//boolean floppy = true;
float contrast_rand, brightness_rand;
int r,g,b;
int threshold, max_threshold, min_threshold;
int[] pix;

void setup() {
	size(100, 100, P2D);
	img = loadImage("image_example.JPG");
	colors = new Colors[img.width*img.height];
	pix = new int[img.width * img.height];
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
	img = loadImage("image_example.JPG");
	image(img, 0, 0);
	change_contrast_or_brightness("inversion");
	img = loadImage("image_example.JPG");
	image(img, 0, 0);
	change_contrast_or_brightness("threshold");
	img = loadImage("image_example.JPG");
	image(img, 0, 0);
	change_contrast_or_brightness("grayscale");
	exit();
}

void doResize() {
	surface.setSize(img.width, img.height);
}

void change_contrast_or_brightness(String method) {
	img.loadPixels();
	for (int i = 0; i < img.pixels.length; i++) {
		colors[i] = new Colors(img.pixels[i], contrast_rand, brightness_rand);
		//pix[i] = img.pixels[i];
	}
	if(method.equals("contrast")) {
		//max_pixel = max(pix);
		println("contrast");
		for (int i = 0; i < img.pixels.length; i++) 
			img.pixels[i] = color(colors[i].contrast_red, colors[i].contrast_green, colors[i].contrast_blue);
	}
	else if(method.equals("brightness")) {
		println("brightness");
		println("brightness_rand: "+brightness_rand);
		for (int i = 0; i < img.pixels.length; i++) 
			img.pixels[i] = color(colors[i].brightness_red, colors[i].brightness_green, colors[i].brightness_blue);
	}
	else if(method.equals("inversion")) {
		println("inversion");
		for (int i = 0; i < img.pixels.length; i++) {
			colors[i].inversionCalculator(16777215);
			img.pixels[i] = color(colors[i].inversion_red, colors[i].inversion_green, colors[i].inversion_blue);
		}
	}
	else if (method.equals("threshold")) {
		println("threshold");
		min_threshold = (int)random(0, 255);
		println("min_threshold: "+min_threshold);
		do
			max_threshold = (int)random(0, 255);
		while(max_threshold <= min_threshold);
		println("max_threshold: "+max_threshold);
		do 
			threshold = (int)random(0,255);
		while(threshold <= min_threshold || threshold >= max_threshold);
		println("threshold: "+threshold);
		for (int i = 0; i < img.pixels.length; i++) {
			colors[i].thresholdCalculator(min_threshold, max_threshold, threshold);
			img.pixels[i] = color(colors[i].threshold_red, colors[i].threshold_green, colors[i].threshold_blue);
		}
	}
	else if (method.equals("grayscale")) {
		println("gray_scale");
		for (int i = 0; i < img.pixels.length; i++) 
			img.pixels[i] = color(colors[i].grayscale_red, colors[i].grayscale_green, colors[i].grayscale_blue);
	}
	img.updatePixels();
	save("data/" + method + ".jpg");
}
