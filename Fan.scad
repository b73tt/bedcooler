pipeOD = 76;
pipeOverlap = 10;
pipeThickness = 2;


fanOD = 85;
fanSize = 96;
fanScrewSize = 4;
fanScrewHeight = 5;
fanScrewDistance = 112+fanScrewSize; //distance between diagonally opposite screw holes (calipers measurement plus 1x radius)

wallThickness = 4;
partHeight = 80;

$fn=100;


// main part
difference() {
    // outer shell
    hull() {
        // rounded corners
        translate([0,(fanSize-pipeOD)/2-wallThickness,0])
        for (i=[0:90:360])
            rotate([0,0,i])
            translate([fanSize/2-wallThickness,fanSize/2-wallThickness,0])
            cylinder(h=1, r=wallThickness);
        
        translate([0,0,partHeight-pipeOverlap])
        cylinder(h=1, r=pipeOD/2+wallThickness);
        
    }
    // inner airflow channel
    hull() {
        translate([0,(fanSize-pipeOD)/2-wallThickness,0])
        cylinder(h=1, r=fanOD/2);
        
        translate([0,0,partHeight-pipeOverlap])
        cylinder(h=1, r=pipeOD/2-pipeThickness);
    }

    // screws for the fan
    translate([0,(fanSize-pipeOD)/2-wallThickness,0])
    for (i=[45:90:360]) {
        rotate([0,0,i])
        translate([fanScrewDistance/2, 0, 0]) {
            cylinder(h=partHeight, r=fanScrewSize/2);
            translate([0, 0, fanScrewHeight])
            cylinder(h=partHeight, r=fanScrewSize);
            
        }
    }
}

// top lip for the pipe
translate([0, 0, partHeight-pipeOverlap])
difference() {
    cylinder(h=pipeOverlap, r=pipeOD/2+wallThickness);
    cylinder(h=pipeOverlap, r=pipeOD/2);
}