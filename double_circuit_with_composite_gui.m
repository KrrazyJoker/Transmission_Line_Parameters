function double_circuit_gui()

    % Create a figure
    fig = figure('Name', 'Double Circuit Calculator', 'Position', [100, 100, 400, 350], 'NumberTitle', 'off', 'MenuBar', 'none', 'ToolBar', 'none');

    % Create UI components
    uicontrol('Style', 'text', 'String', 'Distance a-a*: ', 'Position', [20, 280, 120, 20]);
    edit_d1 = uicontrol('Style', 'edit', 'Position', [150, 280, 100, 20]);

    uicontrol('Style', 'text', 'String', 'Distance b-b*: ', 'Position', [20, 240, 120, 20]);
    edit_d2 = uicontrol('Style', 'edit', 'Position', [150, 240, 100, 20]);

    uicontrol('Style', 'text', 'String', 'Distance c-c*: ', 'Position', [20, 200, 120, 20]);
    edit_d3 = uicontrol('Style', 'edit', 'Position', [150, 200, 100, 20]);

    uicontrol('Style', 'text', 'String', 'Vertical Distance a-b: ', 'Position', [20, 160, 120, 20]);
    edit_h1 = uicontrol('Style', 'edit', 'Position', [150, 160, 100, 20]);

    uicontrol('Style', 'text', 'String', 'Vertical Distance b-c: ', 'Position', [20, 120, 120, 20]);
    edit_h2 = uicontrol('Style', 'edit', 'Position', [150, 120, 100, 20]);

    uicontrol('Style', 'text', 'String', 'Vertical Distance c-a: ', 'Position', [20, 80, 120, 20]);
    edit_h3 = uicontrol('Style', 'edit', 'Position', [150, 80, 100, 20]);

    uicontrol('Style', 'text', 'String', 'Select ACSR code: ', 'Position', [20, 40, 120, 20]);
    acsr_codes = {'warving', 'drake', 'dove', 'ostrich', 'rail', 'pheasant'};
    popup_acsr = uicontrol('Style', 'popupmenu', 'String', acsr_codes, 'Position', [150, 40, 100, 20]);

    btn_calculate = uicontrol('Style', 'pushbutton', 'String', 'Calculate', 'Position', [280, 200, 80, 30], 'Callback', @calculate_callback);

    % Add static text boxes for results
    uicontrol('Style', 'text', 'String', 'Inductance Results', 'Position', [20, 220, 150, 20]);
    uicontrol('Style', 'text', 'String', 'Deq:', 'Position', [20, 190, 100, 20]);
    uicontrol('Style', 'text', 'String', 'Ds:', 'Position', [20, 160, 100, 20]);
    uicontrol('Style', 'text', 'String', 'L:', 'Position', [20, 130, 100, 20]);

    uicontrol('Style', 'text', 'String', 'Capacitance Results', 'Position', [250, 220, 150, 20]);
    uicontrol('Style', 'text', 'String', 'Deq:', 'Position', [250, 190, 100, 20]);
    uicontrol('Style', 'text', 'String', 'Dsc:', 'Position', [250, 160, 100, 20]);
    uicontrol('Style', 'text', 'String', 'C:', 'Position', [250, 130, 100, 20]);
    % Callback function for the Calculate button
    function calculate_callback(~, ~)
        % Get input values
        d1 = str2double(get(edit_d1, 'String'));
        d2 = str2double(get(edit_d2, 'String'));
        d3 = str2double(get(edit_d3, 'String'));
        h1 = str2double(get(edit_h1, 'String'));
        h2 = str2double(get(edit_h2, 'String'));
        h3 = str2double(get(edit_h3, 'String'));
        acsr_index = get(popup_acsr, 'Value');
        acsr_code = acsr_codes{acsr_index};

      % Perform calculations
        [rL, rC] = radii(acsr_code);

        if (d1 == d2 && d2 == d3)
            dab = power((h1^2)*(h1^2 + d2^2), 1/4);
            dbc = dab;
            dac = power((h3^2)*d2^2, 1/4);
        else
            dab = power(sqrt(h1^2 + ((d1 - d2)/2)^2) * sqrt(h1^2 + ((d2 - d3)/2)^2) * sqrt(h1^2 + (d1 - (d1 - d2)/2)^2) * sqrt(h1^2 + (d2 - (d2 - d3)/2)^2), 1/4);
            dbc = power(sqrt(h2^2 + ((d1 - d2)/2)^2) * sqrt(h2^2 + ((d2 - d3)/2)^2) * sqrt(h2^2 + (d1 - (d1 - d2)/2)^2) * sqrt(h2^2 + (d2 - (d2 - d3)/2)^2), 1/4);
            dac = power(((h3)^2 + ((d1 - d3)/2)^2) * d1 * d3, 1/4);
        end

        Deq = power((dab * dbc * dac), 1/3);
        daa = sqrt((h3 * h3) + (d1 - (d1 - d3))^2);
        dsa = sqrt(rL * daa);
        dsb = sqrt(d2 * rL);
        dcc = sqrt((h3 * h3) + (d3 - (d3 - d1))^2);
        dsc = sqrt(rL * dcc);
        Ds = power((dsa * dsb * dsc), 1/3);
        L = 2 * 10^-7 * log(Deq / Ds);

                % Display results for Inductance
        msgbox(['Deq: ' num2str(Deq) ' [m]'], 'Inductance Results', 'modal');
        msgbox(['Ds: ' num2str(Ds) ' [m]'], 'Inductance Results', 'modal');
        msgbox(['L: ' num2str(L) ' [H/m]'], 'Inductance Results', 'modal');

        % Calculation of Capacitance
        dsca = sqrt(rC * daa);
        dscb = sqrt(rC * d2);
        dscc = sqrt(rC * dcc);
        Dsc = power((dsca * dscb * dscc), 1/3);
        k = 8.85 * 10^-12;
        C = (2 * pi * k) / (log(Deq / Dsc));

        % Display results for Capacitance
        msgbox(['Deq: ' num2str(Deq) ' [m]'], 'Capacitance Results', 'modal');
        msgbox(['Dsc: ' num2str(Dsc) ' [m]'], 'Capacitance Results', 'modal');
        msgbox(['C: ' num2str(C) ' [F/m]'], 'Capacitance Results', 'modal');
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

