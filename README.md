# Epidemic Policy Simulation

An agent-based MATLAB simulation developed for the METU IE206 term project
(Spring 2024). The project models epidemic spread on a spatial grid and compares
the effects of isolation and vaccination policies under different transmission
probabilities.

## Project overview

The simulation follows 200 individuals on a 25 x 25 grid for 250 iterations.
Individuals move between neighboring cells, transmit infection through contact,
and transition through infected, recovered, or deceased states. Policy scenarios
extend this base model with isolation and vaccination mechanisms.

The study compares:

| Scenario | Policy setting |
| --- | --- |
| `policy0` | Baseline with no intervention |
| `policy1` | Isolation policy |
| `policy2` | Single-vaccination policy |
| `policy3` | Double-vaccination experiment results |
| `policy4` | Combined isolation and vaccination |
| `policy5` | Policy calibration for transmission probabilities of 0.25, 0.50, and 0.75 |

For the final experiment, policy parameters were calibrated to keep the maximum
infected population below 25% across the three transmission settings. The
reported peak infection rates were 24.0%, 24.5%, and 23.5%, respectively.

## Repository structure

The policy directories preserve the implementation files and/or output figures
retained from each original scenario:

- `main.m`, where present, initializes the simulation, executes iterations, and
  produces plots.
- `movement.m` controls spatial movement.
- `transmit_infection.m` models contact-based transmission.
- `healing_mechanism.m` models recovery and mortality.
- `vaccination_mechanism.m` is included in vaccination scenarios.

The complete methodology, scenario definitions, results, and policy discussion
are available in
[the project report](Project1_ID2517704_ID2577419.pdf).

## Running a scenario

1. Open MATLAB and set the working directory to the desired policy folder.
2. Run `main.m`.
3. Review the generated figures and the maximum infected-population percentage
   printed in the command window.

The model is stochastic and does not set a fixed random seed, so individual runs
may produce different results.

## Academic context

This repository preserves the original course submission and its scenario-based
organization. It was completed by Ekin Akçay and Emir Can Dağlı as part of the
METU Department of Industrial Engineering curriculum.
