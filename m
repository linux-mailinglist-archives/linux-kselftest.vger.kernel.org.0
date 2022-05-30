Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB143537397
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 May 2022 04:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiE3CjP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 29 May 2022 22:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiE3CjP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 29 May 2022 22:39:15 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FCF2FFE8;
        Sun, 29 May 2022 19:39:13 -0700 (PDT)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 24U2ccAY014384;
        Mon, 30 May 2022 11:38:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 24U2ccAY014384
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653878319;
        bh=qE7WzXO+Fvb8LCHJhg8ITc3RTlFLdDuh1rXDaHDbiIs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sPCU552xllBU8amPTSEmdOp5gcSpR0zm/ArNfQPjwi9XgCuHtFun7XDOjdYLirYM3
         p+AkSQw0AR+3WvBwarF9TuRlpuBCBLTppdLT7qvlPdRKSFvgHZrlnPUbDwKIgEj5rK
         SwdW2n57Z1ViQezOnF2lY2gvivUA0gmGIk/EJz0RwNeUyn9AbdfWT0pPqsfWINIeJx
         Dvh2bTyOvlSeUQ9/TXqmRNJUpk8i3TPwmQGrPjLy0uSGNycLt/VmX9qnwlxiuRqUad
         1k9k9XefjR8Jh2MNl0Y6bTdhSpTJbuNizNo9b50pVcS+aIywLjWXMl3z1+bLYRInYI
         9tKzTcarevDog==
X-Nifty-SrcIP: [209.85.216.42]
Received: by mail-pj1-f42.google.com with SMTP id m14-20020a17090a414e00b001df77d29587so12264206pjg.2;
        Sun, 29 May 2022 19:38:39 -0700 (PDT)
X-Gm-Message-State: AOAM530iAPxxtkmVBFFZdAKJbfQHPeVHXqYUFqZpTzJHaaahLo+WQcKd
        UAWSWsqvebltB9YNWZpSY6xOy+OkfcJSjvTqXl8=
X-Google-Smtp-Source: ABdhPJyaQ/wy9B9fshk3yW3KU4TEmW6glMJp4RuyA4kh5/iojS5tBbBKH3o+PslFQejImPVohc4VfuJPFqJ/RefpdpU=
X-Received: by 2002:a17:90a:9412:b0:1e0:c0cc:8630 with SMTP id
 r18-20020a17090a941200b001e0c0cc8630mr20484625pjo.77.1653878318504; Sun, 29
 May 2022 19:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <18500f18-9cd5-a81c-4a55-14e999ed4496@infradead.org>
 <3ae306e0-c6c7-ed12-cacd-62b1c26dba3c@infradead.org> <6671de03-c09c-bfaf-e06c-e45af70d4354@infradead.org>
 <6601a387-de9a-a0d0-11b5-01e0cfa75657@infradead.org> <7a97bac3-6ade-8e1b-cf0c-4a05c83163a3@infradead.org>
 <Yo+lHSmeIsx144cv@shaak> <3b7ec693-f4a5-e1aa-3e07-b22a4008d4c9@infradead.org>
 <YpPjqC+kVLIBpNlq@shaak> <593f31f6-1628-87f2-1b5d-ad8e79119dd6@infradead.org>
In-Reply-To: <593f31f6-1628-87f2-1b5d-ad8e79119dd6@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 30 May 2022 11:37:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUvQdEnSzUUYCjRVaZJpun5hdJ_oY=wYEW2RcF3spHuw@mail.gmail.com>
Message-ID: <CAK7LNASUvQdEnSzUUYCjRVaZJpun5hdJ_oY=wYEW2RcF3spHuw@mail.gmail.com>
Subject: Re: kbuild problem: ERROR: modpost: missing MODULE_LICENSE() in drivers/iio/afe/iio-rescale.o
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Liam Beguin <liambeguin@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
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

On Mon, May 30, 2022 at 9:17 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 5/29/22 14:20, Liam Beguin wrote:
> > Hi Randy,
> >
> > On Thu, May 26, 2022 at 01:04:41PM -0700, Randy Dunlap wrote:
> >>
> >>
> >> On 5/26/22 09:04, Liam Beguin wrote:
> >>> Hi Randy,
> >>>
> >>> On Thu, May 26, 2022 at 08:36:34AM -0700, Randy Dunlap wrote:
> >>>> Liam:
> >>>>
> >>>> Any comment on this?
> >>>> Otherwise I'll just send a formal patch like this (below).
> >>>
> >>> Apologies for not answering earlier.
> >>>
> >>> I wanted to look more into Masahiro's comment and try to fix the
> >>> Makefile, but that can be done after.
> >>>
> >>> IMO your patch improves the current Kconfig, so I'd recommend sending
> >>> the patch. If it can wait a bit, I can look at the Makefile over the
> >>> weekend.
> >>>
> >>
> >> Liam,
> >>
> >> I'll wait until next week to see if you come up with anything.
> >>
> >
> > The following patch fixes the issue while addressing Masahiro's comment.
> > I also considered `select IIO_RESCALE`, but I'm not sure what's usually
> > preferred.
> >
> > diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
> > index 56ca0ad7e77a..4c66c3f18c34 100644
> > --- a/drivers/iio/test/Kconfig
> > +++ b/drivers/iio/test/Kconfig
> > @@ -6,7 +6,7 @@
> >  # Keep in alphabetical order
> >  config IIO_RESCALE_KUNIT_TEST
> >       bool "Test IIO rescale conversion functions"
> > -     depends on KUNIT=y && !IIO_RESCALE
> > +     depends on KUNIT=y && IIO_RESCALE=y
> >       default KUNIT_ALL_TESTS
> >       help
> >         If you want to run tests on the iio-rescale code say Y here.
> > diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
> > index f15ae0a6394f..880360f8d02c 100644
> > --- a/drivers/iio/test/Makefile
> > +++ b/drivers/iio/test/Makefile
> > @@ -4,6 +4,6 @@
> >  #
> >
> >  # Keep in alphabetical order
> > -obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o ../afe/iio-rescale.o
> > +obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o
> >  obj-$(CONFIG_IIO_TEST_FORMAT) += iio-test-format.o
> >  CFLAGS_iio-test-format.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> >
> > I'll send a patch as soon as you confirm this works for you too.
>
> Looks good. Thanks.
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>
> --
> ~Randy


 Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

-- 
Best Regards
Masahiro Yamada
