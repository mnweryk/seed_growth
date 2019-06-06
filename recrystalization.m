function recrystalizationTab = recrystalization(timeStep, lastTime, tab, x, boundsChoice, neighbourhood)
    A = 86710969050178.5;
    B = 9.41268203527779;
    
    %here was drawing in prototype
    
    %declaration
    dislocationTab = zeros(size(tab));
    recrystalizationTab = zeros(size(tab));
    
    times = timeStep:timeStep:lastTime;
    
    ro = A/B + (1- A/B)*exp(1).^(-B*times);
    deltaRo = diff(ro);
    extended_tab = bounds(tab, boundsChoice);
    criticalDislocationValue = 4.21584e12/(size(tab, 1)*size(tab, 2));

    %Average dislocation value
    averageDislocation = (deltaRo/(size(tab, 1)*size(tab, 2)));
    forEveryCell = x*0.01*averageDislocation;
    restOfForEveryCell = (1-(x*0.01))*deltaRo;
    
    for i=1:size(deltaRo, 2)
        %dislocation gun
        dislocationTab = dislocationTab + forEveryCell(i);
        %rozrzut pozosta³ej puli
        while(restOfForEveryCell(i)>0)
            precent =(rand()+randi([5, 10]))/20;
            row = randi(size(tab, 1));
            column = randi(size(tab, 2));
            %precent*restOfForEveryCell
            if restOfForEveryCell(i)-precent*restOfForEveryCell(i)>0
                dislocationTab(row, column) = dislocationTab(row, column) + precent*restOfForEveryCell(i);
                restOfForEveryCell(i) = restOfForEveryCell(i)-precent*restOfForEveryCell(i);
            else
                dislocationTab(row, column) = dislocationTab(row, column) + restOfForEveryCell(i);
                restOfForEveryCell(i) = 0;
            end
        end

        %check if dislocation value exceeded
        [row, column] = find(dislocationTab>criticalDislocationValue);
        for j=1:size(row, 1)
            %[row(j), column(j), countNeighbours(row(j)+1, column(j)+1, extended_tab, neighbourhood, tab(row, column))]
            if countNeighbours(row(j)+1, column(j)+1, extended_tab, neighbourhood, tab(row(j), column(j)))~=0
                recrystalizationTab(row(j), column(j)) = -2;
                dislocationTab(row(j), column(j)) = 0;
            end
        end

        %second condition
        for row=1:size(tab, 1)
            for column = 1:size(tab, 2)
                neighbours = countNeighbours(row+1,column+1, bounds(recrystalizationTab, boundsChoice), neighbourhood, -2);

                if ~isempty(find(neighbours==-1))
                    if ~isempty(find(countNeighbours(row+1, column+1, bounds(dislocationTab,boundsChoice), neighbourhood, -2)>dislocationTab(row, column)))
                        recrystalizationTab(row, column) = -2               
                    end
                end
            end
        end


        %drawing
        figure;
        recrystalizationTab(recrystalizationTab==-1)=-10;
        recrystalizationTab(recrystalizationTab==-2) = -1;  %¿eby by³y w nastêpnym kroku czasowym
        %if dislocation is 0, cell is tab value
        recrystalizationTab(recrystalizationTab==0) = tab(recrystalizationTab==0);
        image(recrystalizationTab);
        colormap(colormapCreating(100));



    end

    
end

