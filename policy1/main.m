%Emir Can Dağlı 2517704 Ekin Akçay 2577419
clear
clc
grid_size = 12;
P = 0.5 ;
people = zeros(200,5);
isolation = zeros(200,2);
maximum_percentage = 0;


infected_num_iteration = zeros(1,250);
infected_total = zeros(1,250);
healing_num_iteration = zeros(1,250);
healing_total = zeros(1,250);
dead_num_iteration = zeros(1,250);
dead_num_total = zeros(1,250) ;

% Placing people on the grid randomly
for i = 1:200 
    for k = 1:2 
        randomizer = randi([-12 12]) ; 
        people(i, k) = randomizer ;
    end
end
% Randomly selecting 20 people (10% of the 200 population)
% We will use the 3rd column to assign if the person has the disase or not
sum_third_column = 0;
sum_fifth_column = 0;
while sum_third_column < 20 || sum_fifth_column < 10
    selecter  = randi([1 200]) ;
    if people(selecter , 3) == 0
        people(selecter, 3) = 1;
        if sum_fifth_column < 10
            people(selecter, 5) = 1;
            isolation(selecter,1) = people(selecter,1);
            isolation(selecter,2) = people(selecter,2);
            sum_fifth_column = sum(people(:, 5));
        end
    end
    sum_third_column = sum(people(:, 3));
end

% Movement model will include the functions transmit_infection() and
% healing_mechanism()

for n = 1:250
    [people, healing_num_iteration,dead_num_iteration] = healing_mechanism(people,healing_num_iteration,dead_num_iteration,n);   
    [people,infected_num_iteration,isolation] = transmit_infection(people, P,infected_num_iteration,n, isolation); 
    movement_array = zeros(200,5);
    movement_array = movement(people,movement_array,grid_size,isolation);
    people = people + movement_array;
    dead_num_total(n) = sum(any(isnan(people), 2)) ;
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
title('Total Number of Infected People over Iterations');
grid on;

figure;
bar(iterations, healing_total,'FaceColor', '#0091FF');
xlabel('Iteration');
ylabel('Number of healing People');
title('Total Number of healed People over Iterations');
grid on;

figure;
bar(iterations, healing_num_iteration,'FaceColor', '#0091FF');
title('Number of healed People over Iterations');
grid on;

figure;
bar(iterations, dead_num_total, 'FaceColor', '#202020');
title('Total Number of Dead People over Iterations');
grid on;

figure;
bar(iterations, dead_num_iteration, 'FaceColor','#202020');
title('Number of Dead People over Iterations');
grid on;



fprintf("Maximum infected person percentage in one iteration : %.2f \n", maximum_percentage);


