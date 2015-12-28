$fa = 1;
$fs = 0.1;

PI = 3.14159265359;

module pie(h, r, a) {
     linear_extrude(h) {
          intersection() {
               circle(r);
               square(r);
               rotate(a-90)
                    square(r);
          }
     }
}

module base(
     thickness = 1,
     diameter = 12.28,
     inner_diameter = 9.4,
     nook_width = 3,
     nook_height = 3.2,
     nook_depth = 0.7,
     tooth_height = 0.6
     )
{
     radius = diameter / 2;
     inner_radius = inner_diameter / 2;
     support_height = 1.64 - thickness;
     perimeter = PI*inner_diameter;
     
     cylinder(thickness, radius, radius);

     translate([0, 0, thickness]) {
          difference() {
               union() {
                    intersection() {
                         for(a = [0:120:360]) {
                              rotate(a)
                                   pie(nook_height+1,
                                       inner_radius + 5,
                                       nook_width / perimeter * 360);
                         }
                         union() {
                              cylinder(nook_height,
                                       inner_radius,
                                       inner_radius - 0.3);
                              translate([0, 0, nook_height - tooth_height])
                                   cylinder(tooth_height,
                                            inner_radius + nook_depth - 0.3,
                                            inner_radius - 0.3);
                         }
                     }
               }
               cylinder(nook_height+1,
                        inner_radius - nook_depth,
                        inner_radius - nook_depth - 0.3);
           }
           intersection() {
               for(a = [0:120:360]) {
                   rotate(a)
                   pie(nook_height+1,
                       inner_radius + 5,
                       nook_width / perimeter * 360);
               }
               difference() {
                   cylinder(tooth_height,
                       inner_radius,
                       inner_radius - 0.3);
                   cylinder(tooth_height + 0.1,
                       inner_radius - 2*nook_depth,
                       inner_radius - nook_depth);
               }
           }
     }
}

base();
