<?xml version="1.0" encoding="utf-8"?>
<!--
# Pretty Atom Feed
Based on "Pretty RSS Feed": https://github.com/genmon/aboutfeeds
Styles an Atom feed, making it friendly for humans viewers
-->
<xsl:stylesheet
    version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:atom="http://www.w3.org/2005/Atom"
    xmlns:media="http://search.yahoo.com/mrss/">
  <xsl:output method="html" version="4.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title><xsl:value-of select="atom:feed/atom:title"/></title>
        <link rel="preload" href="/css/colours.min.css" as="style"/>
        <style type="text/css">
          @import '../css/colours.min.css';
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
            background-color: var(--bg);
            margin: 0 auto;
            padding: 0;
            line-height: 1.5;
            max-width: 90ch;
            display: flex;
            flex-flow: column;
            height: 100vh;
            -webkit-font-smoothing: antialiased;
          }
          header {
            color: var(--fg);
            border-bottom: 5px double var(--fg);
          }
          header a {
            text-decoration: none;
          }
          header p {
            font-family: 'latin_modern', sans-serif;
            font-size: 2.1rem; 
            text-transform: uppercase;
            text-align: center;
            transform: scaleY(1.4);
            padding: 0;
            margin: 0;
            color: var(--fg);
          }
          .container {
            background-color: var(--bg-s);
            color: var(--fg);
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
          .recent {
            display: grid;
            /* The body is 90ch wide with a padding of 1 rem on each side. 
            The grid layout has a gap of 10 px between items and padding of 5 px of each side.
            Therefore to get two colums, each column must by (90ch - 2 rem - 10px)/2 wide. */
            grid-template-columns: repeat(auto-fill, calc(calc(90ch - 2rem - 20px) / 2));
            grid-auto-flow: row;
            gap: 10px;
            padding: 0 5px;
            justify-items: center;
          }
          .recent a {
            padding: 0;
            text-align: left;
            text-decoration: none;
            color: #fff;
            margin: 5px; 
            border-radius: var(--photo-radius);
            height: 220px;
            width: calc(100% - 10px);
          }
          .recent h3 {
            position: relative;
            font-family: latin_modern,sans-serif;
            font-weight: 700;
            font-size: 1.25rem;
            margin: 0;
            padding: 10px;
            height: 100%;
            border: 1px solid var(--bg-2);
            background: var(--bg-img),linear-gradient(rgb(100,100,100),20%,transparent);
            background-size: auto 100%;
            background-position: 50%;
            background-blend-mode: multiply;
            border-radius: var(--photo-radius);
            box-shadow: var(--big-shadow);
            box-sizing: border-box;
          }
          .recipe-label {
            font-family: sans-serif;
            font-size: .9rem;
            font-weight: 400;
            display: inline-block;
            margin: 3px;
            padding: 4px 12px;
            color: var(--fg);
            background-color: var(--bg);
            border-radius: var(--button-radius);
            border: 1px solid var(--bg-2);
            box-shadow: var(--small-shadow);
            position: absolute;
            left: 5px;
            bottom: 0;
          }
          .recipe-label-icon {
            position: relative;
            bottom: -2px;
            margin-right: .5rem;
          }
        </style>
        <script type="text/javascript">
          if (localStorage.getItem("light-theme") == "true") {
            let html = document.querySelector("html");
            html.classList.add("light-theme");
          }
        </script>
      </head>
      <body>
        <header>
          <a href="/">
              <p>Stranger&#160;Foods</p>
          </a>
        </header>
        <div class="container">
          <h1>
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewbox="0 0 16 16">
              <path d="M2 0a2 2 0 00-2 2v12a2 2 0 002 2h12a2 2 0 002-2V2a2 2 0 00-2-2H2zm1.5 2.5c5.523 0 10 4.477 10 10a1 1 0 11-2 0 8 8 0 00-8-8 1 1 0 010-2zm0 4a6 6 0 016 6 1 1 0 11-2 0 4 4 0 00-4-4 1 1 0 010-2zm.5 7a1.5 1.5 0 110-3 1.5 1.5 0 010 3z" fill="var(--orange-alt)"/>
            </svg>
            Atom Feed
          </h1>
          <p><strong>Subscribe</strong> by copying the URL from the address bar into your newsreader.</p>
          <h2>Recent Items</h2>
          <div class="recent">
            <xsl:apply-templates select="atom:feed/atom:entry" >
              <xsl:sort select="position()" data-type="number" order="descending"/>
            </xsl:apply-templates>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="atom:feed/atom:entry">
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="atom:link/@href"/>
      </xsl:attribute>
      <h3>
        <xsl:attribute name="style">--bg-img: url('<xsl:value-of select="media:group/media:thumbnail/@url"/>');</xsl:attribute>
        <xsl:value-of select="atom:title"/>
        <span class="recipe-label">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="recipe-label-icon" viewBox="0 0 16 16">
            <path d="M4 .5a.5.5 0 0 0-1 0V1H2a2 2 0 0 0-2 2v1h16V3a2 2 0 0 0-2-2h-1V.5a.5.5 0 0 0-1 0V1H4V.5zM16 14V5H0v9a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2zM9.5 7h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5zm3 0h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5zM2 10.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm3.5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5z"/>
          </svg>
          <xsl:value-of select="substring(atom:published, 0, 11)"/>
        </span>
      </h3>
    </a>
  </xsl:template>
</xsl:stylesheet>