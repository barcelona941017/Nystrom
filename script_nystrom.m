function script_nystrom(dataset)
%SCRIPT Run Spectral clustering using the Nystrom method with different
%   parameter settings. Two data sets are used for experiments.
%
%   Input  : dataset : data set number, 1 = Corel, 2 = RCV1
%
%   Output : average and standard deviation of
%            - normalized mutual information (NMI)
%            - evd_time
%            - kmeans_time
%            - total_time

%
% Parameter settings for selected data set
%

        
dataset = 4;
if dataset == 1 % Corel
  sample_num_array = [20 50 100 200 500 1000 1500 2000];
  sigma = 20;
  num_clusters = 18;
  disp('Reading data...');
  load('data/corel_feature.mat', 'feature');
  load('data/corel_label.mat', 'label');
elseif dataset == 2 % RCV1
  sample_num_array = [200 500 800 1000 1500 2000 2500 3000 3500];
  sigma = 2;
  num_clusters = 103;
  disp('Reading data...');
  load('data/rcv_feature.mat', 'feature');
  load('data/rcv_label.mat', 'label');
end
if dataset == 3
    sample_num_array = [20 50 100 200 500 1000 1500 2000];
    sample_num_array = 20;
    sigma = 50;
    num_clusters = 2;
    load('数据集/数据mat文件/wine.mat','source_data');
    feature = source_data;
    load('数据集/标签mat文件/wine_label.mat', 'label');
    label = label;
end
if dataset == 4
    sample_num_array = [20 50 100 200 500 1000 1500 2000];
    sample_num_array = 600;
    sigma = 40;
    num_clusters = 5;
    I = imread('D:\学习\学术\快速谱聚类算法的研究\MFSC\MFSC_Apply_Dataset\MatlabAndCpp\图像集\color_img\b17paul1444.png');
    %I = medfilt3_diy(I,[3,3]);
    [data,img_r,img_c] = NormalizedImg(I);
    feature = data;
end

%
% Main program
%
for j = 1:size(sample_num_array, 2)
  num_samples = sample_num_array(1, j);
  disp(['Number of random samples: ', num2str(num_samples)]);
  
  [cluster_labels evd_time kmeans_time total_time] = nystrom(feature, num_samples, sigma, num_clusters);
  total_time
  
  cluster_labels = reshape(cluster_labels,img_r,img_c);
  showSegLabel = (255/num_clusters) * cluster_labels;
     showSegLabel = uint8(showSegLabel);
     figure(11),
     imshow(showSegLabel);
  imwrite(showSegLabel,'C:\Users\Administrator\Desktop\分割结果\gray.png')
  
  segmentType = 2;
  label_filename = 'D:\学习\数据集\2obj\b17paul1444\human_seg\b17paul1444_3.png';
  [ACC,RI,DICE] = showACCandSaveRes(I,cluster_labels,label_filename,segmentType,num_clusters);
  
  
  
  
  for i = 1:10 % Average over 10 runs
    disp(['Iter: ', num2str(i)]);
    [cluster_labels evd_time kmeans_time total_time] = nystrom(feature, num_samples, sigma, num_clusters);
    nmi_score = nmi(label, cluster_labels) % Calculate NMI
    accuracy_score = accuracy(label, cluster_labels) % Calculate accuracy

    all_nmi(i, j) = nmi_score;
    all_accuracy(i, j) = accuracy_score;
    all_evd_time(i, j) = evd_time;
    all_kmeans_time(i, j) = kmeans_time;
    all_total_time(i, j) = total_time;
  end

  % Output the (average/std) results to stdout
  avg_nmi = mean(all_nmi, 1)
  std_nmi = std(all_nmi, 0, 1)
  avg_accuracy = mean(all_accuracy, 1)
  std_accuracy = std(all_accuracy, 0, 1)
  avg_evd_time = mean(all_evd_time, 1)
  std_evd_time = std(all_evd_time, 0, 1)
  avg_kmeans_time = mean(all_kmeans_time, 1)
  std_kmeans_time = std(all_kmeans_time, 0, 1)
  avg_total_time = mean(all_total_time, 1)
  std_total_time = std(all_total_time, 0, 1)
end
