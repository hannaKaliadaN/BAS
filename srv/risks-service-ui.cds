using RiskService from './risk-service';

annotate RiskService.Risks with {
	title       @title: 'Title';
	prio        @title: 'Priority';
	descr       @title: 'Description';
	miti        @title: 'Mitigation';
	impact      @title: 'Impact';
}

annotate RiskService.Mitigations with {
	ID @(
		UI.Hidden,
		Common: {
		Text: description
		}
	);
	description  @title: 'Description';
	owner        @title: 'Owner';
	timeline     @title: 'Timeline';
	risks        @title: 'Risks';
}

annotate RiskService.Risks with @(
	UI: {
		HeaderInfo: {
			TypeName: 'Risk',
			TypeNamePlural: 'Risks',
			Title          : {
                $Type : 'UI.DataField',
                Value : title
            },
			Description : {
				$Type: 'UI.DataField',
				Value: descr
			}
		},
		SelectionFields: [prio],
		LineItem: [
			{Value: title},
			{Value: miti_ID},
			{
				Value: prio,
				Criticality: criticality
			},
			{
				Value: impact,
				Criticality: criticality
			}
		],
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: 'Main', Target: '@UI.FieldGroup#Main'}
		],
		FieldGroup#Main: {
			Data: [
				{Value: miti_ID},
				{
					Value: prio,
					Criticality: criticality
				},
				{
					Value: impact,
					Criticality: criticality
				}
			]
		}
	},
) {

};

annotate RiskService.Risks with {
	miti @(
		Common: {
			//show text, not id for mitigation in the context of risks
			Text: miti.description  , TextArrangement: #TextOnly,
			ValueList: {
				Label: 'Mitigations',
				CollectionPath: 'Mitigations',
				Parameters: [
					{ $Type: 'Common.ValueListParameterInOut',
						LocalDataProperty: miti_ID,
						ValueListProperty: 'ID'
					},
					{ $Type: 'Common.ValueListParameterDisplayOnly',
						ValueListProperty: 'description'
					}
				]
			}
		}
	);
}


annotate  RiskService.SalesOrder with {
 modifiedAt @UI.Hidden;
 modifiedBy @UI.Hidden;
 createdAt @UI.Hidden;
 createdBy @UI.Hidden ;
 };

// Donut Chart
annotate RiskService.SalesPerSupplier with @(UI : {
    Chart #donut                            : {
        $Type               : 'UI.ChartDefinitionType',
        ChartType           : #Donut,
        Description         : 'Donut Chart',
        Measures            : [grossAmountInCompanyCurrency],
        MeasureAttributes   : [{
            $Type     : 'UI.ChartMeasureAttributeType',
            Measure   : grossAmountInCompanyCurrency,
            Role      : #Axis1,
            DataPoint : '@UI.DataPoint#GrossAmountInCompanyCurrency'
        }],
        Dimensions          : [supplier],
        DimensionAttributes : [{
            $Type     : 'UI.ChartDimensionAttributeType',
            Dimension : supplier,
            Role      : #Category
        }]
    },
    PresentationVariant #donutPreVar        : {
        $Type             : 'UI.PresentationVariantType',
        Visualizations    : ['@UI.Chart'],
        MaxItems          : 3,
        IncludeGrandTotal : true,
        SortOrder         : [{
            $Type      : 'Common.SortOrderType',
            Descending : true,
            Property   : grossAmountInCompanyCurrency
        }]
    },
    DataPoint #GrossAmountInCompanyCurrency : {
        $Type                  : 'UI.DataPointType',
        Value                  : grossAmountInCompanyCurrency,
        Title                  : 'Revenue',
        CriticalityCalculation : {
            $Type                   : 'UI.CriticalityCalculationType',
            ImprovementDirection    : #Maximize,
            DeviationRangeHighValue : 1000000,
            DeviationRangeLowValue  : 3000000
        },
        TrendCalculation       : {
            $Type                : 'UI.TrendCalculationType',
            ReferenceValue       : 1000,
            UpDifference         : 10,
            StrongUpDifference   : 100,
            DownDifference       : -10,
            StrongDownDifference : -100
        },
    },
    Identification                          : [{
        $Type : 'UI.DataField',
        Value : grossAmountInCompanyCurrency

    }]
});


annotate  RiskService.SalesHistory with {
 modifiedAt @UI.Hidden;
 modifiedBy @UI.Hidden;
 createdAt @UI.Hidden;
 createdBy @UI.Hidden;
 companyCurrency @title : 'Currency' @Measures.ISOCurrency : 'Currency';
 companyCurrency_Text @title : '';
 creationMonthAsDate @title : 'Creation Date';
 creationMonth @title : 'Month';
 creationMonth_Text @title : 'Month' @Common.QuickInfo : 'Month Long text';
 referenceAmount @title : 'Amount' ; 
 };
// //Line Chart
annotate RiskService.SalesHistory with @(
    UI.Chart #Line                             : {
        $Type               : 'UI.ChartDefinitionType',
        ChartType           : #Line,
        Description         : 'Line Chart',
        Measures            : [grossAmountInCompanyCurrency],
        MeasureAttributes   : [{
            $Type     : 'UI.ChartMeasureAttributeType',
            Measure   : grossAmountInCompanyCurrency,
            Role      : #Axis1,
            DataPoint : '@UI.DataPoint#GrossAmountInCompanyCurrency'
        }],
        Dimensions          : [creationMonth],
        DimensionAttributes : [{
            $Type     : 'UI.ChartDimensionAttributeType',
            Dimension : creationMonth,
            Role      : #Category
        }]
    },
    UI.PresentationVariant #Line               : {
        $Type             : 'UI.PresentationVariantType',
        Visualizations    : ['@UI.Chart#Line'],
        MaxItems          : 3,
        IncludeGrandTotal : true,
        SortOrder         : [{
            $Type      : 'Common.SortOrderType',
            Descending : true,
            Property   : creationMonthAsDate
        }]
    },
    UI.DataPoint #GrossAmountInCompanyCurrency : {
        $Type                  : 'UI.DataPointType',
        Value                  : grossAmountInCompanyCurrency,
        Title                  : 'Revenue',
        CriticalityCalculation : {
            $Type                   : 'UI.CriticalityCalculationType',
            ImprovementDirection    : #Maximize,
            DeviationRangeHighValue : 1000000,
            DeviationRangeLowValue  : 3000000
        },
        TrendCalculation       : {
            $Type                : 'UI.TrendCalculationType',
            ReferenceValue       : referenceAmount,
            UpDifference         : 10,
            StrongUpDifference   : 100,
            DownDifference       : -10,
            StrongDownDifference : -100
        }
    }

);