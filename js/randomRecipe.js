function randomRecipe() {
	var list = document.getElementsByClassName('recipe-list')[0];
	var rand = Math.floor(Math.random() * (list.childElementCount-1)) + 1;
	var randItem = list.children[rand]
	randItem.removeAttribute('id');
	var recipe = document.getElementsByClassName('random-recipe')[0];
	recipe.innerHTML = randItem.innerHTML;
}