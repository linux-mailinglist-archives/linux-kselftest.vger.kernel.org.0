Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838FD4772F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 14:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbhLPNQc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 08:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhLPNQb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 08:16:31 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5F6C06173E
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 05:16:30 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p36-20020a05600c1da400b003457428ec78so546913wms.3
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 05:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=89cO30wmGkXDNc+LXsapdFI9ZHdvoiOb4Ut84k4l3oQ=;
        b=bLwK5hMN2fB2tKrvWDU823tRFJenKqjWILudBAgcNc4NUczgl13StsqoRRPvsu9A2Q
         4uo/fCN+CEdFZgy6XUDkgRzl8S0/SfCr7gMe1ARc+WORfoiLH+s5hI+PrnB4x0BKmNiK
         7nSNgYJlMa8oDD2YMMTA8Ebb53yRiGVU3rA9CZqBIuUXhL1MrCVXV6+7gLThIDhwNGl3
         tTDI0TfLjnh/+/XdM1S7yxWlQqTCnURT6TJXBR+Orjsc80MNWftJO+B1Ar4WfYA6MKyz
         hifQUq4B+SZLhdnL9NlsE/LxulWxPGV6YDbTvdCpDCI5EVxuP3xj4fS/thP13X3OChB5
         2MOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=89cO30wmGkXDNc+LXsapdFI9ZHdvoiOb4Ut84k4l3oQ=;
        b=Mx1T+ydIXAnTtrTS+Ivtsfl/dtzX5coM+Yt98Tn3dPFB/CUsXE4OsWgZMRNaEqVcUr
         JqyTypNcLzdoSsHY6ztnZOgLeuLOHx8CFshSnnM0uRy+nYzW/mjD2Nl8QGuWBFbtD2eE
         1nw0+rS3ODP3hrxdLA+crSqzYKjmYuECLG8OOmeTGjfacFr8tlbzB3nEjJ2Z/EaO98Eh
         02U05/kr9Uk0E3deKJqBMudcg9GuXbljYQxbn/LBP1dwsI4fYjNmrqMrCOXE0yCEVjM9
         s7XddFqGsaz07zIbIIiF/OE6Qg5r7C54to/fTikrBc0CpaFW9DdqLp36W8lsDC5ql51w
         ElTA==
X-Gm-Message-State: AOAM530OrDOWQxjfqeF0yiEmlLe68T0NnUH+Hkd7YfP6OWs0ZnFrjxVl
        CvNX1Rhkd+UX4+t/HK9M0pn6Cw==
X-Google-Smtp-Source: ABdhPJxSHYFEttHi9PhJcCqTks4Zbke2eO5t1ZZOH2GDqSuB9aSBKwW9rGy31Oe5BXIP7Inff3pQZg==
X-Received: by 2002:a05:600c:3ac3:: with SMTP id d3mr4903103wms.174.1639660589195;
        Thu, 16 Dec 2021 05:16:29 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:a9b1:c1cb:ba9c:fad4])
        by smtp.gmail.com with ESMTPSA id 10sm5979821wrb.75.2021.12.16.05.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:16:27 -0800 (PST)
Date:   Thu, 16 Dec 2021 14:16:21 +0100
From:   Marco Elver <elver@google.com>
To:     Harinder Singh <sharinder@google.com>
Cc:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tim.Bird@sony.com
Subject: Re: [PATCH v4 3/7] Documentation: KUnit: Added KUnit Architecture
Message-ID: <Ybs8JXFN4SucHpnj@elver.google.com>
References: <20211216055958.634097-1-sharinder@google.com>
 <20211216055958.634097-4-sharinder@google.com>
 <CANpmjNOGaVgP25xNOSGOyjcA9Lmk4uFmU=f6RrRNJBP_CMEVrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bM2xpafGa4jx1rX3"
