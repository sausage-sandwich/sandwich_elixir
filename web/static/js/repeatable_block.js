document.addEventListener("DOMContentLoaded", function(event) {
  var nestedForms = Array.from(document.getElementsByClassName("js-repeatable"));

  nestedForms.forEach(makeRepeatable);

  function makeRepeatable(container) {
    var addButton = container.getElementsByClassName("js-repeatable-block-add-button")[0]
    addButton.addEventListener("click", function(e) {
      addBlock(e.target.closest(".js-repeatable"));
    }, false);
  }

  function addBlock(container) {
    var block = container.getElementsByClassName("js-repeatable-block");
    var newNode = createNewNode(block);
    block.appendChild(newNode);
  }

  function createNewNode(block) {
    var firstItemNumber = 0;
    var itemNumber = block.length;
    var newNode = block[firstItemNumber].cloneNode(true);
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
