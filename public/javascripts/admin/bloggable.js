Toggle.MCE = Behavior.create(Toggle.LinkBehavior, {
  initialize: function($super, options) {
    var elements = Toggle.extractToggleObjects(this.element.readAttribute('rel'));
    this.textarea = elements.shift();
  },
  toggle: function() {
    if (!tinyMCE.get(this.textarea)) {
      tinyMCE.execCommand('mceAddControl', false, this.textarea);
    } else {
      tinyMCE.execCommand('mceRemoveControl', false, this.textarea);
    }
  }
});

Toggle.SelectByValueBehavior = Behavior.create(Toggle.SelectBehavior, {
  initialize: function(options) {
    var options = options || {};
    this.toggleWrapperIDs = $A();
    this.toggleWrapperIDsFor = {};
    this.element.select('option').each(function(optionElement) {
      var selection = optionElement.value;
      if ($("choose_" + selection)) {
        var element = $("choose_" + selection);
        var wrapperID = Toggle.wrapElement(element).identify();
        this.toggleWrapperIDsFor[optionElement.identify()] = [wrapperID];
        this.toggleWrapperIDs.push(wrapperID);
      } else {
        this.toggleWrapperIDsFor[optionElement.identify()] = [];
      }
    }.bind(this));
    
    this.toggleWrapperIDs = this.toggleWrapperIDs.flatten().uniq();
    this.effect = "none";
    this.toggle();
    this.effect = options.effect || Toggle.DefaultEffect;
  }
});







Event.addBehavior({ 
  "a.toggleMCE" : Toggle.MCE,
  "select.choose_type" : Toggle.SelectByValueBehavior({effect : 'slide'})
});
