// Global variables
int delay = 16;
int num_spheres = 4;

float ACCELERATION = 0.3;
float DRAG = 0.999;
float PARTICLE_PROP = 0.0005;
float PARTICLE_SPEED = 5;
float MAX_SPEED = 5;

PVector mousePos;
Ball main_sphere;
ArrayList spheres;
boolean start_click;

// Setup the Processing Canvas
void setup(){
  size( 800, 600 );
  smooth();
  frameRate( 40 );

  mousePos = new PVector(0,0);
  
  main_sphere = new Ball(width/2, height/2, 50);
  main_sphere.setMain();
  start_click = false;
  
  spheres = new ArrayList();
  
  for (int i = 0; i < num_spheres; i++) {
  	spheres.add(new Ball(random(30 + i, width - 30 - i), random(30 + i, height - 30 - i), 30 + i * 10));
  }
}

// Main draw loop
void draw(){
  
  // Fill canvas grey
  background(50);//#505964 );
  
  //main_sphere.calculateMass();
  main_sphere.collide();
  main_sphere.move();
  main_sphere.display();
  
  for (int i = 0; i < spheres.size(); i++) {
  	Ball ball = (Ball) spheres.get(i);
  	ball.collide();
  	ball.move();
  	ball.display();
  }
                    
}

void mouseClicked() {
	mousePos.x = mouseX;
  	mousePos.y = mouseY;
  	
  	if (main_sphere.radius > 0 && !start_click) {
  		start_click = true;
  		float angle = atan2( mousePos.y - main_sphere.location.y, mousePos.x - main_sphere.location.x);
  		if (main_sphere.speed + ACCELERATION < MAX_SPEED) {
	  		//main_sphere.speed += ACCELERATION;
	  		main_sphere.acceleration.x = -cos(angle) * ACCELERATION;
	  		main_sphere.acceleration.y = -sin(angle) * ACCELERATION;
	  		main_sphere.velocity.add(main_sphere.acceleration);
	  	}
	  	else {
	  		main_sphere.velocity.x = -cos(angle) * main_sphere.speed;
	  		main_sphere.velocity.y = -sin(angle) * main_sphere.speed;
	  	}
	  	
	  	// spills small fragments in order to move (impulse)
	  	main_sphere.calculateMass();
	  	float mainOldMass = main_sphere.mass;
	  	float particleMass = mainOldMass * PARTICLE_PROP;
	  	float mainNewMass = mainOldMass - particleMass;
	  	main_sphere.radius = pow(((mainNewMass * 3) / (4 * PI)),1/3);
	  	float particleRadius = pow(((particleMass * 3) / (4 * PI)),1/3);
	  	float dx = cos(angle) * (main_sphere.radius + particleRadius);
	  	float dy = sin(angle) * (main_sphere.radius + particleRadius);
	  	
	  	// spills particle when 
	  	Ball particle = new Ball( main_sphere.location.x + dx, main_sphere.location.y + dy, particleRadius);
	  	particle.velocity.x = cos(angle) * PARTICLE_SPEED;
	  	particle.velocity.y = sin(angle) * PARTICLE_SPEED;
	  	spheres.add(particle);
  		start_click = false;
  	}
  	
  	
  	
  	//println("distance: " + dist(mousePos.x, mousePos.y, main_sphere.location.x, main_sphere.location.y));
  	
  	//spheres.add(new Ball(mousePos.x, mousePos.y, random(20, 40)));
}

class Ball {
	float radius;
	float diameter;
	float angle;
	float speed;
	float mass;
	
	PVector location;
	PVector vec_scale;
	PVector velocity;
	PVector acceleration;
	
	boolean isMain = false;
	boolean isProjectile = false;
	boolean bouncing;
	
	Ball(float xin, float yin, float rin) {
		radius = rin;
		diameter = 2*radius;
		location = new PVector(xin, yin);
  		vec_scale = new PVector(0, 0);
  		velocity = new PVector(0, 0);
  		acceleration = new PVector(0, 0);
  		
  		bouncing = false;
	}
	
