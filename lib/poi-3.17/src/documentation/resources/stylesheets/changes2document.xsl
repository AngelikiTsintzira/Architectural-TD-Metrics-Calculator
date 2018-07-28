<?xml version="1.0"?>
<!--
   ====================================================================
   Licensed to the Apache Software Foundation (ASF) under one or more
   contributor license agreements.  See the NOTICE file distributed with
   this work for additional information regarding copyright ownership.
   The ASF licenses this file to You under the Apache License, Version 2.0
   (the "License"); you may not use this file except in compliance with
   the License.  You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
   ====================================================================
-->

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

 <xsl:param name="bugtracking-url"/>
 <!-- FIXME : Get the Github URL from properties -->
 <xsl:variable name="github-url" select="'https://github.com/apache/poi'"/>

 <xsl:variable name="bugdetails" select="concat($bugtracking-url, 'show_bug.cgi?id=')"/>
 <xsl:variable name="buglist" select="concat($bugtracking-url, 'buglist.cgi?bug_id=')"/>

 <xsl:template match="link">
   <!-- FIXME! This doesn't work for href or name. Use the externally defined link->a transform if possible -->
   <link href="{@href}"><xsl:apply-templates/></link>
 </xsl:template>

 <!-- usage: <bug num="12345"/> or <bug num="12345,12346"/> or <bug num="github-12"/> -->
 <xsl:template match="bug">
    <xsl:choose>
     <xsl:when test="contains(@num, ',')">
      <link href="{$buglist}{translate(normalize-space(@num),' ','')}">
       <xsl:text></xsl:text><xsl:value-of select="normalize-space( translate(@num, ',', ' ') )"/>
      </link>
     </xsl:when>
     <xsl:otherwise>
      <xsl:choose>
       <xsl:when test="contains(@num, 'github-')">
         <link href="{$github-url}/pull/{translate(@num,'github-','')}">
         <xsl:text></xsl:text><xsl:value-of select="@num"/>
         </link>
       </xsl:when>
       <xsl:otherwise>
         <link href="{$bugdetails}{@num}">
         <xsl:text></xsl:text><xsl:value-of select="@num"/>
         </link>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:otherwise>
    </xsl:choose>
 </xsl:template>

 <xsl:template match="devs"/>
 
 <xsl:template match="changes">
  <document>
   <header>
    <title>History of Changes</title>
   </header>
   <body>
    <p><link href="changes.rss"><img src="images/rss.png" alt="RSS" title="RSS"/></link></p>    
    <xsl:apply-templates/>
   </body>
  </document>
 </xsl:template>

 <xsl:template match="release">
  <section id="{@version}">
   <title>Version <xsl:value-of select="@version"/> (<xsl:value-of select="@date"/>)</title>
    <xsl:apply-templates/>
  </section>
 </xsl:template>

 <xsl:template match="summary">
  <section>
   <title>Summary</title>
    <ul> <!-- create a new list for each noteable change in the summary -->
     <xsl:apply-templates/> <!-- summary-item's -->
    </ul>
  </section>
 </xsl:template>

 <xsl:template match="summary-item">
  <li>
    <xsl:apply-templates/>
  </li>
 </xsl:template>

 <xsl:template match="actions">
   <section><title>Changes</title>
     <table>
       <thead>
         <tr>
           <th>Type</th>
           <th>Bug</th>
           <th style="min-width: 100px;">Module</th>
           <th style="width: 100%;">Description</th>
         </tr>
       </thead>

       <tbody>
         <!-- TODO: sort actions by type -->
         <xsl:apply-templates/> <!-- action's -->
       </tbody>

     </table>
   </section>
 </xsl:template>

 <xsl:template match="action">
  <tr>

  <td style="text-align: center;">
   <icon src="skin/images/{@type}.png" alt="{@type}" title="{@type}"/>
  </td>

  <td>
   <!-- TODO: duplicate code. replace with the <xsl:template match="bug"/> defined above -->
   <xsl:if test="@fixes-bug">
    <xsl:choose>
     <xsl:when test="contains(@fixes-bug, ',')">
      <link href="{$buglist}{translate(normalize-space(@fixes-bug),' ','')}">
       <xsl:text></xsl:text><xsl:value-of select="normalize-space( translate(@fixes-bug, ',', ' ') )"/>
      </link>
     </xsl:when>
     <xsl:otherwise>
      <xsl:choose>
       <xsl:when test="contains(@fixes-bug, 'github-')">
         <link href="{$github-url}/pull/{translate(@fixes-bug,'github-','')}">
         <xsl:text></xsl:text><xsl:value-of select="@fixes-bug"/>
         </link>
       </xsl:when>
       <xsl:otherwise>
         <link href="{$bugdetails}{@fixes-bug}">
         <xsl:text></xsl:text><xsl:value-of select="@fixes-bug"/>
         </link>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:if>
  </td>

  <td>
   <!-- FIXME: is there any way that the module can be fetched from bugzilla using each bug's component? -->
   <xsl:if test="@module">
    <xsl:value-of select="@module"/>
   </xsl:if>
  </td>

  <td>

   <!-- description: bold any backwards-breaking changes -->
   <xsl:choose>
    <xsl:when test="@breaks-compatibility">
     <b>
      <xsl:apply-templates/>
      <xsl:text> (breaks backwards compatibility)</xsl:text>
    </b>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
   </xsl:choose>

   <!-- thanks -->
   <xsl:if test="@due-to and @due-to!=''">
    <xsl:text> Thanks to </xsl:text>
    <xsl:choose>
     <xsl:when test="@due-to-email and @due-to-email!=''">
      <link href="mailto:{@due-to-email}">
       <xsl:value-of select="@due-to"/>
      </link>
     </xsl:when>
     <xsl:otherwise>
      <xsl:value-of select="@due-to"/>
     </xsl:otherwise>
    </xsl:choose>
    <xsl:text>.</xsl:text>
   </xsl:if>
  </td>

  </tr>
 </xsl:template>

</xsl:stylesheet>
