mcX=43.5;
mcY=43.5;
mcZ=30;
mcScrewDiameter=4;
mcScrewInset=3;
mcBottomClearance=3;
mcCornerThickness=2;

espX=35;
espY=30;
espZ=25;

pipeOD=75.5;
wallThickness=4;
clampLength=10;
clampScrew = 4;

$fn=100;

difference() {
    union() {
        //pipe
        cylinder(h=mcX+wallThickness*2, r = pipeOD/2+wallThickness);
        //pipe clamp
        rotate([0,0, -90])
        translate([-wallThickness*1.5,0,0])
        cube([wallThickness*3, pipeOD/2+wallThickness+clampLength, mcX+wallThickness*2]);
        
        //mc outside box
        rotate([0,0,-30])
        translate([-pipeOD/2, -mcX/2, 0])
        rotate([0,-90,0])
        translate([wallThickness, 0, 0])
        difference() {
            translate([-wallThickness, -wallThickness, -wallThickness])
            cube([mcX+wallThickness*2, mcY+wallThickness*2,, mcZ+mcBottomClearance+wallThickness*3]);
            
        }

        //esp negative
        rotate([0,0,30])
        translate([-pipeOD/2-wallThickness, -espX/2, wallThickness-espZ+mcZ])
        rotate([0,-90,0])
        difference() {
            translate([-wallThickness, 0, -wallThickness])
            cube([espX+wallThickness*2, espY, espZ+wallThickness*3]);
            translate([wallThickness/2, 0, wallThickness])
            cube([espX-wallThickness, espY, espZ]);
            
            translate([-wallThickness,espY,-wallThickness+espX/2])
            rotate([45,0,0])
            cube([espX+wallThickness*2, 10, 10]);
            
            translate([0,0,espZ*.67+wallThickness])
            #cube([espX, espY,2]);
        }
        

    }
    
    //motor controller negative
    rotate([0,0,-30])
    translate([-pipeOD/2, -mcX/2, 0])
        rotate([0,-90,0])
        translate([wallThickness, -wallThickness, wallThickness]) {
            difference() {
                #cube([mcX, mcY+wallThickness*2, mcZ+mcBottomClearance]);
                for (x=[mcScrewInset, mcX-mcScrewInset]) {
                    for (y=[mcScrewInset, mcY-mcScrewInset]) {
                        translate([x, y+wallThickness, 0])
                        cylinder(h=mcBottomClearance, r=mcScrewDiameter);
                    }    
                }
            }
            for (x=[mcScrewInset, mcX-mcScrewInset]) {
                for (y=[mcScrewInset, mcY-mcScrewInset]) {
                    translate([x, y+wallThickness, -wallThickness*3]) {
                        cylinder(h=mcBottomClearance+wallThickness*3, r=mcScrewDiameter/2);
                        #cylinder(h=wallThickness*2, r=mcScrewDiameter);
                    }
                        
                }    
            }
            translate([-wallThickness, 10, mcBottomClearance])
            #cube([wallThickness, 10, wallThickness*2]);
            translate([0, 10, mcX-wallThickness*3])
            cube([wallThickness, 10, wallThickness*2]);
        }
    
    //pipe clamp negative
    translate([0,-wallThickness/2,0])
    cube([pipeOD, wallThickness, mcX+wallThickness*2]);
    cylinder(h=mcX+wallThickness*2, r = pipeOD/2);
            
    //pipe clamp screw
    translate([pipeOD/2+wallThickness+clampLength/2, 0, mcX+wallThickness*2-clampLength/2])
    rotate([90,0,0])
    translate([0,0,-wallThickness*1.5])
    cylinder(h=wallThickness*3, r=clampScrew/2);
            
    //angled base for 3D printing
    translate([-pipeOD*0.4, 0, 0])
    rotate([0,62,0])
    translate([0, -pipeOD/2-wallThickness,0])
    cube([pipeOD, pipeOD+wallThickness*4, pipeOD*2]);
}