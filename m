Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3F17E413D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 14:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbjKGNxW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 08:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbjKGNwz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 08:52:55 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320BC10F2
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Nov 2023 05:51:44 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-4ac28bd2857so1300771e0c.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Nov 2023 05:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699365103; x=1699969903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFbhgesTUnqxhtDQL2m5PAauT+IbKwZ6JL+G8+IHHdQ=;
        b=k16zXvaxUbR/1P7PTzeBhhcULujmCr3FUFKcqL6LRXxm6G/+lSvQFWYGrc3VKQ8Zwf
         SfvHqUNn1sYolhL1965mNtPob4akS0ZjARodFpdZ6Dc2Tb6NaDSYFS5fpCkaglfjOW9J
         Kwcxy2J52rJ2EM9UIETM3IqhHsuPPh9Wq/Z9/LS3og3MlLjuHxQlW9Z1yGt3UBpS+DCg
         KkaBMeACgRz+r/pT7vvpDhaEd+OcyAp/dDaCvaVEM0cgSMh3XQwOx1k1xrj7ZrFfJFsg
         n4B8F1jbVXSr13JF8z8dSNsvtE9GFUyxVyrO53xoqeUypQ6VNPHVB4tsb4UJuPJq82cm
         XmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699365103; x=1699969903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFbhgesTUnqxhtDQL2m5PAauT+IbKwZ6JL+G8+IHHdQ=;
        b=XgQz5wSAIBDUiOj34kBkytlLTMONYShBYuP+w1aajvi0V66NLy6euM+S09txWVhb8m
         mEzzZhZK2q+DMtHEBylg1S2mx0giXA6mmksjhS25kbPUaLGxUtSxA5ZZR3zBCIGf7RUk
         gRD0GpvwIL+Z+BY8a/9VKNDD7uWKJURP3TY8ZgsAF68kx5Ggi08k1nnqRZ6OB5Yye9jZ
         nTnAwiacnSie3riMDY7W01THdisDoLXrjUGHBJbpHmh4E7xCCpODz75/J/aCHSqmukMM
         KBzzCxlUKFg8j64UWllRbAamlq56hwE87oQxk9Oy+RYEmH/Q4KDRJUJQTmm/3e5gJ6zm
         aPwA==
X-Gm-Message-State: AOJu0YzWwLC/ubYbDny/xAhH+UZzeYfDUTQhH0EBry5zr2KzlY8GORoD
        jDKUyeqDmhYmdik6h+RKA4TeTyei2dlb2JO/nvwxiw==
X-Google-Smtp-Source: AGHT+IEYK3VvFqFlqkqCX6v5oLDKyDaPY5K2oNNBOIIHvCR8ElKbDarcbIVw0JRJQkyIBzCUOD6vzk6X2p3e7cEnjYU=
X-Received: by 2002:a67:c113:0:b0:45f:274:8c32 with SMTP id
 d19-20020a67c113000000b0045f02748c32mr6745817vsj.32.1699365103136; Tue, 07
 Nov 2023 05:51:43 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYv94gx8+-JMzbmQaue3q3y6QdBmsGUCdD-26X5XavL3Ag@mail.gmail.com>
 <ZAocZRZh4FQRH3lc@smile.fi.intel.com> <CA+G9fYsOttth+k3Ki8LK_ZiayvXa0bAg-DmQAaFHZeEyR=6Lrw@mail.gmail.com>
 <CACRpkdbUYWcFiRh+Y=MOekv2RjSP4sB2t5tVrSsz54Eez6wmVg@mail.gmail.com> <ZJHWdcP+PDaNrw07@smile.fi.intel.com>
In-Reply-To: <ZJHWdcP+PDaNrw07@smile.fi.intel.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Nov 2023 19:21:32 +0530
Message-ID: <CA+G9fYvReHr+ofJAW4yfA5EWT6-MRpR2+fOQG24hROjSd+dY0g@mail.gmail.com>
Subject: Re: selftests: gpio: crash on arm64
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pengfei Xu <pengfei.xu@intel.com>, yi1.lai@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Linus and Bartosz,

On Tue, 20 Jun 2023 at 22:11, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 11, 2023 at 10:57:28AM +0200, Linus Walleij wrote:
> > On Mon, Apr 10, 2023 at 11:16=E2=80=AFAM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
>
> ...
>
> > Add a pr_info() devm_gpio_chip_release() in drivers/gpio/gpiolib-devres=
.c
> > and see if the callback is even called. I think this could be the
> > problem: if that isn't cleaned up, there will be dangling references.
>
> Side note: Since we have devres tracepoints, your patch seems an overkill=
 :-)
> Just enable devres tracepoints and filter out by the function name. I bel=
ieve
> that should work.

Since I have been tracking open issues on the stable-rc kernel,
The reported problem on stable-rc linux.6.3.y has been solved
on the stable-rc linux.6.6.y branch.

Thanks for fixing this reported issue.

Upstream links about this fix and discussion,

Commit daecca4b8433
gpiolib: Do not alter GPIO chip fwnode member

[1] https://lore.kernel.org/linux-gpio/20230703142308.5772-4-andriy.shevche=
nko@linux.intel.com/
[2] https://lore.kernel.org/linux-gpio/CAMRc=3DMfFEBSeJ78NO7XeuzAMJ0KezEPAY=
WsWnFXXaRyQPAf3dA@mail.gmail.com/
[3] https://lore.kernel.org/linux-gpio/CA+G9fYv94gx8+-JMzbmQaue3q3y6QdBmsGU=
CdD-26X5XavL3Ag@mail.gmail.com/

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
