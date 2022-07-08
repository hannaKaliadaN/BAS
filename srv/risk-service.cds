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
    ])                    as projection on my.Risks;

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
    ])                    as projection on my.Mitigations;

    annotate Mitigations with @odata.draft.enabled;

    @readonly
    entity Books          as
        select from my.Books {
            *
        }
        excluding {
            createdBy,
            modifiedBy
        };

    @readonly
    entity Orders         as projection on my.Orders;


    // Enable Fiori Draft for Orders
    annotate AdminService.Orders with @odata.draft.enabled;
    // annotate AdminService.Books with @odata.draft.enabled;

    // Temporary workaround -> cap/issues#3121
    extend service AdminService with {
        entity OrderItems as select from my.OrderItems;
    }
}
