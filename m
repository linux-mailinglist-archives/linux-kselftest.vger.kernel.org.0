Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD682E8D28
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Jan 2021 17:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbhACQ3h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Jan 2021 11:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbhACQ3h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Jan 2021 11:29:37 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDDAC061573;
        Sun,  3 Jan 2021 08:28:56 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id q22so14847124pfk.12;
        Sun, 03 Jan 2021 08:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YHn1ABpSIMNNKM9C0iM0nClJPobmJUK657K7NVHO9W4=;
        b=vCSXiw+g5ITtj8oA63vl0JrNxihfa6Sxu/iT9VyMfgZSSLfjnBDUyhJ0JDff+kj8CA
         xzD8w91sZS4peVCmAg8Wo5x/nZu4PaOCqQotyig7ioe+DAFTMIA8bZu4SdKEJ+gp7NYW
         pTdRlQ6wxg+Tbf2/G64Ez5kq40Oxwxs54r0bFLP8k2ZxdtnsFYANE+A0qQq/3Ea6JQou
         WDOdrAgq9MOQDJLTnWhGIfAdzrr6UBLZqr0NEdcgYWLDVA5MGQrbuzJH+7cyX34uPEme
         F507mtr36gJlKjJglicZrURk/zquEvSDWmWLQNPWOWt21IZeKj8upla/OKY6nLkno/7C
         CK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YHn1ABpSIMNNKM9C0iM0nClJPobmJUK657K7NVHO9W4=;
        b=krDvFru4PiROorKnYIiMrs0ZpWcgrLoLwFbhqdRZJ6PgIgTxtPy5g787HZL3kHiPi3
         nIyasWCmt+pxKuRiLQi4X8dKZ8qtYIZ7dJmZLzxudxSOZwmZ7fvlm+Ov4nRml70VfLQG
         Ur6uNNPNo2zp/Hh2MYBQ87dY+q6MeFgYwYpP3kmTSZv2an+NRV0b8i0/k4mB7hksq5Qr
         uQyGVL0JTfqFKPJJBWxVKD/p1yy6cr+PZ/QeeuV+Bd9l8VRS8RjZlYBA8Z5/GX51xV/x
         Ff/B9qB1bfXXuJFiwmha2EU5TntZNuFXiI43MwF+n37mwPN/9+aX6jYAn7AI2jAa1UuG
         Q6rA==
X-Gm-Message-State: AOAM5300j3Eef/jM/ghChWYpPlScg038eJ9XqoyAWm1SONDpMYGm1K4z
        BNGeErBt0/OGX+Xk3J+yxORpj0c5HtiO9w==
X-Google-Smtp-Source: ABdhPJyi/YBVX8JkNUkZgxAvDMm5uJ7ePypeGlPMv0YzD0LmBlDQ4gyHZ9Epyele+wnBpcZ5zmQCGg==
X-Received: by 2002:a65:5209:: with SMTP id o9mr25272144pgp.34.1609691336344;
        Sun, 03 Jan 2021 08:28:56 -0800 (PST)
