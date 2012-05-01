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
ArrayList walls;

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
	walls = new ArrayList();
	
	setLevel(3);
	
	if (level == 1) {
		buildLevel1();
	}
	else if (level == 2) {
		buildLevel2();
		
	}
	else if (level == 3) {
		buildLevel3();
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

void buildLevel3() {
	mainSphere = new Sphere(width/2, height - 50, 30);
	mainSphere.setColor(mainColor, generalAlpha);
	allSpheres.add(mainSphere);
	
	//big sphere in the center
	addNewSphere(new Sphere(width/2, height/2, 59));
	
	// medium spheres
	addNewSphere(new Sphere(192, 192, 35));
	addNewSphere(new Sphere(width - 192, 192, 35));
	addNewSphere(new Sphere(192, height - 192, 35));
	addNewSphere(new Sphere(width - 192, height - 192, 35));
	
	walls.add(new Wall(0, height/2 - 15, 256, 30));
	walls.add(new Wall(width - 256, height/2 - 15, 256, 30));
	walls.add(new Wall(128*3 - 15, 128, 30, 128));
	walls.add(new Wall(128*5 - 15, 128, 30, 128));
	walls.add(new Wall(128*3 - 15, 128*4, 30, 128));
	walls.add(new Wall(128*5 - 15, 128*4, 30, 128));
	
	// small spheres
	addNewSphere(new Sphere(64, 64, 6));
	addNewSphere(new Sphere(64, 64*2, 6));
	addNewSphere(new Sphere(64, 64*3, 6));
	addNewSphere(new Sphere(64, 64*4, 6));
	addNewSphere(new Sphere(64, 64*5, 6));
	addNewSphere(new Sphere(64, 64*7, 6));
	addNewSphere(new Sphere(64, 64*8, 6));
	addNewSphere(new Sphere(64, 64*9, 6));
	addNewSphere(new Sphere(64, 64*10, 6));
	addNewSphere(new Sphere(64, 64*11, 6));
	addNewSphere(new Sphere(64*2, 64, 6));
	addNewSphere(new Sphere(64*2, 64*5, 6));
	addNewSphere(new Sphere(64*2, 64*7, 6));
	addNewSphere(new Sphere(64*2, 64*11, 6));
	addNewSphere(new Sphere(64*3, 64, 6));
	addNewSphere(new Sphere(64*3, 64*5, 6));
	addNewSphere(new Sphere(64*3, 64*7, 6));
	addNewSphere(new Sphere(64*3, 64*11, 6));
	addNewSphere(new Sphere(64*4, 64, 6));
	addNewSphere(new Sphere(64*4, 64*5, 6));
	addNewSphere(new Sphere(64*4, 64*7, 6));
	addNewSphere(new Sphere(64*4, 64*11, 6));
	addNewSphere(new Sphere(64*5, 64, 6));
	addNewSphere(new Sphere(64*5, 64*2, 6));
	addNewSphere(new Sphere(64*5, 64*3, 6));
	addNewSphere(new Sphere(64*5, 64*4, 6));
	addNewSphere(new Sphere(64*5, 64*5, 6));
	addNewSphere(new Sphere(64*5, 64*6, 6));
	addNewSphere(new Sphere(64*5, 64*7, 6));
	addNewSphere(new Sphere(64*5, 64*8, 6));
	addNewSphere(new Sphere(64*5, 64*9, 6));
	addNewSphere(new Sphere(64*5, 64*10, 6));
	addNewSphere(new Sphere(64*5, 64*11, 6));
	addNewSphere(new Sphere(64*6, 64, 6));
	addNewSphere(new Sphere(64*6, 64*5, 6));
	addNewSphere(new Sphere(64*6, 64*6, 6));
	addNewSphere(new Sphere(64*6, 64*7, 6));
	addNewSphere(new Sphere(64*6, 64*11, 6));
	addNewSphere(new Sphere(64*7, 64, 6));
	addNewSphere(new Sphere(64*7, 64*2, 6));
	addNewSphere(new Sphere(64*7, 64*3, 6));
	addNewSphere(new Sphere(64*7, 64*4, 6));
	addNewSphere(new Sphere(64*7, 64*8, 6));
	addNewSphere(new Sphere(64*7, 64*9, 6));
	addNewSphere(new Sphere(64*7, 64*10, 6));
	addNewSphere(new Sphere(64*7, 64*11, 6));
	addNewSphere(new Sphere(64*8, 64, 6));
	addNewSphere(new Sphere(64*8, 64*2, 6));
	addNewSphere(new Sphere(64*8, 64*3, 6));
	addNewSphere(new Sphere(64*8, 64*4, 6));
	addNewSphere(new Sphere(64*8, 64*8, 6));
	addNewSphere(new Sphere(64*8, 64*9, 6));
	addNewSphere(new Sphere(64*8, 64*10, 6));
	addNewSphere(new Sphere(64*9, 64, 6));
	addNewSphere(new Sphere(64*9, 64*2, 6));
	addNewSphere(new Sphere(64*9, 64*3, 6));
	addNewSphere(new Sphere(64*9, 64*4, 6));
	addNewSphere(new Sphere(64*9, 64*8, 6));
	addNewSphere(new Sphere(64*9, 64*9, 6));
	addNewSphere(new Sphere(64*9, 64*10, 6));
	addNewSphere(new Sphere(64*9, 64*11, 6));
	addNewSphere(new Sphere(64*10, 64, 6));
	addNewSphere(new Sphere(64*10, 64*5, 6));
	addNewSphere(new Sphere(64*10, 64*6, 6));
	addNewSphere(new Sphere(64*10, 64*7, 6));
	addNewSphere(new Sphere(64*10, 64*11, 6));
	addNewSphere(new Sphere(64*11, 64, 6));
	addNewSphere(new Sphere(64*11, 64*2, 6));
	addNewSphere(new Sphere(64*11, 64*3, 6));
	addNewSphere(new Sphere(64*11, 64*4, 6));
	addNewSphere(new Sphere(64*11, 64*5, 6));
	addNewSphere(new Sphere(64*11, 64*6, 6));
	addNewSphere(new Sphere(64*11, 64*7, 6));
	addNewSphere(new Sphere(64*11, 64*8, 6));
	addNewSphere(new Sphere(64*11, 64*9, 6));
	addNewSphere(new Sphere(64*11, 64*10, 6));
	addNewSphere(new Sphere(64*11, 64*11, 6));
	addNewSphere(new Sphere(64*12, 64, 6));
	addNewSphere(new Sphere(64*12, 64*5, 6));
	addNewSphere(new Sphere(64*12, 64*7, 6));
	addNewSphere(new Sphere(64*12, 64*11, 6));
	addNewSphere(new Sphere(64*13, 64, 6));
	addNewSphere(new Sphere(64*13, 64*5, 6));
	addNewSphere(new Sphere(64*13, 64*7, 6));
	addNewSphere(new Sphere(64*13, 64*11, 6));
	addNewSphere(new Sphere(64*14, 64, 6));
	addNewSphere(new Sphere(64*14, 64*5, 6));
	addNewSphere(new Sphere(64*14, 64*7, 6));
	addNewSphere(new Sphere(64*14, 64*11, 6));
	addNewSphere(new Sphere(64*15, 64, 6));
	addNewSphere(new Sphere(64*15, 64*2, 6));
	addNewSphere(new Sphere(64*15, 64*3, 6));
	addNewSphere(new Sphere(64*15, 64*4, 6));
	addNewSphere(new Sphere(64*15, 64*5, 6));
	addNewSphere(new Sphere(64*15, 64*7, 6));
	addNewSphere(new Sphere(64*15, 64*8, 6));
	addNewSphere(new Sphere(64*15, 64*9, 6));
	addNewSphere(new Sphere(64*15, 64*10, 6));
	addNewSphere(new Sphere(64*15, 64*11, 6));
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
	
	for (int j = 0; j < walls.size(); j++) {
		Wall w = (Wall) walls.get(j);
		w.update();
	}
	
	checkGameOver();
	//checkWallCollision();
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
			
			checkWallCollision(sphere1);
		}
	}
}

