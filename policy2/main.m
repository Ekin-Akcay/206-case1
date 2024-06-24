%Emir Can Dağlı 2517704 Ekin Akçay 2577419
clear
clc
grid_size = 12;
P = 0.5 ;
r_s = 0.1 ; 
people = zeros(200,8);
delta_1 = 0.1;

infected_num_iteration = zeros(1,250);
infected_total = zeros(1,250);
healing_num_iteration = zeros(1,250);
healing_total = zeros(1,250);
dead_num_iteration = zeros(1,250);
dead_num_total = zeros(1,250) ;
vaccination_iteration = zeros(1,250);
infected_and_vaccinated_total = zeros(1,250);
maximum_percentage = 0;



% Placing people on the grid randomly
for i = 1:200 
    for k = 1:2 
        randomizer = randi([-12 12]) ; 
        people(i, k) = randomizer ;
    end
end
% Randomly selecting 20 people (10% of the 200 population)
% We will use the 3rd column to assign if the person has the disase or not
percentage_third_column = 0;
while percentage_third_column < delta_1 
    selecter = randi([1 200]) ;
    if people(selecter , 3) == 0
        people(selecter, 3) = 1 ;
    end
    percentage_third_column = (sum(people(:, 3))) / 200 ;
end



% Movement model will include the functions transmit_infection() and
% healing_mechanism()
% Now we will also add the vaccination_mechanism which simulates 

for n = 1:250
    [people,vaccination_iteration] = vaccination_mechanism(people, n,vaccination_iteration);
    [people, healing_num_iteration,dead_num_iteration] = healing_mechanism(people,healing_num_iteration,dead_num_iteration,n);   
    [people,infected_num_iteration] = transmit_infection(people, P,infected_num_iteration,n);
    movement_array = zeros(200,8);
    movement_array = movement(people,movement_array,grid_size);
    people = people + movement_array; 
    dead_num_total(n) = sum(any(isnan(people), 2));
    infected_and_vaccinated_total(n) = sum(people(:,3) == 1 & people(:,6) == 1);
    if n == 1 
        infected_total(n) = infected_num_iteration(n);
        healing_total(n) = healing_num_iteration(n);
        vaccination_total(n) = vaccination_iteration(n);
    else 
        infected_total(n) = infected_total(n-1) + infected_num_iteration(n);
        healing_total(n) = healing_total(n-1) + healing_num_iteration(n);
        vaccination_total(n) = vaccination_total(n-1) + vaccination_iteration(n);
    end
    % Plot individuals and their health status
    sum_third_column = sum(people(:, 3));
    percentage = 100 * sum_third_column / 200 ;
    if percentage > maximum_percentage
        maximum_percentage = percentage;
    end 
    
end
   

% PLOTS OF NUMBER OF DISAESED DEAD AND OTHER
% Create a vector of iteration numbers from 1 to 250
iterations = 1:250;

% Plot for the number of infected people
figure;
bar(iterations, infected_num_iteration, 'FaceColor','#FF0000');
xlabel('Iteration');
ylabel('Number of Infected People');
title('Number of Infected People over Iterations');
grid on;

figure;
bar(iterations, infected_total, 'FaceColor','#FF0000');
xlabel('Iteration');
ylabel('Number of Infected People');
title('Total Number of Infected People over Iterations');
grid on;

% Plot for the number of dead people
figure;
bar(iterations, dead_num_total, 'FaceColor', '#202020');
xlabel('Iteration');
ylabel('Number of Dead People');
title('Total Number of Dead People over Iterations');
grid on;

figure;
bar(iterations, dead_num_iteration, 'FaceColor', '#202020');
xlabel('Iteration');
ylabel('Number of dead People');
title('Number of dead People over Iterations');
grid on;


figure;
bar(iterations, healing_num_iteration, 'FaceColor', '#0091FF');
xlabel('Iteration');
ylabel('Number of healing People');
title('Number of healed People over Iterations');
grid on;

figure;
bar(iterations, healing_total, 'FaceColor', '#0091FF');
xlabel('Iteration');
ylabel('Number of healing People');
title('Total Number of healed People over Iterations');
grid on;

figure;
bar(iterations, vaccination_iteration, 'blue');
title('Number of vaccinated People over Iterations');
grid on;

figure;
bar(iterations, infected_and_vaccinated_total, 'blue');
title('Number of infected and vaccinated People over Iterations');
grid on;

fprintf("Maximum infected person percentage in one iteration : %.2f \n", maximum_percentage);

