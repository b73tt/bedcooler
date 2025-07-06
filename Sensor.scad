wireOD = 3;
sensorMountX = 14;
sensorMountY = 30;
sensorMountZ = 9;
sensorMountScrewSize = 3;
wallThickness = 2;
chamferSize=1;
$fn=50;

difference() {
    // Surround to protect the sensor from feet
    
    hull() {
        cylinder(h = 1, r=sensorMountX/2+wallThickness+wireOD/2-chamferSize);
        translate([0,0,chamferSize])
        cylinder(h = sensorMountY+wallThickness*3+wireOD-chamferSize*2, r=sensorMountX/2+wallThickness+wireOD/2);
        translate([0,0,sensorMountY+wallThickness*3+wireOD-chamferSize])
        cylinder(h = 1, r=sensorMountX/2+wallThickness+wireOD/2-chamferSize);
    }
        
    // internal platform for sensor
    translate([0, 0, 0])
    difference() {
        cylinder(h = sensorMountY+wallThickness*3+wireOD, r=sensorMountX/2);
        rotate([0,0,90])
        translate([-(sensorMountX/2+wallThickness+wireOD/2), sensorMountZ/2, 0])
        cube([sensorMountX+wallThickness*3+wireOD, sensorMountX/2+wallThickness+wireOD/2, sensorMountY+wallThickness*3+wireOD]);
    }
    
    // cutout for sensor
    rotate([90,0,90])
    translate([-sensorMountX/2,0,-sensorMountZ/2])
    cube([sensorMountX, sensorMountY+wallThickness*3+wireOD, sensorMountZ]);
    
    // vertical wire slots
    translate([sensorMountX/2+wallThickness+wireOD/2,0,0])
    cylinder(h=sensorMountY+wallThickness*3+wireOD, r=wireOD/2);
    translate([-(sensorMountX/2+wallThickness+wireOD/2),0,0])
    cylinder(h=sensorMountY+wallThickness*3+wireOD, r=wireOD/2);
    
    // horizontal wire slots
    translate([-(sensorMountX/2+wallThickness+wireOD/2),0,wireOD/2+wallThickness])
    rotate([0,90,0])
    cylinder(h=sensorMountX+wallThickness*2+wireOD, r=wireOD/2);
    
    translate([-(sensorMountX/2+wallThickness+wireOD/2),0,sensorMountY+wallThickness*3+wireOD])
    rotate([0,90,0])
    cylinder(h=sensorMountX+wallThickness*2+wireOD, r=wireOD/2);
    
    //screw hole to hold sensor
    translate([-(sensorMountX/2+wallThickness+wireOD/2),0,wallThickness*3+wireOD+sensorMountX/2])
    rotate([0,90,0]) {
        cylinder(h=sensorMountX+wallThickness*2+wireOD, r=sensorMountScrewSize/2);
        
        //nut
        #cylinder(h=sensorMountScrewSize+1, r=sensorMountScrewSize, $fn=6);
        
        // screw access
        translate([0, 0, sensorMountX+wallThickness])
        cylinder(h=wireOD+wallThickness, r=sensorMountScrewSize);
    }
    
    
}