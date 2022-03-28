clear all 
close all

pathlandm = 'C:\Users\Jip\Documents\Studie\Medical Imaging\Team challenge\Part 2\Landmarks\';
parameters_preop = [];
parameters_postop = [];

%%store all parameters of 1 slice in array
for i= 1:7
    if i == 6
        lm_nr = 7;
    elseif i == 7
        lm_nr = 9;
    else 
        lm_nr = i;
    end
    namelandm_pre = strcat(num2str(lm_nr), 'preop.xml');
    parameters_preop(i,:) = get_parameters(pathlandm, namelandm_pre);
    namelandm_post = strcat(num2str(lm_nr), 'postop.xml');
    parameters_postop(i,:) = get_parameters(pathlandm, namelandm_post);
end      

%%linear regression model
par_names = ["rhi_", "hwr_", "ehr_", "chest_tors_"];
for j = 1: length(parameters_postop(1, :))
        %select parameter to predict 
        pm_to_predict = parameters_postop(:,j);
        %fit model
        model = fitlm(parameters_preop, pm_to_predict, 'linear' );
        model_name = strcat('predictions\lin_regression_model_', par_names(j), 'init_slice' );
        save(model_name, "model")
end

%%LASSO model
for j = 1: length(parameters_postop(1, :))
        %select parameter to predict 
        pm_to_predict = parameters_postop(:,j);
        %fit model
        [fit, model] = lasso(parameters_preop, pm_to_predict, Alpha=0.5);
        model_name = strcat('predictions\lasso_regression_model_', par_names(j), 'init_slice' );
        lambda = model.Lambda;
        save(model_name, "fit", "lambda")
end
