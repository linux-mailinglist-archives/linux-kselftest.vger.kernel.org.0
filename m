Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D127463F9C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 22:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbhK3VIG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Nov 2021 16:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240423AbhK3VIA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Nov 2021 16:08:00 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16700C061748
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Nov 2021 13:04:40 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v1so92196645edx.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Nov 2021 13:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BWwYMH2QXD8RdUA4ARWeTtAI5cdUZzTQzP59cE/DcyM=;
        b=DFwE/Jt9m0dyRM4buFbduTu7WcsnUL2piaBhy02HNohEZGbDBC+POJ03HMyDT2tkCx
         8ptui4G9N8pW0pfA8rYZW89uSRLFGQlGtNpwY4PcFqIsc1bYEGvzBuaJGwD/oOroChcL
         b/b7AcJHBd8x25FXWbEEdbjpG0LdPPr8ipHeXBwjtd/5UdpAYB/Mmt9rJkXvN0YiHjDF
         WVIo69R0PTLDkL+y9XU2/rf3KRdmZz5B0sH7lEg7M7hWOuL7QLZPG/kY+prUWII6ZQoe
         SYp2F6zfeI2jEWCIeAQJK8kIfDiRvHnmKkULoj4oKc8nClAWpdN9eIQT1uMV7A9C3QwK
         uuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BWwYMH2QXD8RdUA4ARWeTtAI5cdUZzTQzP59cE/DcyM=;
        b=TiX5zMMebckQYMtXVsAKUX89CEwI6V67tRCU3YZWONDAQxySeTjKO+Jr9Gm1SVY+uE
         2vmVhNZtl6mqLhx5gXKuvZ/zGZMsLrhpfdD4M8ne23byqUCdrV3nWW6klJvY6c/uw1jV
         DIPE9QY8DAPM6U/Q97RNd0dIDW6tM17Utr8tHzi4vwC77v7dsrQ0HLbMDuOXgb3ndjJH
         fdsamcmlLw0j8ET9a2mnV5wzRgqGEYNaCFDY8J1PX0TGH0qMYfVURmdAWP6FD5V08TBB
         drR29UXBo8H0lTLrVIdkmTZqcAHO4NKZW1wGowLu9o/BI7YmsC5Fu+N0ESzQz5TwmjWI
         4eKg==
X-Gm-Message-State: AOAM5317srHTH4CWN32LsYJ/Q7jBHhQPWC4kd9msZIOJYEZtKlnhBZZa
        a3vqCjSeFSFfXHBvLSSOpiUbIM1JnK8KvYm+jxDjPg==
X-Google-Smtp-Source: ABdhPJwsck9dzegaqyD1ZCTbKPCXQRGaCD3hmU681+zXZ0dURe9qvueKcDsKME504ulmNnxrqM8XHAxmOXWEHL2UxJo=
X-Received: by 2002:a17:907:1deb:: with SMTP id og43mr1750653ejc.189.1638306278433;
 Tue, 30 Nov 2021 13:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20211130154127.12272-1-brgl@bgdev.pl> <20211130154127.12272-3-brgl@bgdev.pl>
 <YaZNyMV5gX5cZpar@smile.fi.intel.com> <CAMRc=Mf5d1i34eBez+pOYjjdyfRL9N_ha_==Cn1rANr=2CB9aQ@mail.gmail.com>
 <YaaQp2rq7N71dm1l@smile.fi.intel.com>
In-Reply-To: <YaaQp2rq7N71dm1l@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 30 Nov 2021 22:04:27 +0100
Message-ID: <CAMRc=Me=Oq_V=+p-AFPcyDjBs-+4Ug3k0AWK9fdEEet2JD3eFw@mail.gmail.com>
Subject: Re: [PATCH v11 2/6] gpiolib: allow to specify the firmware node in
 struct gpio_chip
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 30, 2021 at 10:00 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 30, 2021 at 09:25:35PM +0100, Bartosz Golaszewski wrote:
> > On Tue, Nov 30, 2021 at 5:15 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Tue, Nov 30, 2021 at 04:41:23PM +0100, Bartosz Golaszewski wrote:
> > > > Software nodes allow us to represent hierarchies for device components
> > > > that don't have their struct device representation yet - for instance:
> > > > banks of GPIOs under a common GPIO expander. The core gpiolib core
> > >
> > > core .. core ?!
> > >
> > > > however doesn't offer any way of passing this information from the
> > > > drivers.
> > > >
> > > > This extends struct gpio_chip with a pointer to fwnode that can be set
> > > > by the driver and used to pass device properties for child nodes.
> > > >
> > > > This is similar to how we handle device-tree sub-nodes with
> > > > CONFIG_OF_GPIO enabled.
> > >
> > > Not sure I understand the proposal. Can you provide couple of (simplest)
> > > examples?
> > >
> > > And also it sounds like reinventing a wheel. What problem do you have that you
> > > need to solve this way?
> > >
> > > ...
> > >
> > > > +#if IS_ENABLED(CONFIG_OF_GPIO)
> > > > +     if (gc->of_node && gc->fwnode) {
> > > > +             pr_err("%s: tried to set both the of_node and fwnode in gpio_chip\n",
> > > > +                    __func__);
> > > > +             return -EINVAL;
> > > > +     }
> > > > +#endif /* CONFIG_OF_GPIO */
> > >
> > > I don't like this. It seems like a hack right now.
> > >
> > > Is it possible to convert all GPIO controller drivers to provide an fwnode
> > > rather than doing this? (I believe in most of the drivers we can drop
> > > completely the of_node assignment).
> > >
> >
> > Yes, it's definitely a good idea but I would be careful with just
> > dropping the of_node assignments as callbacks may depend on them
> > later.
>
> GPIO library does it for us among these lines:
>
>         struct fwnode_handle *fwnode = gc->parent ? dev_fwnode(gc->parent) : NULL;
>
>         of_gpio_dev_init(gc, gdev); <<< HERE!
>         acpi_gpio_dev_init(gc, gdev);
>
>         /*
>          * Assign fwnode depending on the result of the previous calls,
>          * if none of them succeed, assign it to the parent's one.
>          */
>         gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
>

Except that it doesn't and I noticed that when working on the
subsequent patch. The child gpiochipX devices all had the parent's
fwnode assigned as their primary fwnode and no secondary fwnode.

Note that this driver doesn't use neither OF nor ACPI in which case
gdev->dev has no fwnode and the parent's one is used. This patch
addresses it. If you have a better idea, let me know.

Bart

>
> > Also it's not just about the gpio_chip of_node assignment -
> > drivers also use a bunch of OF APIs all around the place. I would
> > prefer that it be done one by one and every modified driver be tested.
>
> That's why we want to eliminate dev->fwnode explicit dereference as a first
> step (see dev_fwnode() / device_set_node() APIs).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
