function [people, infected_num_iteration,isolation] = transmit_infection(people,P, infected_num_iteration, n, isolation)
% people: bireyleri ve sağlık durumlarını temsil eden matris
% P: virüs bulaşma olasılığı
counter = 0;
num_people = size(people, 1);
isolation_probability = 1;
for p = 1:num_people
    for j = (p + 1):num_people
        if (people(p,1) == people(j,1)) && (people(p,2) == people(j,2))
            if (people(p, 3) == 1 || people(j, 3) == 1) && ~(people(p, 3) == 1 && people(j, 3) == 1)
                if people(p, 3) == 1 && rand() < P
                    people(j, 3) = 1;
                    if rand() < isolation_probability
                        people(j,5) = 1;
                        isolation(j,1) = people(j,1);
                        isolation(j,2) = people(j,2);
                    end
                    counter = counter + 1;
                elseif people(j, 3) == 1 && rand() < P
                    people(p, 3) = 1;
                    if rand() < isolation_probability
                        people(p,5) = 1;
                        isolation(p,1) = people(p,1);
                        isolation(p,2) = people(p,2);
                    end
                    counter = counter + 1;
                end
            end
        end
    end
end
infected_num_iteration(n) = counter;
end