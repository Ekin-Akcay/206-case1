%Emir Can Dağlı 2517704 Ekin Akçay 2577419
clear
clc

%initialize the given parameters
grid_size = 12;
P = 0.5;
N = 200;
people = zeros(N,4);
M = 25;
delta_1 = 0.1;


%creating arrays for plotting
infected_num_iteration = zeros(1,250);
infected_total = zeros(1,250);
healing_num_iteration = zeros(1,250);
healing_total = zeros(1,250);
dead_num_iteration = zeros(1,250);
dead_num_total = zeros(1,250) ;
maximum_percentage = 0;

%placing people on the grid randomly
for i = 1:200 
    for k = 1:2 
        randomizer = randi([-12 12]) ; 
        people(i, k) = randomizer ;
    end
end

%randomly selecting 20 people (10% of the 200 population)
%we will use the 3rd column to assign if the person has the disase or not
percentage_third_column = 0;
while percentage_third_column < delta_1 
    selecter = randi([1 200]) ;
    if people(selecter , 3) == 0
        people(selecter, 3) = 1 ;
    end
    percentage_third_column = (sum(people(:, 3))) / 200 ;
end


%movement model will include the functions transmit_infection() and
%healing_mechanism()

for n = 1:250%healing mechanism
    [people, healing_num_iteration,dead_num_iteration] = healing_mechanism(people,healing_num_iteration,dead_num_iteration,n); 
    [people,infected_num_iteration] = transmit_infection(people, P,infected_num_iteration,n);
    
    %create movement array for each iteration and adding the movement array
    %for people positions
    movement_array = zeros(200,4);
    movement_array = movement(people,movement_array,grid_size);
    people = people + movement_array;
    dead_num_total(n) = sum(any(isnan(people), 2)) ;
    %adding plot variables
    if n == 1 
        infected_total(n) = infected_num_iteration(n);
        healing_total(n) = healing_num_iteration(n);
    else 
        infected_total(n) = infected_total(n-1) + infected_num_iteration(n);
        healing_total(n) = healing_total(n-1) + healing_num_iteration(n);
    end
    sum_third_column = sum(people(:, 3));
    percentage = 100 * sum_third_column / 200 ;
    if percentage > maximum_percentage
        maximum_percentage = percentage;
    end 
    
end
   
iterations = 1:250;

% Plot for the number of infected people
figure;
bar(iterations, infected_num_iteration, 'FaceColor','#FF0000');
title('Number of Infected People over Iterations');
grid on;

figure;
bar(iterations, infected_total, 'FaceColor','#FF0000');
title('Total Number of Infected People in the System over Iterations');
grid on;

figure;
bar(iterations, healing_total,'FaceColor', '#0091FF');
title('Total Number of Healed People in the System over Iterations');
grid on;

figure;
bar(iterations, healing_num_iteration,'FaceColor', '#0091FF');
title('Number of Healed People over Iterations');
grid on;

figure;
bar(iterations, dead_num_total, 'FaceColor', '#000000');
title('Total Number of Dead People in the System over Iterations');
grid on;

figure;
bar(iterations, dead_num_iteration, 'FaceColor','#000000');
title('Number of Dead People over Iterations');
grid on;



fprintf("Maximum infected person percentage in one iteration : %.2f \n", maximum_percentage);


