function settingsStruct = readFigureSettingsFile(filename)
    % Initialize an empty struct
    settingsStruct = struct();
    
    % Open the file for reading
    fid = fopen(filename, 'r');
    if fid == -1
        error('Cannot open the file.');
    end
    
    % Read each line of the file
    while ~feof(fid)
        line = fgetl(fid);
        if ischar(line)
            % Split the line by space
            tokens = strsplit(line, ' ');
            if length(tokens) == 2
                % Assign the value to the struct field
                fieldName = tokens{1};
                fieldValue = tokens{2};
                
                % Convert numeric values from string to double
                if ~isnan(str2double(fieldValue))
                    fieldValue = str2double(fieldValue);
                end
                
                % Assign the value to the struct
                settingsStruct.(fieldName) = fieldValue;
            end
        end
    end
    
    % Close the file
    fclose(fid);
end
