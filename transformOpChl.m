function chl_tran = transformOpChl(ChlMod,mean_train,std_train,Maxlogtrain,Minlogtrain)
% 
chllog1 = std_train.*ChlMod + mean_train;
chllog = (1./chllog1) + Minlogtrain - Maxlogtrain;
chl_tran = 10.^chllog;

% mean_test = mean(ChlMod);
% std_test = std(ChlMod);
% chllog1 = std_test.*ChlMod + mean_test;

% Maxlogtest = max(chllog1);
% Minlogtest = min(chllog1);
% chllog = (1./chllog1) + Minlogtest - Maxlogtest;
% chl_tran = 10.^chllog;