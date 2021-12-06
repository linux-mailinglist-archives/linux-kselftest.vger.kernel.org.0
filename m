Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCB34691AB
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 09:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbhLFIpR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 03:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239637AbhLFIpQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 03:45:16 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC76CC061746
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Dec 2021 00:41:47 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r25so39511694edq.7
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Dec 2021 00:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYsv0I6A6o5uFK+UPY8fyAiz1zz4uJD9KLB+ITvNrnU=;
        b=Na9oLGTjiwHYKrfq7A9Qz4LGmlnRJjcpjIOYPpDh/3BPi9g5o1X8rpVW4mP/sxLFWM
         hAuDGpKChArD8g+AXlU3xZp/f/CHbnKk1crqS++1O4gK3JoooqAizE3HZFSUN9B+eaqK
         3CZjCwIC5WElGg5rbsUrL1k4xBeKlcgQZLyMBwKuYvrHfsbaL1C8bahRh0XklvAoVPZF
         VQN9nFEdammFsIlCeEssLeM5W9x/+5bmPw/SKWrmpagzgxdh6Q8E3taxBMV46/WvALY1
         E6lPsbdWc7CDV7BKSnBtiGSzkK0b0Sk7YbTI4crokMt+UXLf3a/071HEN/2Woe91yaGy
         O2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYsv0I6A6o5uFK+UPY8fyAiz1zz4uJD9KLB+ITvNrnU=;
        b=hXOwq9Yzlbm96luAmCz/Ac8rjxwFZG7djOvwAKi/tTOG+FZCm1q+ovgJG8d3EYdTUT
         D4XDfv0iXRmmpE0qFTBkC/7ImOFY+/BN1va2mjnkvBfNHt+ni4Z8vi23UQgPGaeNtm+n
         XbB1l5RBPCeBD9LRTUr/yLYGrj07dlphOGGliYjM/dCuWdu3KIUVTB6RKNwquB4aJjWF
         4tYkt7+jHFLPXHdWu81vk/Tv1/VUTAFsbIR9prJ07aXbFhZ+EpLgjJB8Jo+B3wIm/r/X
         cpsiOlKyqnAGKXbWRkjV5az9nSMfYrl1E2fXsYvHe5fmJ6kv4gz1FSmurrwOsK5fpLhL
         5oPw==
X-Gm-Message-State: AOAM533K3h1hy1STw4sC5xyk94LYw1keFe+rm7EtbPp4oqTB+xdedAM0
        JDwg6elKK4uf3dAyL6Nu5PVolYzFz+ob8j0TGp+0RA==
X-Google-Smtp-Source: ABdhPJwaXHvLPRG0pSMIzqzjXufeL6J34ZTE554GDIxU4BWMdqMOHmcM0b1i3AQuocmn3XKeV23g6rGKxx5cN6iGC/8=
X-Received: by 2002:a17:907:c15:: with SMTP id ga21mr43076617ejc.349.1638780104294;
 Mon, 06 Dec 2021 00:41:44 -0800 (PST)
MIME-Version: 1.0
References: <20211203133003.31786-1-brgl@bgdev.pl> <20211203133003.31786-4-brgl@bgdev.pl>
 <YapnTHQZyNCZXrgp@smile.fi.intel.com> <YapoW+DL4jPo69u8@smile.fi.intel.com>
 <Yapp4vakFxH7JV5B@smile.fi.intel.com> <CAMRc=MeWfKHWFKwRjaqczrfwhAodpDLgrWKF-zqXCsjd=gMv3g@mail.gmail.com>
 <Yap5ctmlw6NeNM+7@smile.fi.intel.com>
In-Reply-To: <Yap5ctmlw6NeNM+7@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Dec 2021 09:41:33 +0100
Message-ID: <CAMRc=MffmFgCZFRziw-QJ+Y3WobJZzUh1Nbp2oym6JLqfnZCdQ@mail.gmail.com>
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

On Fri, Dec 3, 2021 at 9:10 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Dec 03, 2021 at 08:28:34PM +0100, Bartosz Golaszewski wrote:
> > On Fri, Dec 3, 2021 at 8:04 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Dec 03, 2021 at 08:56:27PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Dec 03, 2021 at 08:51:56PM +0200, Andy Shevchenko wrote:
> > > > > On Fri, Dec 03, 2021 at 02:29:59PM +0100, Bartosz Golaszewski wrote:
>
> ...
>
> > > > > >   if (gc->parent)
> > > > > >           gdev->dev.of_node = gc->parent->of_node;
> > > > > >
> > > > > > + if (gc->fwnode)
> > > > > > +         gc->of_node = to_of_node(gc->fwnode);
> > > > > > +
> > > > > >   /* If the gpiochip has an assigned OF node this takes precedence */
> > > > > >   if (gc->of_node)
> > > > > >           gdev->dev.of_node = gc->of_node;
> > > > >
> > > > > Similar should be done in acpi_gpio_dev_init():
>
>
> ^^^^^^ (1)
>
> ...
>
> > > If we have parent device for several GPIO devices, this won't work right now
> > > due to limitations of fwnode regarding to the sturct device.
> > >
> > > So, it means we may not have shared primary with different secondary fwnodes.
> > >
> > > So, come back to the initial suggestion (overwrite it for now):
> > >
> > >         /*
> > >          * If custom fwnode provided, use it. Currently we may not
> > >          * handle the case where shared primary node has different
> > >          * secondary ones. Ideally we have to use
> > >          * set_secondary_fwnode() here.
> > >          */
> > >         if (gc->fwnode)
> > >                 device_set_node(&gdev->dev, gc->fwnode);
> > >
> >
> > Other parts of gpiolib-of depend on the of_node being there.
> > Converting it to fwnode is a whole other task so for now I suggest we
> > just convert the fwnode to of_node in struct gpio_chip as per my
> > patch.
>
> But this is about ACPI counterpart. If you do this, do this in both cases.
> Above code for ACPI (1).
>

This series concerns the gpio-sim driver and it only uses configfs
(with manually created platform devices) or device-tree. I would
prefer to do ACPI separately and I'd like you to lead that because I
neither have any HW to test nor claim to understand it. :)

Bart