Content-Disposition: inline
In-Reply-To: <CANpmjNOGaVgP25xNOSGOyjcA9Lmk4uFmU=f6RrRNJBP_CMEVrQ@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--bM2xpafGa4jx1rX3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 16, 2021 at 11:15AM +0100, Marco Elver wrote:
> On Thu, 16 Dec 2021 at 07:00, Harinder Singh <sharinder@google.com> wrote:
> >
> > Describe the components of KUnit and how the kernel mode parts
> > interact with kunit_tool.
> >
> > Signed-off-by: Harinder Singh <sharinder@google.com>
> > ---
> >  .../dev-tools/kunit/architecture.rst          | 204 ++++++++++++++++++
> >  Documentation/dev-tools/kunit/index.rst       |   2 +
> >  .../kunit/kunit_suitememorydiagram.png        | Bin 0 -> 24174 bytes
> >  Documentation/dev-tools/kunit/start.rst       |   1 +
> >  4 files changed, 207 insertions(+)
> >  create mode 100644 Documentation/dev-tools/kunit/architecture.rst
> >  create mode 100644 Documentation/dev-tools/kunit/kunit_suitememorydiagram.png
> 
> In response to the other email: Adding binary blobs just creates
> problems, for comparing different versions, and general bloating the
> whole repo, where better alternatives exist.
> 
> I suppose an ASCII diagram is a bit primitive. :-)
> 
> However, SVG files on the other hand are not binary blobs, they are
> text-markup based (XML), and e.g. diffing them often provides useful
> information about what changed. SVG also has the benefit of being
> vector graphics, and not being limited to one resolution.
> 
> Looking at the diagram you added, I think this can easily be turned
> into vector graphics, and most likely will not use up 24KiB as a
> result.

I gave it a shot, see attached SVG file. I re-created the figure using
Inkscape.

The attached SVG file is an "Optimized SVG", where Inkscape stripped as
much useless info as possible and it should be as portable as possible.
Some care is required to make it render the same everywhere, which I did
by turning some objects into pure paths (like the arrows and '{', '}').
The text is still text, and should look similar enough with most
Monospace fonts. The advantage of it still being text is reduced size,
and also being able to edit it with a plain text editor should only
small details need updating (like variable naming). If shapes need
editing, it can be done with the help of Inkscape itself.

Also, kernel-doc has proper support for dealing with SVG:
https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#image-output

In case you want to use my SVG as-is, you need to add:
Signed-off-by: Marco Elver <elver@google.com>

Thanks,
-- Marco

--bM2xpafGa4jx1rX3
Content-Type: image/svg+xml
Content-Disposition: attachment; filename="kunit_suitememorydiagram.svg"
Content-Transfer-Encoding: quoted-printable

<?xml version=3D"1.0" encoding=3D"UTF-8"?>=0A<svg width=3D"796.93" height=
=3D"555.73" version=3D"1.1" viewBox=3D"0 0 796.93 555.73" xmlns=3D"http://w=
ww.w3.org/2000/svg">=0A	<g transform=3D"translate(-13.724 -17.943)">=0A		<g=
 fill=3D"#dad4d4" fill-opacity=3D".91765" stroke=3D"#1a1a1a">=0A			<rect x=
=3D"323.56" y=3D"18.443" width=3D"115.75" height=3D"41.331"/>=0A			<rect x=
=3D"323.56" y=3D"463.09" width=3D"115.75" height=3D"41.331"/>=0A			<rect x=
=3D"323.56" y=3D"531.84" width=3D"115.75" height=3D"41.331"/>=0A			<rect x=
=3D"323.56" y=3D"88.931" width=3D"115.75" height=3D"74.231"/>=0A		</g>=0A		=
<g>=0A			<rect x=3D"323.56" y=3D"421.76" width=3D"115.75" height=3D"41.331"=
 fill=3D"#b9dbc6" stroke=3D"#1a1a1a"/>=0A			<text x=3D"328.00888" y=3D"446.=
