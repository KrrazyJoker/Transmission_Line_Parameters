function gui_for_double_unbundled_calculator()

    % Create a figure
    fig = figure('Name', 'Double Unbundled Calculator', 'Position', [100, 100, 500, 400], 'NumberTitle', 'off', 'MenuBar', 'none', 'ToolBar', 'none');

    % Create uicontrols
    uicontrol('Style', 'text', 'String', 'Program for Calculation of Inductance and Capacitance of Double un-bundled Circuit (Case-2 & Case-12)', 'Position', [20, 350, 460, 40]);

    uicontrol('Style', 'text', 'String', 'Distance between conductors a and c* (in m):', 'Position', [20, 300, 220, 20]);
    edit_d1 = uicontrol('Style', 'edit', 'Position', [260, 300, 220, 20]);

    uicontrol('Style', 'text', 'String', 'Distance between conductors b and b* (in m):', 'Position', [20, 270, 220, 20]);
    edit_d2 = uicontrol('Style', 'edit', 'Position', [260, 270, 220, 20]);

    uicontrol('Style', 'text', 'String', 'Distance between conductors c and a* (in m):', 'Position', [20, 240, 220, 20]);
    edit_d3 = uicontrol('Style', 'edit', 'Position', [260, 240, 220, 20]);

    uicontrol('Style', 'text', 'String', 'Vertical Distance between conductors a and b (in m):', 'Position', [20, 210, 220, 20]);
    edit_h1 = uicontrol('Style', 'edit', 'Position', [260, 210, 220, 20]);

    uicontrol('Style', 'text', 'String', 'Vertical Distance between conductors b and c (in m):', 'Position', [20, 180, 220, 20]);
    edit_h2 = uicontrol('Style', 'edit', 'Position', [260, 180, 220, 20]);

    uicontrol('Style', 'text', 'String', 'Vertical Distance between conductors c and a (in m):', 'Position', [20, 150, 220, 20]);
    edit_h3 = uicontrol('Style', 'edit', 'Position', [260, 150, 220, 20]);

    uicontrol('Style', 'text', 'String', 'Enter your ACSR code:', 'Position', [20, 120, 220, 20]);
    edit_acsr_code = uicontrol('Style', 'edit', 'Position', [260, 120, 220, 20]);

    btn_calculate = uicontrol('Style', 'pushbutton', 'String', 'Calculate', 'Position', [200, 80, 100, 30], 'Callback', @calculate_callback);

    % Create uicontrols for displaying results
    txt_Deq = uicontrol('Style', 'edit', 'Position', [20, 50, 120, 30], 'Enable', 'off');
    txt_Ds = uicontrol('Style', 'edit', 'Position', [260, 50, 120, 30], 'Enable', 'off');
    txt_L = uicontrol('Style', 'edit', 'Position', [20, 10, 120, 30], 'Enable', 'off');
    txt_C = uicontrol('Style', 'edit', 'Position', [260, 10, 120, 30], 'Enable', 'off');

    % Callback function for the Calculate button
    function calculate_callback(~, ~)
        % Get user inputs
        d1 = str2double(get(edit_d1, 'String'));
        d2 = str2double(get(edit_d2, 'String'));
        d3 = str2double(get(edit_d3, 'String'));
        h1 = str2double(get(edit_h1, 'String'));
        h2 = str2double(get(edit_h2, 'String'));
        h3 = str2double(get(edit_h3, 'String'));
        acsr_code = get(edit_acsr_code, 'String');

        % Call the radii function
        [rL, rC] = radii(acsr_code);

        if (d1 == d2 && d2 == d3)
            dab = power((h1^2) * (h1^2 + d2^2), 1/4);
            dbc = dab;
            dac = power((h3^2) * d2^2, 1/4);
        else
            dab = power(sqrt(h1^2 + ((d1 - d2)/2)^2) * sqrt(h1^2 + ((d2 - d3)/2)^2) * sqrt(h1^2 + (d1 - (d1 - d2)/2)^2) * sqrt(h1^2 + (d2 - (d2 - d3)/2)^2), 1/4);
            dbc = power(sqrt(h2^2 + ((d1 - d2)/2)^2) * sqrt(h2^2 + ((d2 - d3)/2)^2) * sqrt(h2^2 + (d1 - (d1 - d2)/2)^2) * sqrt(h2^2 + (d2 - (d2 - d3)/2)^2), 1/4);
            dac = power(((h3)^2 + ((d1 - d3)/2)^2) * d1 * d3, 1/4);
        end

        Deq = power((dab * dbc * dac), 1/3);
        daa = sqrt((h3^2) + (d1 - (d1 - d3))^2);
        dsa = sqrt(rL * daa);
        dsb = sqrt(d2 * rL);
        dcc = sqrt((h3^2) + (d3 - (d3 - d1))^2);
        dsc = sqrt(rL * dcc);
        Ds = power((dsa * dsb * dsc), 1/3);
        L = 2e-7 * log(Deq/Ds);

        % Display results
        set(txt_Deq, 'String', ['Deq: ' num2str(Deq) ' [m]']);
        set(txt_Ds, 'String', ['Ds: ' num2str(Ds) ' [m]']);
        set(txt_L, 'String', ['Inductance: ' num2str(L) ' [H/m]']);

        % Calculate capacitance
        dsca = sqrt(rC * daa);
        dscb = sqrt(rC * d2);
        dscc = sqrt(rC * dcc);
        Dsc = power((dsca * dscb * dscc), 1/3);
        k = 8.85e-12;
        C = (2 * pi * k) / log(Deq/Dsc);

        % Display capacitance result
        set(txt_C, 'String', ['Capacitance: ' num2str(C) ' [F/m]']);
    end

end

% Radii function
function [rL, rC] = radii(x)
    switch x
        case {'warving', 'WARVING', 'Warving'}
            rL = 0.3831;
            rC = 0.609;
        case {'drake', 'DRAKE', 'Drake'}
            rL = 0.01143;
            rC = 0.014;
        case {'dove', 'DOVE', 'Dove'}
            rL = 0.0314;
            rC = 0.927;
        case {'ostrich', 'Ostrich', 'OSTRICH'}
            rL = 0.00697;
            rC = 0.008636;
        case {'rail', 'RAIL', 'Rail'}
            rL = 0.0386;
            rC = 1.165;
        case {'pheasant', 'PHEASANT', 'Pheasant'}
            rL = 0.01417;
            rC = 0.01762;
    end
end
