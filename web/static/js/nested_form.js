document.addEventListener("DOMContentLoaded", function(event) {
  var nestedForms = Array.from(document.getElementsByClassName("nested-form"));

  nestedForms.forEach(function(form) {
    var addButton = form.getElementsByClassName("nested-form-add-button")[0]
    addButton.addEventListener("click", function(e) {
      addFormItem(e.target.closest(".nested-form"));
    }, false);
  });

  function addFormItem(form) {
    var formItems = form.getElementsByClassName("nested-form-item-fields");
    var newNode = createNewNode(formItems);
    form.appendChild(newNode);
  }

  function createNewNode(formItems) {
    var firstItemNumber = 0;
    var itemNumber = formItems.length;
    var newNode = formItems[firstItemNumber].cloneNode(true);
    Array.from(newNode.querySelectorAll("input,select")).forEach(function(input) {
      input.setAttribute("name", input.name.replace(firstItemNumber, itemNumber));
      input.setAttribute("id", input.id.replace(firstItemNumber, itemNumber));
      clearValue(input);
    })
    return newNode;
  }

  function clearValue(input) {
    input.value = '';
    Array.from(input).forEach(function(option) { option.removeAttribute("selected") })
  }
});