61826" fill=3D"#000000" font-family=3D"sans-serif" font-size=3D"16px" style=
=3D"line-height:1.25" xml:space=3D"preserve"><tspan x=3D"328.00888" y=3D"44=
6.61826" font-family=3D"monospace" font-size=3D"16px">kunit_suite</tspan></=
text>=0A		</g>=0A		<g transform=3D"translate(0 -258.6)">=0A			<rect x=3D"32=
3.56" y=3D"421.76" width=3D"115.75" height=3D"41.331" fill=3D"#b9dbc6" stro=
ke=3D"#1a1a1a"/>=0A			<text x=3D"328.00888" y=3D"446.61826" fill=3D"#000000=
" font-family=3D"sans-serif" font-size=3D"16px" style=3D"line-height:1.25" =
xml:space=3D"preserve"><tspan x=3D"328.00888" y=3D"446.61826" font-family=
=3D"monospace" font-size=3D"16px">kunit_suite</tspan></text>=0A		</g>=0A		<=
g transform=3D"translate(0 -217.27)">=0A			<rect x=3D"323.56" y=3D"421.76" =
width=3D"115.75" height=3D"41.331" fill=3D"#b9dbc6" stroke=3D"#1a1a1a"/>=0A=
			<text x=3D"328.00888" y=3D"446.61826" fill=3D"#000000" font-family=3D"sa=
ns-serif" font-size=3D"16px" style=3D"line-height:1.25" xml:space=3D"preser=
ve"><tspan x=3D"328.00888" y=3D"446.61826" font-family=3D"monospace" font-s=
ize=3D"16px">kunit_suite</tspan></text>=0A		</g>=0A		<g transform=3D"transl=
ate(0 -175.94)">=0A			<rect x=3D"323.56" y=3D"421.76" width=3D"115.75" heig=
ht=3D"41.331" fill=3D"#b9dbc6" stroke=3D"#1a1a1a"/>=0A			<text x=3D"328.008=
88" y=3D"446.61826" fill=3D"#000000" font-family=3D"sans-serif" font-size=
=3D"16px" style=3D"line-height:1.25" xml:space=3D"preserve"><tspan x=3D"328=
=2E00888" y=3D"446.61826" font-family=3D"monospace" font-size=3D"16px">kuni=
t_suite</tspan></text>=0A		</g>=0A		<g transform=3D"translate(0 -134.61)">=
=0A			<rect x=3D"323.56" y=3D"421.76" width=3D"115.75" height=3D"41.331" fi=
ll=3D"#b9dbc6" stroke=3D"#1a1a1a"/>=0A			<text x=3D"328.00888" y=3D"446.618=
26" fill=3D"#000000" font-family=3D"sans-serif" font-size=3D"16px" style=3D=
"line-height:1.25" xml:space=3D"preserve"><tspan x=3D"328.00888" y=3D"446.6=
1826" font-family=3D"monospace" font-size=3D"16px">kunit_suite</tspan></tex=
t>=0A		</g>=0A		<g transform=3D"translate(0 -41.331)">=0A			<rect x=3D"323.=
56" y=3D"421.76" width=3D"115.75" height=3D"41.331" fill=3D"#b9dbc6" stroke=
=3D"#1a1a1a"/>=0A			<text x=3D"328.00888" y=3D"446.61826" fill=3D"#000000" =
font-family=3D"sans-serif" font-size=3D"16px" style=3D"line-height:1.25" xm=
l:space=3D"preserve"><tspan x=3D"328.00888" y=3D"446.61826" font-family=3D"=
monospace" font-size=3D"16px">kunit_suite</tspan></text>=0A		</g>=0A		<g tr=
ansform=3D"translate(3.4459e-5 -.71088)">=0A			<rect x=3D"502.19" y=3D"143.=
16" width=3D"201.13" height=3D"41.331" fill=3D"#dad4d4" fill-opacity=3D".91=
765" stroke=3D"#1a1a1a"/>=0A			<text x=3D"512.02319" y=3D"168.02026" font-f=
amily=3D"sans-serif" font-size=3D"16px" style=3D"line-height:1.25" xml:spac=
e=3D"preserve"><tspan x=3D"512.02319" y=3D"168.02026" font-family=3D"monosp=
ace">_kunit_suites_start</tspan></text>=0A		</g>=0A		<g transform=3D"transl=
ate(3.0518e-5 -3.1753)">=0A			<rect x=3D"502.19" y=3D"445.69" width=3D"201.=
13" height=3D"41.331" fill=3D"#dad4d4" fill-opacity=3D".91765" stroke=3D"#1=
a1a1a"/>=0A			<text x=3D"521.61694" y=3D"470.54846" font-family=3D"sans-ser=
if" font-size=3D"16px" style=3D"line-height:1.25" xml:space=3D"preserve"><t=
span x=3D"521.61694" y=3D"470.54846" font-family=3D"monospace">_kunit_suite=
s_end</tspan></text>=0A		</g>=0A		<rect x=3D"14.224" y=3D"277.78" width=3D"=
134.47" height=3D"41.331" fill=3D"#dad4d4" fill-opacity=3D".91765" stroke=
=3D"#1a1a1a"/>=0A		<text x=3D"32.062176" y=3D"304.41287" font-family=3D"san=
s-serif" font-size=3D"16px" style=3D"line-height:1.25" xml:space=3D"preserv=
e"><tspan x=3D"32.062176" y=3D"304.41287" font-family=3D"monospace">.init.d=
ata</tspan></text>=0A		<g transform=3D"translate(217.98 145.12)" stroke=3D"=
#1a1a1a">=0A			<circle cx=3D"149.97" cy=3D"373.01" r=3D"3.4012"/>=0A			<cir=
cle cx=3D"163.46" cy=3D"373.01" r=3D"3.4012"/>=0A			<circle cx=3D"176.95" c=
y=3D"373.01" r=3D"3.4012"/>=0A		</g>=0A		<g transform=3D"translate(217.98 -=
298.66)" stroke=3D"#1a1a1a">=0A			<circle cx=3D"149.97" cy=3D"373.01" r=3D"=
3.4012"/>=0A			<circle cx=3D"163.46" cy=3D"373.01" r=3D"3.4012"/>=0A			<cir=
cle cx=3D"176.95" cy=3D"373.01" r=3D"3.4012"/>=0A		</g>=0A		<g stroke=3D"#1=
a1a1a">=0A			<rect x=3D"323.56" y=3D"328.49" width=3D"115.75" height=3D"51.=
549" fill=3D"#b9dbc6"/>=0A			<g transform=3D"translate(217.98 -18.75)">=0A	=
			<circle cx=3D"149.97" cy=3D"373.01" r=3D"3.4012"/>=0A				<circle cx=3D"1=
