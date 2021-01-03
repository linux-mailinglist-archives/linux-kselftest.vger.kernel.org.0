Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21742E8CC2
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Jan 2021 16:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbhACPLI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Jan 2021 10:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbhACPLH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Jan 2021 10:11:07 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAB2C0613D3;
        Sun,  3 Jan 2021 07:10:27 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g3so13073917plp.2;
        Sun, 03 Jan 2021 07:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/hDJ6nVM+7UzPC808WfJ3MnlE/12HzLh4p00BC3vEk=;
        b=RFsVnd7sXoYfWdzPGejWjOF0J809wJQTaS0TiXYmTI+MAMcFQv+rV8769H5Gj20yfi
         2yjkVRsGMeTIOg0DB/+8jKr9EjbpsajsCXvf9PHFt//OgCPM79+48LxQrZqE4hz2Iruu
         5mifkkL3sIvrDVMZspMk5Zs8t3touy57BtLJgWDzOPbE0XWuwgxNaoGNMY0uq+cViYzL
         HGmJlzVJcIrUMEOnp3tDOvG45chd8K7OkD0FVINTqdwCxisL7C64TdOXeN7T+RlazMdq
         ZIXncnsDDm4rHs/BsCV4iflslkimJLp+eZVR3KBWgDfPTCoJbIIVFnMbZAQ8MixgjoP1
         JEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/hDJ6nVM+7UzPC808WfJ3MnlE/12HzLh4p00BC3vEk=;
        b=OifI03JCeWkQB/6G5x/HH/QBbBsOenafubiiNmNDemqW2eiqJy9GKTDUl/NinKXiuk
         cTvwbT5GJFTtG41n4i8Yh87tNtsZ5g4VpkMobuaFk1a2OFuXtzA/9LLAzp5+SRFuDJ4s
         jZOgLWJZ44c9AGQyoJaQW4h3X/mfPxdvkVZNWJ3A+CrE/+JmJqY9V+9YsS96HyB2eB/M
         u1YdeEnuBfq8dK5XiSdlBRt+ClM6t4gV8VHImYfDUnl//2Ymr03ip41HDQSMp4qs1acl
         kDdfAsHHntMxrF7gi2JqiiyMR+ZoHDmOp516TakuZxyBeSTHQJ4oIl9/xsQnjyxqDLHx
         lb7A==
X-Gm-Message-State: AOAM532KyEU+gc8FquiFsG5Ce/UG2x/6pgRo60RJHh2q9E4ZaSw33Zid
        5sUHnlxMlTSXN1e8TLAvcs9ycR0dK6Xh9DSEITgDioEoLxDc0S/H
X-Google-Smtp-Source: ABdhPJwzmRYfgxGWTQVdJRv4F1eTZZjRAEcNsniv9bvSpkEgWc7sXLE91cpD2Mgs+i8K47srpqaSKVG7GNKuIV3m09s=
X-Received: by 2002:a17:90a:1050:: with SMTP id y16mr26299767pjd.181.1609686627086;
 Sun, 03 Jan 2021 07:10:27 -0800 (PST)
MIME-Version: 1.0
References: <20210102022949.92304-1-warthog618@gmail.com> <20210102022949.92304-2-warthog618@gmail.com>
 <CAHp75VdMs1mP7pK46qKqJbjfyrcKhSGvtyzQpTRsehMz6o=Jpg@mail.gmail.com> <20210103021725.GA6622@sol>
In-Reply-To: <20210103021725.GA6622@sol>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Jan 2021 17:10:10 +0200
Message-ID: <CAHp75VfONKY7VS0q=GkSX14i--g0=jfBg4RFBoMk4DxJPMHJFg@mail.gmail.com>
Subject: Re: [PATCH 1/7] selftests: gpio: rework and simplify test implementation
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jan 3, 2021 at 4:17 AM Kent Gibson <warthog618@gmail.com> wrote:
> On Sun, Jan 03, 2021 at 12:20:26AM +0200, Andy Shevchenko wrote:
> > On Sat, Jan 2, 2021 at 4:32 AM Kent Gibson <warthog618@gmail.com> wrote:

...

> > > +#include <linux/gpio.h>
> >
> > Perhaps include it after system headers?
>
> hehe, I blindly sorted them.
> Should it matter?

I would include more particular headers later.
Btw system headers can not always be in order because of dependencies.

...

> > > +       local platform=`cat $SYSFS/kernel/debug/gpio | grep "$chip:" | tr -d ',' | awk '{print $5}'`
> >
> > Besides useless use of cat (and tr + awk can be simplified) why are
>
> What do you suggest for the tr/awk simplification?

You have `awk`, you can easily switch the entire pipeline to a little
awk scriptlet.

> > you simply not using
> > /sys/bus/gpio/devices/$chip ?
>
> Cos that shows all the gpiochips, not just the ones created by gpio-mockup.

I didn't get this. What is the content of $chip in your case?

> And I certainly don't want to go messing with real hardware.
> The default tests should still run on real hardware - but only
> accessing the mockup devices.
>
> Got a better way to filter out real hardware?

