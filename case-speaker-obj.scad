
include <mount.scad>
include <case-speaker.scad>

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

            for (i = [ [ 90, 0, 0 ], [ 0, 90, 0 ] ])
                translate([0,0, height - hole/2 - hole /2 ])rotate(i) cylinder(r = hole / 2, h = speaker_d + 2 * wall , center = true);
        }

        translate([ 0, 0, ledge_height ]) ledge();
        translate(mount_translate) d1_mini_holder();
    }
    //translate([0, 0, -15]) cube(size=[100, 100, 100], center=true);
    translate([0, 0, 60]) cube(size=[100, 100, 100], center=true);
}

