function [energy, newId]  = elementEnergy(row, column, tab, neighbourhood, myValue)
%row = row+1;
%column = column+1;
    if neighbourhood == 1
        %Von Neumann
        uppanddown = tab(row-1:2:row+1, column);
        leftandright = tab(row, column-1:2:column+1);
        neighbours = [reshape(uppanddown, 1, 2); leftandright];
    elseif neighbourhood == 2
        %Moore
        uppanddown = tab(row-1:2:row+1, column-1:column+1);
        leftandright = tab(row, column-1:2:column+1);
        neighbours = [uppanddown;leftandright myValue];
        %Hexangonal
    elseif neighbourhood == 31
        uppanddown = tab(row-1:2:row+1, column-1:column+1);
        leftandright = tab(row, column-1:2:column+1);
        up = uppanddown(1, 2:end);
        down = uppanddown(2, 1:end-1);
        uppanddown = [up, down];
        neighbours = [uppanddown leftandright];
    elseif neighbourhood == 32
        uppanddown = tab(row-1:2:row+1, column-1:column+1);
        leftandright = tab(row, column-1:2:column+1);
        up = uppanddown(1, 1:end-1);
        down = uppanddown(2, 2:end);
        uppanddown = [up down];
        neighbours = [uppanddown leftandright];
    elseif neighbourhood == 33
        choice = randi(2, 1, 1);
        if choice == 1
            uppanddown = tab(row-1:2:row+1, column-1:column+1);
            leftandright = tab(row, column-1:2:column+1);
            up = uppanddown(1, 2:end);
            down = uppanddown(2, 1:end-1);
            uppanddown = [up, down];
            neighbours = [uppanddown leftandright];
        else
            uppanddown = tab(row-1:2:row+1, column-1:column+1);
            leftandright = tab(row, column-1:2:column+1);
            up = uppanddown(1, 1:end-1);
            down = uppanddown(2, 2:end);
            uppanddown = [up down];
            neighbours = [uppanddown leftandright];
        end
    elseif neighbourhood == 4
        choice = randi([1, 4], 1, 1);
        if choice == 1
            uppanddown = tab(row-1:2:row+1, column:column+1);
            leftandright = tab(row, column+1);
            neighbours = [uppanddown;leftandright myValue];
        elseif choice == 2
            uppanddown = tab(row-1:2:row+1, column-1:column);
            leftandright = tab(row, column-1);
            neighbours = [uppanddown;leftandright myValue];
        elseif choice == 3
            down = tab(row+1, column-1:column+1);
            leftandright = tab(row, column-1:2:column+1);
            neighbours = [down;leftandright myValue];
        else
            up = tab(row-1, column-1:column+1);
            leftandright = tab(row, column-1:2:column+1);
            neighbours = [up;leftandright myValue];
        end
    end
    
    
    
    %rest
    
    energy = numel(neighbours(neighbours~=myValue));
    neighbours = reshape(neighbours, 1, size(neighbours, 1)*size(neighbours, 2));
    %neighbours(neighbours==myValue) = [];   %do not change id into my value
    if(~isempty(neighbours))
        newId = neighbours(randi(length(neighbours))) ; 
    else
        newId = myValue;    
    end
end

