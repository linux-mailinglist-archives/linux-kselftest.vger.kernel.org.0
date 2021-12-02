Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5D2466927
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Dec 2021 18:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhLBRen (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 12:34:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:27255 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376394AbhLBRej (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 12:34:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236982442"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="236982442"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 09:30:49 -0800
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="477983213"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 09:30:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1msptu-001TJJ-9F;
        Thu, 02 Dec 2021 19:29:42 +0200
Date:   Thu, 2 Dec 2021 19:29:41 +0200
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
Message-ID: <YakChWAsBw8yU4dq@smile.fi.intel.com>
References: <CAMRc=MdQ+a7UrE7csg3GsiLXYGkzti-wPUwPh5J=7WBj74OVZg@mail.gmail.com>
 <YaimotqSgHzS2wdA@smile.fi.intel.com>
 <CAMRc=Mew8xfPb9kgH-bf=t+yb1xGpRwv3Vn0+b-9pPbp3M3g5Q@mail.gmail.com>
 <YaivZe6Qo9LMoywi@smile.fi.intel.com>
 <Yaiv470uDhTbPD1A@smile.fi.intel.com>
 <CAMRc=Mdz=pihuTamENmTiWRGeUU=tb_PuxvsarS+oXFpyq4p=g@mail.gmail.com>
 <YajNsrKmEEBr5zWs@smile.fi.intel.com>
 <CAMRc=MeMhyV1kZ7zvkqrk0okh6shxvB_LapusCFzg6UBh-bU-A@mail.gmail.com>
 <Yajo3IwiLnG5wreC@smile.fi.intel.com>
 <CAMRc=MdcpWpw9cq8Fm5A0RB7TkYkz0NBN5DaASxR2Xe46fBO7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdcpWpw9cq8Fm5A0RB7TkYkz0NBN5DaASxR2Xe46fBO7A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 02, 2021 at 06:00:05PM +0100, Bartosz Golaszewski wrote:
> On Thu, Dec 2, 2021 at 4:41 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Dec 02, 2021 at 02:52:55PM +0100, Bartosz Golaszewski wrote:
> > > On Thu, Dec 2, 2021 at 2:45 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Dec 02, 2021 at 02:06:57PM +0100, Bartosz Golaszewski wrote:
> > > > > On Thu, Dec 2, 2021 at 12:38 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Thu, Dec 02, 2021 at 01:35:01PM +0200, Andy Shevchenko wrote:
> > > > > > > On Thu, Dec 02, 2021 at 12:24:06PM +0100, Bartosz Golaszewski wrote:
> > > > > > > > On Thu, Dec 2, 2021 at 11:58 AM Andy Shevchenko
> > > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > > On Wed, Dec 01, 2021 at 02:11:28PM +0100, Bartosz Golaszewski wrote:
> > > > > > > > > > On Tue, Nov 30, 2021 at 10:04 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > > > > > > >
> > > > > > > > > ...
> > > > > > > > >
> > > > > > > > > > Let me maybe rephrase the problem: currently, for GPIO devices
> > > > > > > > > > instantiating multiple banks created outside of the OF or ACPI
> > > > > > > > > > frameworks (e.g. instantiated manually and configured using a
> > > > > > > > > > hierarchy of software nodes with a single parent swnode and a number
> > > > > > > > > > of child swnodes representing the children), it is impossible to
> > > > > > > > > > assign firmware nodes other than the one representing the top GPIO
> > > > > > > > > > device to the gpiochip child devices.
> > > > > > > > > >
> > > > > > > > > > In fact if we want to drop the OF APIs entirely from gpiolib - this
> > > > > > > > > > would be the right first step as for gpio-sim it actually replaces the
> > > > > > > > > > gc->of_node = some_of_node; assignment that OF-based drivers do for
> > > > > > > > > > sub-nodes defining banks and it does work with device-tree (I verified
> > > > > > > > > > that too) thanks to the fwnode abstraction layer.
> > > > > > > > >
> > > > > > > > > In exchange of acknowledgements I confirm that I understood the issue
> > > > > > > > > you are describing. What I still don't like is this band-aid:ish approach.
> > > > > > > > > What we really need is to replace of_node by fwnode in GPIO library once
> > > > > > > > > for all. But it can be done later after your simulation series (or before,
> > > > > > > > > i.o.w. independently), hence I propose to update TODO and do it separately.
> > > > > > > > >
> > > > > > > >
> > > > > > > > But this is what we already do for OF. How would the core gpiolib know
> > > > > > > > how the firmware nodes represent the banks? It's the driver's job to
> > > > > > > > tell the framework which node corresponds with what. If anything, we
> > > > > > > > should start replacing of_nodes with fwnodes in drivers and eventually
> > > > > > > > we'd drop the of_node pointer from gpio_chip entirely, but we'd keep
> > > > > > > > the fwnode pointer I added as the driver still needs to assign it
> > > > > > > > itself.
> > > > > > > >
> > > > > > > > Again: I may be missing something here but I've been going through
> > > > > > > > this on and on and can't figure out any other way. Looking at
> > > > > > > > gpiolib-acpi.c I don't see it correctly assigning fwnodes to
> > > > > > > > sub-devices either but I don't have any HW to test it.
> > > > > > > >
> > > > > > > > As for this series: I can't really drop this patch as gpio-sim relies
> > > > > > > > on swnodes being correctly associated with gpio_chips to identify the
> > > > > > > > gpiodevs from configfs callbacks.
> > > > > > >
> > > > > > > Then we need to replace of_node by fwnode as a first step. I have looked
> > > > > > > briefly into the list of drivers that may have been cleaned up and it doesn't
> > > > > > > look too long.
> > > > > >
> > > > > > Let me kick this off by sending couple of patches.
> > > > >
> > > > > Are you fine with merging this in the meantime to get gpio-sim into mainline?
> > > >
> > > > gpio-sim, yes, (though I may bikeshed about naming of the configfs attributes,
> > > > etc) but not this patch.
> > > >
> > >
> > > There's no way around it though AFAIK. First - the 'gpio-line-names'
> > > property will not work for banks. 'ngpios' will only work because we
> > > read it manually in probe() to figure out the number of sysfs groups.
> > > And also configfs callbacks will not be able to associate bank devices
> > > with configfs groups. I would really like to hear an alternative -
> > > even if it's just an idea and not actual implementation.
> > >
> > > I'm really curious to see how you'll remove the of_node pointer and
> > > not introduce the corresponding fwnode pointer actually.
> >
> > Seems I was unclear, fwnode pointer will be needed, but what I'm against of is
> > having of_node and fwnode at the same time in the struct gpio_chip.
> >
> > Yes, we may modify this patch to work without that ugly ifdeffery and with both
> > in the structure, but I don't think it's a good solution.
> >
> 
> It may not be the best solution but we can't simply convert all the
> drivers to fwnode and pray they work. I would like every converted
> driver to be well tested because there can be some issues lurking in
> the fwnode <-> of_node conversion. That will take time.

> Meanwhile, this would block gpio-sim for months again. I don't believe
> this patch is wrong as it fixes a real issue and as you said: fwnode
> will most likely stay in gpio_chip.o

It doesn't strictly speaking "fix". But it allows to get things right.

> IMO we should introduce fwnode, convert gpiolib and drivers to using
> it gradually, remove of_node once there are no more users.

I may accept the change after some amendments done:
 - get rid of ifdeffery (remove that block completely)
 - add TODO entry
 - add "deprecated" keyword to of_node
 - ...I hope I haven't miss anything else...

> > Now clearly we have to clean up of_node first.

-- 
With Best Regards,
Andy Shevchenko


