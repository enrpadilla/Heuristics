# Heuristics
A library of heuristic algorithms for combinatorial and continuous optimization problems.

## Motivation
With Julia becoming an upcoming language used to solve optimization problems, my motivation for developing this package was driven by the need for researchers to focus on their research instead of coding the algorithms or those who want to see how the algorithms work, instead of looking at pseudocode, or include them in a simple project. Also, for expanding my knowledge of the algorithms, learning Julia, and contributing to the development of the language for those interested in optimization (like myself).

## Why use this package?
There are several reasons why I think this package is useful:

1. The package has algorithm implementations to solve discrete and continuous optimization problems. In my research of looking through the available metaheuristic packages, I have found that packages either tend to only solve either discrete or continuous problems, but not both. In the event that a problem has a continuous form and a discrete form, and the interest of solving the problem in both forms, only one package has to be called.

1. The documentation on some of the packages are not followed as suggested according to the [Julia language manual](https://docs.julialang.org/en/v1/manual/documentation/).

1. [JuliaOpt](https://www.juliaopt.org/) is obsolete and has transitioned to [JuMP](https://github.com/jump-dev), which as of the writing of this README, does not have any support for heuristics algorithms.

1. Some of the TSP packages only implement the nearest neighbor algorithm then implement only one other algorithm to provide a better solution, as seen in the [TravelingSalesmanHeuristics.jl package](https://github.com/evanfields/TravelingSalesmanHeuristics.jl/).

### What this package is not:
There are packages that are specifically developed with variations of algorithms, i.e. [Evolutionary.jl](https://github.com/wildart/Evolutionary.jl), [GeneticAlgorithms.jl](https://github.com/WestleyArgentum/GeneticAlgorithms.jl), and [StochasticSearch.jl](https://github.com/phrb/StochasticSearch.jl). This package does not currently have that functionality, but I hope to eventually make an attempt at including them in this repository.

**Note:** Due to the experimental nature of heuristic algorithms, some of the implementations presented in this package are of the continuous form, some are of the discrete form (specifically aimed at solving the travelling salesman problem), and some are presented in both forms.

## List of discrete and continuous algorithms
### Discrete heuristic algorithms:
- Greedy algorithm (nearest neighbor algorithm)
- Simulated annealing algorithm
- Genetic algorithm
- Tabu search algorithm
- More coming soon

### Continuous heuristic algorithms:
- Simulated annealing algorithm
- Genetic algorithm
- More coming soon

## Examples:
**TO BE INCLUDED**