const path = "./app/public/main.wasm";
const file = Bun.file(path);
const buffer = await file.arrayBuffer();

const module = await WebAssembly.instantiate(buffer);
const add = module.instance.exports.add as (a: number, b: number) => number;

console.log("-----------------------------------------");
console.log("🚀 Running Zig WASM in Bun!");
console.log(`Input: 10 + 20`);
console.log(`Result: ${add(10, 20)}`);
console.log("-----------------------------------------");
