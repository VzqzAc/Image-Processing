PImage img;
boolean floppy = true;
int r,g,b;
int[] pix;

void setup() {
	size(100, 100, P2D);
	img = loadImage("image_example.JPG");
	doResize();
	surface.setResizable(true);
}

void draw() {
	if(floppy) {
		image(img, 0, 0);
		floppy = !floppy;
	}
}

void doResize() {
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