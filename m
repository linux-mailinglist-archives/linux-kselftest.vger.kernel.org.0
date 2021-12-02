Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068C8466440
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Dec 2021 14:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241818AbhLBNKf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 08:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354377AbhLBNKf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 08:10:35 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE74C06174A
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Dec 2021 05:07:12 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r25so49599784edq.7
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Dec 2021 05:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YFKDntCU6cVKnFCMDZ3hCPdkI89kjs63CB4CHrkHUO8=;
        b=QFXM5/O4UODmHXfJ4aOj2ikW1h+/A3A0o3Bl8auCbnr8C2Q5R3nHtboK5xiMgo7S97
         qDsiuJVzwuEFSe6Vf2PkLH2AXPSTuFElwSIw5Jf/dQEGzTT5sosL7n2yKPiuAq3IgTbw
         jqfaBLi1UlLJR43V9iD7FzjtDd8zLDlp9xmTKHSH8CvdSPeov9HTmAnsCsvNwfWbquN0
         at2Laeo7mLH4ruGIH+duy4b7l2k8v3PJn3XoJA0NXMNudlxjadZG7OkVyWD6PmoYQumv
         Ox1fw1b9eGFqOV8GgAmI9mes3h7HIq/KiUZREku6sRUt+kkQRxo7Argf/1CHh5IewdtG
         jeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFKDntCU6cVKnFCMDZ3hCPdkI89kjs63CB4CHrkHUO8=;
        b=q3oE/5S5HOd6ob067BgqkpySO4YKuxc623oaoBl/9lP8GBM5I9UyaJsrXq9s50kY/e
         b3Inf7RUqvJRvDNwSjkSxBWjHB4Xs62A00OZi1cd2pt39P9TlquuenU9MukkeXk0eJVI
         BqxgK+mk5Ug69uQlAPgRtK1Gkau5DGGIf+1W/HgYVXMARDGmrujg2o34q4FaBqxIuwN9
         WTz0ubldUKrvrn5QIOJ5e3SeIBePdjtK/di7qZr0EnETsykwIXK7t1EDB30Nk0gzHnNw
         5xFZdCttCIv+YrMDoNc8+cgG8tM7OEppP1BC8GWZArV8Jg3GKoLODcPpnbczr36YwPxT
         A2CA==
X-Gm-Message-State: AOAM5334hWray/1gSvF4YHJUtlIxG3RS/VOp2qpgnaeZX/iNL9T8QkO6
        XRKB1sHRU2YVHGirCogZF5EfZxCo2iHgp7khvrE7jQ==
X-Google-Smtp-Source: ABdhPJzvHW9IsyylcMnPNXn8QGiEFiA2SWzB/8bS5oihuPClJaSi3mG1D0Kfu3pzBDcQKnFH2GnOdPL9W9UkrbersBg=
X-Received: by 2002:aa7:cb45:: with SMTP id w5mr17716019edt.405.1638450428246;
 Thu, 02 Dec 2021 05:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20211130154127.12272-1-brgl@bgdev.pl> <20211130154127.12272-3-brgl@bgdev.pl>
 <YaZNyMV5gX5cZpar@smile.fi.intel.com> <CAMRc=Mf5d1i34eBez+pOYjjdyfRL9N_ha_==Cn1rANr=2CB9aQ@mail.gmail.com>
 <YaaQp2rq7N71dm1l@smile.fi.intel.com> <CAMRc=Me=Oq_V=+p-AFPcyDjBs-+4Ug3k0AWK9fdEEet2JD3eFw@mail.gmail.com>
 <CAMRc=MdQ+a7UrE7csg3GsiLXYGkzti-wPUwPh5J=7WBj74OVZg@mail.gmail.com>
 <YaimotqSgHzS2wdA@smile.fi.intel.com> <CAMRc=Mew8xfPb9kgH-bf=t+yb1xGpRwv3Vn0+b-9pPbp3M3g5Q@mail.gmail.com>
 <YaivZe6Qo9LMoywi@smile.fi.intel.com> <Yaiv470uDhTbPD1A@smile.fi.intel.com>
In-Reply-To: <Yaiv470uDhTbPD1A@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 2 Dec 2021 14:06:57 +0100
Message-ID: <CAMRc=Mdz=pihuTamENmTiWRGeUU=tb_PuxvsarS+oXFpyq4p=g@mail.gmail.com>
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

On Thu, Dec 2, 2021 at 12:38 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Dec 02, 2021 at 01:35:01PM +0200, Andy Shevchenko wrote:
> > On Thu, Dec 02, 2021 at 12:24:06PM +0100, Bartosz Golaszewski wrote:
> > > On Thu, Dec 2, 2021 at 11:58 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Wed, Dec 01, 2021 at 02:11:28PM +0100, Bartosz Golaszewski wrote:
> > > > > On Tue, Nov 30, 2021 at 10:04 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > >
> > > > ...
> > > >
> > > > > Let me maybe rephrase the problem: currently, for GPIO devices
> > > > > instantiating multiple banks created outside of the OF or ACPI
> > > > > frameworks (e.g. instantiated manually and configured using a
> > > > > hierarchy of software nodes with a single parent swnode and a number
> > > > > of child swnodes representing the children), it is impossible to
> > > > > assign firmware nodes other than the one representing the top GPIO
> > > > > device to the gpiochip child devices.
> > > > >
> > > > > In fact if we want to drop the OF APIs entirely from gpiolib - this
> > > > > would be the right first step as for gpio-sim it actually replaces the
> > > > > gc->of_node = some_of_node; assignment that OF-based drivers do for
> > > > > sub-nodes defining banks and it does work with device-tree (I verified
> > > > > that too) thanks to the fwnode abstraction layer.
> > > >
> > > > In exchange of acknowledgements I confirm that I understood the issue
> > > > you are describing. What I still don't like is this band-aid:ish approach.
> > > > What we really need is to replace of_node by fwnode in GPIO library once
> > > > for all. But it can be done later after your simulation series (or before,
> > > > i.o.w. independently), hence I propose to update TODO and do it separately.
> > > >
> > >
> > > But this is what we already do for OF. How would the core gpiolib know
> > > how the firmware nodes represent the banks? It's the driver's job to
> > > tell the framework which node corresponds with what. If anything, we
> > > should start replacing of_nodes with fwnodes in drivers and eventually
> > > we'd drop the of_node pointer from gpio_chip entirely, but we'd keep
> > > the fwnode pointer I added as the driver still needs to assign it
> > > itself.
> > >
> > > Again: I may be missing something here but I've been going through
> > > this on and on and can't figure out any other way. Looking at
> > > gpiolib-acpi.c I don't see it correctly assigning fwnodes to
> > > sub-devices either but I don't have any HW to test it.
> > >
> > > As for this series: I can't really drop this patch as gpio-sim relies
> > > on swnodes being correctly associated with gpio_chips to identify the
> > > gpiodevs from configfs callbacks.
> >
> > Then we need to replace of_node by fwnode as a first step. I have looked
> > briefly into the list of drivers that may have been cleaned up and it doesn't
> > look too long.
>
> Let me kick this off by sending couple of patches.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Are you fine with merging this in the meantime to get gpio-sim into mainline?

Bart
