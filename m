Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22D646972D
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 14:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244567AbhLFNhD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 08:37:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:61750 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244021AbhLFNhC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 08:37:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="224179962"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="224179962"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 05:33:34 -0800
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="611237903"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 05:33:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1muE6Y-002nGv-G0;
        Mon, 06 Dec 2021 15:32:30 +0200
Date:   Mon, 6 Dec 2021 15:32:30 +0200
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
Subject: Re: [PATCH v12 4/7] gpio: sim: new testing module
Message-ID: <Ya4Q7s9sbk2UHNA3@smile.fi.intel.com>
References: <20211203133003.31786-1-brgl@bgdev.pl>
 <20211203133003.31786-5-brgl@bgdev.pl>
 <Yap4/VshDPNxLfOt@smile.fi.intel.com>
 <CAMRc=MegnF-VZswJym7np4sBMyFf0=gqeFGdKS0xytnmQOhUpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MegnF-VZswJym7np4sBMyFf0=gqeFGdKS0xytnmQOhUpw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 06, 2021 at 10:48:00AM +0100, Bartosz Golaszewski wrote:
> On Fri, Dec 3, 2021 at 9:08 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Dec 03, 2021 at 02:30:00PM +0100, Bartosz Golaszewski wrote:

...

> > > +#include <linux/gpio/driver.h>
> > > +#include <linux/gpio/machine.h>
> >
> > I would rather move this group below to emphasize that this is closer to GPIO
> > then to other APIs.
> >
> > > +#include <linux/sysfs.h>
> > > +
> >
> > ...here.
> >
> 
> With the number of headers in this file, I'd stick with alphabetical order.

I understand that and agree, but my point is orthogonal to this. The idea is to
emphasize that "hey. this driver has tough relations with the GPIO subsystem".
This is the way, for example, IIO does and I like it.

> > > +#include "gpiolib.h"

...

> > > +static int gpio_sim_apply_pull(struct gpio_sim_chip *chip,
> > > +                            unsigned int offset, int value)
> >
> > I would use up to 100 here...
> >
> > > +     if (test_bit(FLAG_REQUESTED, &desc->flags) &&
> > > +         !test_bit(FLAG_IS_OUT, &desc->flags)) {
> >
> > ...here and so on.
> >
> > But it's up to you.
> >
> 
> Nah, the lines are broken just fine. Let's not overuse the limit.

Yes, but I would consider to join back those which are up to ~83 characters
(I already pointed out at least to one example like this).

...

> > > +     if (sysfs_streq(buf, "pull-down"))
> > > +             pull = 0;
> > > +     else if (sysfs_streq(buf, "pull-up"))
> > > +             pull = 1;
> > > +     else
> > > +             return -EINVAL;
> >
> > sysfs_match_string() and use the very same string array in the above function
> > to print them?

I suppose you agree on this?

...

> > > +     /* Default to input mode. */
> > > +     bitmap_fill(chip->direction_map, num_lines);
> >
> > More accurate is to use bitmap_set(). If we ever debug this it also helpful.
> 
> I'm not sure what you mean, this sets all bits to 1.

Nope, it may set _more_ than all bits. That's why bitmap_set() is more
accurate, because it will do exact setting.

...

> > > +     if (strcmp(trimmed, "input") == 0)
> > > +             dir = GPIOD_IN;
> > > +     else if (strcmp(trimmed, "output-high") == 0)
> > > +             dir = GPIOD_OUT_HIGH;
> > > +     else if (strcmp(trimmed, "output-low") == 0)
> > > +             dir = GPIOD_OUT_LOW;
> > > +     else
> > > +             dir = -EINVAL;
> >
> > Same idea, i.e. static string array and use it above and here with help
> > of match_string().
> 
> It would be great but GPIOD_IN etc. are bit flags and not sequence enums.

Ah, okay, it will make rather sparse array.

-- 
With Best Regards,
Andy Shevchenko


