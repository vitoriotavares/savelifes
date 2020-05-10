// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require semantic-ui
//= require flatpickr/dist/flatpickr
//= require flatpickr/dist/l10n/pt
//= require jquery-mask-plugin/dist/jquery.mask
//= require moment 
//= require cocoon
//= require fullcalendar
//= require fullcalendar/locale-all
//= require js-routes
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
    $('.ui.modal').modal();
    $('#transporte').click(function(){
        $('.ui.modal').modal('show');
    });
    $('.ui.dropdown').dropdown({ clearable: true });
    $('select.dropdown').dropdown({ fullTextSearch: true, clearable: true });
    $('.ui.accordion').accordion();
    $('.top.menu .item').tab();

    $(".cpf").mask("999.999.999-99");
    $(".cnpj").mask("99.999.999/9999-99");
    $('.cep').mask('99999-999');
    $(".telefone").mask("(00) 0000-00009");

    $('#calendar').fullCalendar({
        events: '/events.json',
        locale: 'pt-br',
        timeFormat: 'H:mm',
        dayClick: function(date, jsEvent, view) {
            window.location.href = Routes.new_events_path({i: date.format()})
          }
    });

    $('.print_button').click(function(){
        $("#os_print").print({
            addGlobalStyles : true,
            stylesheet : true,
            rejectWindow : true,
            noPrintSelector : ".no-print",
            iframe : true
        });

    });

    var options = {
        onKeyPress: function(cpfcnpj, e, field, options) {
            var masks = ['000.000.000-000', '00.000.000/0000-00'];
            var mask = (cpfcnpj.length > 14) ? masks[1] : masks[0];
            $('.cpfcnpj').mask(mask, options);
        }
    };

    $('.cpfcnpj').mask('000.000.000-000', options);

    $('.message .close').on('click', function() {
        $(this)
            .closest('.message')
            .transition('fade');
    });

    $('.datepicker').flatpickr({
        dateFormat: "d/m/Y",
        enableTime: false,
        locale: 'pt'
    });

    $('.datetimepicker').flatpickr({
        dateFormat: "d/m/Y H:i",
        enableTime: true,
        locale: 'pt'
    });

    $('.datetimepickerMax').flatpickr({
        dateFormat: "d/m/Y H:i",
        enableTime: true,
        locale: 'pt',
        maxDate: "today"
    });



    $('.timepicker').flatpickr({
        enableTime: true,
        noCalendar: true,
        dateFormat: "H:i",
        time_24hr: true,
        locale: 'pt'
    });

    $(".somenteLetras").mask("L", {
        maxlength: false,
        translation: {
            'L': { pattern: /[A-zÀ-ú ]/, recursive: true }
        }
    });

    $(".somenteNumeros").mask("N", {
        maxlength: false,
        translation: {
            'N': { pattern: /[0-9]/, recursive: true }
        }
    });

    $(".somenteLetrasNumeros").mask("LN", {
        maxlength: false,
        translation: {
            'LN': { pattern: /[A-zÀ-ú0-9]/, recursive: true }
        }
    });

    $('.email').mask("A", {
        translation: {
            "A": { pattern: /[\w@\-.+]/, recursive: true }
        }
    });

    $('.money').mask('#.##0,00', { reverse: true });

     // fix menu when passed
     $('.masthead')
     .visibility({
       once: false,
       onBottomPassed: function() {
         $('.fixed.menu').transition('fade in');
       },
       onBottomPassedReverse: function() {
         $('.fixed.menu').transition('fade out');
       }
     })
   ;

   // create sidebar and attach to menu open
   $('.ui.sidebar')
     .sidebar('attach events', '.toc.item');
});

