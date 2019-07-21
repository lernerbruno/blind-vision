visualInterface = {};
visualInterface.helpButton = $(".help-button");
visualInterface.contrastButton = $(".contrast-button");
visualInterface.contrastList = ["first", "second", "third"];
visualInterface.body = $("body");
visualInterface.help = $(".help");
visualInterface.contrast = $(".contrast");
visualInterface.image = $(".image")[0];
visualInterface.data = {}; 


visualInterface.helpButton.on("mousedown", function(){
    visualInterface.help[0].classList.add("change-contrast");
    console.log("HELP REQUESTED");
})
visualInterface.helpButton.on("mouseup", function(){
    visualInterface.help[0].classList.remove("change-contrast");
})

visualInterface.contrastButton.on("click", function(){
    var className = visualInterface.body[0].className;
    var index = visualInterface.contrastList.indexOf(className);
    if(index == (visualInterface.contrastList.length)-1){
        index = 0
    }else{
        index += 1;
    }
    var newContrast = visualInterface.contrastList[index];
    visualInterface.body[0].classList.remove(className);
    visualInterface.body[0].classList.add(newContrast);
})


visualInterface.plotObjects = function(data){
    visualInterface.image.innerHTML="";
    if(data["faces"] != null){
        visualInterface.plotFaces(data["faces"]);
    }
    if(data["final_dest"] != null){
        visualInterface.plotDestination(data["final_dest"])
    }
}

visualInterface.plotFaces = function(data){
    if(jQuery.isEmptyObject(data)){
        return
    }
    for(var i=0;i<data.length;i++){
        var face = document.createElement("div");
        face.innerHTML="0";
        visualInterface.image.append(face);
        var x = (data[i][0]/640)*100;
        var y = (data[i][1]/480)*100;
        face.classList.add("face");
        face.style.left=x+'%';
        face.style.top=y+'%';
    }
}

visualInterface.plotDestination = function(data){
    if(jQuery.isEmptyObject(data)){
        return
    }
    var x = (data[0]/640)*100;
    var y = (data[1]/480)*100;
    var destination = document.createElement("div");
    destination.innerHTML="X";
    visualInterface.image.append(destination);
    destination.classList.add("destination");
    destination.style.left=x+'%';
    destination.style.top=y+'%';
}

$(window).on("load", function(){
    var interval = setInterval(function(){
        $.ajax({
            type: "GET",
            crossDomain: true,
            url: "http://192.168.1.83:5000/get_kinect",
            success: function (response) {
                visualInterface.plotObjects(response);
            },
            error: function (response){
                visualInterface.image.innerHTML="Error connecting to the server..."
            }
        })
    }, 1000)
})