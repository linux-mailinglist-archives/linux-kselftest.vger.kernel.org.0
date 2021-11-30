Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75955463F95
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 22:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343936AbhK3VEc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Nov 2021 16:04:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:3406 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343957AbhK3VDs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Nov 2021 16:03:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="260283481"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="260283481"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 13:00:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="559738624"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 13:00:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1msADf-000iYw-RX;
        Tue, 30 Nov 2021 22:59:19 +0200
Date:   Tue, 30 Nov 2021 22:59:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 2/6] gpiolib: allow to specify the firmware node in
 struct gpio_chip
Message-ID: <YaaQp2rq7N71dm1l@smile.fi.intel.com>
References: <20211130154127.12272-1-brgl@bgdev.pl>
 <20211130154127.12272-3-brgl@bgdev.pl>
 <YaZNyMV5gX5cZpar@smile.fi.intel.com>
 <CAMRc=Mf5d1i34eBez+pOYjjdyfRL9N_ha_==Cn1rANr=2CB9aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mf5d1i34eBez+pOYjjdyfRL9N_ha_==Cn1rANr=2CB9aQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 30, 2021 at 09:25:35PM +0100, Bartosz Golaszewski wrote:
> On Tue, Nov 30, 2021 at 5:15 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Nov 30, 2021 at 04:41:23PM +0100, Bartosz Golaszewski wrote:
> > > Software nodes allow us to represent hierarchies for device components
> > > that don't have their struct device representation yet - for instance:
> > > banks of GPIOs under a common GPIO expander. The core gpiolib core
> >
> > core .. core ?!
> >
> > > however doesn't offer any way of passing this information from the
> > > drivers.
> > >
> > > This extends struct gpio_chip with a pointer to fwnode that can be set
> > > by the driver and used to pass device properties for child nodes.
> > >
> > > This is similar to how we handle device-tree sub-nodes with
> > > CONFIG_OF_GPIO enabled.
> >
> > Not sure I understand the proposal. Can you provide couple of (simplest)
> > examples?
> >
> > And also it sounds like reinventing a wheel. What problem do you have that you
> > need to solve this way?
> >
> > ...
> >
> > > +#if IS_ENABLED(CONFIG_OF_GPIO)
> > > +     if (gc->of_node && gc->fwnode) {
> > > +             pr_err("%s: tried to set both the of_node and fwnode in gpio_chip\n",
> > > +                    __func__);
> > > +             return -EINVAL;
> > > +     }
> > > +#endif /* CONFIG_OF_GPIO */
> >
> > I don't like this. It seems like a hack right now.
> >
> > Is it possible to convert all GPIO controller drivers to provide an fwnode
> > rather than doing this? (I believe in most of the drivers we can drop
> > completely the of_node assignment).
> >
> 
> Yes, it's definitely a good idea but I would be careful with just
> dropping the of_node assignments as callbacks may depend on them
> later.

GPIO library does it for us among these lines:

	struct fwnode_handle *fwnode = gc->parent ? dev_fwnode(gc->parent) : NULL;

	of_gpio_dev_init(gc, gdev); <<< HERE!
	acpi_gpio_dev_init(gc, gdev);

	/*
	 * Assign fwnode depending on the result of the previous calls,
	 * if none of them succeed, assign it to the parent's one.
	 */
	gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;


> Also it's not just about the gpio_chip of_node assignment -
> drivers also use a bunch of OF APIs all around the place. I would
> prefer that it be done one by one and every modified driver be tested.

That's why we want to eliminate dev->fwnode explicit dereference as a first
step (see dev_fwnode() / device_set_node() APIs).

-- 
With Best Regards,
Andy Shevchenko


