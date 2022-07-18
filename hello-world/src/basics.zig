const std = @import("std");

const expect = @import("std").testing.expect;

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

    const array2 = [_]u8{ 'w', 'o', 'r', 'l', 'd' };
    std.debug.print("{any}\n", .{array2}); // will print: { 119, 111, 114, 108, 100 }

    std.debug.print("array1 length: {d}\n", .{array1.len}); // 5
}

// test with: zig test basics.zig
test "if statement" {
    const a = true;
    var x: u16 = 0;
    if (a) {
        x += 1;
    } else {
        x += 2;
    }
    try expect(x == 1);
}

test "if statement expression" {
    const a = true;
    var x: u16 = 0;
    x += if (a) 1 else 2;
    try expect(x == 1);
}
