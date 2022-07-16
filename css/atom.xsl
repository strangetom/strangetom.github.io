<?xml version="1.0" encoding="utf-8"?>
<!--
# Pretty Atom Feed
Based on "Pretty RSS Feed": https://github.com/genmon/aboutfeeds
Styles an Atom feed, making it friendly for humans viewers
-->
<xsl:stylesheet
    version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="html" version="4.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
      <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title><xsl:value-of select="atom:feed/atom:title"/></title>
        <style type="text/css">
          @font-face {
            font-family: 'latin_modern';
            src: local('Latin Modern Mono'),
                 url('../fonts/lmmonoproplt10-regular-webfont-subset.woff2') format('woff2');
            font-weight: normal;
            font-style: normal;
            font-display: swap;
          }
          body {
            font-family: sans-serif;
            color: #272427;
            background-color: #fff; 
            background-image: url("../img/page-bg-light.svg");
            margin: 0 auto;
            line-height: 1.5;
            max-width: 800px;
            -webkit-font-smoothing: antialiased;
          }
          .header {
            text-decoration: none; 
          }
          .site {
            font-family: 'latin_modern', sans-serif;  
            font-size: 2.1em; 
            text-transform: uppercase;
            text-align: center;
            transform: scaleY(1.4);
            padding: 0;
            margin: 0;
            color: #272427;
          }
          .container {
            border-top: solid #ccc 5px;
            background-color: #fff;
            padding: 1em;
          }
          h1 {
            margin-top: 0;
          }
          h1 svg {
              padding-right: 0.25rem;
              vertical-align: text-bottom;
              width: 1.2em;
              height: 1.2em;
          }
          h3 {
            font-family: 'latin_modern', sans-serif; 
            margin-bottom: 0;
          }
        </style>
      </head>
      <body>
        <a class="header" href="/">
            <p class="site">Stranger&#160;Foods</p>
        </a>
        <div class="container">
          <h1>
            <svg xmlns="http://www.w3.org/2000/svg" viewbox="0 0 16 16"><path d="M2 0a2 2 0 00-2 2v12a2 2 0 002 2h12a2 2 0 002-2V2a2 2 0 00-2-2H2zm1.5 2.5c5.523 0 10 4.477 10 10a1 1 0 11-2 0 8 8 0 00-8-8 1 1 0 010-2zm0 4a6 6 0 016 6 1 1 0 11-2 0 4 4 0 00-4-4 1 1 0 010-2zm.5 7a1.5 1.5 0 110-3 1.5 1.5 0 010 3z" fill="#272427"/></svg>
            Atom Feed
          </h1>
          <p>This preview only shows titles, but the actual feed contains the full content. <strong>Subscribe</strong> by copying the URL from the address bar into your newsreader.</p>
          <h2>Recent Items</h2>
          <xsl:apply-templates select="atom:feed/atom:entry" />
        </div>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="atom:feed/atom:entry">
    <div class="item">
      <h3>
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="atom:link/@href"/>
          </xsl:attribute>
          <xsl:value-of select="atom:title"/>
        </a>
      </h3>
      <small>
        Published: <xsl:value-of select="atom:published" />
      </small>
    </div>
  </xsl:template>
</xsl:stylesheet>