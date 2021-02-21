## Using PDDL to Design an Efficient Elevator Control System.

### Problem Statement

There are around 0.3 million buildings and more than 1 thousand high-rise buildings in Dhaka city and many under construction. There are more than two hundred elevators are being attached every month to these buildings. The electrical energy used by the elevator of a building is around 4% of the overall consumption. Elevators move up and down with predetermined rules which is not time and energy-efficient. Also, conventional elevators don't provide any feature that can be beneficial for disabled users. AI planning offers an elegant approach to solve this problem. We have modeled a domain for the elevators of an educational institution that can find plans that moves the elevators to passengers' destinations, minimizes the total energy consumption, and provides a new feature dedicated to special users.

### Domain

In our domain, there are two types of users (general, teacher) and two types of elevators (Fast, Slow). Each of these elevators has its own reachability to different floors specified in the problem file.

#### Actions used:

`up-slow` A slow elevator moves upwards.\
`down-slow` A slow elevator moves downwards.\
`up-fast` A fast elevator moves upwards.\
`down-down` A fast elevator moves downwards.\
`load-teacher` A teacher boards the elevator.\
`unload-teacher` A teacher leaves the elevator.\
`load-special` A special person boards the elevator.\
`unload-special` A special person leaves the fast elevator.\
`load-general` A general person boards the elevator.\
`unload-general` A general person leaves the fast elevator.

### Problem 1

A building with 9 floors has 2 fast (accelerating) elevators that stop at all the floors. Furthermore, there are 2 slow elevators. One slow elevator stops only at the even floors and the other one stops only at the odd floors. Each elevator has a capacity of 10 persons. One fast elevator is allocated only for the teachers and the other elevators are allocated for the general users. The fast elevator that is allocated for the general users has a special feature that offers a passenger a nonstop trip to his destination. The cost associated with fast elevators is higher than slow elevators. Our planning problem is to find a plan that moves the elevators to passengers' destinations and minimizes total cost.
