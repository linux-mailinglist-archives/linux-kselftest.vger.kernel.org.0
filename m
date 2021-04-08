Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E356358873
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Apr 2021 17:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhDHPbE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Apr 2021 11:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhDHPa4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Apr 2021 11:30:56 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A645FC061760;
        Thu,  8 Apr 2021 08:30:43 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f29so1648385pgm.8;
        Thu, 08 Apr 2021 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oO/23sQ10zNdJXUePDBr15zWZE3PAPzpbovMLWW7jBo=;
        b=tjirxve3e4NPqRl/bXEIjEtydWWwLPJiYhUXPb8No26jWfVlABkQsz8ngfXTZSy2eU
         ROqo0D0+xiP5QpYEIp1Fzrv3icGGF2joJqM/dezoe4Kos+SxF4GwUhmSgGT7wm9AV28I
         xRnrgRw4AbD6WmrvlPG2R+zDn4dm7FBxXdCz/g7bCq7+KG2nYJHAHq1kZuXuJw+/7cwP
         yet1G/dTl6q4jbTGTvLt7hZhyCuw61YGP6TVFsuhWOBm6qEj8dL4ZXFV8LAMW4gnN1HO
         UjD1pvr4Q3cpOQBz5GSclww3QxJuHBsxKQDkRaFddau3Qd1E8hr6M1Mplcqzo0EOAd9R
         mtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oO/23sQ10zNdJXUePDBr15zWZE3PAPzpbovMLWW7jBo=;
        b=cthJOZPeKK/WNMzg/oJ9QsvABpj/QxiAy6VG/YN1tN1Q+FAVxX63JL5pDrgrrjPosV
         X5UNP3LwP/RDDA4h1pkaiPkA++RR2dWZ4EkKbKkZQLhw+qz0xLS8qO5RecixeV7Ys0It
         KNDSGGKu5dKjXQE8/n0fPeCzHNME4jJel5+1v4N/Ko/6fcP5O6mAwqdOUA5t0UYZwkXB
         P9neiBiEhOFtelPKzx2TfldEMM4HhC3TuILeoRomdLEzB0vtmwDx+Y3xzOaCn2S4bIEV
         BJQOSKz2OFYeM4q3OQBO7lo5fvYHPSCqHqAj6rRqHhl1EvcdKfIkjCKtcGTMTJD6cPDw
         42nw==
X-Gm-Message-State: AOAM533wfaiLl6BOjRAmEQuTWGrIeLaA7sBLNQLHoO99J5qTqS63JrJo
        OdzhE/E4CuE8Ps8kODpNV60FZ3ThJRxtSYZ4aqc=
X-Google-Smtp-Source: ABdhPJx3vRd/dP/5NBJB97jSnzkg4mtFwN9apjja9l0XgzUhFHKu5r6RtZf/NZFLldFSKwcOQ66ckVzaBmmlqGlkSkE=
X-Received: by 2002:a62:7c43:0:b029:1ef:20ce:ba36 with SMTP id
 x64-20020a627c430000b02901ef20ceba36mr8145230pfc.40.1617895843021; Thu, 08
 Apr 2021 08:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsiRYaE+y44ApDkvPvbDCdiJ+nnCMhiiaPVsg6p8m4+1Q@mail.gmail.com>
 <CAHp75VdJ7kGXN6sk8HTeSfAKQtHDGSmtdVPn7CSkK5=yfDizuA@mail.gmail.com>
 <CA+G9fYuG12WaC6QAdx1k80v8-As7a7oVVkhaUDxqgV=BaunfxQ@mail.gmail.com>
 <CAHp75Vf1S5Ra4fdkV=faw4tCXbeNiifC3y8MF0_bCqHGfDBLsQ@mail.gmail.com> <CA+G9fYuYC3QK2Zi8pbud0ebai4d4YgB0A4DXg5XWaE1pLWP5tw@mail.gmail.com>
In-Reply-To: <CA+G9fYuYC3QK2Zi8pbud0ebai4d4YgB0A4DXg5XWaE1pLWP5tw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Apr 2021 18:30:26 +0300
Message-ID: <CAHp75VcFo7SxMaKggyx1TM22tfKk7+_ZT4m5N1bXryABjqVeoA@mail.gmail.com>
Subject: Re: [next] [arm64] [gpio] BUG: key has not been registered! DEBUG_LOCKS_WARN_ON:
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
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

On Thu, Apr 8, 2021 at 3:59 PM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> On Thu, 8 Apr 2021 at 15:17, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Thu, Apr 8, 2021 at 11:33 AM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > > On Thu, 8 Apr 2021 at 04:21, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Thu, Apr 8, 2021 at 12:38 AM Naresh Kamboju
> > > > <naresh.kamboju@linaro.org> wrote:
> > > > >
> > > > > While running kselftest recently added gpio gpio-sim.sh test case the following
> > > > > warning was triggered on Linux next tag 20210330 tag running on arm64 juno
> > > > > and hikey devices.
> > > > >
> > > > > GOOD: next-20210326
> > > > > BAD: next-20210330
> > > > >
> > > > > This is still happening today on Linux next tag 20210407.
> > > >
> > > > Can you add the following
> > > >
> > > >   sysfs_attr_init(attrs[i]);
> > > >
> > > > to the end of the loop in gpio_sim_setup_sysfs()?
> > >
> > > Do you mean like this,
> > >
> > > diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> > > index ea17289a869c..5fe67ccf45f7 100644
> > > --- a/drivers/gpio/gpio-sim.c
> > > +++ b/drivers/gpio/gpio-sim.c
> > > @@ -296,6 +296,7 @@ static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
> > >                 dev_attr->store = gpio_sim_sysfs_line_store;
> > >
> > >                 attrs[i] = &dev_attr->attr;
> > > +               sysfs_attr_init(attrs[i]);
> > >         }
> > >
> > >         chip->attr_group.name = "line-ctrl";
> >
> > Precisely.
>
> As per your suggestions the above line added and build tested
> the reported issue is fixed now.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Thanks, I'll send a formal patch.

The rest I leave for Bart to figure out what to do.


-- 
With Best Regards,
Andy Shevchenko