	void collide() {
		for (int i = 0; i < spheres.size(); i++) {
			// get instance of each ball
			Ball ball = (Ball) spheres.get(i);
			if (ball.radius <= 0) {
				spheres.remove(i);
			}
			// calculate distance
			float dx = location.x - ball.location.x;
			float dy = location.y - ball.location.y; 
			float dis = sqrt(dx*dx + dy*dy);
			
			if (dis > 0) {
				float minDist = ball.radius + radius;
				if (dis < minDist) {
					// Find out which ball is bigger
					if (radius > ball.radius) {
						calculateMass();
						ball.calculateMass();
						
						float ballOldMass = ball.mass;
						float disDiff = minDist - dis;
						ball.radius = ((2*ball.radius)-disDiff)/2;
						ball.calculateMass();
						float ballMassDiff = ballOldMass - ball.mass;
						float oldMass = mass;
						float newMass = oldMass + ballMassDiff;
						radius = pow(((newMass * 3) / (4 * PI)),1/3);
					}
					
					if (isMain && (ball.radius > radius)) {
						calculateMass();
						ball.calculateMass();
						
						float oldMass = mass;
						float disDiff = minDist - dis;
						radius = ((2*radius)-disDiff)/2;
						calculateMass();
						float massDiff = oldMass - mass;
						float ballOldMass = ball.mass;
						float ballNewMass = ballOldMass + massDiff;
						ball.radius = pow(((ballNewMass * 3) / (4 * PI)),1/3);
					}
					
					//ball.calculateMass();
					//speed = calculateSpeed(speed, mass, ball.speed, ball.mass);
					//ball.speed = calculateSpeed(ball.speed, ball.mass, speed, mass);
					//println("speed: " + speed);
					//angle = atan2(ball.location.y - location.y, ball.location.x - location.x);
					//velocity.x = -cos(angle) * speed;
					//velocity.y = -sin(angle) * speed;
					
					//ball.angle = atan2(location.y - ball.location.y, location.x - ball.location.x);
					//ball.velocity.x = -cos(ball.angle) * ball.speed;
					//ball.velocity.y = -sin(ball.angle) * ball.speed;
				}
			}
		}
	}
	
	void setMain() {
		isMain = true;
	}
	
	void setProjectile() {
		isProjectile = true;
	}
	
	// the sphere mass is equivalent to the sphere volume
	void calculateMass() {
		mass = round((4 / 3) * PI * radius * radius * radius);
	}
	
	// Calculate resultant from elastic collision
	float calculateSpeed(speed1, mass1, speed2, mass2) {
		return (((speed1 * (mass1 - mass2)) + (2 * mass2 * speed2)) / (mass1 + mass2)) * 0.999;
	}
	
	void move() {
		
		if (location.x > width - radius) {
			location.x = width - radius;
			velocity.x = velocity.x * -1 * DRAG;
		}
		else if (location.x < radius) {
			location.x = radius;
			velocity.x = velocity.x * -1 * DRAG;
		}
		
		if (location.y > height - radius) {
			location.y = height - radius;
			velocity.y = velocity.y * -1 * DRAG;
		}
		else if (location.y < radius) {
			location.y = radius;
			velocity.y = velocity.y * -1 * DRAG;
		}
		
		location.add(velocity);
	}
	
	void display() {
		// Set fill-color to blue
		if (isMain) {
			fill( #94C5F4, 200 );
		}
  		else {
  			if (radius > main_sphere.radius) {
  				fill( #FA989B, 200 );
  			}
  			else {
  				fill( #93F29D, 200 );
  			}
  		}
  		// Set stroke-color white
  		noStroke();
  		// Draw circle
  		ellipse( location.x, location.y, 2*radius, 2*radius );
	}
}


