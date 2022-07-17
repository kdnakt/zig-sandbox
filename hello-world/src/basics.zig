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

    var inferred_variable = @as(u32, 5000);
    std.debug.print("{d}\n", .{inferred_variable});

    const a: i32 = undefined;
    std.debug.print("{d}\n", .{a}); // will print random number like 1863512824

    const b: u32 = undefined;
    std.debug.print("{d}\n", .{b});

    const array1 = [5]u8{ 'h', 'e', 'l', 'l', 'o' };
    std.debug.print("{s}\n", .{array1}); // will print: hello
}
