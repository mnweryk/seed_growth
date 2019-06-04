function tab = countEnergyTab(tab, boundsChoice,neighbourhood, kt)
    
    extended_tab = bounds(tab, boundsChoice); 
    order = randperm(size(tab, 1)*size(tab, 2));
    columnsInRow = size(tab, 2);
    
    energyTab = zeros(size(tab));
    
    for i=1:length(order)
        column = mod(order(i), columnsInRow);
        if column == 0
            row = floor(order(i)/columnsInRow);        
            column = size(tab, 2);
        else
            row = floor(order(i)/columnsInRow)+1;
        end
        %tab(rzad, kolumna);
        [oldEnergy, newId] = elementEnergy(row+1, column+1, extended_tab, neighbourhood, tab(row, column));   %s¹siedztwo moorea
        energyTab(row, column) = oldEnergy;
        oldId = tab(row, column);
        tab(row, column) = newId;
        extended_tab = bounds(tab, boundsChoice);
        newEnergy = elementEnergy(row+1, column+1, extended_tab, neighbourhood, tab(row, column));
        deltaE = newEnergy-oldEnergy;
        tab(row, column) = oldId;
        extended_tab = bounds(tab, boundsChoice);
        
        randValue = rand(1, 1);
        if deltaE <= 0
            probability = 1;
        else
            probability = exp(-deltaE/kt);
        end

        if(randValue<=probability)
            tab(row, column) = newId;
            extended_tab = bounds(tab, boundsChoice);
        end
        
    end
    image(energyTab);

end

