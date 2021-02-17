let addedTags = [];

$("#add-tag-radio").prop("checked", true);
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
  const addTag = $("#add-tag-radio").prop("checked");
  let value = addTag ? $("#add-tag-input").val() : $(".select-tag").val();
  const selectedName = addTag
    ? value
    : $(".select-tag").find("option:selected").text();

  addedTags.push(value);

  $(".tag-container").append(
    " <span id='" +
      value +
      "' class='badge bg-info'>" +
      selectedName +
      "<i class='fa fa-times'/></span>"
  );
  console.log(addedTags)
});

$(document).on("click", ".fa-times", function () {
  const tag = $(this).closest("span");
  const tagId = tag.attr("id");
  addedTags = addedTags.filter(tag => tag !== tagId)
  tag.remove();
});

const renderCollateral = collateral => {
  return `<div>
    <div>${collateral.collateral.name}</div>
    <div>${collateral.weight}</div>
    <div>${collateral.tags.map(tag => tag.name)}</div>
  </div>`
}

$('.submit-button').click(() =>
    
    $.ajax({
      type: 'POST',
      url: '/lead/get_collaterals',
      data: {
        tags: addedTags,
        authenticity_token: $('meta[name=csrf-token]').attr('content'),
      },
    }).then(data => {
      $('#collaterals').empty();
      const collaterlas = data.map(collateral => {
        $('#collaterals').append(() => renderCollateral(collateral))
      })
      console.log(collaterlas[1])
      
      return false;
    }),
  );