I probably have to understand what is the input and what is the
expected output. It's possible I missed something here.

> > > +       # e.g. /sys/class/gpio/gpiochip508/device/gpiochip0/dev
> > > +       local syschip=`ls -d $GPIO_SYSFS/gpiochip*/device/$chip/dev`
> >
> > ls -d is fragile, better to use `find ...`
>
> OK
>
> > > +       syschip=${syschip#$GPIO_SYSFS}
> > > +       syschip=${syschip%/device/$chip/dev}
> >
> > How does this handle more than one gpiochip listed?
>
> It is filtered by $chip so there can only be one.
> Or is that a false assumption?

When you have glob() in use it may return any number of results
(starting from 0) and your script should be prepared for that.

> > Also, can you consider optimizing these to get whatever you want easily?
>
> Sadly that IS my optimized way - I don't know of an easier way to find
> the sysfs GPIO number given the gpiochip and offset :-(.
> Happy to learn of any alternative.

I'm talking about getting $syschip. I think there is a way to get it
without all those shell substitutions from somewhere else.

> > > +       sysfs_nr=`cat $SYSFS/devices/$platform/gpio/$syschip/base`
> >
> > (It's probably fine here, but this doesn't work against PCI bus, for
> > example, see above for the fix)
>
> Not sure what you mean here.

When GPIO is a PCI device the above won't give a proper path.
If we wish to give an example to somebody, it would be better to have
it good enough.

> > > +       sysfs_nr=$(($sysfs_nr + $offset))
> > > +       sysfs_ldir=$GPIO_SYSFS/gpio$sysfs_nr
> > >  }

...

> > > +set_line()
> > >  {
> > > +       if [ -z "$sysfs_nr" ]; then
> > > +               find_sysfs_nr
> > > +               echo $sysfs_nr > $GPIO_SYSFS/export
> > >         fi
> >
> > It sounds like a separate function (you have release_line(), perhaps
> > acquire_line() is good to have).
> >
>
> The cdev implementation has to release and re-acquire in the background
> as there is no simple way to perform a set_config on a requested line
> from shell - just holding the requested line for a set is painful enough,
> and the goal here was to keep the tests simple.
>
> I didn't want to make line acquisition/release explicit in the gpio-mockup
> tests, as that would make them needlessly complicated, so the acquire is
> bundled into the set_line - and anywhere else the uAPI implementation
> needs it.  There is an implicit assumption that a set_line will always
> be called before a get_line, but that is always true - there is no
> "as-is" being tested here.
>
> Of course you still need the release_line at the end of the test, so
> that is still there.

Yes and to me logically correct to distinguish acquire_line() with set_line().
Then wherever you need to set_line(), you may call acquire_line()
which should be idempotent (the same way as release_line() call).

> > > +release_line()
> > >  {
> > > +       [ -z "$sysfs_nr" ] && return
> > > +       echo $sysfs_nr > $GPIO_SYSFS/unexport
> > > +       sysfs_nr=
> > > +       sysfs_ldir=
> > >  }

...

> > > +skip()
> > >  {
> >
> > > +       echo $* >&2
> >
> > In all cases better to use "$*" (note surrounding double quotes).
> >
>
> Agreed - except where
>
>         for option in $*; do
>
> is used to parse parameters.

Exactly! And "" helps with that.

If I put parameters as `a b c "d e"`, your case will take them wrongly.

> > > +       echo GPIO $module test SKIP
> > > +       exit $ksft_skip
> > >  }
> >
> > ...
> >
> > > +        [ ! which modprobe > /dev/null 2>&1 ] && skip "need modprobe installed"
> >
> > AFAIR `which` can be optional on some systems.
> >
>
> That is how other selftests check for availability of modprobe.
> e.g. selftests/kmod/kmod.sh and selftests/vm/test_hmm.sh, so I assumed
> it was acceptable.
>
> Is there an alternative?

OK. Just replace it with a dropped useless test call.
which ... || skip ...

...

> > P.S. Also you may use `#!/bin/sh -efu` as shebang and fix other problems.
>
> A shebang or a `set -efu`?

Shebang. The difference is that with shebang you don't need to edit
the script each time you want to change that.
sh -x /path/to/the/script will give different results.

> I don't see shebang options used anywhere in the selftest scripts, but I
> agree with a set.

Because shell scripts in the kernel are really badly written (so does
Python ones).
Again, even senior developers can't get shell right (including me).

> Either way I am unsure what the shebang should be.
> The majority of the selftest scripts use bash as the shebang, with the
> remainder using plain sh.
> These scripts do use some bash extensions, and it was originally bash, so
> I left it as that.
> My test setups mainly use busybox, and don't have bash, so they complain
> about the bash shebang - though the ash(??) busybox is using still runs
> the script fine.

I'm using busybox on an everyday basis and mentioned shebang works
there if I'm not mistaken.
Because all flags are listed in the standard.
https://pubs.opengroup.org/onlinepubs/007904875/utilities/sh.html

> Thanks again for the review - always a learning experience.

-- 
With Best Regards,
Andy Shevchenko
