function diabetesPredictorApp
    % Create the main UI figure window
    fig = uifigure('Name', 'Diabetes Risk Predictor', 'Position', [500 300 350 450]);
    logo = uiimage(fig);
    logo.ImageSource = 'logo.png';
    logo.Position = [120 450 90 90]; % [x y width height]
    logo.ScaleMethod = 'fit'; % keep aspect ratio
    


    fig.Color = [0.95 0.95 0.95];


    % Create input labels and numeric fields with tooltips
    createLabelAndField(fig, 'Glucose (mg/dL):', [20 380 150 22], 'glucoseInput');
    createLabelAndField(fig, 'BMI (kg/m^2):', [20 340 150 22], 'bmiInput');
    createLabelAndField(fig, 'Age (years):', [20 300 150 22], 'ageInput');
    createLabelAndField(fig, 'Diabetes Pedigree Function:', [20 260 150 22], 'dpfInput');
    createLabelAndField(fig, 'Pregnancies (count):', [20 220 150 22], 'pregInput');
    createLabelAndField(fig, 'Blood Pressure (mm Hg):', [20 180 150 22], 'bpInput');

    % Create Predict button
    btn = uibutton(fig, 'push', ...
        'Text', 'Predict', ...
        'Position', [100 120 150 40], ...
        'ButtonPushedFcn', @(btn,event) predictCallback());
    btn.BackgroundColor = [0.2 0.6 0.8]; % nice blue
    btn.FontColor = [1 1 1]; % white text

    % Output Label
    resultLabel = uilabel(fig, ...
        'Position', [20 60 300 40], ...
        'Text', 'Risk: ', ...
        'FontSize', 16, ...
        'FontWeight', 'bold');

    % Helper function to create label + numeric input with tooltips
    function createLabelAndField(parent, labelText, pos, fieldName)
        uilabel(parent, 'Position', pos, 'Text', labelText);
        editField = uieditfield(parent, 'numeric', 'Position', [pos(1)+160 pos(2) 120 22], 'Tag', fieldName);
        
        % Add tooltip for each field
        switch fieldName
            case 'glucoseInput'
                editField.Tooltip = 'Blood glucose level in mg/dL, e.g., 70-180';
            case 'bmiInput'
                editField.Tooltip = 'Body Mass Index in kg/m², typical 15-40';
            case 'ageInput'
                editField.Tooltip = 'Age in years';
            case 'dpfInput'
                editField.Tooltip = 'Diabetes Pedigree Function (genetic risk), range 0-2';
            case 'pregInput'
                editField.Tooltip = 'Number of pregnancies (for women only)';
            case 'bpInput'
                editField.Tooltip = 'Diastolic blood pressure in mm Hg';
        end
    end

    % Callback function executed on Predict button click
    function predictCallback()
        % Get all input fields by their Tag
        Glucose = getFieldValue('glucoseInput');
        BMI = getFieldValue('bmiInput');
        Age = getFieldValue('ageInput');
        DPF = getFieldValue('dpfInput');
        Preg = getFieldValue('pregInput');
        BP = getFieldValue('bpInput');

        % Validate inputs (simple check)
        if any(isnan([Glucose, BMI, Age, DPF, Preg, BP]))
            uialert(fig, 'Please enter all inputs.', 'Input Error');
            return;
        end

        if any([Glucose, BMI, Age, DPF, Preg, BP] < 0)
            uialert(fig, 'Inputs must be non-negative.', 'Input Error');
            return;
        end

        if BMI < 10 || BMI > 60
            uialert(fig, 'BMI should be between 10 and 60.', 'Input Error');
            return;
        end

        % Call your predict function
        outcome = predictDiabetes(Glucose, BMI, Age, DPF, Preg, BP);

        % Show user-friendly output
        if outcome == 1
            riskText = 'High';
            riskColor = [1 0 0]; % red
        else
            riskText = 'Low';
            riskColor = [0 0.5 0]; % dark green
        end
        resultLabel.Text = ['Risk: ', riskText];
        resultLabel.FontColor = riskColor;
    end

    % Helper function to get input field value by Tag
    function val = getFieldValue(tagName)
        val = NaN; % default invalid
        fields = findall(fig, 'Tag', tagName);
        if ~isempty(fields)
            val = fields.Value;
        end
    end
end
