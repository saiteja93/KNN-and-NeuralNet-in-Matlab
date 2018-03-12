%Load data
InputDirectoryPath = uigetdir('select file path');
X_train = importdata(strcat(InputDirectoryPath,'\X_train.mat'));
y_train = importdata(strcat(InputDirectoryPath,'\y_train.mat'));
X_test = importdata(strcat(InputDirectoryPath,'\X_test.mat'));
y_test = importdata(strcat(InputDirectoryPath,'\y_test.mat'));
y_train = full(ind2vec(y_train));
%create and train the network
net= patternnet(25);
net = train(net,X_train',y_train);
%test network on test data
y = net(X_test');
y= vec2ind(y);
%calculate accuracy
cnt =0;
for i =1:1000
    if y(i)== y_test(i)
        cnt = cnt +1;
    end
end
fprintf('Accuracy = %2.2f%%\n',cnt*100/i);