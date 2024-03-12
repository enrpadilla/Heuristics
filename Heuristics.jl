module TSPHeuristics
    using LinearAlgebra

    """
        nearest(numcities::Int,startingcity::Int,distmat::Matrix{Real})
    
    Return a solution to solve the TSP using the nearest neighbor algorithm.

    # Examples
    ```julia-repl
    julia> nearest(4,1,[NaN 2 4 5;2 NaN 3 7;4 3 NaN 23;5 7 23 NaN])
    ```
    """ 
    function nearest(numcities::Int,startingcity::Int,distmat::AbstractMatrix{T} where {T<:Real})
        issquare = LinearAlgebra.checksquare(distmat)
        diagonal = diag(distmat)
        
        # For loop to validate if the diagonal contains NaN values
        for i=1:length(diagonal)
            if (isnan(diagonal[i]))
                diagonal[i] = 0
            else
                diagonal[i] = 1 
            end    
        end

        # Validate user inputs
        if (numcities <= 0)
            throw(DomainError(numcities,"Number of cities must be a positive integer."))
        elseif (startingcity <= 0 || startingcity > numcities)
            throw(DomainError(startingcity,"The starting city must be a positive integer and less than or equal to the number of cities."))
        elseif (numcities != issquare)   
            throw(DomainError(distmat,"Matrix must be square and dimensions must be equal to number of cities."))
        elseif (iszero(diagonal) == false)
            throw(DomainError(diagonal,"The diagonal must consist of NaN values. The 1's show where in the diagonal there are no NaN's where there should be."))
        else
            # Nearest neighbor algorithm implementation
            notvisited = [i for i in range(1,stop = numcities)]
            notvisited = deleteat!(notvisited,startingcity)
            lastcity = startingcity
            tour = [startingcity]
            while notvisited != []
                nearestcity = notvisited[1]
                mindistance = distmat[nearestcity][lastcity]
                for j in notvisited[2:end]
                    if distmat[j][lastcity] < mindistance
                        nearestcity = j
                        mindistance = distmat[nearestcity][lastcity]
                    end
                end
                tour = push!(tour,nearestcity)
                notvisited = deleteat!(notvisited,findall(x->x==nearestcity,notvisited))
                last = nearestcity
            end
            print(tour)
        end
    end

    """

    """
    #function simulatedannealing()
    
    #end
end

solution = TSPHeuristics.nearest(4,1,[NaN 2 4 5;2 NaN 3 7;4 3 NaN 23;5 7 23 NaN])
print(solution)
