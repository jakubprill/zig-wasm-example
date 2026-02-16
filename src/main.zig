const std = @import("std");
const builtin = @import("builtin");

export fn add(a: i32, b: i32) i32 {
    return a + b;
}

pub fn main() !void {
    if (comptime builtin.target.os.tag == .wasi) {
        std.debug.print("Zig WASI: 10 + 20 = {d}\n", .{add(10, 20)});
    }
}
