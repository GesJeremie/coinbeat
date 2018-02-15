(function()  {
    'use strict';

    Vue.component('component-settings-order', {

        props: [
            'propFolioCryptoCurrencies'
        ],

        data: function() {
            return {
                folioCryptoCurrencies: JSON.parse(this.propFolioCryptoCurrencies)
            }
        },

        created: function() {
            console.log(this.folioCryptoCurrencies);
        }
    });

}());
