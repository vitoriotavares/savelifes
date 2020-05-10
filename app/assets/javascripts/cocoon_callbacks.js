// (function() {
//     jQuery(document).on('turbolinks:load', function() {
//       var order_services_services;
//       order_services_services = $('#order_services_services');
//       order_services_services.on('cocoon:after-insert', function(e, added_el) {
//         console.log('adicionando');
//         $('select.dropdown').dropdown();
//         return added_el.find("input").first().focus();
//       });
//       return order_services_services.on('cocoon:before-remove', function(e, el_to_remove) {
//         console.log('removendo');
//         return el_to_remove.fadeOut(1000);
//       });
//     });
  
//   }).call(this);