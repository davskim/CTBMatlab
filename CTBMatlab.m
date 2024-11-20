%% New and improved Capture the breaker seeder

%% read in CSV of entrants
allCompsCell = readcell('ctb2024.csv');
allCompsCell = allCompsCell(2:end,:);
competitors = allCompsCell(:,1);
meanscoresPre = mean(cell2mat(allCompsCell(:,2:4)),2);
%% Normalize the scores
zscoredComps = cell2mat(allCompsCell(:,2:4));
zscoredComps = zscore(zscoredComps,1);

%checking if normal
figure;
qqplot([zscoredComps(:,1);zscoredComps(:,2);zscoredComps(:,3)]);
title('Post Normalization Aggregate')
figure;
qqplot(cell2mat([allCompsCell(:,2);allCompsCell(:,3);allCompsCell(:,4)]));
title('Pre Normalization Aggregate')
%% Calculate the mean
meanscores = mean(zscoredComps,2);

%% Sort based on scores

[sortScores, perm] = sort(meanscores,'descend');
sortnames = competitors(perm);

%% Hasty clustering based on rounding zscores (TODO: Sweeping Kmeans clustering)
% Randomizing within each integer bracket to treat "equivalent bboys"
multScores = sortScores * 4;
top32 = floor(multScores(1:32));
top32names = sortnames(1:32);
shuffedScores = multScores(1:32);

for i = min(top32):max(top32)
    shuffDex = top32==i;
    shuffnames = top32names(shuffDex);
    shuffscores = multScores(shuffDex);
    permutatrix = randperm(length(shuffnames));
    shuffnames = shuffnames(permutatrix);
    shuffscores = shuffscores(permutatrix);
    top32names(shuffDex) = shuffnames;
    shuffedScores(shuffDex) = shuffscores;
end


visags = [top32names,num2cell(top32),num2cell(shuffedScores)];
visagsall = [sortnames,num2cell(floor(multScores)),num2cell(multScores)];

%% Creating the bracket now
fid = fopen('bracket.txt','w');
fprintf(fid,[top32names{23}, ' and ', top32names{19}])
fprintf(fid,'\nvs\n')
fprintf(fid,[top32names{2}, ' and ', top32names{31}])
fprintf(fid,'\n\n')

fprintf(fid,[top32names{26}, ' and ', top32names{11}])
fprintf(fid,'\nvs\n')
fprintf(fid,[top32names{15}, ' and ', top32names{12}])
fprintf(fid,'\n\n')

fprintf(fid,[top32names{22}, ' and ', top32names{18}])
fprintf(fid,'\nvs\n')
fprintf(fid,[top32names{30}, ' and ', top32names{3}])
fprintf(fid,'\n\n')

fprintf(fid,[top32names{28}, ' and ', top32names{5}])
fprintf(fid,'\nvs\n')
fprintf(fid,[top32names{10}, ' and ', top32names{7}])
fprintf(fid,'\n\n')

fprintf(fid,[top32names{16}, ' and ', top32names{14}])
fprintf(fid,'\nvs\n')
fprintf(fid,[top32names{13}, ' and ', top32names{25}])
fprintf(fid,'\n\n')

fprintf(fid,[top32names{1}, ' and ', top32names{32}])
fprintf(fid,'\nvs\n')
fprintf(fid,[top32names{20}, ' and ', top32names{24}])
fprintf(fid,'\n\n')

fprintf(fid,[top32names{21}, ' and ', top32names{17}])
fprintf(fid,'\nvs\n')
fprintf(fid,[top32names{4}, ' and ', top32names{29}])
fprintf(fid,'\n\n')

fprintf(fid,[top32names{9}, ' and ', top32names{8}])
fprintf(fid,'\nvs\n')
fprintf(fid,[top32names{6}, ' and ', top32names{27}])
fprintf(fid,'\n\n')