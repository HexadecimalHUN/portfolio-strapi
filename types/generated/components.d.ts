import type { Schema, Attribute } from '@strapi/strapi';

export interface PackagePricePackageOption extends Schema.Component {
  collectionName: 'components_package_price_package_options';
  info: {
    displayName: 'package option';
    icon: 'database';
  };
  attributes: {};
}

declare module '@strapi/types' {
  export module Shared {
    export interface Components {
      'package-price.package-option': PackagePricePackageOption;
    }
  }
}
