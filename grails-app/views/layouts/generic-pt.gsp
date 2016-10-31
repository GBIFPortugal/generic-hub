<g:set var="orgNameLong" value="${grailsApplication.config.skin.orgNameLong}"/>
<g:set var="orgNameShort" value="${grailsApplication.config.skin.orgNameShort}"/>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <alatag:addApplicationMetaTags />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    %{--<link rel="shortcut icon" type="image/x-icon" href="favicon.ico">--}%

    <title><g:layoutTitle /></title>
    <r:require modules="bootstrap, hubCore, pt" />
    <r:script disposition='head'>
        // initialise plugins
        jQuery(function(){
            // autocomplete on navbar search input
            jQuery("form#search-form-2011 input#search-2011, form#search-inpage input#search, input#search-2013").autocomplete('http://bie.ala.org.au/search/auto.jsonp', {
                extraParams: {limit: 100},
                dataType: 'jsonp',
                parse: function(data) {
                    var rows = new Array();
                    data = data.autoCompleteList;
                    for(var i=0; i<data.length; i++) {
                        rows[i] = {
                            data:data[i],
                            value: data[i].matchedNames[0],
                            result: data[i].matchedNames[0]
                        };
                    }
                    return rows;
                },
                matchSubset: false,
                formatItem: function(row, i, n) {
                    return row.matchedNames[0];
                },
                cacheLength: 10,
                minChars: 3,
                scroll: false,
                max: 10,
                selectFirst: false
            });

            // Mobile/desktop toggle
            // TODO: set a cookie so user's choice is remembered across pages
            var responsiveCssFile = $("#responsiveCss").attr("href"); // remember set href
            $(".toggleResponsive").click(function(e) {
                e.preventDefault();
                $(this).find("i").toggleClass("icon-resize-small icon-resize-full");
                var currentHref = $("#responsiveCss").attr("href");
                if (currentHref) {
                    $("#responsiveCss").attr("href", ""); // set to desktop (fixed)
                    $(this).find("span").html("Mobile");
                } else {
                    $("#responsiveCss").attr("href", responsiveCssFile); // set to mobile (responsive)
                    $(this).find("span").html("Desktop");
                }
            });

            $('.helphover').popover({animation: true, trigger:'hover'});
        });
    </r:script>
    <r:layoutResources/>
    <g:layoutHead />
</head>

<body class="${pageProperty(name:'body.class')?:'nav-collections'}" id="${pageProperty(name:'body.id')}" onload="${pageProperty(name:'body.onload')}">
<g:set var="fluidLayout" value="${grailsApplication.config.skin.fluidLayout?.toBoolean()}"/>

<div class="header">
    <a href="" style="margin-left:0px"><img src="${resource(dir:'images',file:'gbifpt92_1.png')}" alt=""></a>
    <div id="site-slogan"><g:message code="site.slogan"/></div>        
    <div id="site-name"><strong><a href="/" title="Home" rel="home"><span><g:message code="site.name"/></span></a></strong></div>
</div><!-- End header -->

<nav class="navbar" role="navigation">
  <div class="${fluidLayout?'container-fluid':'container'} container-fluid-navbar">
    <div>
      <ul class="nav span12 pull-left">
        <li><a href="http://www.gbif.pt"><g:message code="home.menu.home"/></a></li>
        <li><a href="http://www.gbif.pt/taxonomy/term/28"><g:message code="home.menu.news"/></a></li>
        <li><a href="http://www.gbif.pt/taxonomy/term/29"><g:message code="home.menu.participation"/></a></li>
        <li class="active"><a href="http://www.gbif.pt/taxonomy/term/30"><g:message code="home.menu.data"/></a></li>
        <li><a href="http://www.gbif.pt/taxonomy/term/44"><g:message code="home.menu.cooperation"/></a></li>
        <li><a href="http://www.gbif.pt/taxonomy/term/31"><g:message code="home.menu.resources"/></a></li>
        <li><a href="http://www.gbif.pt/taxonomy/term/32"><g:message code="home.menu.about"/></a></li>
      </ul>
    </div>
    <div>
      <ul class="nav navbar pull-right"> 
        %{--<li><langs:selector langs="pt_PT, en"/></li>--}%
            <locale:switchLocale />
      </ul>
    </div>
  </div>
</nav><!-- End top menu -->

