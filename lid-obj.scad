include <case-speaker.scad>

$fa = 4;
$fs = 0.25;

small_number = 1 / 1e308;

lid_thickness = 4 * 0.175;
lid_h = 4 + lid_thickness;
lid_ring = 2.5;
lid_gap = 0.5;
lid_outer_radius = speaker_d / 2 + 2 * wall;
lid_inner_radius = speaker_d / 2 + wall;

hexagon_edge = 1.2;
hexagon_gap = 0.8;

module hexagon(edge = 2, h = 5)
{
    for (i = [ 0, 60, 120 ])
        rotate([ 0, 0, i ])
            cube(size = [ edge, edge * tan(60), h ], center = true);
}

translate([ 0, 0, lid_h / 2 ]) difference()
{
    cylinder(r = lid_outer_radius, h = lid_h, center = true);
    cylinder(r = lid_inner_radius, h = lid_h, center = true);
}
difference()
{
    translate([ 0, 0, lid_thickness / 2 ])
        cylinder(r = lid_outer_radius, h = lid_thickness, center = true);

    stepj = (hexagon_edge * 1.5 + hexagon_gap / tan(60)) * 2;
    stepi = hexagon_edge * tan(60) + hexagon_gap;
    gridj = ceil((speaker_d / 2) / stepj + 1) * stepj;
    gridi = ceil((speaker_d / 2) / stepi + 1) * stepi;

    for (j = [-gridj:stepj:gridj])
        for (i = [-gridi:stepi:gridi]) {
            translate([ j, i, 0 ]) hexagon(edge = hexagon_edge);
            translate([
                j + (hexagon_edge * 1.5 + hexagon_gap / tan(60)),
                i + (hexagon_edge * tan(60) + hexagon_gap) / 2,
                0
            ]) hexagon(edge = hexagon_edge);
        }
}










