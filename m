Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B87E6DD60A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 10:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjDKI5s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 04:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjDKI5o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 04:57:44 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FF030E0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 01:57:40 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id a13so7318345ybl.11
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 01:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681203459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdATQ6SYcVmJmouCDRYiMfiaYGt9VMr4r2+RGYSpQ50=;
        b=n1QnfhAOkaZh2YeSwChYZ4fgRwj0FtyFVzAQ9K++nCnadYqTsZxGlIBN2fO9yh2//s
         dyQgz2YGmkzsryKnloXXWyqsH10ez2tBx2ORDmOWjA0FsNDUVJnbeiq0kTF0DIJUWL6M
         B/vDrUEIUINtwrk70qD39awc/Icn6I4fy/ihmKUSpC6GEM4hiZn7uQlykcxTpiY3Zg0a
         bdW14Z+ZT7mxeFjW2egx94p1sdawydoo3MiDabD7pULgaJ3THKyrlPF3+QVxl55HqRyX
         83slDYC2Z4psXhdPPiy2SY4dFyo+ld/TjkUYtOa6HkUVuQvVsKXnrDiqB5+ag/YVqSZr
         HjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681203459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdATQ6SYcVmJmouCDRYiMfiaYGt9VMr4r2+RGYSpQ50=;
        b=4DTt5tMW9cplbcqAFM4sP7oGLom3EiF7NWsraTze+GDGXyOd8od6RK/hN/l6UIFFH7
         inzd4XWS1CPUQ95CFKo8YBCrlp/H4uCJs+Uu6ONeC4vUJ6lPiLcMYLErx5rTAFNfCHTL
         ZwQoB9B31O1Adht2uw7PEO23hIr9cmO3etUwybiUkSNTgyPj4IgoIVf7tIwIddaAlbDs
         TQLhE88SHmhqKTmIM1zV8MqAtJRh1aX5FlN4pwGjwoqNmHx+/74OCqVAmXxBRoTIrnlL
         UAxIT48EUoUXcMOlDVg3UbIQwVqMKN8J44HqDV10a8W5XXZm3k22aqnPWRmlfFiRGI5j
         ezlA==
X-Gm-Message-State: AAQBX9f+ybaHJbbvwaQpsxNTw0XRo62ShwrgUSJm02V050tIPFN441te
        dpjSSKuDpwa66qDN97NLzbZxcq400Ux3wfMeeKw5Nw==
X-Google-Smtp-Source: AKy350a++3JYl4b5orvykBwgXzpw0u/ViD6Mgu9dnHLpQlskcqGZij1u89TLnLtzeuqNxul39K8znLHp3kO5Fmw4ZlU=
X-Received: by 2002:a25:7612:0:b0:b8e:ec30:853e with SMTP id
 r18-20020a257612000000b00b8eec30853emr3267991ybc.4.1681203459288; Tue, 11 Apr
 2023 01:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYv94gx8+-JMzbmQaue3q3y6QdBmsGUCdD-26X5XavL3Ag@mail.gmail.com>
 <ZAocZRZh4FQRH3lc@smile.fi.intel.com> <CA+G9fYsOttth+k3Ki8LK_ZiayvXa0bAg-DmQAaFHZeEyR=6Lrw@mail.gmail.com>
In-Reply-To: <CA+G9fYsOttth+k3Ki8LK_ZiayvXa0bAg-DmQAaFHZeEyR=6Lrw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 11 Apr 2023 10:57:28 +0200
Message-ID: <CACRpkdbUYWcFiRh+Y=MOekv2RjSP4sB2t5tVrSsz54Eez6wmVg@mail.gmail.com>
Subject: Re: selftests: gpio: crash on arm64
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pengfei Xu <pengfei.xu@intel.com>, yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 10, 2023 at 11:16=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
(...)
> Anders performed bisection on this problem.
> The bisection have been poing to this commit log,
>   first bad commit: [24c94060fc9b4e0f19e6e018869db46db21d6bc7]
>     gpiolib: ensure that fwnode is properly set

I don't think this is the real issue.

(...)
> # 2.  Module load error tests
> # 2.1 gpio overflow
(...)
> [   88.900984] Freed in software_node_release+0xdc/0x108 age=3D34 cpu=3D1=
 pid=3D683
> [   88.907899]  __kmem_cache_free+0x2a4/0x2e0
> [   88.912024]  kfree+0xc0/0x1a0
> [   88.915015]  software_node_release+0xdc/0x108
> [   88.919402]  kobject_put+0xb0/0x220
> [   88.922919]  software_node_notify_remove+0x98/0xe8
> [   88.927741]  device_del+0x184/0x380
> [   88.931259]  platform_device_del.part.0+0x24/0xa8
> [   88.935995]  platform_device_unregister+0x30/0x50

I think the refcount is wrong on the fwnode.

The chip is allocated with devm_gpiochip_add_data() which will not call
gpiochip_remove() until all references are removed by calling
devm_gpio_chip_release().

Add a pr_info() devm_gpio_chip_release() in drivers/gpio/gpiolib-devres.c
and see if the callback is even called. I think this could be the
problem: if that isn't cleaned up, there will be dangling references.

diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.c
index fe9ce6b19f15..30a0622210d7 100644
--- a/drivers/gpio/gpiolib-devres.c
+++ b/drivers/gpio/gpiolib-devres.c
@@ -394,6 +394,7 @@ static void devm_gpio_chip_release(void *data)
 {
        struct gpio_chip *gc =3D data;

+       pr_info("GPIOCHIP %s WAS REMOVED BY DEVRES\n", gc->label);
        gpiochip_remove(gc);
 }

If this isn't working we need to figure out what is holding a reference to
the gpiochip.

I don't know how the references to the gpiochip fwnode is supposed to
drop to zero though? I didn't work with mockup much ...

What I could think of is that maybe the mockup driver need a .shutdown()
callback to forcibly call gpiochip_remove(), and in that case it should
be wrapped in a non-existining devm_gpiochip_remove() since devres
is used to register it.

Bartosz will know better though! I am pretty sure he has this working
flawlessly so the tests must be doing something weird which is leaving
references around.

Yours,
Linus Walleij
