// constants
float DRAG = 0.999;
float ACCELERATION = 0.3;
float MAX_SPEED = 5;
float PARTICLE_PROP = 0.0005;
float PARTICLE_SPEED = 5;

int mainColor, smallColor, bigColor, generalAlpha;
int level;
float totalVol;
PVector mousePos;

Sphere mainSphere;
ArrayList spheres;
ArrayList allSpheres;

void setup() {
	size(1024, 768);
	smooth();
	frameRate(40);
	mousePos = new PVector();
	
	// Setting sphere types colors.
	mainColor = #94C5F4;
	smallColor = #93F29D;
	bigColor = #FA989B;
	generalAlpha = 200;
	
	spheres = new ArrayList();
	allSpheres = new ArrayList();
	
	setLevel(1);
	
	if (level == 1) {
		buildLevel1();
	}
	else if (level == 2) {
		buildLevel2();
		
	}
	else if (level == 3) {
	}
	
	calculateTotalVol();
	//for (int i = 0; i < 4; i++) {
		//addNewSphere(new Sphere(random(30 + i, width - 30 -i), random(30 + i, height - 30 - i), 30 + i *10));
	//}
}

void buildLevel1() {
	mainSphere = new Sphere(width/2, height/2, 60);
	mainSphere.setColor(mainColor, generalAlpha);
	allSpheres.add(mainSphere);
		
	addNewSphere(new Sphere(width/4, height/4, 49));
	addNewSphere(new Sphere(width/4, height - height/4, 48));
	addNewSphere(new Sphere(width - width/4, height/4, 70));
}

void buildLevel2() {
	mainSphere = new Sphere(width/2, height/2, 40);
	mainSphere.setColor(mainColor, generalAlpha);
	allSpheres.add(mainSphere);
		
	// big spheres
	addNewSphere(new Sphere(100, 90, 65));
	addNewSphere(new Sphere(360, 300, 50));
	addNewSphere(new Sphere(490, 100, 55));
	addNewSphere(new Sphere(650, 250, 60));
	addNewSphere(new Sphere(120, 500, 70));
	addNewSphere(new Sphere(350, 650, 55));
	addNewSphere(new Sphere(900, 550, 60));
	addNewSphere(new Sphere(850, 100, 90));
	addNewSphere(new Sphere(600, 550, 80));
		
	// small spheres
	addNewSphere(new Sphere(75, 705, 20));
	addNewSphere(new Sphere(75, 250, 25));
	addNewSphere(new Sphere(60, 350, 20));
	addNewSphere(new Sphere(225, 720, 15));
	addNewSphere(new Sphere(205, 625, 20));
	addNewSphere(new Sphere(280, 70, 25));
	addNewSphere(new Sphere(350, 60, 15));
	addNewSphere(new Sphere(230, 130, 20));
	addNewSphere(new Sphere(950, 415, 25));
	addNewSphere(new Sphere(160, 300, 20));
	addNewSphere(new Sphere(900, 300, 20));
	addNewSphere(new Sphere(775, 633, 20));
	addNewSphere(new Sphere(955, 730, 25));
	addNewSphere(new Sphere(725, 710, 15));
}

void addNewSphere(Sphere newSphere) {
	spheres.add(newSphere);
	allSpheres.add(newSphere);
}

void calculateTotalVol() {
	for (int i = 0; i < allSpheres.size(); i++) {
		Sphere sphere1 = (Sphere) allSpheres.get(i);
		sphere1.calculateMass();
		totalVol += sphere1.mass;
	}
}

void draw() {
	background(50);
	checkCollisions();
	
	mainSphere.update();
	
	for (int i = 0; i < spheres.size(); i++) {
		Sphere s = (Sphere) spheres.get(i);
		if (s.radius < mainSphere.radius) {
			s.setColor(smallColor, generalAlpha);
		} else {
			s.setColor(bigColor, generalAlpha);
		}
		s.update();
	}
	
	checkGameOver();
}

