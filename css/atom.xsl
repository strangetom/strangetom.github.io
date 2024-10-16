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
          body {
            font-family: sans-serif;
            background-color: var(--bg-s);
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
            color: var(--fg-1);
            border-bottom: 5px double var(--fg-1);
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
            color: var(--fg-1);
          }
          .container {
            background-color: var(--bg-s);
            color: var(--fg-1);
            padding: 1em; 
          }
          h1 {
            margin-top: 0;
            padding-left: 1.4em;
            position: relative;
          }
          h1:after {
            content: "";
            background: url("/img/feed.svg");
            background-repeat: no-repeat;
            background-size: cover;
            width: 1em;
            height: 1em;
            position: absolute;
            left: 0;
            bottom: 50%;
            transform: translate(0, 50%);
          }
          h2 {
            font-family: 'latin_modern', sans-serif;  
            font-size: 1.8rem;
            font-weight: normal;
            margin: 0;
            color: var(--fg);
            text-align: center;
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
            justify-content: center;
          }
          .recent a {
            display: block;
            padding: 0;
            text-align: left;
            scroll-snap-align: start;
            text-decoration: none;
            color: #fff;
            margin: 5px; 
            border-radius: var(--photo-radius);
          }
          .recent h3 {
            font-family: 'latin_modern', sans-serif;
            font-weight: bold;
            font-size: 1.35rem;
            margin: 0;
            padding: 10px;
            height: 140px;
            border: 1px solid var(--bg-2);
            background: var(--bg-img),linear-gradient(rgb(70, 70, 70), 40%, transparent);
            background-size: 100% auto;
            background-position: 50%;
            background-blend-mode: multiply;
            border-radius: var(--photo-radius);
            box-shadow: var(--big-shadow);
            position: relative;
            color: #ebdbb2; /* --fg-1 */
            letter-spacing: 1px;
            text-shadow: rgba(0,0,0,.5) 2px 2px 1px;
          }
          .recipe-label {
            font-family: sans-serif;
            font-size: 0.9rem;
            font-weight: normal;
            display: inline-block;
            margin: 3px;
            padding: 4px 12px;
            color: var(--fg-1);
            background-color: var(--bg-1);
            border-radius: var(--button-radius);
            border: 1px solid var(--bg-3);
            box-shadow: var(--small-shadow);
            text-shadow: none;
            position: absolute;
            left: 5px;
            bottom: 0;
          }
          .recipe-label-icon {
            height: calc(1em + .5px);
            width: 1em;
            margin-right: .5rem;
            position: relative;
            bottom: -2px;
          }
          hr {
            padding: 0;
            height: 1rem;
            border: none;
            border-top: 1px solid var(--fg-1);
            color: var(--fg-1);
            text-align: center;
            overflow: visible;
          }
          hr:after {
            content: "§";
            display: inline-block;
            position: relative;
            top: -0.8em;
            font-size: 1.2rem;
            padding: 0 0.25em;
            background: var(--bg-s);
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
            Atom Feed
          </h1>
          <p>Subscribe by copying the URL from the address bar into your newsreader.</p>
          <h2>Recent Items</h2>
          <hr/>
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