Received: from sol (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id x21sm29992840pgi.75.2021.01.03.08.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 08:28:55 -0800 (PST)
Date:   Mon, 4 Jan 2021 00:28:49 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Subject: Re: [PATCH 1/7] selftests: gpio: rework and simplify test
 implementation
Message-ID: <20210103162849.GA308445@sol>
References: <20210102022949.92304-1-warthog618@gmail.com>
 <20210102022949.92304-2-warthog618@gmail.com>
 <CAHp75VdMs1mP7pK46qKqJbjfyrcKhSGvtyzQpTRsehMz6o=Jpg@mail.gmail.com>
 <20210103021725.GA6622@sol>
 <CAHp75VfONKY7VS0q=GkSX14i--g0=jfBg4RFBoMk4DxJPMHJFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfONKY7VS0q=GkSX14i--g0=jfBg4RFBoMk4DxJPMHJFg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jan 03, 2021 at 05:10:10PM +0200, Andy Shevchenko wrote:
> On Sun, Jan 3, 2021 at 4:17 AM Kent Gibson <warthog618@gmail.com> wrote:
> > On Sun, Jan 03, 2021 at 12:20:26AM +0200, Andy Shevchenko wrote:
> > > On Sat, Jan 2, 2021 at 4:32 AM Kent Gibson <warthog618@gmail.com> wrote:
> 
> ...
> 
> > > > +#include <linux/gpio.h>
> > >
> > > Perhaps include it after system headers?
> >
> > hehe, I blindly sorted them.
> > Should it matter?
> 
> I would include more particular headers later.
> Btw system headers can not always be in order because of dependencies.
> 
> ...
> 
> > > > +       local platform=`cat $SYSFS/kernel/debug/gpio | grep "$chip:" | tr -d ',' | awk '{print $5}'`
> > >
> > > Besides useless use of cat (and tr + awk can be simplified) why are
> >
> > What do you suggest for the tr/awk simplification?
> 
> You have `awk`, you can easily switch the entire pipeline to a little
> awk scriptlet.
> 

Ah ok - I was actually going the other way to do away with the awk, so
had replaced it with a pair of cuts, though I'm still looking for better
alternatives for the whole gpiochipN:offset -> sysfs_nr mapping problem
- see below.

> > > you simply not using
> > > /sys/bus/gpio/devices/$chip ?
> >
> > Cos that shows all the gpiochips, not just the ones created by gpio-mockup.
> 
> I didn't get this. What is the content of $chip in your case?
> 

$chip is the gpiochipN name, so gpiochip0, gpiochip1 etc.

What we are trying to find here is the base of the GPIO numbering for
the chip so we can export/unexport them to sysfs (after adding the
offset for the particular line).

> > And I certainly don't want to go messing with real hardware.
> > The default tests should still run on real hardware - but only
> > accessing the mockup devices.
> >
> > Got a better way to filter out real hardware?
> 
> I probably have to understand what is the input and what is the
> expected output. It's possible I missed something here.
> 
> > > > +       # e.g. /sys/class/gpio/gpiochip508/device/gpiochip0/dev
> > > > +       local syschip=`ls -d $GPIO_SYSFS/gpiochip*/device/$chip/dev`
> > >
> > > ls -d is fragile, better to use `find ...`
> >
> > OK
> >
> > > > +       syschip=${syschip#$GPIO_SYSFS}
> > > > +       syschip=${syschip%/device/$chip/dev}
> > >
> > > How does this handle more than one gpiochip listed?
> >
> > It is filtered by $chip so there can only be one.
> > Or is that a false assumption?
> 
> When you have glob() in use it may return any number of results
> (starting from 0) and your script should be prepared for that.
> 

Yeah, we really don't want to be using globs at all.

> > > Also, can you consider optimizing these to get whatever you want easily?
> >
> > Sadly that IS my optimized way - I don't know of an easier way to find
> > the sysfs GPIO number given the gpiochip and offset :-(.
> > Happy to learn of any alternative.
> 
> I'm talking about getting $syschip. I think there is a way to get it
> without all those shell substitutions from somewhere else.
> 

$syschip is just an intermediate that I'm not really interested in - it
just helps find the base, and so the nr.

I've been playing with alternatives and my current one is:

	# e.g. /sys/devices/platform/gpio-mockup.1/gpiochip1
	local platform=$(find $SYSFS/devices/platform/ -name $chip -type d -maxdepth 2)
	[ "$platform" ] || fail "can't find platform of $chip"
	# e.g. /sys/devices/platform/gpio-mockup.1/gpio/gpiochip508/base
	local base=$(find $(dirname $platform)/gpio/ -name base -type f -maxdepth 2)
	[ "$base" ] || fail "can't find base of $chip"
	sysfs_nr=$(< $base)
	sysfs_nr=$(($sysfs_nr + $offset))

which works, though still doesn't handle the possibility of multiple
matches returned by the finds.

> > > > +       sysfs_nr=`cat $SYSFS/devices/$platform/gpio/$syschip/base`
> > >
> > > (It's probably fine here, but this doesn't work against PCI bus, for
> > > example, see above for the fix)
> >
> > Not sure what you mean here.
> 
> When GPIO is a PCI device the above won't give a proper path.
> If we wish to give an example to somebody, it would be better to have
> it good enough.
> 

How would it appear for PCI bus?

> > > > +       sysfs_nr=$(($sysfs_nr + $offset))
> > > > +       sysfs_ldir=$GPIO_SYSFS/gpio$sysfs_nr
> > > >  }
> 
> ...
> 
> > > > +set_line()
> > > >  {
> > > > +       if [ -z "$sysfs_nr" ]; then
> > > > +               find_sysfs_nr
> > > > +               echo $sysfs_nr > $GPIO_SYSFS/export
> > > >         fi
> > >
> > > It sounds like a separate function (you have release_line(), perhaps
> > > acquire_line() is good to have).
> > >
> >
> > The cdev implementation has to release and re-acquire in the background
> > as there is no simple way to perform a set_config on a requested line
> > from shell - just holding the requested line for a set is painful enough,
> > and the goal here was to keep the tests simple.
> >
> > I didn't want to make line acquisition/release explicit in the gpio-mockup
> > tests, as that would make them needlessly complicated, so the acquire is
> > bundled into the set_line - and anywhere else the uAPI implementation
> > needs it.  There is an implicit assumption that a set_line will always
> > be called before a get_line, but that is always true - there is no
> > "as-is" being tested here.
> >
> > Of course you still need the release_line at the end of the test, so
> > that is still there.
> 
> Yes and to me logically correct to distinguish acquire_line() with set_line().
> Then wherever you need to set_line(), you may call acquire_line()
> which should be idempotent (the same way as release_line() call).
> 

Oh, ok - it would only be called from set_line - I thought you meant
expose it as part of the uAPI test interface (currently
get_line/set_line/release_line).

> > > > +release_line()
> > > >  {
> > > > +       [ -z "$sysfs_nr" ] && return
> > > > +       echo $sysfs_nr > $GPIO_SYSFS/unexport
> > > > +       sysfs_nr=
> > > > +       sysfs_ldir=
> > > >  }
> 
> ...
> 
> > > > +skip()
> > > >  {
> > >
> > > > +       echo $* >&2
> > >
> > > In all cases better to use "$*" (note surrounding double quotes).
> > >
> >
> > Agreed - except where
> >
> >         for option in $*; do
> >
> > is used to parse parameters.
> 
> Exactly! And "" helps with that.
> 
> If I put parameters as `a b c "d e"`, your case will take them wrongly.
> 
> > > > +       echo GPIO $module test SKIP
> > > > +       exit $ksft_skip
> > > >  }
> > >
> > > ...
> > >
> > > > +        [ ! which modprobe > /dev/null 2>&1 ] && skip "need modprobe installed"
> > >
> > > AFAIR `which` can be optional on some systems.
> > >
> >
> > That is how other selftests check for availability of modprobe.
> > e.g. selftests/kmod/kmod.sh and selftests/vm/test_hmm.sh, so I assumed
> > it was acceptable.
> >
> > Is there an alternative?
> 
> OK. Just replace it with a dropped useless test call.
> which ... || skip ...
> 

Yup - I've since replaced it with a test call to modprobe -h, so no
`which` required.

> ...
> 
> > > P.S. Also you may use `#!/bin/sh -efu` as shebang and fix other problems.
> >
> > A shebang or a `set -efu`?
> 
> Shebang. The difference is that with shebang you don't need to edit
> the script each time you want to change that.
> sh -x /path/to/the/script will give different results.
> 

OK, didn't consider that.
Have got the scripts running with the -efu flags set - that was entertaining.

> > I don't see shebang options used anywhere in the selftest scripts, but I
> > agree with a set.
> 
> Because shell scripts in the kernel are really badly written (so does
> Python ones).
> Again, even senior developers can't get shell right (including me).
> 
> > Either way I am unsure what the shebang should be.
> > The majority of the selftest scripts use bash as the shebang, with the
> > remainder using plain sh.
> > These scripts do use some bash extensions, and it was originally bash, so
> > I left it as that.
> > My test setups mainly use busybox, and don't have bash, so they complain
> > about the bash shebang - though the ash(??) busybox is using still runs
> > the script fine.
> 
> I'm using busybox on an everyday basis and mentioned shebang works
> there if I'm not mistaken.
> Because all flags are listed in the standard.
> https://pubs.opengroup.org/onlinepubs/007904875/utilities/sh.html
> 

I meant the actual /bin/bash, not the flags.
Though I now build bash in my buildroots, so I don't get that warning
anymore.

Cheers,
Kent.
