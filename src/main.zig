//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.
const std = @import("std");
const ui = @import("root.zig");
const glfw = @import("zglfw");
const bgfx = @import("bgfx");

pub fn main() !void {
    try glfw.init();

    glfw.windowHintTyped(.resizable, true);

    const window = try glfw.Window.create(600, 600, "Example Window", null);

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    //const allocator = gpa.allocator();

    _ = bgfx.renderFrame(1000 / 60);

    //var bgfx_init: bgfx.Init;

    // setup your graphics context here

    while (!window.shouldClose()) {
        glfw.pollEvents();

        // render your things here
        //ui.backend.draw(&backend_ctx);

        window.swapBuffers();
    }

    defer glfw.terminate();
    defer window.destroy();
    //ui.backend.deinit(allocator, &backend_ctx);
}
