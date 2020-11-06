
$fa = 4;
$fs = 0.25;

d1_mini_dimensions = [
    26,
    34 + 0.5,
    8,
    2
]; // [x, y, z ,corner] 0.25 bigger because off spec pcb

module d1_mini(w = d1_mini_dimensions[0],
               d = d1_mini_dimensions[1],
               h = d1_mini_dimensions[2],
               corner = d1_mini_dimensions[3])
{
    translate([ 0, 0, h / 2 ]) difference()
    {
        cube(size = [ w, d, h ], center = true);

        corner_heigt = sqrt(corner);
        for (i = [ 0, 1 ])
            mirror([ i, 0, 0 ]) translate([ w / 2, d / 2, 0 ])
                rotate(a = [ 0, 0, 45 ])
                    cube(size = [ 2 * corner_heigt, 2 * corner_heigt, h ],
                         center = true);
    }
}
bottom = 5;
top = 1.1;
outer_edge = 1.5;
inner_edge = 0.5;
outer = [
    d1_mini_dimensions[0] + outer_edge * 2,
    d1_mini_dimensions[1] + outer_edge * 2,
    bottom +
    top
];
holes = 2;
wall_h = 3.25;
overhang = 0.5;
wall_size = [ outer[0], outer_edge + overhang, wall_h ];
port_size = [ 9, inner_edge + outer_edge, 4 ];
plug_size = [ 11, 10, 7 ];
module
d1_mini_holder()
{

    corner = d1_mini_dimensions[3] / 2;

    plug_wall = 1;
    difference()
    {
        union()
        {

            difference()
            {
                translate([ 0, 0, outer[2] / 2 ])
                    cube(size = outer, center = true);
                translate([ 0, 0, outer[2] - top ]) d1_mini();
                d1_mini(w = d1_mini_dimensions[0] - 2 * inner_edge,
                        d = d1_mini_dimensions[1] - 2 * inner_edge);
                hole_location = [
                    d1_mini_dimensions[0] / 2 - corner + sqrt(holes) / 2,
                    d1_mini_dimensions[1] / 2 - corner + sqrt(holes) / 2,
                    outer[2] / 2
                ];

                for (i = [ 0, 1 ])
                    mirror([ i, 0, 0 ]) translate(hole_location)
                        cylinder(r = holes / 2, h = outer[2], center = true);
            }

            translate(
                [ 0, -outer[1] / 2 + wall_size[1] / 2, wall_h / 2 + outer[2] ])
                cube(size = wall_size, center = true);
        }

        for (i = [[port_size, -outer [1] / 2 + wall_size [1] / 2],
                  [plug_size,
                   -outer [1] / 2 + wall_size [1] - inner_edge -
                       plug_size [1] / 2 - plug_wall]])
            translate([
                -d1_mini_dimensions[0] / 2 + port_size[0] / 2 +
                    8, // 8 is offset
                i[1],
                port_size[2] / 2 + outer[2] - port_size[2]
            ]) cube(size = i[0], center = true);
    }
}
access_size = [ 30, outer[0] + 20, outer[2] + wall_size[2] ];

module d1_mini_access(wall = 0)
{
    angle = 45;
    h = wall / cos(angle);
    translate([ 0, -(access_size[0]) / 2 - outer[1] / 2, 0 ])
        rotate([ 0, 0, 90 ])
            ramp(base = [ access_size[0], access_size[1] + 2 * wall ],
                 h1 = (access_size[1] * tan(angle)) + h,
                 h2 = access_size[2] + h);
}



