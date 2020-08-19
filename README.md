# Matrix-Solver-Algorithm-Hardware-Implementation
Implementation of a matrix equation solver algorithm (the following algorithm) in VHDL for the final project of my Design Automation (FPGA) course
```{math}
$$1. let 𝑖 = 0\\\\
2. initialize 𝐴^(0) and 𝑋^(0)\\\\
3. do {\\\\
  3.1. calculate 𝐹^(𝑖)\\\\
  3.2. calculate 𝐺^(𝑖)\\\\
  3.3. solve ∆𝑋^(𝒊) = 𝐺^(𝑖) × 𝐹^(𝑖)\\\\
  3.4. let 𝑋^(𝑖+1) = 𝑋^(𝑖) + ∆𝑋^(𝑖)\\\\
  3.5. update 𝐴^(𝑖+1) 𝑤𝑖𝑡ℎ 𝑋^(𝑖+1)\\\\
  3.6. 𝑖 = 𝑖 + 1\\\\
} while (|∆𝑋| ≥ 𝐸)$$
```
