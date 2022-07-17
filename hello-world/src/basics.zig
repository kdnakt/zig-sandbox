const std = @import("std");

pub fn main() void {
    const constant: i32 = 5;
    std.debug.print("{d}\n", .{constant});
    // constant = 6; // cannot assign

    var variable: u32 = 5000;
    std.debug.print("{d}\n", .{variable});
    variable = 6000;
    std.debug.print("{d}\n", .{variable});

    const inferred_constant = @as(i32, 5);
    std.debug.print("{d}\n", .{inferred_constant});
}
