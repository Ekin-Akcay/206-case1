function [people, infected_num_iteration] = transmit_infection(people, P, infected_num_iteration, n)
% people: bireyleri ve sağlık durumlarını temsil eden matris
% P: virüs bulaşma olasılığı
counter = 0;
num_people = size(people, 1);
r_s = 0.1 ;
for p = 1:num_people
    for j = (p + 1):num_people
        if isequal(people(p, 1:2), people(j, 1:2))
            if (people(p, 3) == 1 || people(j, 3) == 1) && ~(people(p, 3) == 1 && people(j, 3) == 1)
                infect_probability = P;
                if people(p, 6) == 1 || people(j, 6) == 1
                    infect_probability = r_s; % Reduced probability if vaccinated
                end
                % Apply infection based on the probability
                if rand() < infect_probability
                    if people(p, 3) == 1
                        people(j, 3) = 1;
                    else
                        people(p, 3) = 1;
                    end
                    counter = counter + 1;
                end
            end
        end
    end
end
infected_num_iteration(n) = counter;
end