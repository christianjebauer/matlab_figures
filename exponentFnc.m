function exponentFnc(figure, ax, settings, exponentValue)
%exponentFnc Replaces the exponents in a figure by annotations
%   The "x" in the exponents is replaced by a dot

    % delete(findall(figure,'type','annotation'));

    ax.XAxis.SecondaryLabel.Visible = 'off'; 
    ax.YAxis.SecondaryLabel.Visible = 'off'; 
    ax.ZAxis.SecondaryLabel.Visible = 'off'; 
    
    tightPos = tightPosition(ax);
    exponentStartPositions = [tightPos(1,1) + tightPos(1,3), tightPos(1,2);
                              tightPos(1,1), tightPos(1,2) + tightPos(1,4);
                              1, 1]; % ToDo

    for index = 1:length(exponentValue)
        if exponentValue(index) ~= 0
            an = annotation('textbox', [exponentStartPositions(index, 1) * settings.expFactor(index,1), ...
                    exponentStartPositions(index, 2) * settings.expFactor(index,2), 0.1, 0.1], ...
                'String', ['\cdot10^{', num2str(exponentValue(index)), '}'], 'EdgeColor', 'none', ...
                'FontName', settings.font, 'FontSize', settings.fontSize);
            if ax.TickLabelInterpreter == "latex"
                an.Interpreter = 'latex';
                an.String = strcat("$$", an.String, "$$");
            end
        end
    end
end