63.46" cy=3D"373.01" r=3D"3.4012"/>=0A				<circle cx=3D"176.95" cy=3D"373.0=
1" r=3D"3.4012"/>=0A			</g>=0A		</g>=0A		<g transform=3D"scale(1.0933 .9147=
)" stroke-width=3D"32.937" aria-label=3D"{">=0A			<path d=3D"m275.49 545.57=
c-35.836-8.432-47.43-24.769-47.957-64.821v-88.536c-0.527-44.795-10.54-57.97=
-49.538-67.456 38.998-10.013 49.011-23.715 49.538-67.983v-88.536c0.527-40.0=
52 12.121-56.389 47.957-64.821v-5.797c-65.348 0-85.901 17.391-86.955 73.253=
v93.806c-0.527 36.89-10.013 50.065-44.795 59.551 34.782 10.013 44.268 23.18=
8 44.795 60.078v93.279c1.581 56.389 21.607 73.78 86.955 73.78z"/>=0A		</g>=
=0A		<g transform=3D"scale(1.1071 .90325)" stroke-width=3D"14.44" aria-labe=
l=3D"{">=0A			<path d=3D"m461.46 443.55c-15.711-3.6967-20.794-10.859-21.025=
-28.418v-38.815c-0.23104-19.639-4.6209-25.415-21.718-29.574 17.097-4.3898 2=
1.487-10.397 21.718-29.805v-38.815c0.23105-17.559 5.314-24.722 21.025-28.41=
8v-2.5415c-28.649 0-37.66 7.6244-38.122 32.115v41.126c-0.23105 16.173-4.389=
8 21.949-19.639 26.108 15.249 4.3898 19.408 10.166 19.639 26.339v40.895c0.6=
9313 24.722 9.4728 32.346 38.122 32.346z"/>=0A		</g>=0A		<path d=3D"m449.55=
 161.84v2.5h49.504v-2.5z" color=3D"#000000" style=3D"-inkscape-stroke:none"=
/>=0A		<g fill-rule=3D"evenodd">=0A			<path d=3D"m443.78 163.09 8.65-5v10z"=
 color=3D"#000000" stroke-width=3D"1pt" style=3D"-inkscape-stroke:none"/>=
=0A			<path d=3D"m453.1 156.94-10.648 6.1543 0.99804 0.57812 9.6504 5.5781z=
m-1.334 2.3125v7.6856l-6.6504-3.8438z" color=3D"#000000" style=3D"-inkscape=
-stroke:none"/>=0A		</g>=0A		<path d=3D"m449.55 461.91v2.5h49.504v-2.5z" co=
lor=3D"#000000" style=3D"-inkscape-stroke:none"/>=0A		<g fill-rule=3D"eveno=
dd">=0A			<path d=3D"m443.78 463.16 8.65-5v10z" color=3D"#000000" stroke-wi=
dth=3D"1pt" style=3D"-inkscape-stroke:none"/>=0A			<path d=3D"m453.1 457-10=
=2E648 6.1562 0.99804 0.57617 9.6504 5.5781zm-1.334 2.3125v7.6856l-6.6504-3=
=2E8438z" color=3D"#000000" style=3D"-inkscape-stroke:none"/>=0A		</g>=0A		=
<rect x=3D"515.64" y=3D"223.9" width=3D"294.52" height=3D"178.49" fill=3D"#=
dad4d4" fill-opacity=3D".91765" stroke=3D"#1a1a1a"/>=0A		<text x=3D"523.333=
19" y=3D"262.52542" font-family=3D"monospace" font-size=3D"14.667px" style=
=3D"line-height:1.25" xml:space=3D"preserve"><tspan x=3D"523.33319" y=3D"26=
2.52542"><tspan fill=3D"#008000" font-family=3D"monospace" font-size=3D"14.=
667px" font-weight=3D"bold">struct</tspan> kunit_suite {</tspan><tspan x=3D=
"523.33319" y=3D"280.8588"><tspan fill=3D"#008000" font-family=3D"monospace=
" font-size=3D"14.667px" font-weight=3D"bold">  const char</tspan> name[<ts=
pan fill=3D"#ff00ff" font-size=3D"14.667px">256</tspan>];</tspan><tspan x=
=3D"523.33319" y=3D"299.19217">  <tspan fill=3D"#008000" font-family=3D"mon=
ospace" font-size=3D"14.667px" font-weight=3D"bold">int</tspan> (*init)(<ts=
pan fill=3D"#008000" font-family=3D"monospace" font-size=3D"14.667px" font-=
weight=3D"bold">struct</tspan> kunit *);</tspan><tspan x=3D"523.33319" y=3D=
"317.52554">  <tspan fill=3D"#008000" font-family=3D"monospace" font-size=
=3D"14.667px" font-weight=3D"bold">void</tspan> (*exit)(<tspan fill=3D"#008=
000" font-family=3D"monospace" font-size=3D"14.667px" font-weight=3D"bold">=
struct</tspan> kunit *);</tspan><tspan x=3D"523.33319" y=3D"335.85892">  <t=
span fill=3D"#008000" font-family=3D"monospace" font-size=3D"14.667px" font=
-weight=3D"bold">struct</tspan> kunit_case *test_cases;</tspan><tspan x=3D"=
523.33319" y=3D"354.19229">  ...</tspan><tspan x=3D"523.33319" y=3D"372.525=
67">};</tspan></text>=0A	</g>=0A</svg>=0A
--bM2xpafGa4jx1rX3--
