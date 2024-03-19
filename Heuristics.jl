module TSPHeuristics
    using LinearAlgebra
    using Random

    """
        nearest(numcities::Int,startingcity::Int,distmat::AbstractMatrix{T} where {T<:Real})
    
    Return a solution to solve the TSP using the nearest neighbor algorithm.

    # Examples
    ```julia-repl
    julia> TSPHeuristics.nearest(4,1,[NaN 2 4 5;2 NaN 3 7;4 3 NaN 23;5 7 23 NaN])
    [1,2,3,4,1]
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
            end
            firstcity = tour[1]
            push!(tour,firstcity)
            return tour
        end
    end

    """
        simulatedannealing(temp::Float64,alpha::Float64,distmat::AbstractMatrix{T} where {T<:Real},solnvec::Vector{T} where T<:Int64)

    Return a solution to sovle the TSP using the simulated annealing algorithm.

    # Examples
    ```julia-repl
    julia> TSPHeuristics.simulatedannealing(100000.0,0.0001,[NaN 2 4 5;2 NaN 3 7;4 3 NaN 23;5 7 23 NaN],[1,2,3,4,1])
    [2,4,1,3,2]
    ```  
    """
    function simulatedannealing(starttemp::Float64,finaltemp::Float64,alpha::Float64,distmat::AbstractMatrix{T} where {T<:Real},solnvec::Vector{T} where T<:Int64)
        # Remove the last element of the user given vector
        pop!(solnvec)

        # Initialization of variables
        prevtourdist = Inf
        solnlen = length(solnvec)
        randtour = randperm(solnlen)
        issquare = LinearAlgebra.checksquare(distmat)
        diagonal = diag(distmat)
        besttour = []

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
            throw(DomainError([starttemp,finaltemp],"The temperature must be greater than 1."))
        elseif alpha <= 0 || alpha >= 1
            throw(DomainError(alpha,"The value of alpha must be between 0 and 1."))
        elseif solnlen != issquare   
            throw(DomainError(distmat,"The matrix must be square and dimensions must be equal to number of cities."))
        elseif iszero(diagonal) == false
            throw(DomainError(diagonal,"The diagonal of the distance matrix must consist of NaN values. The 1's show where in the diagonal there are no NaN's where there should be."))
        elseif length(unique(solnvec)) != length(solnvec)
            throw(DomainError(solnvec,"The given tour must consist of unique values."))
        else
            # Impementation of simulated annealing algorithm
            while starttemp > finaltemp
                # Swap cities
                i = rand(1:solnlen,1,1)
                j = rand(1:solnlen,1,1)
                cityi = randtour[i]
                cityj = randtour[j]
                randtour[i] = cityj
                randtour[j] = cityi

                # Initialize current tour distance for every temperature iteration
                currtourdist = 0

                # Calculate the current tour distance
                for city in 1:solnlen - 1
                    currtourdist = currtourdist + distmat[randtour[city],randtour[city + 1]]
                end

                # Calculate the cost difference between the distances
                delta = currtourdist - prevtourdist

                # Evaluate if the current tour distance is better
                if delta < 0 || exp(-delta/starttemp) > rand()
                    prevtourdist = currtourdist
                    besttour = randtour
                end
                starttemp *= alpha
            end
            firstcity = besttour[1]
            push!(besttour,firstcity)
            return besttour
        end
    end

    """
        contsimulatedannealing()
    
    Return a solution to solve a continuous optimization problem using the simulated annealing algorithm.

    # Examples
    ```julia-repl
    julia> Heuristics.contsimulatedannealing()
    <SOLUTION HERE>
    ```
    """
    function contsimulatedannealing(f,x::Float64,starttemp::Float64,finaltemp::Float64,)
        # Initialize variables
        y = f(x)
        bestx, besty = x,y

        # Implementation of simulated annealing algorithm
        while starttemp > finaltemp
            i = rand
            
        end
    end

    """
        geneticalgo

    Return a solution to sovle the TSP using the genetic algorithm.

    # Examples
    ```juila-repl
    julia> TSPHeuristics.geneticalgo()
    <SOLUTION HERE>
    """
    #function geneticalgo()

    #end

    #function contgeneticalgo()

    #end

    #function tabusearch()
    
    #end
end

solution = TSPHeuristics.nearest(4,1,[NaN 2 4 5;2 NaN 3 7;4 3 NaN 23;5 7 23 NaN])
print(solution)