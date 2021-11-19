Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F318456DA2
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 11:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhKSKi0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 05:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbhKSKiN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 05:38:13 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A16C06173E
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 02:35:11 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y12so40749566eda.12
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 02:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=da+/SogHXUMysaPRZgIDQxwiiCshPW/hd/yWA0YxHqQ=;
        b=GlnHRBjOnK9LP3NMSvnd1QTOn+l5BYai+2V8bs6Qcctpizcmz21/SwZE+DgAftdQz4
         sZ0mh1an60KYWHvgzkBfqZnEHVYFJ4X5QP08O7fZHPtnMcmus6hrBxGydj9+D7eTwb/I
         i/wnMThnZdCe9HM+smJulD6MMgL90PZLQwK75EkUgaCrZ3eTWVGZesWleUnWgTQ6ZKMY
         hJI0bGMDeQqp1sQkAkQHB+8zEkvcOgkdDmq9EPtpqe/xy6M0RU9mDyCwuIarT7PE/KPs
         /taKqA5EREsQNFCOmr49J1E/7vIpjimYWENZqqvzXKZT2IdjaZ2edHJWp9PI+4ClEvlI
         OpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=da+/SogHXUMysaPRZgIDQxwiiCshPW/hd/yWA0YxHqQ=;
        b=TgNEu5Z/V5B3IbE9/AIu5mvqkAtIm5ivzIlm0BZWf8FsLY5WV4BjV7U5WUVP62QlIO
         YxD5rIwyHWDeYGBebZFgNWq4uSr2G+mH2q2LWLa3hi47roz0Z7OdUlUcVJopoOxL++nz
         oEPI6YCISkSXbgVKc3LqCDX90DNNHHDfHhjZ/impVpkYhY+cZKpsoGYzgnSbzHQT6jkl
         av9ywx1oRgVJh8VMN3wPk+4XgYsvPwUc5FWrB7qhXmeB9cfgLakblvu4vu224oJGHi2V
         D9ArXlhuqZTi+l+9J+Al3goBztS6RgYIxp7m5Nk8LemQJ9+LE1qtfYKdgOTGfM2dNowc
         M+Og==
X-Gm-Message-State: AOAM531rosEC9pVm2dBNKwP0bOZRGX/nE01Q2h1eEevkQyFWaEPwblZF
        TC/g3V+mo9Y5D62vQO1pBMYzVxn31sW5yv0yn8MgDw==
X-Google-Smtp-Source: ABdhPJx3NBTcqINXsR8GAPT3k7d1gVnT5ZVIM4MMhSfBogJ3ihQymdnKbE/olQAjosYRl+tzEQxE8YBNvWdLez3iAYg=
X-Received: by 2002:a05:6402:168a:: with SMTP id a10mr23446917edv.219.1637318110186;
 Fri, 19 Nov 2021 02:35:10 -0800 (PST)
MIME-Version: 1.0
References: <20211118145142.14519-1-brgl@bgdev.pl> <YZZ1cFWaexGlJL8C@smile.fi.intel.com>
 <CAMRc=MdeEiz+uKhAz5-1MX_KG5fmjshRtDXARPMEx8VwBKfXZQ@mail.gmail.com> <YZaGa66iEFb6bJjK@smile.fi.intel.com>
In-Reply-To: <YZaGa66iEFb6bJjK@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 19 Nov 2021 11:34:59 +0100
Message-ID: <CAMRc=MeZrdgxMUxGQ0rFPkSXMto==WrMGPz0Zo8wfdCxM_0+=Q@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] gpio-sim: configfs-based GPIO simulator
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 18, 2021 at 5:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 18, 2021 at 05:37:02PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Nov 18, 2021 at 4:50 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Thu, Nov 18, 2021 at 03:51:38PM +0100, Bartosz Golaszewski wrote:
> > > > This is another shot at the gpio-sim testing module. As there was n=
o
> > > > reasoning with configfs maintainers for many months, this time the =
whole
> > > > concept of committable items has been dropped. Instead, each config=
fs
> > > > chip item (or rather a group - more on that later) exposes a new
> > > > attribute called 'live'. Writing 1 to it brings the chip on-line
> > > > (registers the platform device) and writing 0 tears it down.
> > > >
> > > > There are some caveats to that approach - for example: we can't blo=
ck
> > > > the user-space from deleting chip items when chips are live but is =
just
> > > > handled by silently destroying the chip device in the background.
> > > >
> > > > Andy (rightfully) pointed out that parsing of the lists of line nam=
es is
> > > > awkward so in this iteration it's been replaced by a system that is=
 more
> > > > elegant and will allow to easily extend configuration options for
> > > > specific GPIO lines. This is achieved by turning the chip's configf=
s
> > > > item into a configfs group and allowing the user-space to create
> > > > additional items inside it. The items must be called line<offset> (=
e.g.
> > > > line0, line12 etc.) where the offset part indicates to the module t=
he
> > > > offset for which given item stores the configuration for. Within ea=
ch
> > > > such line item, there are additional attributes that allow specifyi=
ng
> > > > configuration for specific lines. Currently we only support the 'na=
me'
> > > > attribute but I plan to extend that to support GPIO hogging too.
> > >
> > > One question here. Since you know how the driver looks like in both c=
ases
> > > (with and without committable items), would it be possible to modify =
what
> > > you proposed here to the former one in case ConfigFS gains the featur=
e?
> >
> > This would completely change the user interface unfortunately. We
> > could extend it but we would need to keep this one too most likely.
> >
> > TBH I don't see the committable items merged anytime soon, and this is
> > GoodEnough=C2=AE.
>
> Fine with me then!
>
> Thanks for doing this all, I know it's a bit delayed in terms of getting
> into upstream.
>
> Btw, gpio-mockup testing scripts have an issue that the number of lines t=
o
> check overflow is hardcoded and since x86_64 switched to 1024 from 512 it
> reveals the issue. Does gpio-sim solve this in a better way (like telling
> to user space the ngpios, etc)?
>

Yeah the selftests need fixing now.

No, there's no fix for that in gpio-sim - probe() will just fail.
Which makes me think - maybe we should synchronously wait when writing
to 'live' for the probe to return (for instance setup a notifier) so
that we know if the chip probed correctly. Then we can notify the
user-space about the error destroy the device too.

Bart
