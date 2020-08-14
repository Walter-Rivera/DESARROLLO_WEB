/*created by Walter Rivera */
'use strict'

    function enlazar(semestre)
    {
        try
        {
            /*primero parseamos la variable a nùmero */
            var valor = parseInt(semestre);
            /*vamos a mostrar los enlaces hasta que nos pidan ver
            los cursos aprobados de los semestres */
            if(valor==0)
            {
                /*vamos a agregar los enlaces cuando nos lo indiquen*/
                var lista = document.getElementById('enlaces');
                    /*en mi caso como sè que ya cursé 10 semestres y aprobè cursos 
                    defino un contador con tales circunstancias*/
                    for(var i=1;i<=10;i++)
                    {
                        /*crear un elemento li */
                        var elementoLi=document.createElement('li');
                        /*crear la etiqueta para enlace*/
                        var link = document.createElement('a');
                        /*para el 1er. semestre*/ 
                        /*texto en el link*/
                        link.innerHTML='semestre'.concat(i);
                        if(i==1)
                        {
                            /*definimos la ruta del  archivo*/
                            link.setAttribute("href","Javascript:enlazar(1)");
                        }
                        else if(i==2)
                        {
                            /*definimos la ruta del  archivo*/
                            link.setAttribute("href","Javascript:enlazar(2)");
                        }
                        else if(i==3)
                        {
                            /*definimos la ruta del  archivo*/
                            link.setAttribute("href","Javascript:enlazar(3)");
                        }
                        else if(i==4)
                        {
                            /*definimos la ruta del  archivo*/
                            link.setAttribute("href","Javascript:enlazar(4)");
                        }
                        else if(i==5)
                        {
                            /*definimos la ruta del  archivo*/
                            link.setAttribute("href","Javascript:enlazar(5)");
                        }
                        else if(i==6)
                        {
                            /*definimos la ruta del  archivo*/
                            link.setAttribute("href","Javascript:enlazar(6)");
                        }
                        else if(i==7)
                        {
                            /*definimos la ruta del  archivo*/
                            link.setAttribute("href","Javascript:enlazar(7)");
                        }
                        else if(i==8)
                        {
                            /*definimos la ruta del  archivo*/
                            link.setAttribute("href","Javascript:enlazar(8)");
                        }
                        else if(i==9)
                        {
                            /*definimos la ruta del  archivo*/
                            link.setAttribute("href","Javascript:enlazar(9)");
                        }
                        else if(i==10)
                        {
                            /*definimos la ruta del  archivo*/
                            link.setAttribute("href","Javascript:enlazar(10)");
                        }
                        /*le agregramos el mismo id para luego borrarlos si da error en alguna parte */
                        elementoLi.setAttribute("id","lis"+i);
                        /*agregamos la etiqueta a al elemento li */
                        elementoLi.appendChild(link);
                        /*agregamos el elementoLi a nuestra lista (UL) = lista */
                        lista.appendChild(elementoLi); 
                      
                }
            
            }
            /*dependiendo si el usuario por ejemplo quiere ver los cursos
            aprobados de un semestre especìfico en el caso de la pagina que tiene 2 frameset, en la 
            parte inferior vamos a mostrar el contenido del que haya sido seleccionado (1 a 10 en este caso) */
            else if(valor==1)
            {
                parent.inferior.location.href="../tarea1/frames/semestre1.html";
            }
            else if(valor==2)
            {
                parent.inferior.location.href="../tarea1/frames/semestre2.html";
            }
            else if(valor==3)
            {
                parent.inferior.location.href="../tarea1/frames/semestre3.html";
            }
            else if(valor==4)
            {
                parent.inferior.location.href="../tarea1/frames/semestre4.html";
            }
            else if(valor==5)
            {
                parent.inferior.location.href="../tarea1/frames/semestre5.html";
            }
            else if(valor==6)
            {
                parent.inferior.location.href="../tarea1/frames/semestre6.html";
            }
            else if(valor==7)
            {
                parent.inferior.location.href="../tarea1/frames/semestre7.html";
            }
            else if(valor==8)
            {
                parent.inferior.location.href="../tarea1/frames/semestre8.html";
            }
            else if(valor==9)
            {
                parent.inferior.location.href="../tarea1/frames/semestre9.html";
            }
            else if(valor==10)
            {
                parent.inferior.location.href="../tarea1/frames/semestre10.html";
            }

        }
        catch(error)
        {
            alert("debe dar click primero en el link Pagina con frames y Framesets para ver los resultados");
            limpiar();
            
          

        }
       
    };

    function limpiar()
    {
        for(var i=1;i<=10;i++)
            {
                var elementoLis = document.getElementById("lis"+i);
                elementoLis.parentNode.removeChild(elementoLis);
            }

    }