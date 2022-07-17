const std = @import("std");

pub fn main() void {
    const constant: i32 = 5;
    std.debug.print("{d}\n", .{constant});
    // constant = 6; // cannot assign
}
