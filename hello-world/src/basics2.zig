
const std = @import("std");

const expect = @import("std").testing.expect;

pub fn main() void {
    const Direction = enum { north, south, east, west };
    std.debug.print("direction: {s}", .{Direction.north});  
}
