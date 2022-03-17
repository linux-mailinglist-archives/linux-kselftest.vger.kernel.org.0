Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DB84DCD36
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Mar 2022 19:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbiCQSLe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Mar 2022 14:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbiCQSLb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Mar 2022 14:11:31 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553C621A896;
        Thu, 17 Mar 2022 11:10:09 -0700 (PDT)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 22HI9ZKp008822;
        Fri, 18 Mar 2022 03:09:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 22HI9ZKp008822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1647540576;
        bh=9fJ0T7LBj+VU4wzwseO6SCq15p5l4MT92+XwYbfyh7A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g0O2QY2eOMQdP4tqgFmRtI0ZzTg45v1vExNUAbTdEuFaTMU8WVxgdu/ng7CaUp70S
         GgoLF8ASuT4i5QseAAxWbZb+cSnrMR4b1mGVA55jgDgmQ1TSk9CqwkOZDMhLcN06Rh
         fREZ2aWEgBaJZC4AAoukLuHU8Iq2lNNB2GhPGqsXQJeRaWCvo+5H+uKlzRz2vahXEp
         sLQey0FjyP1u+3nmCBL9VHJ6Mwic8qK4C/43zBMYYNpKLAlbnorsnKmSxUhKkISIPF
         wUInAL/45+qKV9QiFdH3oWtWcAuS/8XGurRolJzmYBVDc5RNlqyBo1SBDxGQc6XpnT
         1s8ZT8keKbXNQ==
X-Nifty-SrcIP: [209.85.215.181]
Received: by mail-pg1-f181.google.com with SMTP id e7so3248786pgf.7;
        Thu, 17 Mar 2022 11:09:36 -0700 (PDT)
X-Gm-Message-State: AOAM5316/3Y9JE5EfQJkxFSnUTHsf8D1wTJPxXjaGbM4q4aY4s4Im7xr
        evmjaUF/78+pQ0eL6uIX7viS5xaVnSBxQ7DpCUE=
X-Google-Smtp-Source: ABdhPJx0RR1qQGluLqOYdNH7spVWbNI1goPxD8fcRJEZvGMku52AkzedmY31/7M4+9/aMhhtWkemtBOceL9JJft1uyU=
X-Received: by 2002:a05:6a02:182:b0:374:5a57:cbf9 with SMTP id
 bj2-20020a056a02018200b003745a57cbf9mr4694200pgb.616.1647540575244; Thu, 17
 Mar 2022 11:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220223191016.1658728-1-usama.anjum@collabora.com> <63c5d7ad-b0b2-9b37-16c3-354ac10858b6@collabora.com>
In-Reply-To: <63c5d7ad-b0b2-9b37-16c3-354ac10858b6@collabora.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 18 Mar 2022 03:08:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNATkTPEBPWBSv6Rum0siHiHcJ0Q7VvPVoUQFH=S0M1fqow@mail.gmail.com>
Message-ID: <CAK7LNATkTPEBPWBSv6Rum0siHiHcJ0Q7VvPVoUQFH=S0M1fqow@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Fix separate output directory build of kselftests
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel@collabora.com, kernelci@groups.io,
        "Cc: Shuah Khan" <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 17, 2022 at 7:49 PM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Reminder. Shuah is okay with this patch. Any thoughts?

I do not think this is the right fix,
but something you just happen to find working.


The Make is working in a wrong directory, that is why
the relative path does not work
(and you use the absolute path to work around it)








>
> On 2/24/22 12:10 AM, Muhammad Usama Anjum wrote:
> > Build of kselftests fail if kernel's top most Makefile is used for
> > running or building kselftests with separate output directory. The
> > absolute path is needed to reference other files during this kind of
> > build. Set KBUILD_ABS_SRCTREE to use absolute path during the build. It
> > fixes the following different types of errors:
> >
> > make kselftest-all O=/linux_mainline/build
> > Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
> >
> > make kselftest-all O=build
> > Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
> >
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > ---
> > I've tested this patch on top of next-20220217. The latest next-20220222
> > have missing patches.
> > ---
> >  Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 86f633c2809ea..62b3eb8a102ab 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1411,10 +1411,10 @@ tools/%: FORCE
> >
> >  PHONY += kselftest
> >  kselftest:
> > -     $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
> > +     $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests KBUILD_ABS_SRCTREE=1 run_tests
> >
> >  kselftest-%: FORCE
> > -     $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
> > +     $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests KBUILD_ABS_SRCTREE=1 $*
> >
> >  PHONY += kselftest-merge
> >  kselftest-merge:
>
> --
> Muhammad Usama Anjum



--
Best Regards
Masahiro Yamada
