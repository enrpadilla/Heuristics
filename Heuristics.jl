module TSPHeuristics
    using LinearAlgebra

    """
        nearest(numcities::Int,startingcity::Int,distmat::Matrix{Real})
    
    Return a solution to solve the TSP using the nearest neighbor algorithm.

    # Examples
    ```julia-repl
    julia> nearest(4,2,[])
    ```
    """ 
    function nearest(numcities::Int,startingcity::Int,distmat::AbstractMatrix{T} where {T<:Real})
        issquare = LinearAlgebra.checksquare(distmat)
        diagonal = diag(distmat)
        nanmatrix = fill(NaN,numcities,1)

        # Validate user inputs
        if (numcities <= 0)
            throw(DomainError(numcities,"Number of cities must be a positive integer."))
        elseif (startingcity <= 0 || startingcity > numcities)
            throw(DomainError(startingcity,"The starting city must be a positive integer and less than or equal to the number of cities."))
        elseif (numcities != issquare)   
            throw(DomainError(distmat,"Matrix must be square and dimensions must be equal to number of cities."))
        elseif (diagonal != nanmatrix)
            throw(DomainError(diagonal,"The diagonal must consist of NaN values."))
        else
            # Nearest neighbor algorithm implementation
            
        end
    end
end

solution = TSPHeuristics.nearest(2,2,[2 2;1 1])
print(solution)
