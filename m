Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410FB46A22F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 18:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhLFRJJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 12:09:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:17089 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350011AbhLFRFz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 12:05:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="224225605"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="224225605"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 09:02:04 -0800
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="679057383"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 09:01:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1muHMI-002rA7-Am;
        Mon, 06 Dec 2021 19:00:58 +0200
Date:   Mon, 6 Dec 2021 19:00:58 +0200
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
Message-ID: <Ya5BytiTv7+RpYph@smile.fi.intel.com>
References: <20211203133003.31786-1-brgl@bgdev.pl>
 <20211203133003.31786-5-brgl@bgdev.pl>
 <Yap4/VshDPNxLfOt@smile.fi.intel.com>
 <CAMRc=MegnF-VZswJym7np4sBMyFf0=gqeFGdKS0xytnmQOhUpw@mail.gmail.com>
 <Ya4Q7s9sbk2UHNA3@smile.fi.intel.com>
 <CAMRc=Md9S20JBYYVTkkpgOTgBofDrt3QrbPK94zP4jGw30bq3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Md9S20JBYYVTkkpgOTgBofDrt3QrbPK94zP4jGw30bq3g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 06, 2021 at 04:38:44PM +0100, Bartosz Golaszewski wrote:
> On Mon, Dec 6, 2021 at 2:33 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Dec 06, 2021 at 10:48:00AM +0100, Bartosz Golaszewski wrote:
> > > On Fri, Dec 3, 2021 at 9:08 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > Nah, the lines are broken just fine. Let's not overuse the limit.
> >
> > Yes, but I would consider to join back those which are up to ~83 characters
> > (I already pointed out at least to one example like this).
> 
> I like the old-style limit TBH.

And it's fine. It has remark about overlapping in case of readability and 81
characters on one line is fine as some cases when it is up to ~83 (for old
style).

Anyways, it doesn't worth of spending more time on this. Your choice then.

...

> > > > > +     /* Default to input mode. */
> > > > > +     bitmap_fill(chip->direction_map, num_lines);
> > > >
> > > > More accurate is to use bitmap_set(). If we ever debug this it also helpful.
> > >
> > > I'm not sure what you mean, this sets all bits to 1.
> >
> > Nope, it may set _more_ than all bits. That's why bitmap_set() is more
> > accurate, because it will do exact setting.
> 
> Can this in any way affect any of the code? If the driver is correct,
> it will never use anything beyond the last line bit. If it does, it
> needs fixing. It's as if we cared about what happens to padding added
> to structures by the compiler (as long as we're not passing it to
> user-space of course).

I haven't checked if it affects current code. Consider this as heads up,
because developers often forget about this nuance of bitmap_fill() /
bitmap_clear().

...

> > > > > +     if (strcmp(trimmed, "input") == 0)
> > > > > +             dir = GPIOD_IN;
> > > > > +     else if (strcmp(trimmed, "output-high") == 0)
> > > > > +             dir = GPIOD_OUT_HIGH;
> > > > > +     else if (strcmp(trimmed, "output-low") == 0)
> > > > > +             dir = GPIOD_OUT_LOW;
> > > > > +     else
> > > > > +             dir = -EINVAL;
> > > >
> > > > Same idea, i.e. static string array and use it above and here with help
> > > > of match_string().
> > >
> > > It would be great but GPIOD_IN etc. are bit flags and not sequence enums.
> >
> > Ah, okay, it will make rather sparse array.
> 
> Idea for the future: introduce match_string_ext() with flags one of
> which would allow sparse string arrays?

I thought about that, but since it's a mix of the bits, it might not be so
universal anyway, I would rather think of something which uses 1-bit bit
fields unified under a bit mask, and not a mix of 2 or more bits.

-- 
With Best Regards,
Andy Shevchenko


