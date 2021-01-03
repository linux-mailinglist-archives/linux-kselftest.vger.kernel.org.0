Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5672E8A01
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Jan 2021 03:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbhACCSO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jan 2021 21:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbhACCSN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jan 2021 21:18:13 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A993C061573;
        Sat,  2 Jan 2021 18:17:33 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z12so7778370pjn.1;
        Sat, 02 Jan 2021 18:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lDlbZEoJDK5UwVeuX4/+2MiHOoyLTpzb5+AaeM3gP94=;
        b=LOZ2SfAMcDCA1TXAv/l9pht1zk2qFw8pXqH+H1SsDSD8xwkySgES8CvYaADyLxYZBY
         TEIws4xfVuqZa/gMGtY7wk04UhuGa/7ocZpX4qumKk5tZvAxP3BBMkGynvlVvzEuQboX
         q95X0lhN96X2ppugWOAxv9BAzokcQGXJ2GOociDlABJDAPzV2DRkte00j0EUv2L+TxMb
         /X31rnXHx/MgLcyugWXM61CwRHLhnlFzGlUU8Nq6TtjLNIiTwuNmnmSzobnzP0Ddhjpf
         S0SYKZE8X2si0sJA6Ldf/bSLVXG4qxLmRSjFYI6/zxfdIR/JRKMIhrVCi+qp6BzYhPIS
         /mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lDlbZEoJDK5UwVeuX4/+2MiHOoyLTpzb5+AaeM3gP94=;
        b=R0hUbo4JEdBRdeIbsBzl4PGm27vX/T30ScD15qugcv/67gQXqZwHw54bz1h2rp/3E9
         4QnfCmaBbd+mxImuSRM/mmsEMnePyYTt3AuNsfZflz/zQkB3kKyCBHssuhfsJrDu6dyr
         YGoQ6+zyeDHAwUeHrV2abcw94QpKlziB9HBPMqRAe5hN6q749yGxU6UtsvmeW/hDCmwL
         Azg+Z8JFsmKroSlUNJUwbzXE+U7L1oVClBS81uOwBIlhn3uGqswEUHnomq3YsHLnIDDT
         1Bj981wa7WEANeXZRkHr1MzU3Wx1E0xfkBh7QPCX7ArXIbY2+EXkqvmg53r+1mC1e49B
         7SKw==
X-Gm-Message-State: AOAM5326ySuveJZAcQemaDAS+30RG9MwALRpk1APV4SPiXIL0De9Wi3D
        VphN7Ko/Z8r0uV/TydK/BJM=
X-Google-Smtp-Source: ABdhPJwM83TXV4dPCheshYNW4qWDtDdZsVcRlw9hubLZTkwH6Ok3vLB8Cpj9DDtQkaJ97zym04vd/Q==
X-Received: by 2002:a17:903:230d:b029:dc:8ac6:98aa with SMTP id d13-20020a170903230db02900dc8ac698aamr6616791plh.4.1609640252431;
        Sat, 02 Jan 2021 18:17:32 -0800 (PST)
