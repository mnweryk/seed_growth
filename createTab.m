function tab = createTab(old_tab, choice,colors, rows, columns)
    tab = zeros(rows, columns);
    if rows*columns < colors
        colors = rows*columns;
    end
    
    
    switch choice
        %rand
        case 1
            for i=2:colors+1
                row = randi(rows);
                column = randi(columns); 
                while(tab(row, column) ~= 0)
                    row = randi(rows);
                    column = randi(columns);
                end
                tab(row, column) = i;
            end
            
        %equal spaced
        case 2
            inrow = colors(1);
            incolumn = colors(2);
            col = round(linspace(1, size(tab, 2), inrow));
            row = round(linspace(1, size(tab, 1), incolumn));
            
            tab(row, col) = randi(10, 1, 1);
            [x, y] = find(tab~=0);
            for i=1:size(x, 1)
                tab(x(i), y(i)) = randi(100);
            end
            
            
        %radius spaced
        case 3
            color = colors(1);
            radius = colors(2);
            [row, column] = meshgrid(1:size(tab, 1), 1:size(tab, 2));
            
            %first point
            x0 = randi(columns, 1);
            y0 = randi(rows, 1);
            tab(x0, y0) = 2;
            
            circlePixels = (row-y0).^2+(column-x0).^2 <= radius.^2;            
            [xci, yci] = find(circlePixels);
            for i=1:size(xci, 1)
                if(tab(xci(i),yci(i)) == 0)
                    tab(xci(i), yci(i)) = -1;
                end
            end
            
            %next points
            for i=3:color+1
                x0 = randi(columns, 1);
                y0 = randi(rows, 1);
                limit = 10000;
                
                while(tab(x0, y0) ~= 0)            %zrobiæ jakiœ limit
                    x0 = randi(columns, 1);
                    y0 = randi(rows, 1);
                    limit = limit -1;
                    
                    if (limit == 0)
                        tab = errorTab();
                        return
                    end
     
                end
                
                tab(x0, y0) = i;
                
                circlePixels = (row-y0).^2+(column-x0).^2 <= radius.^2;
                [xci, yci] = find(circlePixels);
                for j=1:size(xci, 1)
                    if(tab(xci(j), yci(j)) == 0)
                        tab(xci(j), yci(j)) = -1;
                    end
                end
            end
            
            %zero when -1
            tab(tab==-1) = 0; 
                  
        
        %manual
        case 4 
            tab = old_tab;
            map = colormapCreating(1000);
            fig = figure;
            a = axes(fig);
            a.Units = 'pixels';
            a.Position =  [10 10 410 410];
            set(gca,'XLim',[1 columns], 'YLim',[1 rows]);
            imshow(tab, 'Parent', gca, 'InitialMagnification','fit', 'Colormap', map);
            button = uicontrol('Style', 'pushButton','String', 'Almost there!', 'Position', [460 250 90 50]);
            button.Callback = @state
            inputflag = 1;
            
            while inputflag == 1
                
                x = -1;
                y = -1;
                while x < 1 || y<1 || x>rows || y>columns                     
                    [y, x] = ginput(1);
                end
                x = uint8(x);
                y = uint8(y);
                if tab(x, y) == 0
                    tab(x, y) = randi(100);
                else
                    tab(x,y) = 0;
                end
                imshow(tab, 'Parent', gca, 'InitialMagnification','fit', 'Colormap', map);
            
            end
            tab
            close(fig)
    end
    
                function state(src,event)
                    inputflag=0;
                    
                end

   
    end
    
                