<nav class="navbar navbar2" role="navigation">
  <div class="navbar-inner navbar-ala">
    <div class="container">
 
      <!-- .btn-navbar is used as the toggle for collapsed navbar content -->
      <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </a>
 
      <!-- Be sure to leave the brand out there if you want it shown -->
      <a class="navbar-brand" href="#"><g:message code="ala.site.name"/></a>
 
      <!-- Everything you want hidden at 940px or less, place within here -->
      <div class="nav-collapse collapse ala-collapse">
        <ul class="nav pull-right" id="navbar1">
          <li><a href="/index.html"><g:message code="ala.menu.home"/></a></li>
          <li><a href="${grailsApplication.config.grails.serverURL}"><g:message code="ala.menu.occurrences"/></a></li>
          <!--<li><a href="/species.html"><g:message code="ala.menu.data"/></a></li>-->
          <li><a href="${grailsApplication.config.grails.serverURL}/explore/your-area?default=true"><g:message code="ala.menu.location"/></a></li>
          <li><a href="${grailsApplication.config.collections.baseUrl}/datasets"><g:message code="ala.menu.datasets"/></a></li>
          <li><a href="${grailsApplication.config.collections.baseUrl}"><g:message code="ala.menu.publishers"/></a></li>
        </ul>
      </div>
 
    </div>
  </div>
</nav>

<div class="${fluidLayout?'container-fluid':'container'}" id="main-content">
    <g:layoutBody />
</div>

<!-- Other data portals -->
<div class="row lowerbar">
  <div class="span1"><h2>Portais de dados GBIF</h2>
    <p>Global: <span>
    <a href="http://www.gbif.org/occurrence">GBIF.ORG</a></span></p>
    <p>Suportados pelo ALA:</p>
    <ul>
      <!-- <li><a href="#">Argentina</a></li> -->
      <li><a href="http://www.ala.org.au/">Austrália</a></li>
      <li><a href="https://portaldabiodiversidade.icmbio.gov.br/portal/">Brasil (Min. Ambiente)</a></li>
      <!-- <li><a href="#">Costa Rica</a></li> -->
      <li><a href="http://datos.gbif.es/">Espanha</a></li>
      <li><a href="http://www.als.scot/">Escócia</a></li>
      <li><a href="http://portail.gbif.fr/">França</a></li>
      <li><a href="http://ala-demo.gbif.org/">Reino Unido (demo)</a></li>
    </ul>
    <p>Outros portais</p>
    <ul>
      <li><a href="http://gbif.sibbr.gov.br/explorador/pt/busca">Brasil (SiBBr)</a></li>
      <li><a href="http://www.enciclovida.mx">México</a></li>
      <li><a href="http://gis.biomap.pl/?lang=en">Polónia</a></li>
    </ul>
  </div>
  <div class="span1"><h2><a href="http://www.gbif.pt">Início</a></h2></div>
    <div class="span1"><h2><a href="http://www.gbif.pt/taxonomy/term/28">Notícias</a></h2></div>
    <div class="span1"><h2><a href="http://www.gbif.pt/taxonomy/term/29">Participar</a></h2>
      <ul>
        <li><a href="http://www.gbif.pt/node/18">Publicadores Portugueses</a></li>
        <li><a href="http://www.gbif.pt/node/28">Acordo de partilha de dados</a></li>
        <li><a href="http://www.gbif.pt/node/133">Ciclo de publicação de dados</a></li>
        <li><a href="http://www.gbif.pt/node/17">Como partilhar</a></li>
        <li><a href="http://www.gbif.pt/node/46">Informação sobre uso</a></li>
        <li><a href="http://www.gbif.pt/node/16">Porquê partilhar</a></li>
        <li><a href="http://www.gbif.pt/node/115">Questionário</a></li>
      </ul>
    </div>
    <div class="span1"><h2><a href="http://www.gbif.pt/taxonomy/term/30">Dados</a></h2>
      <ul>
        <li><a href="http://www.gbif.pt/node/25">Acordo de utilização de dados</a></li>
        <li><a href="http://www.gbif.pt/node/24">Pesquisar e aceder aos dados</a></li>
        <li><a href="http://www.gbif.pt/node/133">Exemplos de uso dos dados</a></li>
        <li><a href="http://www.gbif.pt/node/17">Política de Acesso Aberto</a></li>
      </ul>
    </div>
    <div class="span1"><h2><a href="http://www.gbif.pt/taxonomy/term/44">Cooperação</a></h2>
      <ul>
        <li><a href="http://www.gbif.pt/taxonomy/term/51">Aumento de capacitação GBIF</a></li>
        <li><a href="http://www.gbif.pt/taxonomy/term/45">Pesquisar e aceder aos dados</a></li>
        <li><a href="http://www.gbif.pt/taxonomy/term/47">Exemplos de uso dos dados</a></li>
      </ul>
    </div>
    <div class="span1"><h2><a href="http://www.gbif.pt/taxonomy/term/31">Recursos</a></h2>
      <ul>
        <li><a href="http://www.gbif.pt/taxonomy/term/49">Apresentações</a></li>
        <li><a href="http://www.gbif.pt/taxonomy/term/42">Formação</a></li>
        <li><a href="http://www.gbif.pt/taxonomy/term/50">Materiais promocionais</a></li>
        <li><a href="http://www.gbif.pt/taxonomy/term/39">Padrões</a></li>
        <li><a href="http://www.gbif.pt/taxonomy/term/40">Software</a></li>
        <li><a href="http://www.gbif.pt/taxonomy/term/38">Manuais</a></li>
        <li><a href="http://www.gbif.pt/taxonomy/term/43">Folha informativa</a></li>
      </ul>
    </div>
    <div class="span1"><h2><a href="http://www.gbif.pt/taxonomy/term/32">Sobre nós</a></h2>
      <ul>
        <li><a href="http://www.gbif.pt/node/83">Sobre o Nó Português</a></li>
        <li><a href="http://www.gbif.pt/taxonomy/term/37">Antecedentes</a></li>
        <li><a href="http://www.gbif.pt/node/79">Contactos</a></li>
        <li><a href="http://www.gbif.pt/taxonomy/term/48">Relatórios</a></li>
      </ul>
    </div>
    <div class="span1"><h2>Redes sociais</h2>
      <ul class="list-inline">
      <li><a href="https://twitter.com/gbifportugal" target="_blank"><i class="fa fa-twitter fa-lg"></i><span class="sr-only"> Twitter</span></a></li>
      <li><a href="https://www.facebook.com/pages/Nó-Português-do-GBIF/294265787393100" target="_blank"><i class="fa fa-facebook fa-lg"></i><span class="sr-only"> Facebook</span></a></li>
      </ul>
    </div>
