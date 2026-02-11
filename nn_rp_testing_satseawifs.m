load('finalrpnet.mat')
load('only_nets_nn_hyp_5050.mat');clear net_lm_loop min_col min_row
load('OC4_OCI_satswifs6w.mat')
load('svm_default_gauss_model_trained.mat')
troph_flag.oligo = 1;
troph_flag.meso = 1;
troph_flag.eutro = 1;
troph_flag.oligomeso = 1;
troph_flag.huswitch = 1;

idx_oligo = find(TestChl<=0.1);
idx_meso = find(TestChl>0.1 & TestChl<=1);
idx_eutro = find(TestChl>1);


test_data0 = SeawifsmatchpupRrs;
Rrs443_test = test_data0(:,2);
Rrs490_test = test_data0(:,3);
Rrs555_test = test_data0(:,5);
Rrs670_test = test_data0(:,6);

test_data_c1 = (Rrs490_test - Rrs443_test)./(490 - 443);
test_data_c2 = (Rrs555_test - Rrs490_test)./(555 - 490);
test_data_c3 = Rrs555_test - ((Rrs670_test - Rrs443_test)).*((555 - 443)/(670 - 443));
test_data_c4 = Rrs555_test - ((Rrs670_test - Rrs490_test)).*((555 - 490)/(670 - 490));
test_data = [test_data_c1,test_data_c2,test_data_c3,test_data_c4,Rrs443_test./Rrs555_test,Rrs490_test./Rrs555_test];% KeyT3

%% nn validation testing seawifs satellite data
% TestChl([147,32,35,96,201,202,141,223],1)=NaN;

