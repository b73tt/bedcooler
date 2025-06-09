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