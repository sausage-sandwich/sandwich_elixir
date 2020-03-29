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
    container.insertBefore(newNode, blocks[blocks.length - 1].nextSibling);
    newNode.querySelectorAll("input,select")[0].focus();
  }

  function createNewNode(blocks) {
    var firstItemIndex = 0;
    var newItemIndex = blocks.length; // last item index + 1 = (blocks.length - 1) + 1
    var newNode = blocks[firstItemIndex].cloneNode(true);
    Array.from(newNode.querySelectorAll("input,select")).forEach(function(input) {
      input.setAttribute("name", input.name.replace(firstItemIndex, newItemIndex));
      input.setAttribute("id", input.id.replace(firstItemIndex, newItemIndex));
      clearValue(input);
    })
    return newNode;
  }

  function clearValue(input) {
    input.value = '';
    Array.from(input).forEach(function(option) { option.removeAttribute("selected") })
  }
});
