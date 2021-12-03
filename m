Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EFB467E3A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 20:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382870AbhLCTcL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 14:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353723AbhLCTcK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 14:32:10 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14155C061751
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Dec 2021 11:28:46 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v1so15747292edx.2
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Dec 2021 11:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n3mtz8VE+XSHmuF/1hsfZdAAcBHullfiaK+FTYXOaw0=;
        b=QIq8O9E5NW9kqjHRg+AslYvtUmzsQzcyNAmATrdMlBVEbcPBmv9bkO/Sm9E6zkrJOh
         diMXbc4RT6JCMzezCzmf/5E4HgC50k7amZB9hp2212Q1EZrl0nNm4TAnj/aodEzPYAWY
         F7DDEkKlfLVQL7BZ0ejDRUWGIJt62pt9m3jugDXkutl92BTDJWmLIfavoH3GKPjHsTuR
         C7C1YJr1kmL1+MoRW5l/h0A2v/bG0cl7ZyV6AfbuoTF4VPLAk8YPdLdtAUDtGUoqHEOg
         5SRsCBFYIuAymbbBzzHD2FKVJmQMxlF7XHp6L1ptGCpwaKJzePwZM7l0janlE4aig5Wm
         K5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3mtz8VE+XSHmuF/1hsfZdAAcBHullfiaK+FTYXOaw0=;
        b=l6fiLhWTF5yPLFcImRosSJ+9pHNQAyv8N8zSuvczpzrvhsqNN30Be+vIBtqBGu7w5f
         oBW5+V8tJ1JrhD9QPDAM5CaJaCKTos0vWOfRgtTjCw2L2vzneeKCZaiItvrT3OBEY3gE
         C9r6g8y3x+xva10SGQLvx5eVIvCXg6Z89lYO3CAic0+RB51zr7nZ6tzSRJMofqmQPoV9
         UiY0zEDq7idThwGublkv4/utvQXogZ1ztZ74gsuYKMv6sXUbt0ShzWGb7JSYUCa4Upac
         mNCffwutBa2VuJxQ+SgwVBmLzGg/KgC4PYtwDUAb0yDEj6We4cI5OnsTFl3FT6fumnsK
         gZag==
X-Gm-Message-State: AOAM533r0pEIgvo2Bu3a/VftgbApMne+KTA/uHqqgDSlt2rL8CPDoNIm
        gbd3/JthDoS8ERDFAfLIGvSPrpRLLeduqO4/X5UV1A==
X-Google-Smtp-Source: ABdhPJw5CFp+py3IKpRGcPqNiGG4UgNpCg+pnkKmPhuMsAAZLi5nAdE7ZVqX7PQoax8QqIjtj5Hg0Mw+3NOuAu2BELU=
X-Received: by 2002:a05:6402:27c7:: with SMTP id c7mr29557634ede.0.1638559724691;
 Fri, 03 Dec 2021 11:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20211203133003.31786-1-brgl@bgdev.pl> <20211203133003.31786-4-brgl@bgdev.pl>
 <YapnTHQZyNCZXrgp@smile.fi.intel.com> <YapoW+DL4jPo69u8@smile.fi.intel.com> <Yapp4vakFxH7JV5B@smile.fi.intel.com>
In-Reply-To: <Yapp4vakFxH7JV5B@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 3 Dec 2021 20:28:34 +0100
Message-ID: <CAMRc=MeWfKHWFKwRjaqczrfwhAodpDLgrWKF-zqXCsjd=gMv3g@mail.gmail.com>
Subject: Re: [PATCH v12 3/7] gpiolib: of: make fwnode take precedence in
 struct gpio_chip
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 3, 2021 at 8:04 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Dec 03, 2021 at 08:56:27PM +0200, Andy Shevchenko wrote:
> > On Fri, Dec 03, 2021 at 08:51:56PM +0200, Andy Shevchenko wrote:
> > > On Fri, Dec 03, 2021 at 02:29:59PM +0100, Bartosz Golaszewski wrote:
> >
> > ...
> >
> > > >   if (gc->parent)
> > > >           gdev->dev.of_node = gc->parent->of_node;
> > > >
> > > > + if (gc->fwnode)
> > > > +         gc->of_node = to_of_node(gc->fwnode);
> > > > +
> > > >   /* If the gpiochip has an assigned OF node this takes precedence */
> > > >   if (gc->of_node)
> > > >           gdev->dev.of_node = gc->of_node;
> > >
> > > Similar should be done in acpi_gpio_dev_init():
> > >
> > >     if (gc->fwnode)
> > >             device_set_node(&gdev->dev, gc->fwnode);
> >
> > Hmm... On the second though this should be rather
> >
> >       if (gc->fwnode)
> >               set_secondary_fwnode(&gdev->dev, gc->fwnode);
> >
> > So the logic will be that:
> >  - if we have parent, set primary fwnode to it
> >  - if we have fwnode, set secondary one to it
> >  - otherwise do nothing
>
> Heck, it's Friday...
>
> If we have parent device for several GPIO devices, this won't work right now
> due to limitations of fwnode regarding to the sturct device.
>
> So, it means we may not have shared primary with different secondary fwnodes.
>
> So, come back to the initial suggestion (overwrite it for now):
>
>         /*
>          * If custom fwnode provided, use it. Currently we may not
>          * handle the case where shared primary node has different
>          * secondary ones. Ideally we have to use
>          * set_secondary_fwnode() here.
>          */
>         if (gc->fwnode)
>                 device_set_node(&gdev->dev, gc->fwnode);
>

Other parts of gpiolib-of depend on the of_node being there.
Converting it to fwnode is a whole other task so for now I suggest we
just convert the fwnode to of_node in struct gpio_chip as per my
patch.

Bart
