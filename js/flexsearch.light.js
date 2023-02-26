/**!
 * FlexSearch.js v0.7.31 (Light)
 * Copyright 2018-2022 Nextapps GmbH
 * Author: Thomas Wilkerling
 * Licence: Apache-2.0
 * https://github.com/nextapps-de/flexsearch
 */
(function(self){'use strict';function t(a){return"undefined"!==typeof a?a:!0}function v(a){const c=Array(a);for(let b=0;b<a;b++)c[b]=y();return c}function y(){return Object.create(null)}function z(a,c){return c.length-a.length};const A=/[\p{Z}\p{S}\p{P}\p{C}]+/u;function B(a,c){const b=Object.keys(a),d=b.length,e=[];let h="",f=0;for(let g=0,l,n;g<d;g++)l=b[g],(n=a[l])?(e[f++]=new RegExp(c?"(?!\\b)"+l+"(\\b|_)":l,"g"),e[f++]=n):h+=(h?"|":"")+l;h&&(e[f++]=new RegExp(c?"(?!\\b)("+h+")(\\b|_)":"("+h+")","g"),e[f]="");return e}function C(a,c){for(let b=0,d=c.length;b<d&&(a=a.replace(c[b],c[b+1]),a);b+=2);return a};function D(a){if(a=(""+a).toLowerCase())if(this.o&&(a=C(a,this.o)),this.A&&1<a.length&&(a=C(a,this.A)),A||""===A)if(a=a.split(A),this.filter){var c=this.filter;const b=a.length,d=[];for(let e=0,h=0;e<b;e++){const f=a[e];f&&!c[f]&&(d[h++]=f)}a=d}return a};const F={},G={};function H(a,c,b,d){const e=a.length;let h=[],f,g,l=0;d&&(d=[]);for(let n=e-1;0<=n;n--){const m=a[n],r=m.length,p=y();let q=!f;for(let k=0;k<r;k++){const u=m[k],M=u.length;if(M)for(let E=0,x,w;E<M;E++)if(w=u[E],f){if(f[w]){if(!n)if(b)b--;else if(h[l++]=w,l===c)return h;if(n||d)p[w]=1;q=!0}if(d&&(x=(g[w]||0)+1,g[w]=x,x<e)){const N=d[x-2]||(d[x-2]=[]);N[N.length]=w}}else p[w]=1}if(d)f||(g=p);else if(!q)return[];f=p}if(d)for(let n=d.length-1,m,r;0<=n;n--){m=d[n];r=m.length;for(let p=0,q;p<r;p++)if(q=
m[p],!f[q]){if(b)b--;else if(h[l++]=q,l===c)return h;f[q]=1}}return h};function I(a,c){if(!(this instanceof I))return new I(a);let b;if(a){var d=a.charset;b=a.lang;"string"===typeof d&&(-1===d.indexOf(":")&&(d+=":default"),d=G[d]);"string"===typeof b&&(b=F[b])}else a={};let e,h,f=a.context||{};this.encode=a.encode||d&&d.encode||D;this.register=c||y();this.s=e=a.resolution||9;this.B=c=d&&d.B||a.tokenize||"strict";this.i="strict"===c&&f.depth;this.j=t(f.bidirectional);this.g=h=t(a.optimize);this.m=t(a.fastupdate);this.h=a.minlength||1;this.C=a.boost;this.map=h?v(e):y();
this.v=e=f.resolution||1;this.l=h?v(e):y();this.u=d&&d.u||a.rtl;this.o=(c=a.matcher||b&&b.o)&&B(c,!1);this.A=(c=a.stemmer||b&&b.A)&&B(c,!0);if(a=c=a.filter||b&&b.filter){a=c;d=y();for(let g=0,l=a.length;g<l;g++)d[a[g]]=1;a=d}this.filter=a}I.prototype.append=function(a,c){return this.add(a,c,!0)};
I.prototype.add=function(a,c,b,d){if(c&&(a||0===a)){if(!d&&!b&&this.register[a])return this.update(a,c);c=this.encode(c);if(d=c.length){const n=y(),m=y(),r=this.i,p=this.s;for(let q=0;q<d;q++){let k=c[this.u?d-1-q:q];var e=k.length;if(k&&e>=this.h&&(r||!m[k])){var h=J(p,d,q),f="";switch(this.B){case "full":if(2<e){for(h=0;h<e;h++)for(var g=e;g>h;g--)if(g-h>=this.h){var l=J(p,d,q,e,h);f=k.substring(h,g);K(this,m,f,l,a,b)}break}case "reverse":if(1<e){for(g=e-1;0<g;g--)f=k[g]+f,f.length>=this.h&&K(this,
m,f,J(p,d,q,e,g),a,b);f=""}case "forward":if(1<e){for(g=0;g<e;g++)f+=k[g],f.length>=this.h&&K(this,m,f,h,a,b);break}default:if(this.C&&(h=Math.min(h/this.C(c,k,q)|0,p-1)),K(this,m,k,h,a,b),r&&1<d&&q<d-1)for(e=y(),f=this.v,h=k,g=Math.min(r+1,d-q),e[h]=1,l=1;l<g;l++)if((k=c[this.u?d-1-q-l:q+l])&&k.length>=this.h&&!e[k]){e[k]=1;const u=this.j&&k>h;K(this,n,u?h:k,J(f+(d/2>f?0:1),d,q,g-1,l-1),a,b,u?k:h)}}}}this.m||(this.register[a]=1)}}return this};
function J(a,c,b,d,e){return b&&1<a?c+(d||0)<=a?b+(e||0):(a-1)/(c+(d||0))*(b+(e||0))+1|0:0}function K(a,c,b,d,e,h,f){let g=f?a.l:a.map;if(!c[b]||f&&!c[b][f])a.g&&(g=g[d]),f?(c=c[b]||(c[b]=y()),c[f]=1,g=g[f]||(g[f]=y())):c[b]=1,g=g[b]||(g[b]=[]),a.g||(g=g[d]||(g[d]=[])),h&&g.includes(e)||(g[g.length]=e,a.m&&(a=a.register[e]||(a.register[e]=[]),a[a.length]=g))}
I.prototype.search=function(a,c,b){b||(c||"object"!==typeof a?"object"===typeof c&&(b=c):(b=a,a=b.query));let d=[],e;let h,f=0;if(b){a=b.query||a;c=b.limit;f=b.offset||0;var g=b.context;h=!1}if(a&&(a=this.encode(""+a),e=a.length,1<e)){b=y();var l=[];for(let m=0,r=0,p;m<e;m++)if((p=a[m])&&p.length>=this.h&&!b[p])if(this.g||h||this.map[p])l[r++]=p,b[p]=1;else return d;a=l;e=a.length}if(!e)return d;c||(c=100);g=this.i&&1<e&&!1!==g;b=0;let n;g?(n=a[0],b=1):1<e&&a.sort(z);for(let m,r;b<e;b++){r=a[b];g?
(m=L(this,d,h,c,f,2===e,r,n),h&&!1===m&&d.length||(n=r)):m=L(this,d,h,c,f,1===e,r);if(m)return m;if(h&&b===e-1){l=d.length;if(!l){if(g){g=0;b=-1;continue}return d}if(1===l)return O(d[0],c,f)}}return H(d,c,f,h)};
function L(a,c,b,d,e,h,f,g){let l=[],n=g?a.l:a.map;a.g||(n=P(n,f,g,a.j));if(n){let m=0;const r=Math.min(n.length,g?a.v:a.s);for(let p=0,q=0,k,u;p<r;p++)if(k=n[p])if(a.g&&(k=P(k,f,g,a.j)),e&&k&&h&&(u=k.length,u<=e?(e-=u,k=null):(k=k.slice(e),e=0)),k&&(l[m++]=k,h&&(q+=k.length,q>=d)))break;if(m){if(h)return O(l,d,0);c[c.length]=l;return}}return!b&&l}function O(a,c,b){a=1===a.length?a[0]:[].concat.apply([],a);return b||a.length>c?a.slice(b,b+c):a}
function P(a,c,b,d){b?(d=d&&c>b,a=(a=a[d?c:b])&&a[d?b:c]):a=a[c];return a}I.prototype.contain=function(a){return!!this.register[a]};I.prototype.update=function(a,c){return this.remove(a).add(a,c)};I.prototype.remove=function(a,c){const b=this.register[a];if(b){if(this.m)for(let d=0,e;d<b.length;d++)e=b[d],e.splice(e.indexOf(a),1);else Q(this.map,a,this.s,this.g),this.i&&Q(this.l,a,this.v,this.g);c||delete this.register[a]}return this};
function Q(a,c,b,d,e){let h=0;if(a.constructor===Array)if(e)c=a.indexOf(c),-1!==c?1<a.length&&(a.splice(c,1),h++):h++;else{e=Math.min(a.length,b);for(let f=0,g;f<e;f++)if(g=a[f])h=Q(g,c,b,d,e),d||h||delete a[f]}else for(let f in a)(h=Q(a[f],c,b,d,e))||delete a[f];return h};const R=self;let S;const T={Index:I,Document:null,Worker:null,registerCharset:function(a,c){G[a]=c},registerLanguage:function(a,c){F[a]=c}};(S=R.define)&&S.amd?S([],function(){return T}):R.exports?R.exports=T:R.FlexSearch=T;}(this));