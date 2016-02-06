class Colors {

	int B_MASK = 255;
	int G_MASK = 255<<8;
	int R_MASK = 255<<16;

	float contrast_red, contrast_green, contrast_blue;
	float brightness_red, brightness_green, brightness_blue;
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
	}

	float contrastCalculation(int color_value, float contrast_rand) {
		return color_value * contrast_rand;
	}

	float brightnessCalculator(int color_value, float brightness_rand) {
		return color_value + brightness_rand;
	}
}