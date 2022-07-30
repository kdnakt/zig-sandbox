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

    var d: u32 = 5;
    {
        defer d += 2;
        std.debug.print("d={d}\n", .{d}); // 5
    }
    std.debug.print("d={d}\n", .{d}); // 7

    var f: f32 = 5;
    {
        defer f += 2;
        defer f /= 2;
    }
    std.debug.print("f={d}\n", .{f}); // 4.5

    const AllocationError = error{OutOfMemory};
    const err: FileOpenError = AllocationError.OutOfMemory;
    std.debug.print("err={s}\n", .{err});

    const maybe_error: AllocationError!u16 = 10;
    const no_error = maybe_error catch 0;
    const t = @TypeOf(no_error);
    std.debug.print("type of no_error={s}\n", .{t});

    std.debug.print("Calling failingFunction()\n", .{});
    failingFunction() catch |e| {
        std.debug.print("got error={s}\n", .{e});
    };
    std.debug.print("Called failingFunction()\n", .{});

    // type coercion
    const xx: error{AccessDenied}!void = createFile();
    // unwrap error unions
    _ = xx catch {};

    const A = error{NotDir, PathNotFound};
    const B = error{OutOfMemory,PathNotFound};
    const C = A || B;
    std.debug.print("merged errors={any}\n", .{C}); // errors=C

    var xxx: i8 = 10;
    switch (xxx) {
        -1...1 => {
            xxx = -xxx;
        },
        10, 100 => {
            xxx = @divExact(xxx, 10);
        },
        else => {},
    }
    std.debug.print("xxx={d}\n", .{xxx});

    xxx = switch (xxx) {
        -1...1 => -xxx,
        10, 100 => @divExact(xxx, 10),
        else => xxx,
    };
    std.debug.print("xxx={d}\n", .{xxx});

    //const array4 = [3]u8{1, 2, 3};
    //var index: u8 = 5;
    //const b4 = array4[index]; // will panic
    //_ = b4;

    std.debug.print("failFnCounter()\n", .{});
    failFnCounter() catch |e| {
        std.debug.print("got error={s}\n", .{e});
        std.debug.print("problems={d}\n", .{problems});
        return;
    };

    // never reached
    const ff = failFn() catch |e| {
        std.debug.print("got error={s}\n", .{e});
        return;
    };
    std.debug.print("ff={d}\n", .{ff}); // never reached
}

fn addFive(x: u32) u32 {
    return x + 5;
}

fn fib(n: u16) u16 {
   if (n == 0 or n == 1) return n;
   return fib(n - 1) + fib(n - 2);
}

const FileOpenError = error{
    AccessDenied,
    OutOfMemory,
    FileNotFound,
};

fn failingFunction() error{Oops}!void {
    return error.Oops;
}

// `try x` is a shortcut for `x catch |err| return err`
fn failFn() error{Oops}!i32 {
    try failingFunction();
    return 12;
}

var problems: u32 = 98;

fn failFnCounter() error{Oops}!void {
    errdefer problems += 1;
    try failingFunction();
}

// error unions returned from a function can be inferred
fn createFile() !void {
    return error.AccessDenied;
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

// test "unreachable" {
//     const x: i32 = 1;
//     const y: u32 = if (x == 2) 5 else unreachable;
//     _ = y;
// }

fn asciiToUpper(x: u8) u8 {
    return switch(x) {
        'a'...'z' => x + 'A' - 'a',
        'A'...'Z' => x,
        else => unreachable,
    };
}

test "unreachable switch" {
    try expect(asciiToUpper('a') == 'A');
    try expect(asciiToUpper('A') == 'A');
    try expect(asciiToUpper('b') == 'B');
    try expect(asciiToUpper('B') == 'B');
}
