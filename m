Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562A7465028
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 15:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350109AbhLAOnz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 09:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350483AbhLAOll (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 09:41:41 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6D6C061A2E
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Dec 2021 06:36:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g14so102620572edb.8
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Dec 2021 06:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ChSebfqCj5wevOY8wZg+W9iuB4H9eQB3dOPbSDOcmPA=;
        b=EanfV/bSpiu1gCOTcYKKTYSiCLzgoyOskJdrxQJqP9sheWREwa1fxafaUhFV+ww+Xz
         TQ3g16zyAWG2ADnSpwVqyLuc/X9eXn8dus4RgPRsnTnezVD+1rU06eRH8CqTTjycpU6d
         qdGFxlb++klnpgAQ2+EA3cM+W0ahw3elD13wd+LaHPnmF39+nsmaFzAlN2McrOvxFMK6
         uUNkA6OQYAkDZSr0o0iBeSgpgktwep30ayJCf5L94OFMW5b7ZNNPcl1FgduvRDHe9KIq
         R98BUUDubR+rQMuWr037huoees5fKNvXZQZLe2ovprtCJUOYwI9OORbgrU74R6LFX9fO
         iTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ChSebfqCj5wevOY8wZg+W9iuB4H9eQB3dOPbSDOcmPA=;
        b=kVbCTvCfJB3HFiFfjOSz+l5nJgP7BF8p54BUuZOtD9MVML6IUwApDoz/N9c2zxhPOQ
         JPL0YsBC1l3zBOXrKbca5eJ18+W9nU/qnB5KK1xMQCzT/JxU0QHFaeILdTUkWOTwjgM7
         n8Nj4qXPHfr5IV0B4Ux4Bh2DDLoLIbXrvLfsc3n/KNEwSpJdCY4zcc4PeGn205GNlYBz
         CU66Z3tDsfJZI6cLbq/k9FNt8q+bVRLgmtpdHPrysCqti/uQ9KZ8ixJRMrarGZ8oNOih
         cD8eg/wNzZEjsXQCzwFc8o/4W/w1CJPJOT3FEJ2bwokkL+SX1BjCcEoo4lTAqzIDJFnB
         wElg==
X-Gm-Message-State: AOAM531tSR54rPcUaGyqAddB/JNiRQ/CN2cYL1ERdX4XflPAlXM2DgDH
        fV8Uf+Oi9mhX/4Z10JHg7kQwXuN6PNHQre5no+386g==
X-Google-Smtp-Source: ABdhPJwJmjDcpB9YHDENf4MntkqZ++v6jJAxzsj6jdE8tXSrKbb9kv8Ct01EthGBUvv8+gntL+vjD5cn4cuDLYUbki8=
X-Received: by 2002:a05:6402:354e:: with SMTP id f14mr8934573edd.245.1638369399803;
 Wed, 01 Dec 2021 06:36:39 -0800 (PST)
MIME-Version: 1.0
References: <20211130154127.12272-1-brgl@bgdev.pl> <20211130154127.12272-3-brgl@bgdev.pl>
 <YaZNyMV5gX5cZpar@smile.fi.intel.com> <CAMRc=Mf5d1i34eBez+pOYjjdyfRL9N_ha_==Cn1rANr=2CB9aQ@mail.gmail.com>
 <YaaQp2rq7N71dm1l@smile.fi.intel.com> <CAMRc=Me=Oq_V=+p-AFPcyDjBs-+4Ug3k0AWK9fdEEet2JD3eFw@mail.gmail.com>
 <CAMRc=MdQ+a7UrE7csg3GsiLXYGkzti-wPUwPh5J=7WBj74OVZg@mail.gmail.com>
 <Yad7IQwXDc8gS2Ne@smile.fi.intel.com> <CAMRc=MeScPA=764xoi9Leu7LayEbhMCuA3u_g5NJjLyc8sJ-vg@mail.gmail.com>
 <YaeGg34Log9dExYX@smile.fi.intel.com> <YaeHtzyqe3XwgWw/@smile.fi.intel.com>
In-Reply-To: <YaeHtzyqe3XwgWw/@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 1 Dec 2021 15:36:29 +0100
Message-ID: <CAMRc=McuGvUUPt9VMARqdNttbXyau5ib-MgR_EYskxqJtUxcsQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/6] gpiolib: allow to specify the firmware node in
 struct gpio_chip
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 1, 2021 at 3:34 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Dec 01, 2021 at 04:28:19PM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 01, 2021 at 02:53:42PM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Dec 1, 2021 at 2:40 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Wed, Dec 01, 2021 at 02:11:28PM +0100, Bartosz Golaszewski wrote:
> > > > > On Tue, Nov 30, 2021 at 10:04 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > ...
> >
> > > > > Let me maybe rephrase the problem: currently, for GPIO devices
> > > > > instantiating multiple banks created outside of the OF or ACPI
> > > > > frameworks (e.g. instantiated manually and configured using a
> > > > > hierarchy of software nodes with a single parent swnode and a number
> > > > > of child swnodes representing the children), it is impossible to
> > > > > assign firmware nodes other than the one representing the top GPIO
> > > > > device to the gpiochip child devices.
> > > > >
> > > > > In fact if we want to drop the OF APIs entirely from gpiolib - this
> > > > > would be the right first step as for gpio-sim it actually replaces the
> > > > > gc->of_node = some_of_node; assignment that OF-based drivers do for
> > > > > sub-nodes defining banks and it does work with device-tree (I verified
> > > > > that too) thanks to the fwnode abstraction layer.
> > > >
> > > > I still don't see how you set up hierarchy of primary/secondary fwnodes.
> > > >
> > > > And I don't like this change. It seems it band-aids some issue with fwnode
> > > > usage. What the easiest way to reproduce the issue with your series applied
> > > > (without this change)?
> > >
> > > Drop this patch and drop the line where the fwnode is assigned in
> > > gpio-sim.c. Then probe the device and print the addresses of the
> > > parent and child swnodes. See how they are the same and don't match
> > > the swnode hierarchy we created. You can then apply this patch and see
> > > how it becomes correct.
> >
> > Thanks. I will give a spin.
> >
> > Note, it seems I have to revert your older code first...
>
> Okay, I have to postpone because simple revert doesn't work for me.
> Can you clean up the next, please and I can use it starting from tomorrow?
>
>
> $ git tag --contains 5065e08e4ef3
> DONT-USE-next-20211105
> next-20211101
> next-20211102
> next-20211103
> next-20211104
> next-20211105
> next-20211106
> next-20211108
> next-20211109
> next-20211110
> next-20211111
> next-20211112
> next-20211115
> next-20211116
> next-20211117
> next-20211118
> next-20211123
> next-20211124
> next-20211125
> next-20211126
> next-20211129
> next-20211130
> next-20211201
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

None of this is in next, please use:
https://github.com/brgl/linux/tree/topic/gpio-sim-v12 if you want a
branch.

I just thought you were going to simply apply these patches.

Bart
