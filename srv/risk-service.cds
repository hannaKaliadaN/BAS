using {sap.ui.riskmanagement as my} from '../db/schema';

@path : 'service/risk'
service RiskService {
    entity Risks @(restrict : [
        {
            grant : ['READ'],
            to    : ['RiskViewer']
        },
        {
            grant : ['*'],
            to    : ['RiskManager']
        }
    ]) as projection on my.Risks;

    annotate Risks with @odata.draft.enabled;

    entity Mitigations @(restrict : [
        {
            grant : ['READ'],
            to    : ['RiskViewer']
        },
        {
            grant : ['*'],
            to    : ['RiskManager']
        }
    ]) as projection on my.Mitigations;

    annotate Mitigations with @odata.draft.enabled;
    entity SalesOrder       as select from my.SalesOrderType;

    @readonly
    entity SalesHistory as select from my.SalesHistoryType
        excluding {
            createdAt,
            createdBy,
            modifiedAt,
            modifiedBy
        };

    entity SalesPerSupplier as select from my.SalesPerSupplierType;


}
