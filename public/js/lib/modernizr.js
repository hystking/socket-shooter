/*! modernizr 3.0.0-alpha.4 (Custom Build) | MIT *
 * http://modernizr.com/download/#-shiv !*/
!function(e,n){function t(e,n){return typeof e===n}function a(){var e,n,a,r,i,c,l;for(var f in o){if(e=[],n=o[f],n.name&&(e.push(n.name.toLowerCase()),n.options&&n.options.aliases&&n.options.aliases.length))for(a=0;a<n.options.aliases.length;a++)e.push(n.options.aliases[a].toLowerCase());for(r=t(n.fn,"function")?n.fn():n.fn,i=0;i<e.length;i++)c=e[i],l=c.split("."),1===l.length?Modernizr[l[0]]=r:(!Modernizr[l[0]]||Modernizr[l[0]]instanceof Boolean||(Modernizr[l[0]]=new Boolean(Modernizr[l[0]])),Modernizr[l[0]][l[1]]=r),s.push((r?"":"no-")+l.join("-"))}}function r(e){var n=c.className,t=Modernizr._config.classPrefix||"";if(l&&(n=n.baseVal),Modernizr._config.enableJSClass){var a=new RegExp("(^|\\s)"+t+"no-js(\\s|$)");n=n.replace(a,"$1"+t+"js$2")}Modernizr._config.enableClasses&&(n+=" "+t+e.join(" "+t),l?c.className.baseVal=n:c.className=n)}var o=[],i={_version:"3.0.0-alpha.4",_config:{classPrefix:"",enableClasses:!0,enableJSClass:!0,usePrefixes:!0},_q:[],on:function(e,n){var t=this;setTimeout(function(){n(t[e])},0)},addTest:function(e,n,t){o.push({name:e,fn:n,options:t})},addAsyncTest:function(e){o.push({name:null,fn:e})}},Modernizr=function(){};Modernizr.prototype=i,Modernizr=new Modernizr;var s=[],c=n.documentElement,l="svg"===c.nodeName.toLowerCase();l||!function(e,n){function t(e,n){var t=e.createElement("p"),a=e.getElementsByTagName("head")[0]||e.documentElement;return t.innerHTML="x<style>"+n+"</style>",a.insertBefore(t.lastChild,a.firstChild)}function a(){var e=y.elements;return"string"==typeof e?e.split(" "):e}function r(e,n){var t=y.elements;"string"!=typeof t&&(t=t.join(" ")),"string"!=typeof e&&(e=e.join(" ")),y.elements=t+" "+e,l(n)}function o(e){var n=E[e[g]];return n||(n={},v++,e[g]=v,E[v]=n),n}function i(e,t,a){if(t||(t=n),u)return t.createElement(e);a||(a=o(t));var r;return r=a.cache[e]?a.cache[e].cloneNode():p.test(e)?(a.cache[e]=a.createElem(e)).cloneNode():a.createElem(e),!r.canHaveChildren||h.test(e)||r.tagUrn?r:a.frag.appendChild(r)}function s(e,t){if(e||(e=n),u)return e.createDocumentFragment();t=t||o(e);for(var r=t.frag.cloneNode(),i=0,s=a(),c=s.length;c>i;i++)r.createElement(s[i]);return r}function c(e,n){n.cache||(n.cache={},n.createElem=e.createElement,n.createFrag=e.createDocumentFragment,n.frag=n.createFrag()),e.createElement=function(t){return y.shivMethods?i(t,e,n):n.createElem(t)},e.createDocumentFragment=Function("h,f","return function(){var n=f.cloneNode(),c=n.createElement;h.shivMethods&&("+a().join().replace(/[\w\-:]+/g,function(e){return n.createElem(e),n.frag.createElement(e),'c("'+e+'")'})+");return n}")(y,n.frag)}function l(e){e||(e=n);var a=o(e);return!y.shivCSS||f||a.hasCSS||(a.hasCSS=!!t(e,"article,aside,dialog,figcaption,figure,footer,header,hgroup,main,nav,section{display:block}mark{background:#FF0;color:#000}template{display:none}")),u||c(e,a),e}var f,u,m="3.7.2",d=e.html5||{},h=/^<|^(?:button|map|select|textarea|object|iframe|option|optgroup)$/i,p=/^(?:a|b|code|div|fieldset|h1|h2|h3|h4|h5|h6|i|label|li|ol|p|q|span|strong|style|table|tbody|td|th|tr|ul)$/i,g="_html5shiv",v=0,E={};!function(){try{var e=n.createElement("a");e.innerHTML="<xyz></xyz>",f="hidden"in e,u=1==e.childNodes.length||function(){n.createElement("a");var e=n.createDocumentFragment();return"undefined"==typeof e.cloneNode||"undefined"==typeof e.createDocumentFragment||"undefined"==typeof e.createElement}()}catch(t){f=!0,u=!0}}();var y={elements:d.elements||"abbr article aside audio bdi canvas data datalist details dialog figcaption figure footer header hgroup main mark meter nav output picture progress section summary template time video",version:m,shivCSS:d.shivCSS!==!1,supportsUnknownElements:u,shivMethods:d.shivMethods!==!1,type:"default",shivDocument:l,createElement:i,createDocumentFragment:s,addElements:r};e.html5=y,l(n)}(this,n),a(),r(s),delete i.addTest,delete i.addAsyncTest;for(var f=0;f<Modernizr._q.length;f++)Modernizr._q[f]();e.Modernizr=Modernizr}(window,document);