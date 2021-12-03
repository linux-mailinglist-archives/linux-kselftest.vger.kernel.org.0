Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A68D467EAB
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 21:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383003AbhLCUNw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 15:13:52 -0500
Received: from mga03.intel.com ([134.134.136.65]:9889 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382989AbhLCUNw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 15:13:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="236988804"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="236988804"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 12:10:27 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="610535018"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 12:10:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mtEry-001ta5-PP;
        Fri, 03 Dec 2021 22:09:22 +0200
Date:   Fri, 3 Dec 2021 22:09:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v12 3/7] gpiolib: of: make fwnode take precedence in
 struct gpio_chip
Message-ID: <Yap5ctmlw6NeNM+7@smile.fi.intel.com>
References: <20211203133003.31786-1-brgl@bgdev.pl>
 <20211203133003.31786-4-brgl@bgdev.pl>
 <YapnTHQZyNCZXrgp@smile.fi.intel.com>
 <YapoW+DL4jPo69u8@smile.fi.intel.com>
 <Yapp4vakFxH7JV5B@smile.fi.intel.com>
 <CAMRc=MeWfKHWFKwRjaqczrfwhAodpDLgrWKF-zqXCsjd=gMv3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MeWfKHWFKwRjaqczrfwhAodpDLgrWKF-zqXCsjd=gMv3g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 03, 2021 at 08:28:34PM +0100, Bartosz Golaszewski wrote:
> On Fri, Dec 3, 2021 at 8:04 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Dec 03, 2021 at 08:56:27PM +0200, Andy Shevchenko wrote:
> > > On Fri, Dec 03, 2021 at 08:51:56PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Dec 03, 2021 at 02:29:59PM +0100, Bartosz Golaszewski wrote:

...

> > > > >   if (gc->parent)
> > > > >           gdev->dev.of_node = gc->parent->of_node;
> > > > >
> > > > > + if (gc->fwnode)
> > > > > +         gc->of_node = to_of_node(gc->fwnode);
> > > > > +
> > > > >   /* If the gpiochip has an assigned OF node this takes precedence */
> > > > >   if (gc->of_node)
> > > > >           gdev->dev.of_node = gc->of_node;
> > > >
> > > > Similar should be done in acpi_gpio_dev_init():


^^^^^^ (1)

...

> > If we have parent device for several GPIO devices, this won't work right now
> > due to limitations of fwnode regarding to the sturct device.
> >
> > So, it means we may not have shared primary with different secondary fwnodes.
> >
> > So, come back to the initial suggestion (overwrite it for now):
> >
> >         /*
> >          * If custom fwnode provided, use it. Currently we may not
> >          * handle the case where shared primary node has different
> >          * secondary ones. Ideally we have to use
> >          * set_secondary_fwnode() here.
> >          */
> >         if (gc->fwnode)
> >                 device_set_node(&gdev->dev, gc->fwnode);
> >
> 
> Other parts of gpiolib-of depend on the of_node being there.
> Converting it to fwnode is a whole other task so for now I suggest we
> just convert the fwnode to of_node in struct gpio_chip as per my
> patch.

But this is about ACPI counterpart. If you do this, do this in both cases.
Above code for ACPI (1).

-- 
With Best Regards,
Andy Shevchenko


