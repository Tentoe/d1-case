$fa = 4;
$fs = 0.25;

speaker_d = 57;
ring_h = 4;
hole = 2;
ring_tickness = 2.5;
lid_thickness = 0.35;

module hexagon(edge = 2, h = 5)
{
    for (i = [ 0, 60, 120 ])
        rotate([ 0, 0, i ])
            cube(size = [ edge, edge * tan(60), h ], center = true);
}

translate([ 0, 0, ring_h / 2 ]) difference()
{
    cylinder(r = speaker_d / 2, h = ring_h, center = true);
    cylinder(r = speaker_d / 2 - ring_tickness, h = ring_h, center = true);
    for (i = [ [ 90, 0, 0 ], [ 0, 90, 0 ] ])
        rotate(i) cylinder(r = hole / 2, h = speaker_d, center = true);
}

difference()
{
    translate([ 0, 0, lid_thickness / 2 ])
        cylinder(r = speaker_d / 2, h = lid_thickness, center = true);

    hexagon_edge = 1.2;
    hexagon_gap = 0.8;

    hexagon_grid = speaker_d + 10;
    for(j = [-hexagon_grid / 2:(hexagon_edge * 1.5 + hexagon_gap/tan(60) )*2:hexagon_grid / 2])
    for (i = [-hexagon_grid / 2:hexagon_edge * tan(60) + hexagon_gap:hexagon_grid / 2]){
        translate([ j, i, 0 ]) hexagon(edge = hexagon_edge);
        translate([ j + (hexagon_edge * 1.5 + hexagon_gap/tan(60) ), i + (hexagon_edge * tan(60) + hexagon_gap)/2, 0 ]) hexagon(edge = hexagon_edge);
    }

}




    