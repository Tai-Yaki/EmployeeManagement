$(function() {
  $("form").on("change", 'input[type="file"]', function(e) {
    var file = e.target.files[0],
        reader = new FileReader(),
        $preview = $(".image-preview");

    if(file.type.indexOf("image") < 0) {
      return false;
    }

    reader.onload = (function(file) {
      return function(e) {
        $preview.empty();
        $preview.append($("<img>").attr({
          src: e.target.result,
          class: "preview",
          title: file.name
        }));

        $(".preview").css("width", "128px");
        $(".preview").css("height", "128px");
        $(".preview").css("object-fit", "contain");
        $(".preview").css("background-color", "black");
      };
    })(file);

    reader.readAsDataURL(file);
  })
})