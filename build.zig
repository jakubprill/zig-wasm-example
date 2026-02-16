const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    // 1. Browser/Freestanding WASM (for Vite)
    const target_freestanding = b.resolveTargetQuery(.{
        .cpu_arch = .wasm32,
        .os_tag = .freestanding,
    });
    const exe_freestanding = b.addExecutable(.{
        .name = "main",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target_freestanding,
            .optimize = optimize,
        }),
    });
    exe_freestanding.entry = .disabled;
    exe_freestanding.rdynamic = true;

    const install_freestanding = b.addInstallFile(exe_freestanding.getEmittedBin(), "../app/public/main.wasm");
    b.getInstallStep().dependOn(&install_freestanding.step);

    // 2. WASI WASM (for Wasmtime)
    const target_wasi = b.resolveTargetQuery(.{
        .cpu_arch = .wasm32,
        .os_tag = .wasi,
    });
    const exe_wasi = b.addExecutable(.{
        .name = "main-wasi",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target_wasi,
            .optimize = optimize,
        }),
    });
    // For WASI, main is the entry point, so we don't disable it.
    b.installArtifact(exe_wasi);
}
