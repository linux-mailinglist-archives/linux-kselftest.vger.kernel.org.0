Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4C86DDBC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 15:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDKNLv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 09:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjDKNLt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 09:11:49 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF8B19A2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 06:11:48 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id v10so7309872vsf.6
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1681218707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GonC8IX0js+OVi94Wk4G2xkTnBOQ98tF+JQsSsp/P+Q=;
        b=xcJRS2UHnJF4qMLv4zXTiL1wmsA2j57YKkXofoZoG/nncFZ9Dc1hTwLN9PxOK66kSn
         mz5KoPN9Le33iDewCg+LcdfbSvEsXPwZX+o6OB81EpOzNNkDtFiXuemIctsk56gBvpCC
         wDInekSq7XXxuRAZSFDN+SVTjC0FN04Oh7DdCusqwKQ8b4Fga6xT4XzMEc0v9bldQ9Ez
         dAgN26c61YqIQFVmFY94LfFbXWjGBpZmtDSFpAPxfM5ShpqBMCeOaneCk3slWVYcWVcA
         pTI/4tv2eM4KsYmeCwLjBPhsy9AF78MmkekST/L15qszuiH85CAGdjRrRpkonzJhc9h+
         hwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681218707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GonC8IX0js+OVi94Wk4G2xkTnBOQ98tF+JQsSsp/P+Q=;
        b=HnKsRlPySgJ9BfAfGRj6tqx1RpFwkCCZ0JkiuFSikCuHjWJq8CSyvU2jad/qbZVA1p
         mZdcqUjkvyTzn1WEcp8vE0uNuijn7WRv6UrQNfma4i4XcwueksZmpyAhtbN2fEJoO9B+
         JOfdxIK8we7VfXZFaoxLt+E7tQdqg/fDfDfji3YFeRs93DjatTISc/C5P1XdL1qFqW7d
         qdEWpXop/DBo8skCcPJ3whdUtl62lHKnSaYK7kp1nc77E5e5hrzaDAvhkBqjkQ9FUJDA
         GTo9SwZVPA8d+Gnge5K6PGBsc+r/c6losCK4ITuGIHREbBjVNZvz+0nxaVsf3Re7BVSM
         TIeg==
X-Gm-Message-State: AAQBX9c8/eT+0wahpCkNQ6CNRUb3LF5fY9oY/5ZpW/391pwOrx5QIWli
        iTnmm71YmKN0oe7XbXbw7mqD8/imwp+8iuHezkivww==
X-Google-Smtp-Source: AKy350YbgCCHeeQll+PtCuIJBiGVDqYrDGK7d5MCr7dW/WF0/1JpvIxP/7GIUb8Prhz1Fy5k/YBRj+Zy3NIQvBwzyTk=
X-Received: by 2002:a67:ca81:0:b0:426:7730:1b89 with SMTP id
 a1-20020a67ca81000000b0042677301b89mr1904738vsl.0.1681218707036; Tue, 11 Apr
 2023 06:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYv94gx8+-JMzbmQaue3q3y6QdBmsGUCdD-26X5XavL3Ag@mail.gmail.com>
 <ZAocZRZh4FQRH3lc@smile.fi.intel.com> <CA+G9fYsOttth+k3Ki8LK_ZiayvXa0bAg-DmQAaFHZeEyR=6Lrw@mail.gmail.com>
 <CACRpkdbUYWcFiRh+Y=MOekv2RjSP4sB2t5tVrSsz54Eez6wmVg@mail.gmail.com>
In-Reply-To: <CACRpkdbUYWcFiRh+Y=MOekv2RjSP4sB2t5tVrSsz54Eez6wmVg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 11 Apr 2023 15:11:36 +0200
Message-ID: <CAMRc=MeivPz2nOjgFwYscZQpbuXnt=z5JAVMB4uzahQJgKjdKg@mail.gmail.com>
Subject: Re: selftests: gpio: crash on arm64
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pengfei Xu <pengfei.xu@intel.com>, yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 11, 2023 at 10:57=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Mon, Apr 10, 2023 at 11:16=E2=80=AFAM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> (...)
> > Anders performed bisection on this problem.
> > The bisection have been poing to this commit log,
> >   first bad commit: [24c94060fc9b4e0f19e6e018869db46db21d6bc7]
> >     gpiolib: ensure that fwnode is properly set
>
> I don't think this is the real issue.
>
> (...)
> > # 2.  Module load error tests
> > # 2.1 gpio overflow
> (...)
> > [   88.900984] Freed in software_node_release+0xdc/0x108 age=3D34 cpu=
=3D1 pid=3D683
> > [   88.907899]  __kmem_cache_free+0x2a4/0x2e0
> > [   88.912024]  kfree+0xc0/0x1a0
> > [   88.915015]  software_node_release+0xdc/0x108
> > [   88.919402]  kobject_put+0xb0/0x220
> > [   88.922919]  software_node_notify_remove+0x98/0xe8
> > [   88.927741]  device_del+0x184/0x380
> > [   88.931259]  platform_device_del.part.0+0x24/0xa8
> > [   88.935995]  platform_device_unregister+0x30/0x50
>
> I think the refcount is wrong on the fwnode.
>
> The chip is allocated with devm_gpiochip_add_data() which will not call
> gpiochip_remove() until all references are removed by calling
> devm_gpio_chip_release().
>
> Add a pr_info() devm_gpio_chip_release() in drivers/gpio/gpiolib-devres.c
> and see if the callback is even called. I think this could be the
> problem: if that isn't cleaned up, there will be dangling references.
>
> diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.=
c
> index fe9ce6b19f15..30a0622210d7 100644
> --- a/drivers/gpio/gpiolib-devres.c
> +++ b/drivers/gpio/gpiolib-devres.c
> @@ -394,6 +394,7 @@ static void devm_gpio_chip_release(void *data)
>  {
>         struct gpio_chip *gc =3D data;
>
> +       pr_info("GPIOCHIP %s WAS REMOVED BY DEVRES\n", gc->label);
>         gpiochip_remove(gc);
>  }
>
> If this isn't working we need to figure out what is holding a reference t=
o
> the gpiochip.
>
> I don't know how the references to the gpiochip fwnode is supposed to
> drop to zero though? I didn't work with mockup much ...
>
> What I could think of is that maybe the mockup driver need a .shutdown()
> callback to forcibly call gpiochip_remove(), and in that case it should
> be wrapped in a non-existining devm_gpiochip_remove() since devres
> is used to register it.
>
> Bartosz will know better though! I am pretty sure he has this working
> flawlessly so the tests must be doing something weird which is leaving
> references around.
>
> Yours,
> Linus Walleij

Interestingly I'm not seeing this neither with gpio-sim selftests nor
with any of the libgpiod tests which suggests it's the gpio-mockup
module that's doing something wrong (or very right in which case it
uncovers some otherwise hidden bug). Anyway, I'll try to spend some
time on it and figure it out, although I'd like to be done with
gpio-mockup altogether already.

Bart
