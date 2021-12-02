Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630244668C2
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Dec 2021 18:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359812AbhLBRDl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 12:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359815AbhLBRDl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 12:03:41 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB4FC061758
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Dec 2021 09:00:18 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id l25so533952eda.11
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Dec 2021 09:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RleHhnHbPAOcRMuCS7kxWAWoueEz531KAPD2vJkfnyQ=;
        b=zoO/K5tHvnsvI4bG5hfw5KHzS9iKC/PTv+BaruJVSSK0yyO+ZdWnVCVb26rc3Mr+ff
         2toqDxHMUZ9wtBb6mXHwczDauzTdTBKxpfBJl0txusXuzGCH7ysbzQNwFJggVsky2Mnr
         Y2QRkFlkCfrkqVYORVEXtQ9836xIdSbzBfQtV8y+AaFQp9WK9oWDqBKIBWoOAPfOmKD7
         o6WlJcmB+botFV/DLlMPRa/VQ36LfP4BbmkE71tGUj9ffdJcD4iFslJyYO6FybtOrlBF
         3pWsVhwmmltlQxwzOpyNjaBpyGpwDPCfMRRloMI05ik2tYdGdnvSE95uuycd8Qv0JwH4
         Drqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RleHhnHbPAOcRMuCS7kxWAWoueEz531KAPD2vJkfnyQ=;
        b=JqguUXiQSEbDF67uiLwFqS9wC7WDI5tZTi1H8Uak7J3SfdKr8UJMbRnca1L/hTkkaj
         a66PNyRes9spBQ0WZznLr8kun123q7Fpi5Hc2ni+o6xF7OdmVBlUP68Elo1PnjjjzUwI
         GTSwHMbnsR++YfpZZul5kMUMMxWDYDovLkkNqMQr06e41i9cdF0g/TryepXyikbTTBRy
         NuNXmuEaG9TY9/BdpOYvhzhgt7LzmUtqBf5YyncjYyTb3QoyWoLJtGA/KrBWu11T30oM
         9kuBqVHsTmwTrgBxyTyMRUG9z9krBqQveECI2sxMgZ7rsCeYKn8EurBk5mSFfsPB55Lu
         yZAA==
X-Gm-Message-State: AOAM531+FdDrN8QEQcWH7leyuYwUMqL/dbQsWsU+4NvAzcRaUtm3P6MU
        S3v1SdLweU3QoMpp/JlBf/ym5wiKa5gLmOFGEDm9jA==
X-Google-Smtp-Source: ABdhPJwDzxGuhVaCs0MCmWLrrRxyrDMbprDyGdZil/inTCBno9piac+590RuthSK0sasRCebEWhk1uPEH0r4Th59n4Y=
X-Received: by 2002:a17:907:1deb:: with SMTP id og43mr16504714ejc.189.1638464416189;
 Thu, 02 Dec 2021 09:00:16 -0800 (PST)
MIME-Version: 1.0
References: <YaaQp2rq7N71dm1l@smile.fi.intel.com> <CAMRc=Me=Oq_V=+p-AFPcyDjBs-+4Ug3k0AWK9fdEEet2JD3eFw@mail.gmail.com>
 <CAMRc=MdQ+a7UrE7csg3GsiLXYGkzti-wPUwPh5J=7WBj74OVZg@mail.gmail.com>
 <YaimotqSgHzS2wdA@smile.fi.intel.com> <CAMRc=Mew8xfPb9kgH-bf=t+yb1xGpRwv3Vn0+b-9pPbp3M3g5Q@mail.gmail.com>
 <YaivZe6Qo9LMoywi@smile.fi.intel.com> <Yaiv470uDhTbPD1A@smile.fi.intel.com>
 <CAMRc=Mdz=pihuTamENmTiWRGeUU=tb_PuxvsarS+oXFpyq4p=g@mail.gmail.com>
 <YajNsrKmEEBr5zWs@smile.fi.intel.com> <CAMRc=MeMhyV1kZ7zvkqrk0okh6shxvB_LapusCFzg6UBh-bU-A@mail.gmail.com>
 <Yajo3IwiLnG5wreC@smile.fi.intel.com>
In-Reply-To: <Yajo3IwiLnG5wreC@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 2 Dec 2021 18:00:05 +0100
Message-ID: <CAMRc=MdcpWpw9cq8Fm5A0RB7TkYkz0NBN5DaASxR2Xe46fBO7A@mail.gmail.com>
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

