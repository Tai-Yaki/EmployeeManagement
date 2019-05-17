$(document).on("turbolinks:load", function() {
  $(function() {
    $(".image-setter").click(function() {
      $("#prof-image").click();
    });

    $(".image-setter").hover(function() {
      $(".image-setter").css("background-color", "rgba(0, 0, 0, 0.5)");
      $(".image-camera").css("opacity", "1");
    }, 
    function() {
      $(".image-setter").css("background-color", "transparent");
      $(".image-camera").css("opacity", "0.5");
    })
  })
})
