* This file includes the constraints on post harvest losses that may be included in the model

Variables
         LocalMarket_GrainDelivered Total grain delivered at the local market from all possible sources
         RegionalMarket_GrainDelivered Total grain delivered at the regional market from all possible sources
         FarmGate_GrainDelivered Total grain delivered (purchased) at the farm gate from all possible sources
         TotalGrainDelivered The total grain delivered to all possible markets
         TotalPHLLoss The total post harvest loss in the supply chain in percentage
         ;

Equations
         PHLConstraint1
         PHLConstraint2
         PHLConstraint3
         PHLConstraint4
         PHLConstraint5
         PHLConstraint6
         PHLConstraint7
         PHLConstraint8
         PHLConstraint9
         ;

PHLConstraint1(HarvestingHorizonAggregation,LocalMarketSet)..
                         LocalMarket_GrainDelivered(HarvestingHorizonAggregation,LocalMarketSet) =e=
                         sum((DistrictSelected,FarmNumber),
                                 HarvestFarmGateLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 LocalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2)),
                                 RegionalCSPLocalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate);


PHLConstraint2(NonHarvestingHorizonAggregation,LocalMarketSet)..
                         LocalMarket_GrainDelivered(NonHarvestingHorizonAggregation,LocalMarketSet) =e=
                         sum((DistrictSelected,FarmNumber),
                                 HarvestFarmGateLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation),
                                 LocalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation),
                                 RegionalCSPLocalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,LocalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate);


PHLConstraint3(HarvestingHorizonAggregation,RegionalMarketSet)..
                         RegionalMarket_GrainDelivered(HarvestingHorizonAggregation,RegionalMarketSet) =e=
                         sum((DistrictSelected,FarmNumber)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 HarvestFarmGateRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and connectselected(DistrictSelected,RegionalMarketSet)),
                                 LocalCSPRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation2)
                                         $(ord(HarvestingHorizonAggregation)>=ord(HarvestingHorizonAggregation2) and connectselected(DistrictSelected,RegionalMarketSet)),
                                 RegionalCSPRegionalMarketGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation2)
                         )*(1-TransportationDryMatterLossRate);


PHLConstraint4(NonHarvestingHorizonAggregation,RegionalMarketSet)..
                         RegionalMarket_GrainDelivered(NonHarvestingHorizonAggregation,RegionalMarketSet) =e=
                         sum((DistrictSelected,FarmNumber)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 HarvestFarmGateRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalMarketSet)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((LocalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 LocalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,LocalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate)
                         +
                         sum((RegionalCSPCenterSet,DistrictSelected,FarmNumber,HarvestingHorizonAggregation)$(connectselected(DistrictSelected,RegionalMarketSet)),
                                 RegionalCSPRegionalMarketGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber,RegionalCSPCenterSet,RegionalMarketSet,HarvestingHorizonAggregation)
                         )*(1-TransportationDryMatterLossRate);


PHLConstraint5(HarvestingHorizonAggregation)..
                         FarmGate_GrainDelivered(HarvestingHorizonAggregation) =e= sum((DistrictSelected,FarmNumber),HarvestFarmGateDirectPurchaseGrain(HarvestingHorizonAggregation,DistrictSelected,FarmNumber));

PHLConstraint6(NonHarvestingHorizonAggregation)..
                         FarmGate_GrainDelivered(NonHarvestingHorizonAggregation) =e= sum((DistrictSelected,FarmNumber),HarvestFarmGateDirectPurchaseGrain(NonHarvestingHorizonAggregation,DistrictSelected,FarmNumber));


PHLConstraint7..      TotalGrainDelivered =e=
                      sum(HarvestingHorizonAggregation, FarmGate_GrainDelivered(HarvestingHorizonAggregation)*card(HarvestingHorizonAggregationStep))
                      +
                      sum(NonHarvestingHorizonAggregation, FarmGate_GrainDelivered(NonHarvestingHorizonAggregation)*card(NonHarvestingHorizonAggregationStep))
                      +
                      sum((HarvestingHorizonAggregation,LocalMarketSet), LocalMarket_GrainDelivered(HarvestingHorizonAggregation,LocalMarketSet)*card(HarvestingHorizonAggregationStep))
                      +
                      sum((NonHarvestingHorizonAggregation,LocalMarketSet), LocalMarket_GrainDelivered(NonHarvestingHorizonAggregation,LocalMarketSet)*card(NonHarvestingHorizonAggregationStep))
                      +
                      sum((HarvestingHorizonAggregation,RegionalMarketSet), RegionalMarket_GrainDelivered(HarvestingHorizonAggregation,RegionalMarketSet)*card(HarvestingHorizonAggregationStep))
                      +
                      sum((NonHarvestingHorizonAggregation,RegionalMarketSet), RegionalMarket_GrainDelivered(NonHarvestingHorizonAggregation,RegionalMarketSet)*card(NonHarvestingHorizonAggregationStep));

PHLConstraint8..    TotalPHLLoss =e=   (Par_FarmGateTotalGrain - TotalGrainDelivered)*100/Par_FarmGateTotalGrain;

PHLConstraint9..    TotalPHLLoss =l= 3.5;

Model PHLConstraints /
         PHLConstraint1
         PHLConstraint2
         PHLConstraint3
         PHLConstraint4
         PHLConstraint5
         PHLConstraint6
         PHLConstraint7
         PHLConstraint8
         PHLConstraint9
         /;
