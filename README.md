# Transmission Line Parameters

This repository contains information about the inductance (𝑳) and capacitance (𝑪) of transmission lines.

## Inductance (𝑳)

Inductance is an important parameter in transmission lines, defining the ability of a line to store energy in the form of magnetic flux. Here are some key points about inductance:

- The inductance of a transmission line is defined as the number of flux linkages produced per ampere of current flowing through the line.
- The inductance of a single conductor (assuming two conductors in the line) is given by the formula:

  𝑳 = 𝑳𝒂 = 𝑳𝒃 = 2 × 10^(-7) ln(D/r') H/m,

  where:
  - D is the distance between the conductors,
  - r' is the radius of the conductor.

- The total inductance of both conductors in the line is the sum of the inductances of each conductor, given by:

  𝑳 = 𝑳𝒂 + 𝑳𝒃 = 4 × 10^(-7) ln(D/r') H/m.

## Capacitance (𝑪)

Capacitance is another important parameter in transmission lines, defining the ability of a line to store energy in the form of electric charge. Here are some key points about capacitance:

- In a 3-phase transmission system, capacitance is considered individually for each conductor rather than between conductors.
- For symmetrical spacing between conductors, the capacitance per unit length is given by the formula:

  𝑪𝑨 = 2πε₀/ln(D/r) F/m,

  where:
  - ε₀ is the permittivity of free space,
  - D is the distance between the conductors,
  - r is the radius of the conductor.
For unsymmetrical spacing between conductors, the capacitance per unit length is given by:

  𝑪𝑨 = 2πε₀ /log( ((d₁ xd₂ xd₃)^1/3)/r)F/m,

  where:
  - d₁, d₂, d₃ are the distances between the conductors.
## License

This repository is open-sourced under the terms of the [MIT License](LICENSE).
