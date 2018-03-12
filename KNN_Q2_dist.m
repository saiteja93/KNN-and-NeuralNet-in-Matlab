%Load input data
InputDirectoryPath = uigetdir('select file path');
X_train = importdata(strcat(InputDirectoryPath,'\X_train.mat'));
y_train = importdata(strcat(InputDirectoryPath,'\y_train.mat'));
X_test = importdata(strcat(InputDirectoryPath,'\X_test.mat'));
y_test = importdata(strcat(InputDirectoryPath,'\y_test.mat'));
k = 7;
% distances are stored in 'distanes' matrix
distance = zeros(size(X_train,1),size(X_test,1));
%Classifications of test data are stored in 'classified'
classified = zeros(size(X_test,1),1);
knn = zeros(k,size(X_test,1)); 
%Iterate for each test item
for i = 1 : size(X_test,1)
    %iteration to find nearest neighbors to an test item
   for j = 1 : size (X_train,1)
       sumsq = 0;
       for p = 1: size(X_test,2)
           sumsq = sumsq + (X_test(i,p)- X_train(j,p))^2;
       end
        distance(j,i) = sqrt(sumsq);
   end
    %sort the distance matrix
    b = sort(distance(:,i));
    %take (k+1)st element and find all below that
    %if k=7 then all distances below 8th element in sorted array are
    %extracted from distances matrix
    x = b(k+1,1);
    [I,J] = find(distance(:,i)<x);
    for k = 1 : length(I)
        knn(k,i) = y_train(1,I(k));
    end    
    %classify using mode function
    classified(i,1) = mode(knn(:,i));
end
%find accuracy
  y = y_test(:);
  count = 0;
  for i = 1 : length(classified)
      if(classified(i,1) == y(i,1))
          count = count+1;
      end
  end
  accuracy = (count/length(classified))*100;
  fprintf('Accuracy = %2.2f%%\n',accuracy);