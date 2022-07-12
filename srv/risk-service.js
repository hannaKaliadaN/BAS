
const cds = require('@sap/cds')
const proxy = require("@sap/cds-odata-v2-adapter-proxy");
cds.on("bootstrap", app => app.use(proxy()));
/**
 * Implementation for Risk Management service defined in ./risk-service.cds
 */

module.exports = cds.service.impl(async function() {
    this.after('READ', 'Risks', risksData => {
        const risks = Array.isArray(risksData) ? risksData : [risksData];
        risks.forEach(risk => {
            if (risk.impact >= 100000) {
                risk.criticality = 1;
            } else {
                risk.criticality = 2;
            }
        });
    });
});


