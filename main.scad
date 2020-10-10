$fa = 1;
$fs = 0.4;
$fn = 100;

/* Global vars */
corner_diameter = 7.00;

num_pacifiers = 4;
pacifier_x_spacing = 12.00*2; // * 2 bcz Jennifer
pacifier_y_spacing = 20.00*2; // * 2 bcz Jennifer
pacifier_diameter = 27.00;
pacifier_insert_height = 13.5;

pacifier_insert_thickness = 2.00; // Not needed?
pacifier_rows = 2;

shell_thickness = 1.00;
lid_thickness = 2.00;
lid_overlap = 5.00;
lid_spacing = 1.00;

/* Hole matrix */
num_cols = num_pacifiers/pacifier_rows;
pacifier_holes_witdh = num_cols*(pacifier_diameter) + (num_cols-1)*pacifier_x_spacing;

pacifier_holes_height = pacifier_rows * pacifier_diameter + (pacifier_rows-1) * pacifier_y_spacing;

/* Box Vars */
w2 = pacifier_holes_witdh/2+pacifier_x_spacing-corner_diameter/2+shell_thickness/2;
h2 = pacifier_holes_height/2+pacifier_y_spacing-corner_diameter/2+shell_thickness/2;
box_height = pacifier_insert_height*4;

ww2 = w2-shell_thickness/2;
hh2 = h2-shell_thickness/2;
www2 = ww2-lid_spacing;
hhh2 = hh2-lid_spacing;
ccorner_diameter = corner_diameter;

module pacifier_slots() {
    for (i = [0:pacifier_rows-1])
    {
        for (j = [0:(num_pacifiers/pacifier_rows)-1])
        {
            num_cols = num_pacifiers/pacifier_rows;
            x_coord = -pacifier_holes_witdh/2 + pacifier_diameter/2 + j*(pacifier_x_spacing+pacifier_diameter);
            tot_height = pacifier_rows * pacifier_diameter + (pacifier_rows-1) * pacifier_y_spacing;
            y_coord = -pacifier_holes_height/2 + pacifier_diameter/2 + i*(pacifier_y_spacing+pacifier_diameter);
            translate([x_coord, y_coord]) cylinder(d=pacifier_diameter, h=pacifier_insert_height*2);
        }
    }
}

module box_shell() {
    difference () {
        hull () {
            translate([-w2, -h2]) cylinder(d=corner_diameter, h=box_height);
            translate([w2, -h2]) cylinder(d=corner_diameter, h=box_height);
            translate([w2, h2]) cylinder(d=corner_diameter, h=box_height);
            translate([-w2, h2]) cylinder(d=corner_diameter, h=box_height);
        }

        translate([0, 0, shell_thickness]) hull () {
            translate([-ww2, -hh2]) cylinder(d=ccorner_diameter, h=box_height);
            translate([ww2, -hh2]) cylinder(d=ccorner_diameter, h=box_height);
            translate([ww2, hh2]) cylinder(d=ccorner_diameter, h=box_height);
            translate([-ww2, hh2]) cylinder(d=ccorner_diameter, h=box_height);
        }
    }
}

module box_lid () {
    union() {
        translate([0, 0, box_height]) hull () {
            translate([-w2, -h2]) cylinder(d=ccorner_diameter, h=lid_thickness);
            translate([w2, -h2]) cylinder(d=ccorner_diameter, h=lid_thickness);
            translate([w2, h2]) cylinder(d=ccorner_diameter, h=lid_thickness);
            translate([-w2, h2]) cylinder(d=ccorner_diameter, h=lid_thickness);
        }
        difference() {
            translate([0, 0, box_height-lid_overlap]) hull () {
                translate([-www2, -hhh2]) cylinder(d=ccorner_diameter, h=lid_overlap);
                translate([www2, -hhh2]) cylinder(d=ccorner_diameter, h=lid_overlap);
                translate([www2, hhh2]) cylinder(d=ccorner_diameter, h=lid_overlap);
                translate([-www2, hhh2]) cylinder(d=ccorner_diameter, h=lid_overlap);
            }
            wwww2 = www2-shell_thickness/2;
            hhhh2 = hhh2-shell_thickness/2;
            translate([0, 0, box_height-lid_overlap*2]) hull () {
                translate([-wwww2, -hhhh2]) cylinder(d=ccorner_diameter, h=lid_overlap*2);
                translate([wwww2, -hhhh2]) cylinder(d=ccorner_diameter, h=lid_overlap*2);
                translate([wwww2, hhhh2]) cylinder(d=ccorner_diameter, h=lid_overlap*2);
                translate([-wwww2, hhhh2]) cylinder(d=ccorner_diameter, h=lid_overlap*2);
            }
        }
    }
}

module insert () {
    difference() {
        _ww2 = ww2 - lid_spacing;
        _hh2 = hh2 - lid_spacing;
        translate([0, 0, shell_thickness]) hull () {
            translate([-_ww2, -_hh2]) cylinder(d=ccorner_diameter, h=pacifier_insert_height);
            translate([_ww2, -_hh2]) cylinder(d=ccorner_diameter, h=pacifier_insert_height);
            translate([_ww2, _hh2]) cylinder(d=ccorner_diameter, h=pacifier_insert_height);
            translate([-_ww2, _hh2]) cylinder(d=ccorner_diameter, h=pacifier_insert_height);
        }
        pacifier_slots();
        _www2 = _ww2 - shell_thickness;
        _hhh2 = _hh2 - shell_thickness;
        translate([0, 0, 0]) hull () {
            translate([-_www2, -_hhh2]) cylinder(d=ccorner_diameter, h=pacifier_insert_height);
            translate([_www2, -_hhh2]) cylinder(d=ccorner_diameter, h=pacifier_insert_height);
            translate([_www2, _hhh2]) cylinder(d=ccorner_diameter, h=pacifier_insert_height);
            translate([-_www2, _hhh2]) cylinder(d=ccorner_diameter, h=pacifier_insert_height);
        }
    }
}

//color("orange") box_shell();
//color("blue") insert();
color("red") box_lid();

//color("green") pacifier_slots();
