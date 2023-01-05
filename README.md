# ConsumerDataCCPA

This Julia package contains the code to generate all graphs used in **Canayaz, M., Kantorovitch, I., & Mihet, R. (2022). Consumer Privacy and the Value of Consumer Data (No. 22-68). Swiss Finance Institute.** The code was written by Ilja Kantorovitch throughout 2022. This version is from 05.01.2023.

The code solves for a static equilibrium in which data depreciates fully and plots the comparative statics for changes in the parameters `Tau` (trading friction), `A_G` (size of customer bases), `Nu` (non-rivalry of data), and `Xi` (usefulness of externally acquired data). The graphs are then exported in .pdf and .png format to the Graphs folder.

To use the package, write in the Julia REPL

```
    ]add https://github.com/IljaK91/ConsumerDataCCPA
```

To develop the package, write in the Julia REPL

```
    ]dev https://github.com/IljaK91/ConsumerDataCCPA
```

After adding this package to your environment, you only need to add `Measures.jl` and `Plots.jl`, after which you should be able to execute `main.jl`.

License information:

MIT License

Copyright (c) 2023 Ilja Kantorovitch

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
