# Zig WASM Example

A demonstration of integrated Zig and WebAssembly (WASM) development across different environments.

## Requirements

Check [mise.toml](file:///Users/jakubprill/Projects/zig/wasm-example/mise.toml) for details on tool versions (`zig`, `bun`, `wasmtime`).

## Overview

This repository shows how to:
1.  **Build** Zig code into WASM using the Zig build system (`build.zig`).
2.  **Run in Browser**: Integrated with a Vite + TypeScript project.
3.  **Run in Bun**: A server-side JavaScript runner using `run-wasm.ts`.
4.  **Run in WASI**: Standalone CLI execution using `wasmtime`.

## Test Case

The core logic is a simple `add` function implemented in Zig:
```zig
export fn add(a: i32, b: i32) i32 {
    return a + b;
}
```

We verify this by calculating `10 + 20` and expecting `30` in all environments.

## Quick Start

### 1. Build the project
```bash
zig build
```

### 2. Run in Browser (Vite)
```bash
cd app
bun install
bun run dev
```

### 3. Run in Bun
```bash
bun run-wasm.ts
```

### 4. Run in Wasmtime
```bash
wasmtime zig-out/bin/main-wasi.wasm
```
