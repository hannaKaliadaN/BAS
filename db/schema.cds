namespace sap.ui.riskmanagement;

using {
  Currency,
  managed,
  cuid
} from '@sap/cds/common';

entity Risks : managed {
  key ID          : UUID @(Core.Computed : true);
      title       : String(100);
      prio        : String(5);
      descr       : String;
      miti        : Association to Mitigations;
      impact      : Integer;
      criticality : Integer;
}

entity Mitigations : managed {
  key ID          : UUID @(Core.Computed : true);
      description : String;
      owner       : String;
      timeline    : String;
      risks       : Association to many Risks
                      on risks.miti = $self;
}

entity Books : managed {
  key ID       : Integer;
      title    : localized String(111);
      descr    : localized String(1111);
      author   : Association to Authors;
      stock    : Integer;
      price    : Decimal(9, 2);
      currency : Currency;
}

entity Authors : managed {
  key ID           : Integer;
      name         : String(111);
      dateOfBirth  : Date;
      dateOfDeath  : Date;
      placeOfBirth : String;
      placeOfDeath : String;
      books        : Association to many Books
                       on books.author = $self;
}

entity Orders : cuid, managed {
  OrderNo  : String        @title : 'Order Number'; //> readable key
  Items    : Composition of many OrderItems
               on Items.parent = $self;
  total    : Decimal(9, 2) @readonly;
  currency : Currency;
}

entity OrderItems : cuid {
  parent    : Association to Orders;
  book      : Association to Books;
  amount    : Integer;
  netAmount : Decimal(9, 2);
}