On Thu, Dec 2, 2021 at 4:41 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Dec 02, 2021 at 02:52:55PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Dec 2, 2021 at 2:45 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Thu, Dec 02, 2021 at 02:06:57PM +0100, Bartosz Golaszewski wrote:
> > > > On Thu, Dec 2, 2021 at 12:38 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > On Thu, Dec 02, 2021 at 01:35:01PM +0200, Andy Shevchenko wrote:
> > > > > > On Thu, Dec 02, 2021 at 12:24:06PM +0100, Bartosz Golaszewski wrote:
> > > > > > > On Thu, Dec 2, 2021 at 11:58 AM Andy Shevchenko
> > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Dec 01, 2021 at 02:11:28PM +0100, Bartosz Golaszewski wrote:
> > > > > > > > > On Tue, Nov 30, 2021 at 10:04 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > > > > > >
> > > > > > > > ...
> > > > > > > >
> > > > > > > > > Let me maybe rephrase the problem: currently, for GPIO devices
> > > > > > > > > instantiating multiple banks created outside of the OF or ACPI
> > > > > > > > > frameworks (e.g. instantiated manually and configured using a
> > > > > > > > > hierarchy of software nodes with a single parent swnode and a number
> > > > > > > > > of child swnodes representing the children), it is impossible to
> > > > > > > > > assign firmware nodes other than the one representing the top GPIO
> > > > > > > > > device to the gpiochip child devices.
> > > > > > > > >
> > > > > > > > > In fact if we want to drop the OF APIs entirely from gpiolib - this
> > > > > > > > > would be the right first step as for gpio-sim it actually replaces the
> > > > > > > > > gc->of_node = some_of_node; assignment that OF-based drivers do for
> > > > > > > > > sub-nodes defining banks and it does work with device-tree (I verified
> > > > > > > > > that too) thanks to the fwnode abstraction layer.
> > > > > > > >
> > > > > > > > In exchange of acknowledgements I confirm that I understood the issue
> > > > > > > > you are describing. What I still don't like is this band-aid:ish approach.
> > > > > > > > What we really need is to replace of_node by fwnode in GPIO library once
> > > > > > > > for all. But it can be done later after your simulation series (or before,
> > > > > > > > i.o.w. independently), hence I propose to update TODO and do it separately.
> > > > > > > >
> > > > > > >
> > > > > > > But this is what we already do for OF. How would the core gpiolib know
> > > > > > > how the firmware nodes represent the banks? It's the driver's job to
> > > > > > > tell the framework which node corresponds with what. If anything, we
> > > > > > > should start replacing of_nodes with fwnodes in drivers and eventually
> > > > > > > we'd drop the of_node pointer from gpio_chip entirely, but we'd keep
> > > > > > > the fwnode pointer I added as the driver still needs to assign it
> > > > > > > itself.
> > > > > > >
> > > > > > > Again: I may be missing something here but I've been going through
> > > > > > > this on and on and can't figure out any other way. Looking at
> > > > > > > gpiolib-acpi.c I don't see it correctly assigning fwnodes to
> > > > > > > sub-devices either but I don't have any HW to test it.
> > > > > > >
> > > > > > > As for this series: I can't really drop this patch as gpio-sim relies
> > > > > > > on swnodes being correctly associated with gpio_chips to identify the
> > > > > > > gpiodevs from configfs callbacks.
> > > > > >
> > > > > > Then we need to replace of_node by fwnode as a first step. I have looked
> > > > > > briefly into the list of drivers that may have been cleaned up and it doesn't
> > > > > > look too long.
> > > > >
> > > > > Let me kick this off by sending couple of patches.
> > > >
> > > > Are you fine with merging this in the meantime to get gpio-sim into mainline?
> > >
> > > gpio-sim, yes, (though I may bikeshed about naming of the configfs attributes,
> > > etc) but not this patch.
> > >
> >
> > There's no way around it though AFAIK. First - the 'gpio-line-names'
> > property will not work for banks. 'ngpios' will only work because we
> > read it manually in probe() to figure out the number of sysfs groups.
> > And also configfs callbacks will not be able to associate bank devices
> > with configfs groups. I would really like to hear an alternative -
> > even if it's just an idea and not actual implementation.
> >
> > I'm really curious to see how you'll remove the of_node pointer and
> > not introduce the corresponding fwnode pointer actually.
>
> Seems I was unclear, fwnode pointer will be needed, but what I'm against of is
> having of_node and fwnode at the same time in the struct gpio_chip.
>
> Yes, we may modify this patch to work without that ugly ifdeffery and with both
> in the structure, but I don't think it's a good solution.
>

It may not be the best solution but we can't simply convert all the
drivers to fwnode and pray they work. I would like every converted
driver to be well tested because there can be some issues lurking in
the fwnode <-> of_node conversion. That will take time.

Meanwhile, this would block gpio-sim for months again. I don't believe
this patch is wrong as it fixes a real issue and as you said: fwnode
will most likely stay in gpio_chip.

IMO we should introduce fwnode, convert gpiolib and drivers to using
it gradually, remove of_node once there are no more users.

Bart

> Now clearly we have to clean up of_node first.
>
