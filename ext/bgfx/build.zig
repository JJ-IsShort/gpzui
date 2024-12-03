const std = @import("std");

// This is not really "built". It is really linked.
pub fn build(b: *std.Build) void {
    _ = b;
}

pub fn link(b: *std.Build, exe: *std.Build.Step.Compile) void {
    //exe.linkLibC();
    exe.linkLibCpp();
    // TODO: Make this more platform independent.
    //exe.addCSourceFiles(.{ .root = b.path("ext/bgfx/"), .files = &.{ "bgfx/include/bgfx/c99/bgfx.h", "bx/include/bx/bx.h" } });
    //exe.addIncludePath(b.path("ext/bgfx/bgfx/include/bgfx/c99/bgfx.h"));
    const bgfxModule = b.createModule(.{ .root_source_file = .{ .src_path = .{ .owner = b, .sub_path = "ext/bgfx/bgfx/bindings/zig/bgfx.zig" } } });
    exe.root_module.addImport("bgfx", bgfxModule);
    const objects_to_include = .{ "bgfx", "bimg", "bimg_decode", "bimg_encode", "bx", "glsl-optimizer", "glslang", "spirv-cross", "spirv-opt" };
    inline for (objects_to_include) |object| {
        exe.addObjectFile(b.path("ext/bgfx/bgfx/.build/linux64_gcc/bin/lib" ++ object ++ "Debug.a"));
    }
    exe.linkSystemLibrary2("stdc++", .{ .needed = true });
    //exe.linkSystemLibrary("pthread");
    //exe.addObjectFile(b.path("").cw("/lib64/libpthread.a"));
    //exe.linkSystemLibrary("dl");
    //exe.linkSystemLibrary("rt");

    exe.verbose_link = true;
}
