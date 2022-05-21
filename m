Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42D952F8AA
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 06:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiEUE0t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 00:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiEUE0s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 00:26:48 -0400
X-Greylist: delayed 606 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 May 2022 21:26:45 PDT
Received: from condef-06.nifty.com (condef-06.nifty.com [202.248.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D759353B66;
        Fri, 20 May 2022 21:26:45 -0700 (PDT)
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-06.nifty.com with ESMTP id 24L4DoiS011650;
        Sat, 21 May 2022 13:13:50 +0900
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 24L4DK2q027193;
        Sat, 21 May 2022 13:13:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 24L4DK2q027193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653106400;
        bh=l0jnxTYMQ+einh42QUtyR5KEJNXZYp44NPYbbHl4Gxs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sd5Skt6f3VurMXt5yhrtPI6uLY0krE0xiOnSxvKESWZeBs6mXJKK7XkPbgQPNHtsQ
         w/zexhv88CfDWesdsGdN4Cfc+YwIGsfTr9e8JjjyTvsnnzFNeu4xbGz2ZWhSWfgTTx
         O5jWTWbb9J81OTusmiZT9gqcOGNsZ/pN0AIAxdwBi9iQ4xbzismIfdzIjYIu7CANk3
         v2jjLaIKUk0occAC1tI27flxadhMJq8JFWlAeBLbE9si0sPsNDmcAEc/dMFCZNPKGb
         eQuMzPXBMU8olS1sodK/CoZIj3bOD8Fs7b//KLVh5oR5pgJyrpR/M7Q7xl+4f6kmPR
         EulfIbEV+I+Uw==
X-Nifty-SrcIP: [209.85.210.176]
Received: by mail-pf1-f176.google.com with SMTP id bo5so9241216pfb.4;
        Fri, 20 May 2022 21:13:20 -0700 (PDT)
X-Gm-Message-State: AOAM5325KldPcz5pYtzw2U4yaxYjLdoUwRz3bA+6E/fX3ih2qcAABDyL
        19I2ncyTEx/iG0x76tD46PutcnTapX/5N8LpELg=
X-Google-Smtp-Source: ABdhPJw1AsOYGWIj+yvZJTCKNKYKKsbmQJJOhJyF3fQ5aMkMnJqrTIcQ++lJlPJIW3w4X9wOzRz7FfdDlbiCVzQ49Mk=
X-Received: by 2002:a05:6a00:a02:b0:4fd:f9dd:5494 with SMTP id
 p2-20020a056a000a0200b004fdf9dd5494mr13624800pfh.68.1653106399660; Fri, 20
 May 2022 21:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <18500f18-9cd5-a81c-4a55-14e999ed4496@infradead.org>
In-Reply-To: <18500f18-9cd5-a81c-4a55-14e999ed4496@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 21 May 2022 13:12:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNAShN5=0a_+XyXg-1+q=fbdcxMxR2fwts8eZyz2HAtn5bw@mail.gmail.com>
Message-ID: <CAK7LNAShN5=0a_+XyXg-1+q=fbdcxMxR2fwts8eZyz2HAtn5bw@mail.gmail.com>
Subject: Re: kbuild problem: ERROR: modpost: missing MODULE_LICENSE() in drivers/iio/afe/iio-rescale.o
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 21, 2022 at 11:40 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> In March I reported that a randconfig build complained:
>
> ERROR: modpost: missing MODULE_LICENSE() in drivers/iio/afe/iio-rescale.o
>
> (https://lore.kernel.org/all/16509fb6-e40c-e31b-2c80-264c44b0beb9@infradead.org/)
>
> I am still seeing this problem so I tried to dig into it a bit.
> However, I don't see why get_next_modinfo() and friends don't find the
> MODULE_LICENSE() since it is in the iio-rescale.o file.
>
> (BTW, I see this build error on many different $ARCH [around 15 tested]
> and with 2 different versions of GCC.)
>
> Q1: Is modpost checking both vmlinux and iio-rescale.o for modinfo license
> strings?


MODULE_LICENSE() is no-op for vmlinux.

modpost checks this only for modules.



>
> It looks like it is, because it appears (?) that modpost is looking at
> drivers/iio/test/iio-test-rescale.o (<<<<< a kunit test, which is builtin
> in my .config) and at drivers/iio/afe/iio-rescale.o (which is built as a
> loadable module).
>
> Is this confusing modpost?
> I renamed drivers/iio/afe/iio-rescale.c to afe-rescale.c and changed its
> Makefile entry accordingly and the MODULE_LICENSE error goes away.
>
> Is this a modpost error or is kunit messing things up?
>
> thanks for looking.
> --
> ~Randy



-- 
Best Regards
Masahiro Yamada
