module TSPHeuristics
    using LinearAlgebra
    using Pkg

    if istrue(isdir(Pkg.dir("Distributions")))
        using Distributions
    else
        Pkg.add("Distributions")
    end

    """
        nearest(numcities::Int,startingcity::Int,distmat::AbstractMatrix{T} where {T<:Real})
    
    Return a solution to solve the TSP using the nearest neighbor algorithm.

    # Examples
    ```julia-repl
    julia> TSPHeuristics.nearest(4,1,[NaN 2 4 5;2 NaN 3 7;4 3 NaN 23;5 7 23 NaN])
    [1,2,3,4]
    ```
    """ 
    function nearest(numcities::Int,startingcity::Int,distmat::AbstractMatrix{T} where {T<:Real})
        issquare = LinearAlgebra.checksquare(distmat)
        diagonal = diag(distmat)
        
        # For loop to validate if the diagonal of the distance matrix contains NaN values
        for i=1:length(diagonal)
            if (isnan(diagonal[i]))
                diagonal[i] = 0
            else
                diagonal[i] = 1 
            end    
        end

        # Validate user inputs
        if numcities <= 0
            throw(DomainError(numcities,"Number of cities must be a positive integer."))
        elseif startingcity <= 0 || startingcity > numcities
            throw(DomainError(startingcity,"The starting city must be a positive integer and less than or equal to the number of cities."))
        elseif numcities != issquare   
            throw(DomainError(distmat,"Matrix must be square and dimensions must be equal to number of cities."))
        elseif iszero(diagonal) == false
            throw(DomainError(diagonal,"The diagonal of the distance matrix must consist of NaN values. The 1's show where in the diagonal there are no NaN's where there should be."))
        else
            # Nearest neighbor algorithm implementation
            notvisited = [i for i in range(1,stop = numcities)]
            notvisited = deleteat!(notvisited,startingcity)
            lastcity = startingcity
            tour = [startingcity]
            while notvisited != []
                nearestcity = notvisited[1]
                mindistance = distmat[lastcity,nearestcity]
                for j in notvisited[2:end]
                    if distmat[lastcity,j] < mindistance
                        nearestcity = j
                        mindistance = distmat[lastcity,nearestcity]
                    end
                end
                tour = push!(tour,nearestcity)
                notvisited = deleteat!(notvisited,findall(x->x==nearestcity,notvisited))
                last = nearestcity
            end
            return tour
        end
    end

    """
        simulatedannealing(starttemp::Float64,finaltemp::Float64,soln::Vector{Int64})

    Return a solution to sovle the TSP using the simulated anenaling algorithm.

    # Examples
    ```julia-repl
    julia> TSPHeuristics.simulatedannealing()
    <TOUR OF SOLUTION AFTER RUNNING ALGO HERE>
    ```
    """
    function simulatedannealing(starttemp::Float64,finaltemp::Float64,alpha::Float8,distmat::AbstractMatrix{T} where {T<:Real},soln::Vector{Int64})
        # Initialization of variables
        solnlen = length(soln)
        bestlen = length(soln)
        bestsoln = soln
        iteration = 1
        issquare = LinearAlgebra.checksquare(distmat)
        diagonal = diag(distmat)
        
        # For loop to validate if the diagonal of the distance matrix contains NaN values
        for i=1:length(diagonal)
            if isnan(diagonal[i])
                diagonal[i] = 0
            else
                diagonal[i] = 1 
            end    
        end

        # Validate user inputs
        if starttemp <= finaltemp
            throw(DomainError(starttemp,"The starting temperature must be greater than the final temperature."))
        elseif alpha <= 0 || alpha >= 1
            throw(DomainError(alpha,"The value of alpha must be between 0 and 1."))
        elseif numcities != issquare   
            throw(DomainError(distmat,"The matrix must be square and dimensions must be equal to number of cities."))
        elseif iszero(diagonal) == false
            throw(DomainError(diagonal,"The diagonal of the distance matrix must consist of NaN values. The 1's show where in the diagonal there are no NaN's where there should be."))
        elseif length(unique(soln)) != length(soln)
            throw(DomainError(soln,"The given tour must consist of unique values."))
        else
            # Impementation of simulated annealing algorithm
            while starttemp > finaltemp
                i = Distributions.Uniform(1,solnlen)

                starttemp = starttemp * alpha
            end
        end
    end
end

#solution = TSPHeuristics.simulatedannealing(100,0,.5,[NaN 2 4 5;2 NaN 3 7;4 3 NaN 23;5 7 23 NaN],[1,2,3,4])