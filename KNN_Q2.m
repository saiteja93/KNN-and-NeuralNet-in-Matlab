% load datasets
InputDirectoryPath = uigetdir('select file path');
X_train = importdata(strcat(InputDirectoryPath,'\X_train.mat'));
y_train = importdata(strcat(InputDirectoryPath,'\y_train.mat'));
X_test = importdata(strcat(InputDirectoryPath,'\X_test.mat'));
y_test = importdata(strcat(InputDirectoryPath,'\y_test.mat'));
y_test = y_test';
y_train = y_train';
k = 7;
%Train and predict classes for test data
Mdl = fitcknn(X_train,y_train,'NumNeighbors',k,'NSMethod','exhaustive','Standardize',1);
label = predict(Mdl,X_test);

%Find accuracy by comparing already available classes of test data
cnt =0;
for i =1 :size(label)
    if(label(i) == y_test(i))
        cnt = cnt+1;
    end
end

fprintf('Accuracy = %2.2f%%\n',cnt*100/i);