</div>


</div>

<section class="partners">
    <div class="container-fluid">
      <p> Este portal de dados é suportado por:</p>
      <div class="span2">
        <a href="http://www.ala.org.au/" target="_blank"><img src="${resource(dir:'images',file:'ala-logo1.png')}" alt="Atlas  of Living Australia" title="Atlas  of Living Australia"/></a>
      </div>
      <div class="span2">
          <a href="http://www.gbif.org/" target="_blank"><img src="${resource(dir:'images',file:'GBIF-2015.png')}" alt="GBIF" title="GBIF"/></a>
      </div>
      <div class="span2">
          <a href="https://crowdin.com/" target="_blank"><img src="${resource(dir:'images',file:'crowdin-white.png')}" alt="crowdin" title="crowdin"/></a>
      </div>
      <div class="span2">
          <a href="https://www.incd.pt/ " target="_blank"><img src="${resource(dir:'images',file:'incd-logo-gray.png')}" alt="INCD" title="INCD"/></a>
      </div>
      <div class="span2">
          <span style="font-size: 24px; font-weight: bold; text-transform: uppercase;">PORBIOTA</span>
      </div>
      <div class="span2">
          <a href="https://www.gbif.pt/ " target="_blank"><img src="${resource(dir:'images',file:'GBIFPORTUGAL.png')}" alt="GBIF Portugal" title="GBIF Portugal"/></a>
      </div>
    </div>
  </section>
  <div class="credits">Créditos:<br>
    Fotografias: <a href="https://www.flickr.com/photos/83637132@N02">César Garcia</a>.
    Esta página usa a biblioteca css <a href="http://getbootstrap.com">Bootstrap 3</a>, incluindo icons <a href="http://glyphicons.com/">Glyphicons</a> e fontes <a href="http://fortawesome.github.io/Font-Awesome/">FontAwesome</a>.
  </div>

<div id="footer">
    <div class="container-fluid">
        <div class="row-fluid" style="padding-top: 10px">
            Excepto quando declarado, os conteúdos deste sítio são licenciados através da licença <a href="https://creativecommons.org/licenses/by/3.0/pt/" title="External link to Creative Commons" class="external">Creative Commons Atribuição 3.0 Portugal</a>.
            <a href="http://creativecommons.org/licenses/by/3.0/pt/" title="External link to Creative Commons"><img src="http://i.creativecommons.org/l/by/3.0/88x31.png" width="88" height="31" alt=""></a>
        </div>
        <div class="row-fluid">
            A utilização de conteúdos GBIF está sujeito ao <a href="http://www.gbif.org/terms/licences/data-use" title="Acordo de Utilização de Dados">Acordo de Utilização de Dados GBIF</a>, e à <a href="http://www.gbif.pt/node/116" title="Política de Privacidade">Política de Privacidade</a>.
        </div>
    </div>
</div>
<div id="footer" style="border-top: none">
    <div class="container-fluid">
        <div class="row-fluid">
        O <a href="http://www.gbif.pt" title="Nó Português do GBIF">Nó Português do GBIF</a> é acolhido pelo <a href="http://www.isa.ulisboa.pt" title="Instituto Superior de Agronomia (ISA)">Instituto Superior de Agronomia (ISA)</a>,
com o apoio da <a href="http://www.fct.pt" title="Fundação para a Ciência e a Tecnologia (FCT)">Fundação para a Ciência e a Tecnologia (FCT)</a>.
        </div>
    </div>
</div><!--/#footer -->
<br/>

<!-- JS resources-->
<r:layoutResources/>

<script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-41841769-3', 'auto');
    ga('send', 'pageview');

</script>
</body>
</html>
