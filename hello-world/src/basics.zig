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

    var i: u8 = 2;
    while (i < 100) {
        i *= 2;
    }
    std.debug.print("i={d}\n", .{i}); // prints: 128

    var j: u8 = 1;
    var sum: u8 = 0;
    while (j <= 10) : (j += 1) {
        sum += j;
    }
    std.debug.print("j={d}\n", .{j}); // 11
    std.debug.print("sum={d}\n", .{sum}); // 55

    i = 0;
    sum = 0;
    while (i <= 3) : (i += 1) {
        if (i == 2) continue;
        sum += i;
    }
    std.debug.print("i={d}\n", .{i});
    std.debug.print("sum={d}\n", .{sum});

    sum = 0;
    i = 0;
    while (i <= 3) : (i += 1) {
        if (i == 2) break;
        sum += i;
    }
    std.debug.print("i={d}\n", .{i});
    std.debug.print("sum={d}\n", .{sum});

    const array3 = [_]u8{ 'a', 'b', 'c' };
    for (array3) | character, index | {
        std.debug.print("character={any}", .{character});
        std.debug.print(" index={d}\n", .{index});
    }

    for (array3) | character | {
        std.debug.print("character={any}\n", .{character});
    }

    for (array3) | _, index | {
        std.debug.print("index={d}\n", .{index});
    }
    for (array3) |_| {
        std.debug.print("for loop\n", .{});
    }

    const res = addFive(2);
    std.debug.print("addFive(2) == {d}\n", .{res});

    const fib_ten = fib(10);
    std.debug.print("fib(10) == {d}\n", .{fib_ten});

    _ = fib(5);
}

fn addFive(x: u32) u32 {
    return x + 5;
}

fn fib(n: u16) u16 {
   if (n == 0 or n == 1) return n;
   return fib(n - 1) + fib(n - 2);
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
