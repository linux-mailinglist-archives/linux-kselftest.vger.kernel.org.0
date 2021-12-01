Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB2E464EEE
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 14:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbhLANoN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 08:44:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:16329 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232866AbhLANoM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 08:44:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="299847684"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="299847684"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 05:40:51 -0800
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="477541904"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 05:40:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1msPpp-000zsJ-Q2;
        Wed, 01 Dec 2021 15:39:45 +0200
Date:   Wed, 1 Dec 2021 15:39:45 +0200
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
Message-ID: <Yad7IQwXDc8gS2Ne@smile.fi.intel.com>
References: <20211130154127.12272-1-brgl@bgdev.pl>
 <20211130154127.12272-3-brgl@bgdev.pl>
 <YaZNyMV5gX5cZpar@smile.fi.intel.com>
 <CAMRc=Mf5d1i34eBez+pOYjjdyfRL9N_ha_==Cn1rANr=2CB9aQ@mail.gmail.com>
 <YaaQp2rq7N71dm1l@smile.fi.intel.com>
 <CAMRc=Me=Oq_V=+p-AFPcyDjBs-+4Ug3k0AWK9fdEEet2JD3eFw@mail.gmail.com>
 <CAMRc=MdQ+a7UrE7csg3GsiLXYGkzti-wPUwPh5J=7WBj74OVZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdQ+a7UrE7csg3GsiLXYGkzti-wPUwPh5J=7WBj74OVZg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 01, 2021 at 02:11:28PM +0100, Bartosz Golaszewski wrote:
> On Tue, Nov 30, 2021 at 10:04 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Tue, Nov 30, 2021 at 10:00 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Tue, Nov 30, 2021 at 09:25:35PM +0100, Bartosz Golaszewski wrote:
> > > > On Tue, Nov 30, 2021 at 5:15 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > On Tue, Nov 30, 2021 at 04:41:23PM +0100, Bartosz Golaszewski wrote:
> > > > > > Software nodes allow us to represent hierarchies for device components
> > > > > > that don't have their struct device representation yet - for instance:
> > > > > > banks of GPIOs under a common GPIO expander. The core gpiolib core
> > > > >
> > > > > core .. core ?!
> > > > >
> > > > > > however doesn't offer any way of passing this information from the
> > > > > > drivers.
> > > > > >
> > > > > > This extends struct gpio_chip with a pointer to fwnode that can be set
> > > > > > by the driver and used to pass device properties for child nodes.
> > > > > >
> > > > > > This is similar to how we handle device-tree sub-nodes with
> > > > > > CONFIG_OF_GPIO enabled.
> > > > >
> > > > > Not sure I understand the proposal. Can you provide couple of (simplest)
> > > > > examples?
> > > > >
> > > > > And also it sounds like reinventing a wheel. What problem do you have that you
> > > > > need to solve this way?
> > > > >
> > > > > ...
> > > > >
> > > > > > +#if IS_ENABLED(CONFIG_OF_GPIO)
> > > > > > +     if (gc->of_node && gc->fwnode) {
> > > > > > +             pr_err("%s: tried to set both the of_node and fwnode in gpio_chip\n",
> > > > > > +                    __func__);
> > > > > > +             return -EINVAL;
> > > > > > +     }
> > > > > > +#endif /* CONFIG_OF_GPIO */
> > > > >
> > > > > I don't like this. It seems like a hack right now.
> > > > >
> > > > > Is it possible to convert all GPIO controller drivers to provide an fwnode
> > > > > rather than doing this? (I believe in most of the drivers we can drop
> > > > > completely the of_node assignment).
> > > > >
> > > >
> > > > Yes, it's definitely a good idea but I would be careful with just
> > > > dropping the of_node assignments as callbacks may depend on them
> > > > later.
> > >
> > > GPIO library does it for us among these lines:
> > >
> > >         struct fwnode_handle *fwnode = gc->parent ? dev_fwnode(gc->parent) : NULL;
> > >
> > >         of_gpio_dev_init(gc, gdev); <<< HERE!
> > >         acpi_gpio_dev_init(gc, gdev);
> > >
> > >         /*
> > >          * Assign fwnode depending on the result of the previous calls,
> > >          * if none of them succeed, assign it to the parent's one.
> > >          */
> > >         gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
> > >
> >
> > Except that it doesn't and I noticed that when working on the
> > subsequent patch. The child gpiochipX devices all had the parent's
> > fwnode assigned as their primary fwnode and no secondary fwnode.
> >
> > Note that this driver doesn't use neither OF nor ACPI in which case
> > gdev->dev has no fwnode and the parent's one is used. This patch
> > addresses it. If you have a better idea, let me know.
> >
> > Bart
> 
> Let me maybe rephrase the problem: currently, for GPIO devices
> instantiating multiple banks created outside of the OF or ACPI
> frameworks (e.g. instantiated manually and configured using a
> hierarchy of software nodes with a single parent swnode and a number
> of child swnodes representing the children), it is impossible to
> assign firmware nodes other than the one representing the top GPIO
> device to the gpiochip child devices.
> 
> In fact if we want to drop the OF APIs entirely from gpiolib - this
> would be the right first step as for gpio-sim it actually replaces the
> gc->of_node = some_of_node; assignment that OF-based drivers do for
> sub-nodes defining banks and it does work with device-tree (I verified
> that too) thanks to the fwnode abstraction layer.

I still don't see how you set up hierarchy of primary/secondary fwnodes.

And I don't like this change. It seems it band-aids some issue with fwnode
usage. What the easiest way to reproduce the issue with your series applied
(without this change)?

-- 
With Best Regards,
Andy Shevchenko


