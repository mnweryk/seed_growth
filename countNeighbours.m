function neighbours = countNeighbours(row, column, tab, neighbourhood, myValue)
    if neighbourhood == 1
        %Von Neumann
        uppanddown = tab(row-1:2:row+1, column);
        leftandright = tab(row, column-1:2:column+1);
        neighbours = [reshape(uppanddown, 1, 2); leftandright];
    elseif neighbourhood == 2
        %Moore
        uppanddown = tab(row-1:2:row+1, column-1:column+1);
        leftandright = tab(row, column-1:2:column+1);
        neighbours = [uppanddown;leftandright 0];
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
            neighbours = [uppanddown;leftandright 0];
        elseif choice == 2
            uppanddown = tab(row-1:2:row+1, column-1:column);
            leftandright = tab(row, column-1);
            neighbours = [uppanddown;leftandright 0];
        elseif choice == 3
            down = tab(row+1, column-1:column+1);
            leftandright = tab(row, column-1:2:column+1);
            neighbours = [down;leftandright 0];
        else
            up = tab(row-1, column-1:column+1);
            leftandright = tab(row, column-1:2:column+1);
            neighbours = [up;leftandright 0];
        end
    end
    
    %rest
    if myValue == -1     %seeding and growth
        neighbours = neighbours(neighbours~=0);
        if size(neighbours, 1)*size(neighbours, 2) > 0
        neighbours = neighbours(randi(size(neighbours, 2)*size(neighbours,1))) ;
        else
            neighbours = 0;
        end
    elseif myValue == -2    %check if dislocation tab in neighbours is bigger than yours
        neighbours = neighbours(neighbours~=0);
    else                %recrystalization
        neighbours = neighbours(neighbours~=0);
        neighbours = neighbours(neighbours~=myValue);
        if size(neighbours, 1)*size(neighbours, 2) > 0
        neighbours = neighbours(randi(size(neighbours, 2)*size(neighbours,1))) ;
        else
            neighbours = 0;
        end
    end
end

