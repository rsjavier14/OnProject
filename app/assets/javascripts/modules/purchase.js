var Purchase = (function(){

  function getCondition(){
     return $('.condition:checked').val();
  }

  function initFormEvents(){
    NumberHelper.mascaraMoneda('.maskMoneda');
    Peoples.search({selector: elements.peopleSearch, url: searchPeopleUrl});
    Material.search({selector: elements.materialSearch, url: setSearchMaterialUrl});
    TableHelper.totalsEvent({selector: elements.materialSearch.selector, table: elements.table.selector, url: '/materials/'});
    $("#details-body").on("nested:fieldAdded", function(event, insertedItem) {
      //$(event.target).find(':input').enableClientSideValidations();
      NumberHelper.mascaraMoneda('.maskMoneda');
      DatepickerHelper.initDatepicker('.datepicker');
      var name_field = event.field.find(elements.materialSearch.selector);
      Material.search($.extend({selector: name_field.val($(event.link).data('predefined-name')), url: setSearchMaterialUrl}));
    });
    $("#details-body-cuota").on("nested:fieldAdded", function(event, insertedItem) {
      //$(event.target).find(':input').enableClientSideValidations();
      NumberHelper.mascaraMoneda('.maskMoneda');
      DatepickerHelper.initDatepicker('.datepicker');
    });
    $(".condition").on("change",function(){
      var condition = getCondition();
      if ( condition === 'contado' ) {
        $('.accordion').css( "display", "none" );
      }
      else if (condition === 'crédito') {
        $('.accordion').css( "display", "block" );
      }
    }).trigger("change");
  }

  return {
    init: function() {
      elements =
        {
          table: $('#purchase-table'),
          peopleSearch: $('.people-search'),
          materialSearch: $('.material-search')
        };
    },
    index: function() {
      DatepickerHelper.initDateRangePicker('#date-range');
    },
    'new': function() {
      initFormEvents();
    },
    'create': function(){
      initFormEvents();
    },
    'edit': function() {
      initFormEvents();
    },
    'update': function(){
      initFormEvents();
    },
    setSearchMaterial: function(url) {
      setSearchMaterialUrl = url;
    },
    setSearchProvider: function(url) {
      searchPeopleUrl = url;
    }
  };

}());