void mouseClicked() {
	mousePos.x = mouseX;
	mousePos.y = mouseY;
	
	//println(mousePos.x + ", " + mousePos.y);
	
	if (mainSphere.radius > 0) {
		mainSphere.calculateScales(mousePos);
		
		// Set speed and direction
		if (mainSphere.speed + ACCELERATION < MAX_SPEED) {
			mainSphere.setVelocity(mainSphere.velocity.x + (-mainSphere.vscale.x * ACCELERATION), 
									mainSphere.velocity.y + (-mainSphere.vscale.y * ACCELERATION)); 
		}
		else {
			mainSphere.setVelocity(MAX_SPEED * (-mainSphere.vscale.x), 
									MAX_SPEED * (-mainSphere.vscale.y));
		} 
		
		// Spill small fragments in order to move (impulse)
		mainSphere.calculateMass();
		float oldMass = mainSphere.mass;
		float partMass = oldMass * PARTICLE_PROP;
		mainSphere.mass = oldMass - partMass;
		mainSphere.calculateRadius();
		
		float partRadius = mainSphere.calculateRadius(partMass);
		float partX = mainSphere.vscale.x * (mainSphere.radius + partRadius);
		float partY = mainSphere.vscale.y * (mainSphere.radius + partRadius);
		
		// Instantiating the particle.
		Sphere particle = new Sphere(mainSphere.location.x + partX, mainSphere.location.y + partY, partRadius);
		particle.setVelocity(mainSphere.vscale.x * PARTICLE_SPEED, mainSphere.vscale.y * PARTICLE_SPEED);
		//spheres.add(particle);
		addNewSphere(particle); 
	}
}

void setLevel(int i) {
	level = i;
}

float roundFloat(float num, int digits) {
	float newNum = num;
	newNum *= pow(10, digits);
	round(newNum);
	newNum /= pow(10, digits);
	return newNum;
}

void checkCollisions() {
	for (int i = 0; i < allSpheres.size(); i++) {
		Sphere sphere1 = (Sphere) allSpheres.get(i);
		if (sphere1.radius <= 0) {
			allSpheres.remove(i);
		}
		else {
			for (int j = i; j < allSpheres.size(); j++) {
				Sphere sphere2 = (Sphere) allSpheres.get(j);
				if (sphere2.radius <= 0) {
					allSpheres.remove(j);
				}
				else {
					float distance = sphere1.calculateDistance(sphere2.location);
					float minDist = sphere1.radius + sphere2.radius;
					
					if (distance < minDist) {
						if (sphere1.radius > sphere2.radius) {
							sphere1.absorbSphere(sphere2, distance, minDist);
						} else {
							sphere2.absorbSphere(sphere1, distance, minDist);
						}
					}
				}
			}
		}
	}
}

void checkGameOver() {
	if (mainSphere.radius <= 0) {
		fill(#ffffff);
		textFont("Arial", 70);
		text("Game Over", 350, height/2);
	}
	mainSphere.calculateMass();
	if (mainSphere.mass >= totalVol*0.9) {
		fill(#ffffff);
		textFont("Arial", 70);
		text("You Win", 350, height/2);
	}
}

class Sphere {	
	float radius;
	float mass;
	float angle;
	float speed;
	
	int scolor, salpha;
	
	PVector location;
	PVector velocity;
	PVector vscale;
	
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
	
	void calculateScales(PVector location2) {
		this.angle = atan2(location2.y - this.location.y, location2.x - this.location.x);
		this.vscale.x = roundFloat(cos(this.angle), 2);
		this.vscale.y = roundFloat(sin(this.angle), 2);
	}
	
	void setVelocity(float x, float y) {
		this.velocity.x = x;
		this.velocity.y = y;
		this.speed = roundFloat(sqrt(pow(x, 2) + pow(y, 2)), 2);
	}
	
	void setColor(int scolor, int salpha) {
		this.scolor = scolor
		this.salpha = salpha;
	}
	
	void absorbSphere(Sphere anotherSphere, float distance, float minDist) {
		this.calculateMass();
		anotherSphere.calculateMass();
		
		float smallOldMass = anotherSphere.mass;
		anotherSphere.radius = ((anotherSphere.radius * 2) - (minDist - distance)) / 2;
		anotherSphere.calculateMass();
		this.mass += (smallOldMass - anotherSphere.mass);
		this.calculateRadius();
	}
	
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
	
	void update() {
		bounceOnWalls();
		
		fill(scolor, salpha);
		
		noStroke();
		ellipse(location.x, location.y, radius * 2, radius * 2);
	}
}