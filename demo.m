data = imread_ncut('jpg_images/5.bmp',128,128);
data = reshape(data,128*128,1);
% data_struct = load('C:\Users\Administrator\Desktop\学习\学术\快速谱聚类算法的研究\实验代码处理数据集\2Moons_v2.mat');
% data = data_struct.xt;
% data = data';
%data = csvread('C:\Users\Administrator\Desktop\SpiralData_Clean_Spread.csv');
%data = data(:,1:2)';
%data = x;
% figure(1);clf;
% plot(data(1,:),data(2,:),'ks', 'MarkerFaceColor','k','MarkerSize',5); axis image; hold on; 
% data =data';
% num_samples = 100;
sigma = 0.5;
num_clusters = 4;
%[cluster_labels evd_time kmeans_time total_time] = nystrom(data, num_samples, sigma, num_clusters);
num_neighbors = 10;
block_size = 10;
save_type = 0;
gen_nn_distance(data, num_neighbors, block_size, save_type)
[cluster_labels evd_time kmeans_time total_time] = sc(A, sigma, num_clusters);

cluster_color = ['rgbmyc'];
figure(2);clf;
data = data';
for j=1:num_clusters,
    id = find(cluster_labels == j);
    plot(data(1,id),data(2,id),[cluster_color(j),'s'], 'MarkerFaceColor',cluster_color(j),'MarkerSize',5); hold on; 
end
hold off; axis image;
disp('This is the clustering result');
disp('The demo is finished.');
