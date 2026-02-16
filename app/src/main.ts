import './style.css'

document.querySelector<HTMLDivElement>('#app')!.innerHTML = `
  <div>
    <h1>Zig WASM + Vite + TypeScript</h1>
    <div id="result">Loading WASM...</div>
  </div>
`

WebAssembly.instantiateStreaming(fetch("/main.wasm"), {})
  .then(obj => {
    const add = obj.instance.exports.add as (a: number, b: number) => number;
    const result = add(10, 20);
    const resultDiv = document.getElementById("result")!;
    resultDiv.innerHTML = `Result from Zig WASM (10 + 20): <strong>${result}</strong>`;
    console.log("Result from Zig WASM:", result);
  })
  .catch(err => {
    console.error(err);
    document.getElementById("result")!.innerText = "Error loading WASM: " + err;
  });
