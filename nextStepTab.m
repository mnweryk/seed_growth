function [next_tab, completed] = nextStepTab(extended_tab, neighbourhood)
    [sh1, sh2] = size(extended_tab);
    next_tab = zeros(sh1-2, sh2-2);
    completed = 1;
    for row=2:sh1-1
        for column=2:sh2-1
            neighbours = countNeighbours(row, column, extended_tab, neighbourhood, -1);
            if extended_tab(row, column) == 0
                if neighbours == 0
                    completed = -1;
                end                    
                next_tab(row-1, column-1) = neighbours;
            else
                next_tab(row-1, column-1) = extended_tab(row, column);
            end
        end
    end
end

