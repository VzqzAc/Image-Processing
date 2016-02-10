class Colors {

	int B_MASK = 255;
	int G_MASK = 255<<8;
	int R_MASK = 255<<16;
	//int threshold = 127;

	float contrast_red, contrast_green, contrast_blue;
	float brightness_red, brightness_green, brightness_blue;
	float inversion_red, inversion_green, inversion_blue;
	float grayscale_red, grayscale_green, grayscale_blue;
	int threshold_red, threshold_green, threshold_blue;
	int rgb_threshold;
	int red, green, blue;

	public Colors (int info, float contrast_rand, float brightness_rand) {
		//int r, g, b;
		red = (info & R_MASK)>>16;
		green = (info & G_MASK)>>8;
		blue = info & B_MASK;

		contrast_red = contrastCalculation(red, contrast_rand);
		contrast_green = contrastCalculation(green, contrast_rand);
		contrast_blue = contrastCalculation(blue, contrast_rand);

		brightness_red = brightnessCalculator(red, brightness_rand);
		brightness_green = brightnessCalculator(green, brightness_rand);
		brightness_blue = brightnessCalculator(blue, brightness_rand);

		//threshold_red = threshold_green = threshold_blue = thresholdCalculator(red, green, blue);

		grayscale_red = grayscale_green = grayscale_blue = grayscaleCalculator(red, green, blue);
	}

	public static float contrastCalculation(int color_value, float contrast_rand) {
		return color_value * contrast_rand;
	}

	public static float brightnessCalculator(int color_value, float brightness_rand) {
		return color_value + brightness_rand;
	}

	public void inversionCalculator(int max_pixel) {
		int max_red = (max_pixel & R_MASK)>>16;
		int max_green = (max_pixel & G_MASK)>>8;
		int max_blue = max_pixel & B_MASK;

		//int inversion_red = (color_value & R_MASK)>>16;
		//int inversion_green = (color_value & G_MASK)>>8;
		//int inversion_blue = color_value & B_MASK;

		inversion_red = max_red - red;
		inversion_green = max_green - green;
		inversion_blue = max_blue - blue; 
	}

	public void thresholdCalculator(int max_threshold, int min_threshold, int threshold) {
		int count = 0;
		if(this.red < threshold) count++;
		if(this.green < threshold) count++;
		if(this.blue < threshold) count++;

		if(count >= 2) this.threshold_red = this.threshold_green = this.threshold_blue = max_threshold;
		else this.threshold_red = this.threshold_green = this.threshold_blue = min_threshold;
	}

	public static float grayscaleCalculator(int red, int green, int blue) {
		return (float)((0.2126 * red) + (.7152 * green) + (0.0722 * blue));
	}
}