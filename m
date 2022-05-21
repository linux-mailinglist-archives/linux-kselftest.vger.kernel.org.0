Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7EE52F869
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 06:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354579AbiEUEQo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 00:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354585AbiEUEQV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 00:16:21 -0400
X-Greylist: delayed 140 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 May 2022 21:16:11 PDT
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E2F643C;
        Fri, 20 May 2022 21:16:08 -0700 (PDT)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 24L4FUIi003497;
        Sat, 21 May 2022 13:15:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 24L4FUIi003497
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653106531;
        bh=Xf8NCYo0YOY0bu0jQcQFs+Y8y5oCImuro2ljp5V6ip8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZZXzFo08FpfLUVD9UO80XU+0Efkc74oNFrA6OLIxxXMqqA76QbqTl/WHeKugnGPnf
         fd1cY6IN+BQdngSibRpE4pnkctuXxQn/Sdky98WJ6YcYunUQYfumpoAJ9rviao90e+
         4+xWf0OJg0GRdoPqMpC/hVLBLdIaUFwNTDsrO3eoJ1pdWwj1v12xehdfs6+/Zj1KIc
         h0U9Co+FJXpyV2uGJZwnYMi7XYSi3a3O39BHN2OiepffWjFp2pGr/wx0vBapqgtJPH
         2fSQGiNj6/WMVMsvoSt3yXizW5dA816cl6zIOa8ATAVJnXz9yHY0H/Ii/py17KMQsX
         EU888zGjcbBug==
X-Nifty-SrcIP: [209.85.216.52]
Received: by mail-pj1-f52.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so13073908pjb.0;
        Fri, 20 May 2022 21:15:31 -0700 (PDT)
X-Gm-Message-State: AOAM530c8LPxDeARtFu2K7ZWBO+MRFNhBfshCpnuiSUK7R5OGrkX3Axn
        90cNe8EtDpr2TJYAG8efChDRRMJHG6+xAkoMvNc=
X-Google-Smtp-Source: ABdhPJxrFjJ2ttg5R6GbMR6RsPOHoOOY83n9AMXyiwvC5OibXR3D7T4dW+4rE3208jNHJKQ/yc+X80O6GyqEkkqkAJ0=
X-Received: by 2002:a17:90a:e7cd:b0:1dc:74eb:7526 with SMTP id
 kb13-20020a17090ae7cd00b001dc74eb7526mr14425148pjb.144.1653106530271; Fri, 20
 May 2022 21:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <18500f18-9cd5-a81c-4a55-14e999ed4496@infradead.org>
 <3ae306e0-c6c7-ed12-cacd-62b1c26dba3c@infradead.org> <6671de03-c09c-bfaf-e06c-e45af70d4354@infradead.org>
 <6601a387-de9a-a0d0-11b5-01e0cfa75657@infradead.org>
In-Reply-To: <6601a387-de9a-a0d0-11b5-01e0cfa75657@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 21 May 2022 13:14:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNASMOqfjHsE82ErjeYOJjxHgD_HZcm1VUcESORS6UridWw@mail.gmail.com>
Message-ID: <CAK7LNASMOqfjHsE82ErjeYOJjxHgD_HZcm1VUcESORS6UridWw@mail.gmail.com>
Subject: Re: kbuild problem: ERROR: modpost: missing MODULE_LICENSE() in drivers/iio/afe/iio-rescale.o
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Liam Beguin <liambeguin@gmail.com>,
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

On Sat, May 21, 2022 at 12:51 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Ok, one more.
> [also adding Liam here]
>
> On 5/20/22 20:17, Randy Dunlap wrote:
> >
> >
> > On 5/20/22 20:08, Randy Dunlap wrote:
> >>
> >>
> >> On 5/20/22 19:40, Randy Dunlap wrote:
> >>> Hi,
> >>>
> >>> In March I reported that a randconfig build complained:
> >>>
> >>> ERROR: modpost: missing MODULE_LICENSE() in drivers/iio/afe/iio-rescale.o
> >>>
> >>> (https://lore.kernel.org/all/16509fb6-e40c-e31b-2c80-264c44b0beb9@infradead.org/)
> >>>
> >>> I am still seeing this problem so I tried to dig into it a bit.
> >>> However, I don't see why get_next_modinfo() and friends don't find the
> >>> MODULE_LICENSE() since it is in the iio-rescale.o file.
> >>>
> >>> (BTW, I see this build error on many different $ARCH [around 15 tested]
> >>> and with 2 different versions of GCC.)
> >>>
> >>> Q1: Is modpost checking both vmlinux and iio-rescale.o for modinfo license
> >>> strings?
> >>>
> >>> It looks like it is, because it appears (?) that modpost is looking at
> >>> drivers/iio/test/iio-test-rescale.o (<<<<< a kunit test, which is builtin
> >>> in my .config) and at drivers/iio/afe/iio-rescale.o (which is built as a
> >>> loadable module).
> >>>
> >>> Is this confusing modpost?
> >>> I renamed drivers/iio/afe/iio-rescale.c to afe-rescale.c and changed its
> >>> Makefile entry accordingly and the MODULE_LICENSE error goes away.
> >>
> >> Oh well. This rename causes drivers/iio/test/iio-test-rescale.c to have
> >> build errors, so that's not a solution, just some info...
> >
> > and that was due to not updating drivers/iio/test/Makefile.
> > When that is done, the missing MODULE_LICENSE() is back in afe-rescale.o.
> >
> >>
> >>> Is this a modpost error or is kunit messing things up?
> >>>
> >>> thanks for looking.
>
> Does this look OK? It allows afe/iio-rescale.o to build XOR
> test/iio-rescale.o (not both of them).
>
> --- a/drivers/iio/test/Kconfig
> +++ b/drivers/iio/test/Kconfig
> @@ -6,7 +6,7 @@
>  # Keep in alphabetical order
>  config IIO_RESCALE_KUNIT_TEST
>         bool "Test IIO rescale conversion functions"
> -       depends on KUNIT=y && !IIO_RESCALE
> +       depends on KUNIT=y && IIO_RESCALE=n
>         default KUNIT_ALL_TESTS
>         help
>           If you want to run tests on the iio-rescale code say Y here.
>
>
> --
> ~Randy



As you may have already noticed,
the root cause is drivers/iio/test/Makefile

obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o ../afe/iio-rescale.o



For the combination of
CONFIG_IIO_RESCALE=m
CONFIG_IIO_RESCALE_KUNIT_TEST=y,

drivers/iio/afe/iio-rescale.o is built twice;
as modular by drivers/iio/afe/Makefile, and
as built-in by drivers/iio/test/Makefile.

That's why MODULE_LICENSE() is lost.


I think your solution will work
although this Makefile is not recommended.






--
Best Regards
Masahiro Yamada
