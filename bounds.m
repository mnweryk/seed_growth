function new_tab = bounds(tab, choice)
    new_tab = zeros(size(tab, 1)+2, size(tab, 2)+2);
    new_tab(2:size(new_tab, 1)-1, 2:size(new_tab, 2)-1) = tab;      %copying tab into new_tab
    
    if choice == 1                                          %periodic
        
        new_tab(:,1) = new_tab(:, end-1);                   %left column
        new_tab(:, end) = new_tab(:, 2);                    %right column
        new_tab(1, :) = new_tab(end-1, :);
        new_tab(end,:) = new_tab(2,:);
    
    elseif choice == 2
        
        new_tab(:, [1 end]) = 0;
        new_tab([1, end], :) = 0;
    end
end