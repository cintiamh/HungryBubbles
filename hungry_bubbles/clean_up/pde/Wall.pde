class Wall {
	float w_width;
	float w_height;
	float xmin, xmax, ymin, ymax;
	
	PVector location;
	
	Wall(float x, float y, float w, float h) {
		this.location = new PVector(x, y);
		this.w_width = w;
		this.w_height = h;
		xmin = x;
		xmax = x + w;
		ymin = y;
		ymax = y + h;
	} 
	
	void update() {
		fill(#ffffff);
		noStroke();
		rect(location.x, location.y, w_width, w_height);
	}
}