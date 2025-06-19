pipeOD = 76;
minPipeOverlap = 10;
pipeOverlap = 40;
wallThickness = 4;
faceDepth = 30;
faceSquashFactor = 3;
faceForward = 10;
$fn=100;

difference() {
    // outer shell from the top of the pipe to the face
    hull() {
        cylinder(h = 1, r = pipeOD/2+wallThickness);
        
        rotate([90,0,0])
        translate([0,80,faceDepth+pipeOD/4+faceForward])
        scale([faceSquashFactor, 1/faceSquashFactor, 1])
        cylinder(h=faceDepth, r=pipeOD/2+wallThickness);
    }

    // inner shell for the airflow path
    hull() {
        cylinder(h = 1, r = pipeOD/2);
        
        rotate([90,0,0])
        translate([0,80,faceDepth+pipeOD/4+faceForward])
        scale([faceSquashFactor*(pipeOD/2-wallThickness/faceSquashFactor)/(pipeOD/2), 1/faceSquashFactor*(pipeOD/2-wallThickness*faceSquashFactor)/(pipeOD/2), 1])
        cylinder(h=faceDepth, r=pipeOD/2+wallThickness);
    }
};

// angled base for 3d printing and pipe connection
difference() {
    translate([0,0,-pipeOverlap])
    difference() {
        cylinder(h = pipeOverlap, r = pipeOD/2+wallThickness);
        cylinder(h = pipeOverlap, r = pipeOD/2);
    }

    translate([0, pipeOD/2+wallThickness, -minPipeOverlap])
    rotate([-45,0,0])
    translate([-pipeOD,0,-pipeOD*2])
    cube(pipeOD*2);
    
}


// internal brace to keep the face from squashing
// these dimensions are wrong
#hull() {
translate([-wallThickness/2, -pipeOD/2-wallThickness, 0])
#cube([wallThickness, pipeOD+wallThickness, 1]);

translate([-wallThickness/2,-80-wallThickness*2, faceDepth+pipeOD/4+faceForward+pipeOD/faceSquashFactor+wallThickness*2])
cube([wallThickness, faceDepth-wallThickness, 1]);
    translate([-wallThickness/2,-80-wallThickness, faceDepth+pipeOD/4+faceForward+wallThickness])
cube([wallThickness, faceDepth+1, 1]);
    
}


// base lines to get a better grab on the bed
translate([0,pipeOD/2+wallThickness-2,-minPipeOverlap-2])
rotate([45,0,0]) {
translate([-pipeOD*1.5, -pipeOD/2,0])
cube([pipeOD*3, 2, 0.3]);

translate([-pipeOD*1.5, 0,0])
cube([pipeOD*3, 2, 0.3]);
}