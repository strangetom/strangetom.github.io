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
        <link rel="preload" href="/css/header.min.css" as="style"/>
        <style type="text/css">
          @import '../css/colours.min.css';
          @import '../css/header.min.css';
          body {
            font-family: sans-serif;
            background-color: var(--bg-s);
            margin: 0 auto;
            max-width: 90ch;
            padding: 0;
            line-height: 1.5;
          }
          main {
            background-color: var(--bg-s);
            color: var(--fg);
          }
          h1 {
            font-family: 'quattrocento', serif;
            font-size: 2rem;
            font-weight: normal;
            margin: 1rem;
            padding: 0;
            position: relative;
            padding-left: 1.4em;
          }
          p {
            margin: 0 1rem;
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
          #recent {
            margin: 0 1rem;
          }
          #recent a:nth-of-type(odd) h2 {
            /* Swap order of h2 and img */
            text-align: right;
          }
          #recent a:nth-of-type(odd) div {
            /* Swap order of h2 and img */
            order: -1;
          }
          .recipe-card {
            display: grid;
            grid-template-columns: 1fr 1fr;
            grid-gap: .25rem;
            align-items: center;
            justify-items: center;
            margin: -.5rem 0 1rem;
            text-decoration: none;
            color: var(--fg-1);
          }
          .recipe-card h2 {
            font-family: 'quattrocento', serif;
            font-size: 1.2rem;
            font-weight: normal;
            margin: 0;
          }
          .recipe-card h2 .info>span {
            background-color: var(--yellow-alt);
            padding: .2rem .4rem;
            font-size: .9rem;
            color: var(--bg);
            border-radius: var(--small-radius);
            font-weight: bold;
          }
          .recipe-card div {
            position: relative;
          }
          .recipe-card img {
            display: block;
            margin: 0 auto;
            box-shadow: var(--big-shadow);
            height: 180px;
            width: 85%;
            max-width: 512px;
            object-fit: cover;
            border-radius: var(--small-radius);
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
            <a href="/">Stranger&#160;Foods</a>
        </header>
        <main>
          <h1>
            Atom Feed
          </h1>
          <p>Subscribe by copying the URL from the address bar into your newsreader.</p>
          <hr/>
          <section id="recent">
            <xsl:apply-templates select="atom:feed/atom:entry" >
              <xsl:sort select="position()" data-type="number" order="descending"/>
            </xsl:apply-templates>
          </section>
        </main>
      </body>
      <script type="text/javascript">
        let imgs = document.querySelectorAll("img");
        imgs.forEach(img => {
          img.addEventListener("error", (e) => {
            e.target.src = "/img/placeholder.webp";
          })
        })
      </script>
    </html>
  </xsl:template>
  <xsl:template match="atom:feed/atom:entry">
    <a class="recipe-card">
      <xsl:attribute name="href">
        <xsl:value-of select="atom:link/@href"/>
      </xsl:attribute>
      <h2>
        <xsl:value-of select="atom:title"/>
        <div class="info">
          <span>
            <xsl:value-of select="substring(atom:published, 0, 11)"/>
          </span>
        </div>
      </h2>
      <div>
        <img>
          <xsl:attribute name="src">
            <xsl:value-of select="media:group/media:thumbnail/@url"/>
          </xsl:attribute>
          <xsl:attribute name="alt">
            Photograph of <xsl:value-of select="atom:title"/>
          </xsl:attribute>
        </img>
      </div>
    </a>
    <hr/>
  </xsl:template>
</xsl:stylesheet>