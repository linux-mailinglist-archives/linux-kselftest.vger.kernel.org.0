Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A9F46A012
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 16:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378362AbhLFP5S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 10:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359235AbhLFPxG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 10:53:06 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE48C061354
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Dec 2021 07:38:57 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x15so44887297edv.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Dec 2021 07:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9W76LEYV5XhSTyhRdFVRetLYZIBZdbQgyi0kE7VCZkQ=;
        b=Ep1PRSgWEBrqoMpiSmKhUIGt1Fr0WmZ777zbXw94howGm9kNp46MfHZcAt6MoWDTs6
         3809rEmQXOxTqUNa381ZfSyzRGqvSFsdcBMr7PxBDUTl7QWcH3StbT+fvORS4q1lII8/
         7dkVnPx+XYhDj0WyvuUyGsza4I+pP26cDkrwVp/FY2pb+RqoRIgLk0pEVfWqPPx0O4fT
         DM1bAqCrpnYyK0z8NCea4ofaeJwVL02LGd6KMelvL53woiW4SIu2ZvYy5S/p6qPUYhT9
         Tu234fy2YBArgSInn5rHNsI7G8FpZ4AmP0lbQPlWK9UuEP95oFVfu7I7/H53bU2f3AOB
         s7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9W76LEYV5XhSTyhRdFVRetLYZIBZdbQgyi0kE7VCZkQ=;
        b=kqe+pbqhmp9Cfgc7i0p+j8Wtpa4sYIIOK+nkuqtd0IPO5Q2TS0tPyC59JqNK68wFha
         4Cnh7fiJH01H+LZs13ayJogdqpppq2by3GQ5cK9eHMRqYAGWJVp6hMdX2O0gqwmudtms
         CkydEikNp3meu5BkJOpYQyV8ec8gNnkD1fnRHXdtmhovFfp6daOnDCM6vcujpRnXFKzM
         8AUQup+I4q8YJXOC/AezENXEOFMJ9Ht3aSdfbYhk/EiD/sKGrw9cGrwCSfSS6wkZR5R/
         DWUji0KNf9vJV8HlEGUWLAx/HubctQDvz4lEUEtq/E4dlQRpD/m9QvUS2Go3JdNlAHEu
         eSyg==
X-Gm-Message-State: AOAM531P+Va+9PW9Hqc2Iu1M+vmEt3ijI4uPQwKDKB6C85THXinQUSWr
        aWQIoIx/lsudY9VIPbkVP+5LnVxaMTWv+jW5keErqw==
X-Google-Smtp-Source: ABdhPJxB1THlRQIslUVG/FPMSytVNxteW/9OP1ov9HXjuOe9pM8XzbihMvfp6i6oAN0uC/Cg/IXdwRindazm6cTahJo=
X-Received: by 2002:a05:6402:2805:: with SMTP id h5mr49317374ede.267.1638805135387;
 Mon, 06 Dec 2021 07:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20211203133003.31786-1-brgl@bgdev.pl> <20211203133003.31786-5-brgl@bgdev.pl>
 <Yap4/VshDPNxLfOt@smile.fi.intel.com> <CAMRc=MegnF-VZswJym7np4sBMyFf0=gqeFGdKS0xytnmQOhUpw@mail.gmail.com>
 <Ya4Q7s9sbk2UHNA3@smile.fi.intel.com>
In-Reply-To: <Ya4Q7s9sbk2UHNA3@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Dec 2021 16:38:44 +0100
Message-ID: <CAMRc=Md9S20JBYYVTkkpgOTgBofDrt3QrbPK94zP4jGw30bq3g@mail.gmail.com>
Subject: Re: [PATCH v12 4/7] gpio: sim: new testing module
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 6, 2021 at 2:33 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Dec 06, 2021 at 10:48:00AM +0100, Bartosz Golaszewski wrote:
> > On Fri, Dec 3, 2021 at 9:08 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Dec 03, 2021 at 02:30:00PM +0100, Bartosz Golaszewski wrote:
>
> ...
>
> > > > +#include <linux/gpio/driver.h>
> > > > +#include <linux/gpio/machine.h>
> > >
> > > I would rather move this group below to emphasize that this is closer to GPIO
> > > then to other APIs.
> > >
> > > > +#include <linux/sysfs.h>
> > > > +
> > >
> > > ...here.
> > >
> >
> > With the number of headers in this file, I'd stick with alphabetical order.
>
> I understand that and agree, but my point is orthogonal to this. The idea is to
> emphasize that "hey. this driver has tough relations with the GPIO subsystem".
> This is the way, for example, IIO does and I like it.
>

I really don't think this is necessary.

> > > > +#include "gpiolib.h"
>
> ...
>
> > > > +static int gpio_sim_apply_pull(struct gpio_sim_chip *chip,
> > > > +                            unsigned int offset, int value)
> > >
> > > I would use up to 100 here...
> > >
> > > > +     if (test_bit(FLAG_REQUESTED, &desc->flags) &&
> > > > +         !test_bit(FLAG_IS_OUT, &desc->flags)) {
> > >
> > > ...here and so on.
> > >
> > > But it's up to you.
> > >
> >
> > Nah, the lines are broken just fine. Let's not overuse the limit.
>
> Yes, but I would consider to join back those which are up to ~83 characters
> (I already pointed out at least to one example like this).
>

I like the old-style limit TBH.

> ...
>
> > > > +     if (sysfs_streq(buf, "pull-down"))
> > > > +             pull = 0;
> > > > +     else if (sysfs_streq(buf, "pull-up"))
> > > > +             pull = 1;
> > > > +     else
> > > > +             return -EINVAL;
> > >
> > > sysfs_match_string() and use the very same string array in the above function
> > > to print them?
>
> I suppose you agree on this?
>

Yes, already changed that in v13.

> ...
>
> > > > +     /* Default to input mode. */
> > > > +     bitmap_fill(chip->direction_map, num_lines);
> > >
> > > More accurate is to use bitmap_set(). If we ever debug this it also helpful.
> >
> > I'm not sure what you mean, this sets all bits to 1.
>
> Nope, it may set _more_ than all bits. That's why bitmap_set() is more
> accurate, because it will do exact setting.
>

Can this in any way affect any of the code? If the driver is correct,
it will never use anything beyond the last line bit. If it does, it
needs fixing. It's as if we cared about what happens to padding added
to structures by the compiler (as long as we're not passing it to
user-space of course).

> ...
>
> > > > +     if (strcmp(trimmed, "input") == 0)
> > > > +             dir = GPIOD_IN;
> > > > +     else if (strcmp(trimmed, "output-high") == 0)
> > > > +             dir = GPIOD_OUT_HIGH;
> > > > +     else if (strcmp(trimmed, "output-low") == 0)
> > > > +             dir = GPIOD_OUT_LOW;
> > > > +     else
> > > > +             dir = -EINVAL;
> > >
> > > Same idea, i.e. static string array and use it above and here with help
> > > of match_string().
> >
> > It would be great but GPIOD_IN etc. are bit flags and not sequence enums.
>
> Ah, okay, it will make rather sparse array.
>

Idea for the future: introduce match_string_ext() with flags one of
which would allow sparse string arrays?

Bart
