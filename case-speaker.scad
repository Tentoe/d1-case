
include <mount.scad>

$fa = 4;
$fs = 0.25;

small_number = 1 / 1e308;

speaker_d = 57;
wall = 0.8;
ledge = 2;
ledge_height = 45;
ledge_thickness = 0.8;
top_height = 2.5 + 4;
height = ledge_height + top_height;
mount_offset = sqrt(pow(speaker_d / 2, 2) - pow(outer[0] / 2, 2));
mount_translate = [ 0, outer[1] / 2 - mount_offset - wall , 0 ];

module
d1_case()
{
    difference()
    {
        translate([ 0, 0, height / 2 ]) cylinder(
            r = speaker_d / 2 + wall, h = height + wall, center = true);

        translate([ 0, 0, (height + wall) / 2 ])
            cylinder(r = speaker_d / 2, h = height, center = true);
    }
    intersection()
    {
        translate([ 0, 0, height / 2 ]) cylinder(
            r = speaker_d / 2 + wall, h = height + wall, center = true);
        translate([
            mount_translate[0],
            mount_translate[1],
            mount_translate[2] -
            wall
        ]) d1_mini_access(wall = wall);
    }
}

module ledge(r = speaker_d / 2, thickness = ledge_thickness)
{

    angle = 60;

    translate([ 0, 0, thickness / 2 ]) difference()
    {
        cylinder(r = r, h = thickness, center = true);
        cylinder(r = r - ledge, h = thickness, center = true);
    }

    thickness2 = thickness * tan(angle);
    translate([ 0, 0, -thickness2 + thickness ]) difference()
    {
        cylinder(r = r + small_number, h = thickness2, center = true);
        cylinder(r1 = r + small_number,
                 r2 = r - ledge,
                 h = thickness2,
                 center = true);
    }
}
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
    //translate([0, 0, 62]) cube(size=[100, 100, 100], center=true);
}