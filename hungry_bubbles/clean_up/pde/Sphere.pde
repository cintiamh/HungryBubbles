/**
 * Summary: This class renders the sphere image and do all the calculations associated to a sphere.
 * author: Cintia Higashi
 */
class Sphere {	
	float radius;
	float mass;
	float angle;
	float speed;
	
	int scolor, salpha;
	
	PVector location;
	PVector velocity;
	PVector vscale;
	
	/* Class constructor asks for the sphere's initial position (x, y) and its initial radius */
	Sphere (float x, float y, float r) {
		this.location = new PVector(x, y);
		this.radius = r;
		this.velocity = new PVector(0, 0);
		this.vscale = new PVector();
	}
	
	// calculates the mass according to the given radius
	float calculateMass(float r) {
		return roundFloat(round((4/3) * PI * pow(r, 3)), 2);
	}
	
	void calculateMass() {
		this.mass = calculateMass(this.radius);
	}
	
	// calculates a sphere's radius according to the given mass
	float calculateRadius(float m) {
		return roundFloat(pow(((m * 3) / (4 * PI)), 1/3), 2);
	}
	
	void calculateRadius() {
		this.radius = calculateRadius(this.mass);
	}
	
	// calculates the distance from this sphere to another point in the screen
	float calculateDistance(PVector location1) {
		return sqrt(pow((location1.x - this.location.x), 2) + pow((location1.y - this.location.y), 2));  
	}
	
	// calculates the scales for x and y vectors given a vector (used for further calculations)
	void calculateScales(PVector location2) {
		this.angle = atan2(location2.y - this.location.y, location2.x - this.location.x);
		this.vscale.x = roundFloat(cos(this.angle), 2);
		this.vscale.y = roundFloat(sin(this.angle), 2);
	}
	
	// sets the partial vector velocity and calculates the final speed.
	void setVelocity(float x, float y) {
		this.velocity.x = x;
		this.velocity.y = y;
		this.speed = roundFloat(sqrt(pow(x, 2) + pow(y, 2)), 2);
	}
	
	void setColor(int scolor, int salpha) {
		this.scolor = scolor
		this.salpha = salpha;
	}
	
	// Everytime two spheres collide, the bigger sphere absorbs the small one.
	// This function checks if two spheres collided and how much was absorbed 
	// and sets the new masses and radius for the two spheres.
	void absorbSphere(Sphere anotherSphere, float distance, float minDist) {
		this.calculateMass();
		anotherSphere.calculateMass();
		
		float smallOldMass = anotherSphere.mass;
		anotherSphere.radius = ((anotherSphere.radius * 2) - (minDist - distance)) / 2;
		anotherSphere.calculateMass();
		this.mass += (smallOldMass - anotherSphere.mass);
		this.calculateRadius();
	}
	
	// Checks if the sphere reached the border limits. If so, it bounces back, just
	// like a ball.
	void bounceOnWalls() {
		if (location.x > width - radius) {
			location.x = width - radius;
			setVelocity(velocity.x * -1 * DRAG, velocity.y);
		}
		else if (location.x < radius) {
			location.x = radius;
			setVelocity(velocity.x * -1 * DRAG, velocity.y);
		}
		
		if (location.y > height - radius) {
			location.y = height - radius;
			setVelocity(velocity.x, velocity.y * -1 * DRAG);
		}
		else if (location.y < radius) {
			location.y = radius;
			setVelocity(velocity.x, velocity.y * -1 * DRAG);
		}
		location.add(velocity);
	}
	
	// Update function called every frame to redraw the sphere.
	void update() {
		bounceOnWalls();
		
		fill(scolor, salpha);
		
		noStroke();
		ellipse(location.x, location.y, radius * 2, radius * 2);
	}
}