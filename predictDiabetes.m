function outcome = predictDiabetes(Glucose, BMI, Age, DiabetesPedigreeFunction, Pregnancies, BloodPressure)
    if Glucose <= 127
        if BMI <= 26.4
            outcome = 0;
        else
            if Age <= 28
                outcome = 0;
            else
                if Glucose <= 99
                    outcome = 0;
                else
                    if DiabetesPedigreeFunction <= 0.56
                        outcome = 0;
                    else
                        if Pregnancies <= 6
                            if Age <= 30
                                outcome = 1;
                            else
                                if Age <= 34
                                    outcome = 0;
                                else
                                    if BMI <= 33.1
                                        outcome = 1;
                                    else
                                        outcome = 0;
                                    end
                                end
                            end
                        else
                            outcome = 1;
                        end
                    end
                end
            end
        end
    else
        if BMI <= 29.9
            if Glucose <= 145
                outcome = 0;
            else
                if Age <= 25
                    outcome = 0;
                else
                    if Age <= 61
                        if BMI <= 27.1
                            outcome = 1;
                        else
                            if BloodPressure <= 82
                                if DiabetesPedigreeFunction <= 0.396
                                    outcome = 1;
                                else
                                    outcome = 0;
                                end
                            else
                                outcome = 0;
                            end
                        end
                    else
                        outcome = 0;
                    end
                end
            end
        else
            if Glucose <= 157
                if BloodPressure <= 61
                    outcome = 1;
                else
                    if Age <= 30
                        outcome = 0;
                    else
                        outcome = 1;
                    end
                end
            else
                outcome = 1;
            end
        end
    end
end