Received: from sol (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id a2sm26174425pfg.203.2021.01.02.18.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 18:17:31 -0800 (PST)
Date:   Sun, 3 Jan 2021 10:17:25 +0800
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
Message-ID: <20210103021725.GA6622@sol>
References: <20210102022949.92304-1-warthog618@gmail.com>
 <20210102022949.92304-2-warthog618@gmail.com>
 <CAHp75VdMs1mP7pK46qKqJbjfyrcKhSGvtyzQpTRsehMz6o=Jpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdMs1mP7pK46qKqJbjfyrcKhSGvtyzQpTRsehMz6o=Jpg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jan 03, 2021 at 12:20:26AM +0200, Andy Shevchenko wrote:
> On Sat, Jan 2, 2021 at 4:32 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > The GPIO mockup selftests are overly complicated with separate
> > implementations of the tests for sysfs and cdev uAPI, and with the cdev
> > implementation being dependent on tools/gpio and libmount.
> >
> > Rework the test implementation to provide a common test suite with a
> > simplified pluggable uAPI interface.  The cdev implementation utilises
> > the GPIO uAPI directly to remove the dependence on tools/gpio.
> > The simplified uAPI interface removes the need for any file system mount
> > checks in C, and so removes the dependence on libmount.
> >
> > The rework also fixes the sysfs test implementation which has been broken
> > since the device created in the multiple gpiochip case was split into
> > separate devices.
> 
> Okay, I commented something, not sure if everything is correct, needs
> double checking.
> Shell is quite a hard programming language. Everyday I found something
> new about it.
> 

You are telling me - there are about six million ways to do even the
most trivial tasks.  Makes you appreciate more constrained languages.

> ...
> 
> > +#include <linux/gpio.h>
> 
> Perhaps include it after system headers?
> 

hehe, I blindly sorted them.
Should it matter?

> > +#include <signal.h>
> > +#include <stdint.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/ioctl.h>
> > +#include <unistd.h>
> 
> ...
> 
> > +SYSFS=`mount -t sysfs | head -1 | awk '{ print $3 }'`
> 
> Oh, would below be better?
>   grep -w sysfs /proc/mounts | cut -f2 -d' '
> 

That looks good - the other is a carry over from the old gpio-mockup.sh.

> ...
> 
> > +[ ! -d "$SYSFS" ] && skip "sysfs is not mounted"
> 
> [ -d ... ] || skip "..."
> 

Yeah, those were if [ .. ]; then fi originally. I did the first step
of simplification and missed the second :-(.

> ...
> 
> > +[ ! -d "$GPIO_SYSFS" ] && skip "CONFIG_GPIO_SYSFS is not selected"
> 
> Ditto.
> 
> ...
> 
> > +       local platform=`cat $SYSFS/kernel/debug/gpio | grep "$chip:" | tr -d ',' | awk '{print $5}'`
> 
> Besides useless use of cat (and tr + awk can be simplified) why are

What do you suggest for the tr/awk simplification?

> you simply not using
> /sys/bus/gpio/devices/$chip ?
> 

Cos that shows all the gpiochips, not just the ones created by gpio-mockup.
And I certainly don't want to go messing with real hardware.
The default tests should still run on real hardware - but only
accessing the mockup devices.

Got a better way to filter out real hardware?

> > +       # e.g. /sys/class/gpio/gpiochip508/device/gpiochip0/dev
> > +       local syschip=`ls -d $GPIO_SYSFS/gpiochip*/device/$chip/dev`
> 
> ls -d is fragile, better to use `find ...`
> 

OK 

> > +       syschip=${syschip#$GPIO_SYSFS}
> > +       syschip=${syschip%/device/$chip/dev}
> 
> How does this handle more than one gpiochip listed?

It is filtered by $chip so there can only be one.
Or is that a false assumption?

> Also, can you consider optimizing these to get whatever you want easily?
> 

Sadly that IS my optimized way - I don't know of an easier way to find
the sysfs GPIO number given the gpiochip and offset :-(.
Happy to learn of any alternative.

> > +       sysfs_nr=`cat $SYSFS/devices/$platform/gpio/$syschip/base`
> 
> (It's probably fine here, but this doesn't work against PCI bus, for
> example, see above for the fix)
> 

Not sure what you mean here.

> > +       sysfs_nr=$(($sysfs_nr + $offset))
> > +       sysfs_ldir=$GPIO_SYSFS/gpio$sysfs_nr
> >  }
> 
> ...
> 
> > +set_line()
> >  {
> > +       if [ -z "$sysfs_nr" ]; then
> > +               find_sysfs_nr
> > +               echo $sysfs_nr > $GPIO_SYSFS/export
> >         fi
> 
> It sounds like a separate function (you have release_line(), perhaps
> acquire_line() is good to have).
> 

The cdev implementation has to release and re-acquire in the background
as there is no simple way to perform a set_config on a requested line
from shell - just holding the requested line for a set is painful enough,
and the goal here was to keep the tests simple.

I didn't want to make line acquisition/release explicit in the gpio-mockup
tests, as that would make them needlessly complicated, so the acquire is
bundled into the set_line - and anywhere else the uAPI implementation
needs it.  There is an implicit assumption that a set_line will always
be called before a get_line, but that is always true - there is no
"as-is" being tested here.

Of course you still need the release_line at the end of the test, so
that is still there.

> > +release_line()
> >  {
> > +       [ -z "$sysfs_nr" ] && return
> > +       echo $sysfs_nr > $GPIO_SYSFS/unexport
> > +       sysfs_nr=
> > +       sysfs_ldir=
> >  }
> 
> ...
> 
> > +BASE=`dirname $0`
> 
> Can be used via shell substitutions.
> 

Yup

> ...
> 
> > +skip()
> >  {
> 
> > +       echo $* >&2
> 
> In all cases better to use "$*" (note surrounding double quotes).
> 

Agreed - except where

	for option in $*; do

is used to parse parameters.

> > +       echo GPIO $module test SKIP
> > +       exit $ksft_skip
> >  }
> 
> ...
> 
> > +        [ ! which modprobe > /dev/null 2>&1 ] && skip "need modprobe installed"
> 
> AFAIR `which` can be optional on some systems.
> 

That is how other selftests check for availability of modprobe.
e.g. selftests/kmod/kmod.sh and selftests/vm/test_hmm.sh, so I assumed
it was acceptable.

Is there an alternative?

> ...
> 
> > +       DEBUGFS=`mount -t debugfs | head -1 | awk '{ print $3 }'`
> > +       [ ! -d "$DEBUGFS" ] && skip "debugfs is not mounted"
> 
> Same as per sysfs in another script.
> 
> ...
> 
> > +try_insert_module()
> > +{
> > +       modprobe -q $module $1
> > +       err=$?
> > +       [ $err -ne 0 ] && fail "insert $module failed with error $err"
> 
> I guess it's as simple as `modprobe ... || fail "... $?"
> 

Yup

> > +}
> 
> ...
> 
> > +       [ ! -e "$mock_line" ] && fail "missing line $chip:$offset"
> 
> [ -e ... ] || ...
> 
> ...
> 
> > +       local ranges=$1
> > +       local gc=
> > +       shift
> 
> I found that combination
>        local ranges=$1; shift
> is better to read.
> 

Agreed - the gc certainly shouldn't be splitting the two.

> ...
> 
> > +       gpiochip=`ls -d $DEBUGFS/$module/gpiochip* 2>/dev/null`
> 
> `find ...` is a better choice.
> 
> > +       for chip in $gpiochip; do
> > +               gc=`basename $chip`
> > +               [ -z "$1" ] && fail "unexpected chip - $gc"
> > +               test_line $gc 0
> 
> > +               if [ "$random" ] && [ $1 -gt 2 ]; then
> 
> You call the test twice, while you may do it in one go.
> 

Ahh, replacing the && with -a. Good to know.

> > +                       test_line $gc $((( RANDOM % ($1 - 2) + 1)))
> > +               fi
> > +               test_line $gc $(($1 - 1))
> > +               test_no_line $gc $1
> >                 shift
> > +       done
> > +       [ "$1" ] && fail "missing expected chip of width $1"
> 
> ...
> 
> > +# manual gpio allocation tests fail if a physical chip already exists
> > +[ "$full_test" ] && [ -e "/dev/gpiochip0" ] && skip "full tests conflict with gpiochip0"
> 
> I guess it should be rather something like
> 
> [ "$full_test" = "true" -a -e "/dev/gpiochip0" ]
> 

I'm going with empty for false, so you can drop the = "true" here.

> P.S. Also you may use `#!/bin/sh -efu` as shebang and fix other problems.
> 

A shebang or a `set -efu`?
I don't see shebang options used anywhere in the selftest scripts, but I
agree with a set.

Either way I am unsure what the shebang should be.
The majority of the selftest scripts use bash as the shebang, with the
remainder using plain sh.
These scripts do use some bash extensions, and it was originally bash, so
I left it as that.
My test setups mainly use busybox, and don't have bash, so they complain
about the bash shebang - though the ash(??) busybox is using still runs
the script fine.

Thanks again for the review - always a learning experience.

Cheers,
Kent.
