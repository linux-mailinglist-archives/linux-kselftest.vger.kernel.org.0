Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41653583FB
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Apr 2021 14:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhDHM7i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Apr 2021 08:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhDHM7f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Apr 2021 08:59:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66570C061763
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Apr 2021 05:59:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l4so2857610ejc.10
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Apr 2021 05:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bXaNApsUJBQRijtom4CaAhgB0kqvpHWQ8lB5126OVbU=;
        b=GqDXqGZU3WOMP1JWd2baxuE3IyzrOvNzhGrIswRLTHGuF9mrtmJwVpIrBpcgr7FlcN
         WEcSKNIIFX/CsruJLWPGL2QL7ImMGOnkcsp4u/azNm0XV4gUEXVOaiUWAJdALRQxfC/e
         EBl1xxE1z3cTgnbymFn8WDpltPG/z1561B8cpvBdOK2NrfwBWW86pRBXFqXGMUUZEfsF
         8NCZsV7VxOUJR/cqDBjxlkxe+o5yjfu0cflXxhoV5dOUDikes/YYz9H0NNJf5yThfhQx
         9EbztooxPKJYpQmslI9JtPWXV8AMOJpwrD+Aq24gNXE2nQsLfZ2Eoaj5iHTaz1dnA8kC
         XhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXaNApsUJBQRijtom4CaAhgB0kqvpHWQ8lB5126OVbU=;
        b=S0kjfXNxMWetRXIwh9D/g0Fh9EPOP7sSbzOSSV6MrV5V911XP2A/q/ztJ0BmqS7m/E
         JwgELSUU/GFsB7mr7TZj/U+mg+2S/lnaCSyTgxo1o4UTM1bjT1Zbn6eAtAPy8z0qRepu
         hsMtwbQnYzUHp7FWwOedLX36bcNo1Fd4P3v4Ax+Dbvh6+vCW40a0VT78tmDkdFztaCdJ
         adHdok+HuHhpJ6ZVSD/tNcfd6TSI94ldnaLq1farxKclwmev8O479ur9+4H0c3TORRXz
         p1BW9dBZSPCULqUwsY+pKeT0uRBQ6gFTiMbAqGRm+UaZzeIz2JlEsLLVMa9e/Zqsw/5b
         2fXg==
X-Gm-Message-State: AOAM531rrEUwcax40aV7SP0WC8oR4L5MnUnj8ejqnLY9Oe7VL2lMHBVT
        FTlCr2fGtn/Axqd+Y9WzHaOzXMCK/knRGTM0B8XfuA==
X-Google-Smtp-Source: ABdhPJzT52+7fhpzyGdEPpFOaQHm0H5K5N9slJdZWOCE0StJyTV8DY7tAOulhTQU/LlU+EEkYf+hetlLkRsAW1D8TBw=
X-Received: by 2002:a17:907:7785:: with SMTP id ky5mr10011936ejc.133.1617886762806;
 Thu, 08 Apr 2021 05:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsiRYaE+y44ApDkvPvbDCdiJ+nnCMhiiaPVsg6p8m4+1Q@mail.gmail.com>
 <CAHp75VdJ7kGXN6sk8HTeSfAKQtHDGSmtdVPn7CSkK5=yfDizuA@mail.gmail.com>
 <CA+G9fYuG12WaC6QAdx1k80v8-As7a7oVVkhaUDxqgV=BaunfxQ@mail.gmail.com> <CAHp75Vf1S5Ra4fdkV=faw4tCXbeNiifC3y8MF0_bCqHGfDBLsQ@mail.gmail.com>
In-Reply-To: <CAHp75Vf1S5Ra4fdkV=faw4tCXbeNiifC3y8MF0_bCqHGfDBLsQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 8 Apr 2021 18:29:11 +0530
Message-ID: <CA+G9fYuYC3QK2Zi8pbud0ebai4d4YgB0A4DXg5XWaE1pLWP5tw@mail.gmail.com>
Subject: Re: [next] [arm64] [gpio] BUG: key has not been registered! DEBUG_LOCKS_WARN_ON:
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Colin King <colin.king@canonical.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 8 Apr 2021 at 15:17, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Thu, Apr 8, 2021 at 11:33 AM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> > On Thu, 8 Apr 2021 at 04:21, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Apr 8, 2021 at 12:38 AM Naresh Kamboju
> > > <naresh.kamboju@linaro.org> wrote:
> > > >
> > > > While running kselftest recently added gpio gpio-sim.sh test case the following
> > > > warning was triggered on Linux next tag 20210330 tag running on arm64 juno
> > > > and hikey devices.
> > > >
> > > > GOOD: next-20210326
> > > > BAD: next-20210330
> > > >
> > > > This is still happening today on Linux next tag 20210407.
> > >
> > > Can you add the following
> > >
> > >   sysfs_attr_init(attrs[i]);
> > >
> > > to the end of the loop in gpio_sim_setup_sysfs()?
> >
> > Do you mean like this,
> >
> > diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> > index ea17289a869c..5fe67ccf45f7 100644
> > --- a/drivers/gpio/gpio-sim.c
> > +++ b/drivers/gpio/gpio-sim.c
> > @@ -296,6 +296,7 @@ static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
> >                 dev_attr->store = gpio_sim_sysfs_line_store;
> >
> >                 attrs[i] = &dev_attr->attr;
> > +               sysfs_attr_init(attrs[i]);
> >         }
> >
> >         chip->attr_group.name = "line-ctrl";
>
> Precisely.

As per your suggestions the above line added and build tested
the reported issue is fixed now.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

>
> > > If it fixes an issue I'll send a formal patch.
> >
> > I will build and test this and report here.

OTOH,
LKFT builds kernel and rootfs on host and runs tests on various target
devices. While doing this process "make install" is not installing required
test files like gpio-mockup-cdev and gpio-line-name.

# ./gpio-mockup.sh: line 106: ./gpio-mockup-cdev: No such file or directory
# ./gpio-sim.sh: line 100: ./gpio-line-name: No such file or directory

Test run log:
------------------
# selftests: gpio: gpio-mockup.sh
# 1.  Module load tests
# 1.1.  dynamic allocation of gpio
# ./gpio-mockup.sh: line 106: ./gpio-mockup-cdev: No such file or directory
# test failed: line value is 127 when 1 was expected
# GPIO gpio-mockup test FAIL
not ok 1 selftests: gpio: gpio-mockup.sh # exit=1
# selftests: gpio: gpio-sim.sh
# 1. chip_name and dev_name attributes
# 1.1. Chip name is communicated to user
# 1.2. chip_name returns 'none' if the chip is still pending
# 1.3. Device name is communicated to user
# 1.4. dev_name returns 'none' if chip is still pending
# 2. Creating simulated chips
# 2.1. Default number of lines is 1
# 2.2. Number of lines can be specified
# 2.3. Label can be set
# 2.4. Label can be left empty
# 2.5. Line names can be configured
# ./gpio-sim.sh: line 100: ./gpio-line-name: No such file or directory
# line name is incorrect
# GPIO gpio-sim test FAIL
not ok 2 selftests: gpio: gpio-sim.sh # exit=1

- Naresh
