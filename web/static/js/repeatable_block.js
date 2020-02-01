// .js-repeatable - container that must include n
// .js-repeatable-block-add-button - a control to add a block
// and .js-rebeatable-block - the block that must be duplicated and appended into the container
// example:
// .js-repeatable
//   .js-repeatable-block-add-button.btn.btn-danger Add
//   .js-rebeatable-block I will be repeated!

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
    var blocks = Array.from(container.getElementsByClassName("js-repeatable-block"));
    var newNode = createNewNode(blocks);
    container.appendChild(newNode);
  }

  function createNewNode(blocks) {
    var firstItemNumber = 0;
    var itemNumber = blocks.length;
    var newNode = blocks[firstItemNumber].cloneNode(true);
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
