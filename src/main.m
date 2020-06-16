clear; clc; close all;

% 0. Preparing data
import DataAccess.*;
fileName = '../data/inputData.mat';
%tmp = DataAccess.convertDataFromCSV('../data/datasets_74977_169835_StudentsPerformance.csv')
%save(fileName, 'tmp');
dao = DataAccess(fileName);

% 1. Test multiple configurations to find best net
import NeuronNetwork.*;
net = NeuronNetwork(dao);
%net.testMutlipleLayersConfigurations([10:20:50]);

% 2. Test performance without some features with best configuration found
% in previous point
net.testNetworkAfterColumnRemoval(["tansig"], 'purelin', [20], ['tansig_purelin_20_without_']);


% 3. Predict exam results based on other exams
%net.testExams(["tansig"], 'purelin', [20], ['cz3_egz']);  

% *** Correlation
% correlation coeffitient - how good linear model can show relation between two columns
% a. between all exams results:
%{
disp(corr(dao.D));

% plots for exams correlation
figure;
title("Zależność pomiędzy wynikami egzaminu 1 i 2");
plot(dao.D(:, 1), dao.D(:, 2), ' *');
xlabel("Egzamin 1");
ylabel("Egzamin 2");
saveas(gca, '../images/korelacja_egzamin12.png');
%}

% b. between exams and input data:
%{
for i = 1:5
    disp(corr([dao.D dao.X(:, i)]));
end
%}
