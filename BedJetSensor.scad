wireOD = 3;
sensorMountX = 14;
sensorMountY = 30;
sensorMountScrewSize = 3;
wallThickness = 2;

$fn=50;

difference() {
    // main body with rounded corners and 45 degree insets for the wire to wrap around    
    union() {
        hull() {
            for (x = [-wallThickness, sensorMountX+wallThickness]) {
            for (y = [-wallThickness, sensorMountY+wallThickness]) {
                translate([x, y, 0])
                cylinder(h = 0.1, r=wireOD*2);
                translate([x, y, wireOD])
                cylinder(h = 0.1, r=wireOD);
            }    
            }
            
            translate([-wireOD, -wireOD*3, wireOD])
            rotate([0, 90, 0])
            difference() {
            cylinder(h=sensorMountX+wireOD*2, r=wireOD);
            #cylinder(h=sensorMountX+wireOD*2, r=wireOD/2);
            }
        }
        hull() {
            for (x = [-wallThickness, sensorMountX+wallThickness]) {
            for (y = [-wallThickness, sensorMountY+wallThickness]) {
                translate([x, y, 2*wireOD-0.1])
                cylinder(h = 0.1, r=wireOD*2);
                translate([x, y, wireOD])
                cylinder(h = 0.1, r=wireOD);
            }    
            }
        

        }
    }
    
    // screw hole
    translate([sensorMountX/2, sensorMountX/2, 0])
    cylinder(h=wireOD*2, r=sensorMountScrewSize/2);
    
    // recess for sensor to sit in
    translate([0,0,wireOD])
    cube([sensorMountX, sensorMountY, wireOD]);

translate([-wireOD*2, -wireOD*2.5, wireOD])
rotate([0, 90, 0])
cylinder(h=sensorMountX+wireOD*4, r=wireOD/2);


}