tic
nnrp_result_temp = finalrpnet(test_data');
chl_tran_nnrp = transformOpChl(nnrp_result_temp,mean_TrainChl_0,std_TrainChl_0,TrainChllogMax,TrainChllogMin);
toc
[stats_temp,stats2_temp] = get_stats_troph(TestChl,chl_tran_nnrp',troph_flag);

%% svr validation testing seawifs satellite data
svrdefgauss_result_temp = predict(svmdefaugauss_aph_model,test_data);
chl_tran_svrdefgauss = transformOpChl(svrdefgauss_result_temp,mean_TrainChl_0,std_TrainChl_0,TrainChllogMax,TrainChllogMin);
[stats_svrdefg_temp,stats_svrdefg2_temp] = get_stats_troph(TestChl,chl_tran_svrdefgauss,troph_flag);
%% to excel
% Seabass SeaWiFS Validation (ssv)
exstats_ssv = stats_extract_new(stats2_temp,troph_flag);
exstats_ssv_svrdefg = stats_extract_new(stats_svrdefg2_temp,troph_flag);
load('OC4_OCI_satswifs6w.mat')
troph_flag.huswitch = 1;
exstats_oc4 = stats_extract_new(OC4_stats2_satswifs6w,troph_flag);
exstats_oci = stats_extract_new(OCI_stats2_satswifs6w,troph_flag);

file_Excel = "temp_results_new.xlsx";
xlswrite(file_Excel,exstats_ssv.stats_comp,1,'C16:C25');
xlswrite(file_Excel,exstats_ssv.stats_one,1,'G16:G25');
xlswrite(file_Excel,exstats_ssv.stats_t5,1,'K16:K25');
xlswrite(file_Excel,exstats_ssv.stats_oligo,1,'O16:O25');
xlswrite(file_Excel,exstats_ssv.stats_meso,1,'S16:S25');
xlswrite(file_Excel,exstats_ssv.stats_eutro,1,'W16:W25');

xlswrite(file_Excel,exstats_ssv_svrdefg.stats_comp,1,'D16:D25');
xlswrite(file_Excel,exstats_ssv_svrdefg.stats_one,1,'H16:H25');
xlswrite(file_Excel,exstats_ssv_svrdefg.stats_t5,1,'L16:L25');
xlswrite(file_Excel,exstats_ssv_svrdefg.stats_oligo,1,'P16:P25');
xlswrite(file_Excel,exstats_ssv_svrdefg.stats_meso,1,'T16:T25');
xlswrite(file_Excel,exstats_ssv_svrdefg.stats_eutro,1,'X16:X25');

xlswrite(file_Excel,exstats_oc4.stats_comp,1,'E16:E25');
xlswrite(file_Excel,exstats_oc4.stats_one,1,'I16:I25');
xlswrite(file_Excel,exstats_oc4.stats_t5,1,'M16:M25');
xlswrite(file_Excel,exstats_oc4.stats_oligo,1,'Q16:Q25');
xlswrite(file_Excel,exstats_oc4.stats_meso,1,'U16:U25');
xlswrite(file_Excel,exstats_oc4.stats_eutro,1,'Y16:Y25');

xlswrite(file_Excel,exstats_oci.stats_comp,1,'F16:F25');
xlswrite(file_Excel,exstats_oci.stats_one,1,'J16:J25');
xlswrite(file_Excel,exstats_oci.stats_t5,1,'N16:N25');
xlswrite(file_Excel,exstats_oci.stats_oligo,1,'R16:R25');
xlswrite(file_Excel,exstats_oci.stats_meso,1,'V16:V25');
xlswrite(file_Excel,exstats_oci.stats_eutro,1,'Z16:Z25');
%% scatter plots
figure('units','normalized','outerposition',[0 0 1 1])

subplot(2,3,1);
scatter(TestChl(idx_oligo),chl_tran_nnrp(idx_oligo),60,'bo','LineWidth',1.5);hold on
scatter(TestChl(idx_meso),chl_tran_nnrp(idx_meso),60,'go','LineWidth',1.5);hold on
scatter(TestChl(idx_eutro),chl_tran_nnrp(idx_eutro),60,'ro','LineWidth',1.5);hold on
plot([0.001 100],[0.001, 100],'k');
set(gca,'XScale','log','YScale','log')
xlim([0.01 100]);
ylim([0.01 100]);
title('NN');
legend({'Oligo','Meso','Eutro'},'location','southeast');legend('boxoff');
set(gca,'box','on');
set(gca,'FontSize',32,'Fontweight','bold','linewidth',1.5);
% xlabel('{\it In situ} Chl (mg/m^3)');
ylabel('Satellite Chl (mg/m^3)'); 

subplot(2,3,2);
scatter(TestChl(idx_oligo),chl_oc4_satswifs6w(idx_oligo),60,'bo','LineWidth',1.5);hold on
scatter(TestChl(idx_meso),chl_oc4_satswifs6w(idx_meso),60,'go','LineWidth',1.5);hold on
scatter(TestChl(idx_eutro),chl_oc4_satswifs6w(idx_eutro),60,'ro','LineWidth',1.5);hold on
plot([0.001 100],[0.001, 100],'k');
set(gca,'XScale','log','YScale','log')
xlim([0.01 100]);
ylim([0.01 100]);
title('OC4');
legend({'Oligo','Meso','Eutro'},'location','southeast');legend('boxoff');
set(gca,'box','on');
set(gca,'FontSize',32,'Fontweight','bold','linewidth',1.5);
xlabel('{\it In situ} Chl (mg/m^3)');
% ylabel('Satellite Chl (mg/m^3)'); 


subplot(2,3,3);
scatter(TestChl(idx_oligo),chl_oci_satswifs6w(idx_oligo),60,'bo','LineWidth',1.5);hold on
scatter(TestChl(idx_meso),chl_oci_satswifs6w(idx_meso),60,'go','LineWidth',1.5);hold on
scatter(TestChl(idx_eutro),chl_oci_satswifs6w(idx_eutro),60,'ro','LineWidth',1.5);hold on
plot([0.001 100],[0.001, 100],'k');
set(gca,'XScale','log','YScale','log')
xlim([0.01 100]);
ylim([0.01 100]);
title('OCI');
legend({'Oligo','Meso','Eutro'},'location','southeast');legend('boxoff');
set(gca,'box','on');
set(gca,'FontSize',32,'Fontweight','bold','linewidth',1.5);
% xlabel('{\it In situ} Chl (mg/m^3)');
% ylabel('Satellite Chl (mg/m^3)');


