Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B780B2E88F4
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jan 2021 23:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbhABWVY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jan 2021 17:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbhABWVX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jan 2021 17:21:23 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3078FC061573;
        Sat,  2 Jan 2021 14:20:43 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w6so14080691pfu.1;
        Sat, 02 Jan 2021 14:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvj3QNWHvPAoiZHUm6pmC1Sy91xyP79X8SDuYQJzgjs=;
        b=SbRW4nQJDrxVtZcl9m4Q4u/0cnkmNuCQWvVhaNEW0BqwmuFS8rFuAzyU7SLVX8qwuo
         s082AgB0zJXDbmwbYNHlLdWU3Hri58F5AZix2XsJCBhaAb55XGlDYPYQFuND/X1v1TFJ
         6tl195/4os951gX3hebYjvF7bgmk7xaL1S5g21+SrFY51DM00cN4KnR8vNR14wiVtUNB
         RDHhxTBQAyV8VibMqhE/l922uPlMXSavFkSwPSHDRdv2aENNGWG75xLwrhhQZa27qQP7
         JEiWGc1hTUkjOLnRNPmgWs9/bNhKMwCtGdsQXgtaY5TvFT6+s8sSzkKd+1CNFGFnc+hA
         z1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvj3QNWHvPAoiZHUm6pmC1Sy91xyP79X8SDuYQJzgjs=;
        b=cVOcHRohzqI0xAX3bX5Lk9XDnX+j/NcXCh2wnmwhCRC5bVDvDVEtTnpVzquZgTt69j
         s59yTE9yPZiZjzKc8E6dYUS+PYSiqpXFZOYFhtxMmfc1cLCImOCgNTVNWV/v7//TIvs2
         jVbsftVbcZSlABtHT1yWjXDOek/0F7MhtDNK5mLAOSSp+3o7oJNK0177XfbyAsA+SPz6
         kHKM0uuKW6pDyP0GnNom9RCPnVb2LLaFiO2xMmQkrc+am1NhZne443aBsRtycLyoYmyO
         UzeK+ukd5tOxmJhZxI5+tFY58fNWaCWsQuZafJxG7AvPVODIZD4RbT2UAMTohaAE4Fyn
         Pvvw==
X-Gm-Message-State: AOAM531ys0630dptWIZVDp1rvWRmDC/5vuv+RtW7mV6qlWy6yKbgbSam
        8ag2QAOpnvANVS6vrXU9j68YOmtR0brb2ykNnH8=
X-Google-Smtp-Source: ABdhPJxRqyW/F6qI9+WasE44zZR90C2fNeYtoTeV9v8EdiZBjT3kVXZQaxzHkhZvkD44Q9+lRR16QFHAsd/XD9WHLkI=
X-Received: by 2002:a05:6a00:170a:b029:19d:afca:4704 with SMTP id
 h10-20020a056a00170ab029019dafca4704mr39254027pfc.7.1609626042415; Sat, 02
 Jan 2021 14:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20210102022949.92304-1-warthog618@gmail.com> <20210102022949.92304-2-warthog618@gmail.com>
In-Reply-To: <20210102022949.92304-2-warthog618@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Jan 2021 00:20:26 +0200
Message-ID: <CAHp75VdMs1mP7pK46qKqJbjfyrcKhSGvtyzQpTRsehMz6o=Jpg@mail.gmail.com>
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

On Sat, Jan 2, 2021 at 4:32 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> The GPIO mockup selftests are overly complicated with separate
> implementations of the tests for sysfs and cdev uAPI, and with the cdev
> implementation being dependent on tools/gpio and libmount.
>
> Rework the test implementation to provide a common test suite with a
> simplified pluggable uAPI interface.  The cdev implementation utilises
> the GPIO uAPI directly to remove the dependence on tools/gpio.
> The simplified uAPI interface removes the need for any file system mount
> checks in C, and so removes the dependence on libmount.
>
> The rework also fixes the sysfs test implementation which has been broken
> since the device created in the multiple gpiochip case was split into
> separate devices.

Okay, I commented something, not sure if everything is correct, needs
double checking.
Shell is quite a hard programming language. Everyday I found something
new about it.

...

> +#include <linux/gpio.h>

Perhaps include it after system headers?

> +#include <signal.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <unistd.h>

...

> +SYSFS=`mount -t sysfs | head -1 | awk '{ print $3 }'`

