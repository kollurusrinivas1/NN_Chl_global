function exstats = stats_extract_new(stats,troph_flag)
mard = [];mrt = [];Bias = [];Rmsd = [];Urmd = [];
MeaR = [];MedR = [];R2Lin = [];R2log = [];nop = [];
for i=1:6
    mard = [mard;stats(i).MARD_Hu];
    mrt = [mrt;stats(i).MRT_Hu];
    Bias = [Bias;stats(i).Bias_Hu];
    Rmsd = [Rmsd;stats(i).rmse];
    Urmd= [Urmd;stats(i).URMD_Hu];
    MeaR = [MeaR;stats(i).MeanRat_Hu];
    MedR = [MedR;stats(i).MedRat_Hu];
    R2Lin = [R2Lin;stats(i).corrcoef];
    R2log = [R2log;stats(i).corrcoef_log10];
    nop = [nop;stats(i).N];
end

oidx = 1;
midx = 2;
eidx = 3;
oneidx = 4;
t5idx = 5;
cidx = 6;


if troph_flag.oligomeso == 1
    exstats.stats_one = [mard(oneidx);Bias(oneidx);mrt(oneidx);Rmsd(oneidx);Urmd(oneidx);MeaR(oneidx);MedR(oneidx);R2Lin(oneidx);R2log(oneidx);nop(oneidx)];
else
    exstats.stats_one = NaN(1,10);
end
if troph_flag.huswitch == 1
    exstats.stats_t5 = [mard(t5idx);Bias(t5idx);mrt(t5idx);Rmsd(t5idx);Urmd(t5idx);MeaR(t5idx);MedR(t5idx);R2Lin(t5idx);R2log(t5idx);nop(t5idx)];
else
    exstats.stats_t5 = NaN(1,10);
end
if troph_flag.oligo == 1
    exstats.stats_oligo = [mard(oidx);Bias(oidx);mrt(oidx);Rmsd(oidx);Urmd(oidx);MeaR(oidx);MedR(oidx);R2Lin(oidx);R2log(oidx);nop(oidx)];
else
    exstats.stats_oligo = NaN(1,10);
end
if troph_flag.meso == 1
    exstats.stats_meso = [mard(midx);Bias(midx);mrt(midx);Rmsd(midx);Urmd(midx);MeaR(midx);MedR(midx);R2Lin(midx);R2log(midx);nop(midx)];
else
    exstats.stats_meso = NaN(1,10);
end
if troph_flag.eutro == 1
    exstats.stats_eutro = [mard(eidx);Bias(eidx);mrt(eidx);Rmsd(eidx);Urmd(eidx);MeaR(eidx);MedR(eidx);R2Lin(eidx);R2log(eidx);nop(eidx)];
else
    exstats.stats_eutro = NaN(1,10);
end
exstats.stats_comp = [mard(cidx);Bias(cidx);mrt(cidx);Rmsd(cidx);Urmd(cidx);MeaR(cidx);MedR(cidx);R2Lin(cidx);R2log(cidx);nop(cidx)];
