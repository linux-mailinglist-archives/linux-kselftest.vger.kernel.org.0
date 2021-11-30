Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191A1463F54
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 21:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbhK3UgQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Nov 2021 15:36:16 -0500
Received: from mga06.intel.com ([134.134.136.31]:32793 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233340AbhK3UgP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Nov 2021 15:36:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="297117964"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="297117964"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 12:32:56 -0800
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="499927892"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 12:32:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ms9mP-000hmT-Ru;
        Tue, 30 Nov 2021 22:31:09 +0200
Date:   Tue, 30 Nov 2021 22:31:09 +0200
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
Message-ID: <YaaKDSY0qkEZqSP3@smile.fi.intel.com>
References: <20211130154127.12272-1-brgl@bgdev.pl>
 <20211130154127.12272-3-brgl@bgdev.pl>
 <YaZNyMV5gX5cZpar@smile.fi.intel.com>
 <YaZPACT53i4LovrM@smile.fi.intel.com>
 <CAMRc=MdRMeyzonY+AZa8CWfh6Bk64e3OXAmGk3X=rx=DrM4-mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdRMeyzonY+AZa8CWfh6Bk64e3OXAmGk3X=rx=DrM4-mw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 30, 2021 at 07:32:28PM +0100, Bartosz Golaszewski wrote:
> On Tue, Nov 30, 2021 at 5:20 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Nov 30, 2021 at 06:14:01PM +0200, Andy Shevchenko wrote:
> > > On Tue, Nov 30, 2021 at 04:41:23PM +0100, Bartosz Golaszewski wrote:
> >
> > ...
> >
> > > Not sure I understand the proposal. Can you provide couple of (simplest)
> > > examples?
> > >
> > > And also it sounds like reinventing a wheel. What problem do you have that you
> > > need to solve this way?
> >
> > Have you seen these:
> >         drivers/gpio/gpio-dwapb.c
> >         drivers/mfd/intel_quark_i2c_gpio.c
> > ?
> >
> > GPIO driver has a main (controller level) node along with children on per bank
> > basis. Currently it works with the provided approach (see second driver).

> Yep, I know dwapd. What happens in probe is that each bank device is
> created using the properties from the associated child fwnode but the
> parent device's fwnode is actually assigned as the gpiochip's fwnode.

The first device is the physical device of the GPIO controller,
the

   ,-> fwnode of the physical device
   |
  GPIO  -> portA -> gpiodev A (child fwnode A)
       `-> portB -> gpiodev B (child fwnode B)
           ...

> This is logically wrong

I don't see how, it represents hardware as is.

> and OF doesn't do it - it assigns the child
> of_node to the child device if gpio_chip->of_node is assigned in the
> driver.

And this is exactly what happens.

> I'm not sure if ACPI does this.

Depending on the device description. In the case of dwapb on Galileo platform
the ACPI just misses that, that's why board files (see second driver).

> Non-OF drivers don't have a way to do this and this patch enables it.

You meant non-FW drivers, right? How come? What am I missing?

I don't see the issue here. When user wants to have GPIO device, first we
instantiate it with its own fwnode (in your case swnode), followed by
additional (child) swnode per bank.

> I want to add it mostly because gpio-sim can then use the software
> node to identify the device in the configfs by that software node but
> IMO this is logically correct too.

I also think so.

-- 
With Best Regards,
Andy Shevchenko