Oh, would below be better?
  grep -w sysfs /proc/mounts | cut -f2 -d' '

...

> +[ ! -d "$SYSFS" ] && skip "sysfs is not mounted"

[ -d ... ] || skip "..."

...

> +[ ! -d "$GPIO_SYSFS" ] && skip "CONFIG_GPIO_SYSFS is not selected"

Ditto.

...

> +       local platform=`cat $SYSFS/kernel/debug/gpio | grep "$chip:" | tr -d ',' | awk '{print $5}'`

Besides useless use of cat (and tr + awk can be simplified) why are
you simply not using
/sys/bus/gpio/devices/$chip ?

> +       # e.g. /sys/class/gpio/gpiochip508/device/gpiochip0/dev
> +       local syschip=`ls -d $GPIO_SYSFS/gpiochip*/device/$chip/dev`

ls -d is fragile, better to use `find ...`

> +       syschip=${syschip#$GPIO_SYSFS}
> +       syschip=${syschip%/device/$chip/dev}

How does this handle more than one gpiochip listed?
Also, can you consider optimizing these to get whatever you want easily?

> +       sysfs_nr=`cat $SYSFS/devices/$platform/gpio/$syschip/base`

(It's probably fine here, but this doesn't work against PCI bus, for
example, see above for the fix)

> +       sysfs_nr=$(($sysfs_nr + $offset))
> +       sysfs_ldir=$GPIO_SYSFS/gpio$sysfs_nr
>  }

...

> +set_line()
>  {
> +       if [ -z "$sysfs_nr" ]; then
> +               find_sysfs_nr
> +               echo $sysfs_nr > $GPIO_SYSFS/export
>         fi

It sounds like a separate function (you have release_line(), perhaps
acquire_line() is good to have).

> +release_line()
>  {
> +       [ -z "$sysfs_nr" ] && return
> +       echo $sysfs_nr > $GPIO_SYSFS/unexport
> +       sysfs_nr=
> +       sysfs_ldir=
>  }

...

> +BASE=`dirname $0`

Can be used via shell substitutions.

...

> +skip()
>  {

> +       echo $* >&2

In all cases better to use "$*" (note surrounding double quotes).

> +       echo GPIO $module test SKIP
> +       exit $ksft_skip
>  }

...

> +        [ ! which modprobe > /dev/null 2>&1 ] && skip "need modprobe installed"

AFAIR `which` can be optional on some systems.

...

> +       DEBUGFS=`mount -t debugfs | head -1 | awk '{ print $3 }'`
> +       [ ! -d "$DEBUGFS" ] && skip "debugfs is not mounted"

Same as per sysfs in another script.

...

> +try_insert_module()
> +{
> +       modprobe -q $module $1
> +       err=$?
> +       [ $err -ne 0 ] && fail "insert $module failed with error $err"

I guess it's as simple as `modprobe ... || fail "... $?"

> +}

...

> +       [ ! -e "$mock_line" ] && fail "missing line $chip:$offset"

[ -e ... ] || ...

...

> +       local ranges=$1
> +       local gc=
> +       shift

I found that combination
       local ranges=$1; shift
is better to read.

...

> +       gpiochip=`ls -d $DEBUGFS/$module/gpiochip* 2>/dev/null`

`find ...` is a better choice.

> +       for chip in $gpiochip; do
> +               gc=`basename $chip`
> +               [ -z "$1" ] && fail "unexpected chip - $gc"
> +               test_line $gc 0

> +               if [ "$random" ] && [ $1 -gt 2 ]; then

You call the test twice, while you may do it in one go.

> +                       test_line $gc $((( RANDOM % ($1 - 2) + 1)))
> +               fi
> +               test_line $gc $(($1 - 1))
> +               test_no_line $gc $1
>                 shift
> +       done
> +       [ "$1" ] && fail "missing expected chip of width $1"

...

> +# manual gpio allocation tests fail if a physical chip already exists
> +[ "$full_test" ] && [ -e "/dev/gpiochip0" ] && skip "full tests conflict with gpiochip0"

I guess it should be rather something like

[ "$full_test" = "true" -a -e "/dev/gpiochip0" ]

P.S. Also you may use `#!/bin/sh -efu` as shebang and fix other problems.

--
With Best Regards,
Andy Shevchenko
