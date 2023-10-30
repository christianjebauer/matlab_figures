%% Sets the font of a plot
function setFont
    ax = gca;
    grid on;
    ax.LabelFontSizeMultiplier = 1;
    ax.TitleFontSizeMultiplier = 1;
    ax.FontSizeMode = 'manual';
    ax.FontSize = 9;
    ax.FontName = 'CMU Serif'; % Use listfonts to see all available fonts
end
