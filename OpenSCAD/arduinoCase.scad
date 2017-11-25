
//This is the base case for arduino uno

board_width = 53;
board_thick = 4;
box_thick = 3;
// I create a 2D polygon using array points with exact same shape as the Arduino Uno Board, then use linear_extrude() function to make it 3D
module Box(box_height,box_thick)
{
	linear_extrude(height = box_height, convexity = 10, twist = 0)
	{
		polygon( points = [ [0, board_width+box_thick*2],
						[64.5+box_thick*2, board_width+box_thick*2],
						[65.5+box_thick*2, 52+box_thick*2],
						[65.5+box_thick*2, 40+box_thick*2],
						[68+box_thick*2, 37+box_thick*2],
						[68+box_thick*2, 5+box_thick],
						[65.5+box_thick*2, 2.54+box_thick],
						[65.5+box_thick*2, 0],
						[0, 0] ],
				convexity = 10);
	}
}
power_poz = 4;
module PowerPlug()
{
        translate([0,power_poz+box_thick,board_thick+box_thick])
		cube([24, 9, 11]);
}
USB_poz = 32;
module USB()
{
		translate([0, USB_poz+box_thick, board_thick+box_thick])
		cube([26, 12, 11]);
}
//Holes on Arduino Uno Board
module Hole()
{
	cylinder(r=1.5, h=13, $fn=25);
}
module lid()
{
    difference(){
        union(){
            cube([65.5+3,56,2]);
            translate([0,1.5,0])cube([10,53,3]);
            translate([68-65,1.5,0])Box(3,0);
        }
        #translate([24.4+2,4,0])cube([38.6,2.5,3]);
        #translate([17+2,53-4,0])cube([47,2.5,3]);
        #translate([18,53-7-2,0])cube([7,4,3]);
        #translate([63+2,25+2,0])cube([4,7,3]);
    }
}
// This is to make a box with plugins
union(){
    difference()
    {
        Box(20,3);
        PowerPlug();
        USB(); 
        box_thick = 0;
        #translate([3,3,3])Box(17,0);
        #translate([0,3,17])cube([3,59-2*3,3]); 
        #translate([0,1.5,18])cube([65.5+3,1.5,2]);
        #translate([0,1.5,18])cube([65.5+3,1.5,2]);
        #translate([0,1.5+53,18])cube([65.5+3,3,2]);
    }
    translate([15+3,53+3-1.5-1,0])Hole();
    translate([15+3,1.5+3+1,0])Hole();
    translate([65.5+3,7+3,0])Hole();
    translate([65.5+3,36+3,0])Hole();
}
// A lid for the box
translate([0,-70,0])lid();
