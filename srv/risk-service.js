// "use strict";

const cds = require("@sap/cds");
// const proxy = require("@sap/cds-odata-v2-adapter-proxy");

// cds.on("bootstrap", app => app.use(proxy()));
/**
 * Implementation for Risk Management service defined in ./risk-service.cds
 */
// module.exports = cds.on("bootstrap", (app) => app.use(proxy()));
module.exports = cds.service.impl(async function () {
  this.after("READ", "Risks", (risksData) => {
    const risks = Array.isArray(risksData) ? risksData : [risksData];
    risks.forEach((risk) => {
      if (risk.impact >= 100000) {
        risk.criticality = 1;
      } else {
        risk.criticality = 2;
      }
    });
  });
});

// module.exports = cds.server;
// const express = require("express");
// const cds = require("@sap/cds");
// const proxy = require("@sap/cds-odata-v2-adapter-proxy");

// const host = "0.0.0.0";
// const port = process.env.PORT || 4004;

// (async () => {
//   const app = express();

//   // OData V2
//   app.use(proxy());

//   // OData V4
//   await cds.connect.to("db");
//   await cds.serve("all").in(app);

//   const server = app.listen(port, host, () => console.info(`app is listing at ${host}:${port}`));
//   server.on("error", (error) => console.error(error.stack));
// })();

// const proxy = require('@sap/cds-odata-v2-adapter-proxy')
// const cds = require('@sap/cds')
// cds.on('bootstrap', app => app.use(proxy()))
// module.exports = cds.server