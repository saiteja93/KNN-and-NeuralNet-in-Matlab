% load datasets
InputDirectoryPath = uigetdir('select file path');
X_train = importdata(strcat(InputDirectoryPath,'\X_train.txt'));
y_train = importdata(strcat(InputDirectoryPath,'\y_train.txt'));
X_test = importdata(strcat(InputDirectoryPath,'\X_test.txt'));
y_test = importdata(strcat(InputDirectoryPath,'\y_test.txt'));
y_train = y_train';
k = 7;
%Cll Knn function to test the data on training data
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