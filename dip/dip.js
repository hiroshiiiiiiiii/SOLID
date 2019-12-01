var ReceiptPresenter = /** @class */ (function () {
    // name: string;
    // items: ItemInterface[];
    function ReceiptPresenter(name, items) {
        this.name = name;
        this.items = items;
        this.name = name;
        this.items = items;
    }
    ReceiptPresenter.prototype.output = function () {
        return this.items;
        // let subtotal= 0;
        // let shipping_fee = 0;
        // let tax = 0;
        // let num = [7, 8, 9];
        // num.forEach(function (value) {
        //   console.log(value);
        // });
        // items.forEach(funcion (item) {
        //   console.log(item);
        //   // subtotal = subtotal + item.price;
        //   // shipping_fee = shipping_fee + item.shipping_fee,
        //   // tax = tax + item.tax,
        // });
        // const doc = `
        //   ==== 領収書 ====
        //   ----------------
        //   小計: ${subtotal.floor}円
        //   送料: ${shipping_fee.floor}円
        //   消費税: ${tax.floor}円
        //   合計: ${(subtotal + shipping_fee + tax).floor}円
        //   ================
        // `
        // return doc;
    };
    return ReceiptPresenter;
}());
var DigitalItem = /** @class */ (function () {
    function DigitalItem(name, items) {
        this.name = name;
        this.items = items;
        this.name = name;
        this.items = items;
    }
    DigitalItem.prototype.shipping_fee = function () {
        return 0;
    };
    DigitalItem.prototype.tax = function () {
        this.price * 0.08;
    };
    return DigitalItem;
}());
var ShippingItem = /** @class */ (function () {
    function ShippingItem(weight) {
        this.weight = weight;
        this.weight = weight;
    }
    ShippingItem.prototype.shipping_fee = function () {
        if (this.weight < 1000) {
            return 500.0;
        }
        else {
            return 1000.0;
        }
    };
    ShippingItem.prototype.tax = function () {
        this.price * 0.08;
    };
    return ShippingItem;
}());
var DiscountItem = /** @class */ (function () {
    function DiscountItem(name, price, weight) {
        this.name = name;
        this.price = price;
        this.weight = weight;
        this.name = name;
        this.price = discounted_price(price);
        this.weight = weight;
    }
    DiscountItem.prototype.shipping_fee = function () {
        if (this.weight < 1000) {
            return 500.0;
        }
        else {
            return 1000.0;
        }
    };
    DiscountItem.prototype.tax = function () {
        this.price * 0.08;
    };
    DiscountItem.prototype.discounted_price = function () {
        this.price * ((100 - 20.0) / 100);
    };
    return DiscountItem;
}());
var items = [
    new DigitalItem('Office365シリアル番号', 12000),
    new ShippingItem('ロッキングチェア', 25000, 15000),
    new DiscountItem('美肌マスク', 2400, 200)
];
return new ReceiptPresenter('Relic太郎', items).output();