void checkWallCollision(Sphere s) {
	for (int i = 0; i < walls.size(); i++) {
		Wall wall1 = (Wall)walls.get(i);
		
		float xUpDiff = width;
		float xDownDiff = width;
		float yUpDiff = height;
		float yDownDiff = height;
		boolean xUpBounce = false;
		boolean xDownBounce = false;
		boolean yUpBounce = false; 
		boolean yDownBounce = false;
		
		if ((wall1.xmin <= (s.location.x + s.radius/2)) && ((s.location.x - s.radius/2) <= wall1.xmax)) {
			
			yUpDiff = wall1.ymax - (s.location.y - s.radius);
			yDownDiff = (s.location.y + s.radius) - wall1.ymin;
			if (yUpDiff > 0 && yUpDiff < wall1.w_height) {
				yUpBounce = true;
				yDownDiff = height;
			}
			else if (yDownDiff > 0 && yDownDiff < wall1.w_height) {
				yDownBounce = true;
				yUpDiff = height;
			}
		}
		else if ((wall1.ymin <= (s.location.y + s.radius/2)) && ((s.location.y - s.radius/2) <= wall1.ymax)) {
			
			xUpDiff = wall1.xmax - (s.location.x - s.radius);
			xDownDiff = (s.location.x + s.radius) - wall1.xmin;
			if (xUpDiff > 0 && xUpDiff < wall1.w_width) {
				xUpBounce = true;
				xDownDiff = width;
			}
			else if (xDownDiff > 0 && xDownDiff < wall1.w_width) {
				xDownBounce = true;
				xUpDiff = width;
			}
		}
		
		//get the smallest number
		
		if (xUpBounce || xDownBounce || yUpBounce || yDownBounce) {
			//println(xUpDiff + ", " + yUpDiff + ", " + xDownDiff + ", " + yDownDiff);
			if (yUpDiff < yDownDiff && yUpDiff < xUpDiff && yUpDiff < xDownDiff) {
			//if (xUpBounce) {
				s.setVelocity(s.velocity.x, s.velocity.y * - 1 * DRAG);
				s.location.y = wall1.ymax + s.radius;
			}
			else if (yDownDiff < yUpDiff && yDownDiff < xUpDiff && yDownDiff < xDownDiff) {
			//else if (xDownBounce) {
				s.setVelocity(s.velocity.x, s.velocity.y * - 1 * DRAG);
				s.location.y = wall1.ymin - s.radius;
			}
			else if (xUpDiff < yUpDiff && xUpDiff < yDownDiff && xUpDiff < xDownDiff) {
			//else if (yUpBounce) {
				s.setVelocity(s.velocity.x * -1 * DRAG, s.velocity.y);
				s.location.x = wall1.xmax + s.radius;
			}
			else {
				s.setVelocity(s.velocity.x * -1 * DRAG, s.velocity.y);
				s.location.x = wall1.xmin - s.radius;
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