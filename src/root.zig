//! By convention, root.zig is the root source file when making a library. If
//! you are making an executable, the convention is to delete this file and
//! start with main.zig instead.
const std = @import("std");
const testing = std.testing;
const glfw = @import("zglfw");
pub const backend = @import("backend.zig");

pub const Context = struct {
    window: glfw.Window,
};

pub fn init_window(name: [:0]const u8) !Context {
    try glfw.init();

    glfw.windowHintTyped(.resizable, true);

    const window = try glfw.Window.create(600, 600, name, null);
    return Context{ .window = window };
}

pub fn deinit_window(ctx: Context) void {
    glfw.terminate();
    ctx.window.destroy();
}
