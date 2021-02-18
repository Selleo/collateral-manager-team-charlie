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
  const addTag = $("#add-tag-radio").prop("checked");
  let value = addTag ? $("#add-tag-input").val() : $(".select-tag").val();
  const selectedName = addTag
    ? value
    : $(".select-tag").find("option:selected").text();
  if (!addedTags.includes(value)) {
    addedTags.push(value);
    $(".tag-container").append(
      " <span id='" +
        value +
        "' class='badge bg-info'>" +
        selectedName +
        "<i class='fa fa-times'/></span>"
    );
  }
  console.log(addedTags)
});

$(document).on("click", ".fa-times", function () {
  const tag = $(this).closest("span");
  const tagId = tag.attr("id");
  addedTags = addedTags.filter(tag => tag !== tagId)
  tag.remove();
  console.log(addedTags)
});

function renderCollateral(collateral) {
  return `<tr>
  <td>${collateral.collateral.name}</td>
  <td>${collateral.collateral.description}</td>
  <td>${collateral.collateral.url}</td>
  <td>${collateral.collateral.name}</td></tr>`
}

function getOnePart(tab) {
  res = '';
  tab.forEach(element => {
    res = res + element
  });
  console.log(res);
  return res;
}

$('.submit-button').click(() =>
    
    $.ajax({
      type: 'POST',
      url: '/search/get_collaterals',
      data: {
        tags: addedTags,
        authenticity_token: $('meta[name=csrf-token]').attr('content'),
      },
    }).then(data => {
      $('#collaterals').empty();
      a = [];
      data.map(collateral => {
        a.push(renderCollateral(collateral))
      })
      $('#collaterals').append(
      `<h1 class = "text-center"></h1>
      <table class="table table-striped table-hover"> 
      <thead>
      <tr><td>Name</td><td>Description</td><td>Url</td><td>Tags</td></tr>
      </thead>
      <tbody>` + getOnePart(a) +
     '</tbody></table>');

      return false;
    }),
  );
