function [stats_troph,stats_troph2] = get_stats_troph(data_orig2,estimate2,troph_flag)


% estimate = estimate2(find(estimate2<100 & data_orig2<100 & data_orig2>0.01 & estimate2>0.01 & (abs(data_orig2-estimate2)./data_orig2)<1));
% data_orig = data_orig2(find(estimate2<100 & data_orig2<100& data_orig2>0.01 & estimate2>0.01& (abs(data_orig2-estimate2)./data_orig2)<1));
estimate = estimate2(find(estimate2<100 & data_orig2<100 & data_orig2>0.001 & estimate2>0.001) );
data_orig = data_orig2(find(estimate2<100 & data_orig2<100& data_orig2>0.001 & estimate2>0.001));

% outlier = [2,4];
% vid = ones(1,length(estimate));
% vid(outlier)=0;
% vid
if troph_flag.oligo == 1
    perc_oligo = length(find(data_orig(:,1)<=0.1))/(length(data_orig)/100);
    idx_oligo = find(data_orig(:,1)<=0.1);
    
    if length(idx_oligo)>1
        stats_troph.oligo =stats_new(data_orig(idx_oligo),estimate(idx_oligo));
        stats_troph.perc_oligo = perc_oligo;
        stats_troph2(1,:) =stats_new(data_orig(idx_oligo),estimate(idx_oligo));
    else
        stats_troph.oligo = stats_new(1:50,1:50);
        stats_troph.perc_oligo = 0;
        stats_troph2(1,:) =stats_new(1:50,1:50);
    end
else
    stats_troph.oligo = stats_new(1:50,1:50);
    stats_troph.perc_oligo = 0;
    stats_troph2(1,:) =stats_new(1:50,1:50);
end
if troph_flag.meso == 1
    perc_meso = length(find(data_orig(:,1)>0.1 & data_orig(:,1)<=1))/(length(data_orig)/100);
    idx_meso = find(data_orig(:,1)>0.1 & data_orig(:,1)<=1);
    
    if length(idx_meso)>1
        stats_troph.meso =stats_new(data_orig(idx_meso),estimate(idx_meso));
        stats_troph.perc_meso = perc_meso;
        stats_troph2(2,:) =stats_new(data_orig(idx_meso),estimate(idx_meso));
    else
        stats_troph.meso = stats_new(1:50,1:50);
        stats_troph.perc_meso = 0;
        stats_troph2(2,:) =stats_new(1:50,1:50);
    end
else
    stats_troph.meso = stats_new(1:50,1:50);
    stats_troph.perc_meso = 0;
    stats_troph2(2,:) =stats_new(1:50,1:50);
end
if troph_flag.eutro == 1
    perc_eutro = length(find(data_orig(:,1)>1))/(length(data_orig)/100);
    idx_eutro = find(data_orig(:,1)>1);
    
    if length(idx_eutro)>1
        stats_troph.eutro =stats_new(data_orig(idx_eutro),estimate(idx_eutro));
        stats_troph.perc_eutro = perc_eutro;
        stats_troph2(3,:) =stats_new(data_orig(idx_eutro),estimate(idx_eutro));
    else
        stats_troph.eutro = stats_new(1:50,1:50);
        stats_troph.perc_eutro = 0;
        stats_troph2(3,:) =stats_new(1:50,1:50);
    end
else
    stats_troph.eutro = stats_new(1:50,1:50);
    stats_troph.perc_eutro = 0;
    stats_troph2(3,:) =stats_new(1:50,1:50);
    
end
if troph_flag.oligomeso == 1
    perc_oligomeso = length(find(data_orig(:,1)<=1))/(length(data_orig)/100);
    idx_oligomeso = find(data_orig(:,1)<=1);
    
    if length(idx_oligomeso)>1
        stats_troph.perc_oligomeso = perc_oligomeso;
        stats_troph.oligomeso = stats_new(data_orig(idx_oligomeso),estimate(idx_oligomeso));
        stats_troph2(4,:) =stats_new(data_orig(idx_oligomeso),estimate(idx_oligomeso));
    else
        stats_troph.oligomeso = stats_new(1:50,1:50);
        stats_troph.perc_oligomeso = 0;
        stats_troph2(4,:) =stats_new(1:50,1:50);
    end
else
    stats_troph.oligomeso = stats_new(1:50,1:50);
    stats_troph.perc_oligomeso = 0;
    stats_troph2(4,:) =stats_new(1:50,1:50);
end
if troph_flag.huswitch == 1
    perc_huswitch =  length(find(data_orig(:,1)<0.25))/(length(data_orig)/100);
    idx_huswitch = find(data_orig(:,1)<0.25);
    
    if length(idx_huswitch)>1
        stats_troph.perc_huswitch = perc_huswitch;
        stats_troph.huswitch = stats_new(data_orig(idx_huswitch),estimate(idx_huswitch));
        stats_troph2(5,:) =stats_new(data_orig(idx_huswitch),estimate(idx_huswitch));
    else
        stats_troph.huswitch = stats_new(1:50,1:50);
        stats_troph.perc_huswitch = 0;
        stats_troph2(5,:) =stats_new(1:50,1:50);
    end
else
    stats_troph.huswitch = stats_new(1:50,1:50);
    stats_troph.perc_huswitch = 0;
    stats_troph2(5,:) =stats_new(1:50,1:50);
    
end
stats_troph.complete =stats_new(data_orig,estimate);
stats_troph2(6,:) =stats_new(data_orig,estimate);
