const addedTags = [];
const removedTags = [];

$("#add-tag-radio").prop("checked", true);
$("#select-tag").hide();
$("#tag-weight-1").prop("checked", true);

$("#add-tag-radio").change(function () {
  if ($(this).is(":checked")) {
    $(".select-tag").hide();
    $("#add-tag-input").show();
  }
});

$("#select-tag-radio").change(function () {
  if ($(this).is(":checked")) {
    $(".select-tag").show();
    $("#add-tag-input").hide();
  }
});

$(".add-tag-button").click(function () {
  const weight = $("input[name=tag-weight]:checked").val();
  const addTag = $("#add-tag-radio").prop("checked") || false;
  let value = addTag ? $("#add-tag-input").val() : $(".select-tag").val();

  const selectedName = addTag
    ? value
    : $(".select-tag").find("option:selected").text();

  console.log(selectedName);

  if (selectedName) {
    addedTags.push({ weight, id: value });

    $(".tag-container").append(
      " <span id='" +
        value +
        "' class='badge bg-info'>" +
        selectedName +
        (weight ? " - " + weight : "") +
        "<i class='fa fa-times'/></span>"
    );
  }
});

$(document).on("click", ".fa-times", function () {
  const tag = $(this).closest("span");
  const tagId = tag.attr("id");
  const addedTag = addedTags.filter((tag) => tag.id === tagId);
  const index = addedTag.length > 0 ? addedTags.indexOf(addedTag[0]) : -1;
  if (index !== -1) {
    addedTags.splice(index, 1);
  } else {
    removedTags.push(tagId);
  }

  tag.remove();
});

$(".form").submit(function () {
  $(".form").append(
    "<input type='hidden' name='added_tags' value=" +
      JSON.stringify(addedTags) +
      "/>",
    "<input type='hidden' name='removed_tags' value=" +
      JSON.stringify(removedTags) +
      "/>"
  );
});
