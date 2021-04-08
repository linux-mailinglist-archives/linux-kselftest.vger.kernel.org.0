Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D832357FCB
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Apr 2021 11:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhDHJrm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Apr 2021 05:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhDHJrm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Apr 2021 05:47:42 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173FDC061760;
        Thu,  8 Apr 2021 02:47:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t20so730072plr.13;
        Thu, 08 Apr 2021 02:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PnV0J8nT4j9vAMnnAhfzCebkcqE6zUO4OM97+q9ZYAo=;
        b=jG6sR68hkJd2v0SpFbAi4EkdDo37+pdAoRVaP9nRyzLun0VHwdC4rd9/3+xOM/FRQZ
         Q/Ogc7aMDu1VEwHg1vhDN4CAzEVZoA3EXVCE5Ic9CMscyAFORtYmxTnW7aNsKN76VdKG
         uPDSFnWyCkNVl/um6qVY9O7PC1Ri/Mdm7EbFUFm16b+C1Z9ro5PRNz1BtR8zi0/ZumhP
         jFJhKL+K9xPqUrlIxydZv/iEj9AegtQG7M3NOh+oX4m7ncjmoDKG7LLSrBYwGbc3Nebf
         PvdmGle4FC1+9+4agYNvw3ny2kmRKFwpOs29dcHCVtZng4zwhVDSNEsmPgbBfYGmxAUR
         hPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PnV0J8nT4j9vAMnnAhfzCebkcqE6zUO4OM97+q9ZYAo=;
        b=NLOEUhjOnQVSkhXxql0B05GygrF8dSlf8kju0jhfY0pw0Ipt/Aaq4yMsDjVokrnZop
         PFzgMYtlDa2u84SZCZZGTr7IzDbTzncxcrLTjIWZA7kI/xwQVGF7aHFPeF74hUw+2lSC
         Bf0+1jV3O+qmGRk4YCqQgOx32IC+mQRoqMJrPYthW2ScHcaLdVDMeX4KwOKLJPknDLm+
         RghyX43w2ys1G90TksQBT2ovusA+K+bIVIZZd+GgykBzRuAuiXwTZNyVHOkWePv2zbjV
         kRzYzrF5gGMvAtALmFoNJatgrE9ohoQQDTChzThc4lHzTnktZwOvq1Y+HGFz1mFP4hlc
         /LEw==
X-Gm-Message-State: AOAM533JqM02yzOGDZzMvv3FVfUYYKRpiltvoFu0WSIoAmshQb75lX5q
        tDloLPO6DGOAR5upOp8MEkkudkVvbE5xDyVLW2U=
X-Google-Smtp-Source: ABdhPJzONwCYTjNR9XF+/k3EFvV70hIKqAUs3+4MK2GVkd0ZfVW3JG4nQrVzkOHbs0w5xrv/TzTRM3yWg1v5W/GeDoo=
X-Received: by 2002:a17:90a:156:: with SMTP id z22mr7815188pje.181.1617875249307;
 Thu, 08 Apr 2021 02:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsiRYaE+y44ApDkvPvbDCdiJ+nnCMhiiaPVsg6p8m4+1Q@mail.gmail.com>
 <CAHp75VdJ7kGXN6sk8HTeSfAKQtHDGSmtdVPn7CSkK5=yfDizuA@mail.gmail.com> <CA+G9fYuG12WaC6QAdx1k80v8-As7a7oVVkhaUDxqgV=BaunfxQ@mail.gmail.com>
In-Reply-To: <CA+G9fYuG12WaC6QAdx1k80v8-As7a7oVVkhaUDxqgV=BaunfxQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Apr 2021 12:47:13 +0300
Message-ID: <CAHp75Vf1S5Ra4fdkV=faw4tCXbeNiifC3y8MF0_bCqHGfDBLsQ@mail.gmail.com>
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

On Thu, Apr 8, 2021 at 11:33 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
> On Thu, 8 Apr 2021 at 04:21, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Thu, Apr 8, 2021 at 12:38 AM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > >
> > > While running kselftest recently added gpio gpio-sim.sh test case the following
> > > warning was triggered on Linux next tag 20210330 tag running on arm64 juno
> > > and hikey devices.
> > >
> > > GOOD: next-20210326
> > > BAD: next-20210330
> > >
> > > This is still happening today on Linux next tag 20210407.
> >
> > Can you add the following
> >
> >   sysfs_attr_init(attrs[i]);
> >
> > to the end of the loop in gpio_sim_setup_sysfs()?
>
> Do you mean like this,
>
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index ea17289a869c..5fe67ccf45f7 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -296,6 +296,7 @@ static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
>                 dev_attr->store = gpio_sim_sysfs_line_store;
>
>                 attrs[i] = &dev_attr->attr;
> +               sysfs_attr_init(attrs[i]);
>         }
>
>         chip->attr_group.name = "line-ctrl";

Precisely.

> > If it fixes an issue I'll send a formal patch.
>
> I will build and test this and report here.

Thanks!

-- 
With Best Regards,
Andy Shevchenko
