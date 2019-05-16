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
        var img_src = e.target.result;

        $preview.empty();
        $preview.append($("<img>").attr({
          src: img_src,
          class: "preview",
          title: file.name
        }));

        $(".preview").css("width", "128px");
        $(".preview").css("height", "128px");
        $(".preview").css("object-fit", "contain");
        $(".preview").css("display", "block");
        $(".preview").css("margin", "auto");
      };
    })(file);

    reader.readAsDataURL(file);
  })
})