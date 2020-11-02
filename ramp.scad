


module rampe(base = [10,10], h1=10, h2 =5, center = true){

    RampePoints = [
  [  0,  0,  0 ],  //0
  [ 0, base[1], 0 ],  //1
  [ base[0], base[1] ,0 ],  //2
  [ base[0],0 ,0 ],  //3
  [  0,  0,  h1 ],  //4
  [ 0, base[1], h1 ],  //5
  [ base[0], base[1] ,h2 ],  //6
  [ base[0],0 ,h2 ], //7
    ];
    RampeFaces = [ //clockwise
    [0,3,2,1], //bot
    [0,4,7,3], //front
    [2,6,5,1], //back
    [1,5,4,0], //left
    [3,7,6,2], //right
    [4,5,6,7], //top
    ];
    if(center)
    translate([0,-base[1]/2,0]) polyhedron( RampePoints, RampeFaces );
    else 
        polyhedron( RampePoints, RampeFaces );
}

