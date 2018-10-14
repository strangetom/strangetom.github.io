onload = function() {
    // Initialize document element references
    patternField = document.getElementById("search-pattern");
    patternField.oninput = onPatternChange;
    patternField.onpropertychange = patternField.oninput;

    resultsList = document.getElementById("search-results");
};

displayResults = function(results) {
    var newResultsList = resultsList.cloneNode(false);

    // Because adding too many elements is catastrophically slow because HTML is slow
    var max_entries = 20;

    // Create HTML elements for results
    for (index = 0; index < results.length && index < max_entries; ++index) {

        var recipe = results[index];

        var li = document.createElement('li');
        li.classList.add(recipe.category)


        var a = document.createElement('a');
        a.href = recipe.html;

        var img_recipe = document.createElement('img');
        img_recipe.setAttribute('category', recipe.category);
        img_recipe.onerror = function() {
            this.onerror=null;
            this.src="./img/" + this.getAttribute('category') + ".svg";
        };
        img_recipe.classList.add('photo');
        img_recipe.src = recipe.image;                

        var h2_name = document.createElement('h2');
        h2_name.innerHTML = recipe.name;

        a.appendChild(img_recipe);
        a.appendChild(h2_name);

        li.appendChild(a);

        newResultsList.appendChild(li);
    }

    // Replace the old results from the DOM.
    resultsList.parentNode.replaceChild(newResultsList, resultsList);
    resultsList = newResultsList;
};

onPatternChange = function() {

    var options = {
        shouldSort: true,
        threshold: 0.22,
        location: 0,
        distance: 100,
        maxPatternLength: 32,
        minMatchCharLength: 1,
        keys: ["name"]
    };
    var fuse = new Fuse(recipe_data["recipes"], options);
    var pattern = patternField.value;
    if(pattern.length == 0) {
        var emptyList = resultsList.cloneNode(false);
        resultsList.parentNode.replaceChild(emptyList, resultsList);
        resultsList = emptyList;        
        return;
    } else {
        var result = fuse.search(patternField.value);
        displayResults(result);
    };
};
