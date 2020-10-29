
$fa = 4;
$fs = 0.25;

d1_mini_dimensions = [ 26, 34, 8, 2 ]; // [x, y, z ,corner]

module d1_mini(w = d1_mini_dimensions[0],
               d = d1_mini_dimensions[1],
               h = d1_mini_dimensions[2],
               corner = d1_mini_dimensions[3])
{
    translate([ 0, 0, h / 2 ]) difference()
    {
        cube(size = [ w, d, h ], center = true);

        corner_heigt = sqrt(corner);
        translate([ w / 2, d / 2, 0 ]) rotate(a = [ 0, 0, 45 ]) cube(
            size = [ 2 * corner_heigt, 2 * corner_heigt, h ], center = true);
        translate([ -w / 2, d / 2, 0 ]) rotate(a = [ 0, 0, 45 ]) cube(
            size = [ 2 * corner_heigt, 2 * corner_heigt, h ], center = true);
    }
}

module d1_mini_holder(bottom = 3,
                      top = 1,
                      outer_edge = 1.5,
                      inner_edge = 1,
                      holes = 2,
                      overhang = 0.5,
                      wall_h = 3)
{
    h = bottom + top;
    outer = [
        d1_mini_dimensions[0] + outer_edge * 2,
        d1_mini_dimensions[1] + outer_edge * 2,
        h
    ];
    corner = d1_mini_dimensions[3] / 2;

    difference()
    {
        translate([ 0, 0, h / 2 ]) cube(size = outer, center = true);
        translate([ 0, 0, h - top ]) d1_mini();
        d1_mini(w = d1_mini_dimensions[0] - 2 * inner_edge,
                d = d1_mini_dimensions[1] - 2 * inner_edge);
        hole_location = [
            d1_mini_dimensions[0] / 2 - corner + sqrt(holes) / 2,
            d1_mini_dimensions[1] / 2 - corner + sqrt(holes) / 2,
            h / 2
        ];
        translate(hole_location) cylinder(r = holes / 2, h = h, center = true);
        translate([ -hole_location[0], hole_location[1], hole_location[2] ])
            cylinder(r = holes / 2, h = h, center = true);
    }
    wall_size = [ outer[0], outer_edge + overhang, wall_h ];
    difference()
    {
        translate(
            [ 0, -outer[1] / 2 + wall_size[1] / 2, wall_h / 2 + outer[2] ])
            cube(size = wall_size, center = true);
        port_size = [ 7.5, wall_size[1], 2.85 ];
        translate([
            0,
            -outer[1] / 2 + wall_size[1] / 2,
            port_size[2] / 2 + outer[2]
        ]) cube(size = port_size, center = true);
    }
}
d1_mini_holder(); // usb port 7.5x 2.85  2 mm max wall wall// stifthöhe 11.2