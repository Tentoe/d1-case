
include <case-speaker.scad>
include <mount.scad>
use <ramp.scad>

$fa = 4;
$fs = 0.25;

difference()
{
    union()
    {
        difference()
        {
            d1_case();

            translate([
                mount_translate[0],
                mount_translate[1],
                mount_translate[2] -
                wall
            ]) d1_mini_access();
        }

        translate([ 0, 0, ledge_height ]) ledge();
        translate(mount_translate) d1_mini_holder();
    }
    // tests
    // translate([0, 0, -15]) cube(size=[100, 100, 100], center=true);
    //translate([ 0, 0, 70 ]) cube(size = [ 100, 100, 100 ], center = true);
    //translate([ 0, 34, 0 ]) cube(size = [ 100, 100, 100 ], center = true);
}



