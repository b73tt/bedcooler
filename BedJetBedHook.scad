pipeOD = 75;
pipeOverlap = 10;
pipeClampSize = 12;
pipeClampScrewSize = 4;
wallThickness = 4;

bedDepth = 42;

$fn=100;

difference() {
union() {
difference() {
    hull() {
        translate([0,0,-pipeOD*1.5])
        cylinder(h=pipeOverlap+pipeOD*1.5, r=pipeOD/2+wallThickness);

        translate([-pipeOD/2-wallThickness,0,-pipeOD*1.5])
        cube([pipeOD+wallThickness, bedDepth+pipeOD/2+wallThickness*2, pipeOverlap+pipeOD*1.5]);
    }
    translate([0,0,-pipeOverlap-pipeOD*1.5])
    cylinder(h=pipeOverlap*2+pipeOD*1.5, r=pipeOD/2);
    translate([-pipeOD/2, pipeOD/2+wallThickness, -pipeOverlap-pipeOD*1.5])
    cube([pipeOD+wallThickness, bedDepth, pipeOverlap+pipeOD*1.5]);
    
    //pipe clamp split
    translate([-wallThickness/2, -pipeOD/2-wallThickness,-pipeOD*1.5])
    cube([wallThickness, wallThickness*2, pipeOverlap+pipeOD*1.5]);
}

// pipe clamp

for (i=[-wallThickness, wallThickness]) {
    translate([i-wallThickness/2, -pipeOD/2-wallThickness-pipeClampSize,-pipeOD*1.5])
    difference() {
        cube([wallThickness, pipeClampSize+wallThickness, pipeOverlap+pipeOD*1.5]);
        for (j=[pipeOD*1.5+wallThickness, pipeOD+pipeOverlap-wallThickness]) {
            translate([0, pipeClampSize/2, j])
            rotate([0,90,0])
            #cylinder(h=wallThickness,r=pipeClampScrewSize/2);
        }
    }
}
}

// angled base for 3d printing
translate([-pipeOD/2-wallThickness,0,0])
rotate([0,45,0])
translate([0,-pipeOD/2-pipeClampSize-wallThickness, -pipeOverlap-pipeOD])
cube([pipeOD*2, pipeOD+bedDepth+wallThickness*5+pipeClampSize, pipeOverlap+pipeOD]);


}