Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944DE4E9FD4
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 21:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbiC1TiJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 15:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245757AbiC1TiB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 15:38:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE114EA28
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 12:36:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id p15so30793749ejc.7
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3nSgxmmg//mySu9Cydedpr4Jhc1g8g4FNQinYIPgOU=;
        b=T6fqFffdtdfHXtp2UxqFYdjmnVqBqs3TDGX0S+zhlL0s2VPk2tjDZHu/hwv5GitnER
         kOmO/z8a3ZFLZIZpaWjszZ5EkgGSPco6C/G1DP6st3I57A+o7HXj+mMmojdPN4OABjUa
         a0ZwIyskZwiNEvLAnPVakxU5R1wtxIVnHVhepPkynKyp7rlSwzzCPMb5t5pSaC8x4B2K
         bQejuXPF9k3ZteDBU7YMWoRzW0yIBmPY3Q7ZUNfg2YFHfrtf+/Ya3TLibn5BJ2daoycQ
         Aby/RloMJT4qVDAL/1CEzZVotkyGWjHCMBpBXmL+S1pN0R3CuGaiSM3DsPv+U2Hs2tAf
         xzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3nSgxmmg//mySu9Cydedpr4Jhc1g8g4FNQinYIPgOU=;
        b=Q4MgVwyP4IjN5zGzPl3wOZT1shcqB4sl+FCVybKuYN5CSsrCoBhZhyp1LIUtaLTegS
         PUUSjj1sIaTpanY4AtknpC96s6EmfrLuO+ouKxj8dEZWhadQtJ47nfduH4Z524nqZbBJ
         dUOtdOPfRBQ89slml0ljYIgrg/FduE0+upqfELHpuYxz5Iibx/QciYFTA/JJ6MzoJdcv
         deknwLYPOiOT5lNQNYLLlbUp3q4tkBH4SEA5VtvRFCPbcJhdfreeSYVDXLpVqwm/XE4N
         qL88s6boefSU4rWea5dDaukNiWjIlmtkfc53wsyb5mzeNw1zJbKRa1JX1L0oaxtbKhsg
         E7mg==
X-Gm-Message-State: AOAM531wSeQCkSJuCZ9Tn6oNzU+FPHXVu2TFgdnRSvUXzlPoEnRnWyKs
        1VcIEncEWtLnHlgUhvH15Rd3PJfFaVKcQfmdonFk3Q==
X-Google-Smtp-Source: ABdhPJyRXH6t65V981NP8WK54X384Pl7tl7sgr87i7dlNrc6CVNo5L/KZ3rpYjK+gaACLnE+fpkP6az2xsOA+g5ryN8=
X-Received: by 2002:a17:906:37cd:b0:6e0:bdb6:f309 with SMTP id
 o13-20020a17090637cd00b006e0bdb6f309mr18431848ejc.394.1648496174928; Mon, 28
 Mar 2022 12:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220326003356.487828-1-dlatypov@google.com> <CABVgOSmbQxZmmNtUQLsvMSPkr2FpXB_kdJUUbC=nLrt6xN7e2A@mail.gmail.com>
 <CAGS_qxq_vFtGS4BGieZz8L3QH7rZ7ZN25pGYmjWWoXbTGOKC9A@mail.gmail.com>
 <CAFd5g45f3X3xF2vz2BkTHRqOC4uW6GZxtUUMaP5mwwbK8uNVtA@mail.gmail.com> <CAGS_qxp604tXbqzSg0nmz=Ws9ZzX47u-XCftNxfcamyM=GrQYw@mail.gmail.com>
In-Reply-To: <CAGS_qxp604tXbqzSg0nmz=Ws9ZzX47u-XCftNxfcamyM=GrQYw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 28 Mar 2022 15:36:04 -0400
Message-ID: <CAFd5g47E-p9V25MwAr96mZdcpr3-1cr2MZucvqYMbXqvacQeRQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: update kconfig options needed for
 UML coverage
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>, maxime@cerno.tech
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 28, 2022 at 2:58 PM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Mon, Mar 28, 2022 at 11:54 AM 'Brendan Higgins' via KUnit
> Development <kunit-dev@googlegroups.com> wrote:
> >
> > On Mon, Mar 28, 2022 at 12:35 PM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > On Fri, Mar 25, 2022 at 9:56 PM David Gow <davidgow@google.com> wrote:
> > > >
> > >
> > > <snip>
> > >
> > > > >         # Append coverage options to the current config
> > > > > -       $ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
> > > > > +       $ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
> > > > >         $ ./tools/testing/kunit/kunit.py run
> > > >
> > > > Would we want to instead use a chain of --kconfig_add arguments? (I
> > > > think there are advantages either way...)
> > >
> > > I've been considering this ever since the --kconfig_add patch was accepted.
> > > It's more compatible w/ commands using --kunitconfig, but it also
> > > looks very verbose.
> > > E.g. it looks like
> > >
> > > $ tools/testing/kunit/kunit.py run --make_options=CC=/usr/bin/gcc-6
> > > --kconfig_add=CONFIG_DEBUG_INFO=y
> > > --kconfig_add=CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> > > --kconfig_add=CONFIG_GCOV=y
> >
> > I don't think it's *that* much more verbose, but I see your point. I
> > personally prefer this, but not enough to argue about it.
>
> I personally prefer it too, but I'm biased as the person who added
> --kconfig_add.
> They're both ugly enough I'd figured I'd save the bikeshedding for
> another patch.
>
> >
> > > Neither looks very appealing to me, so I've just kept it as-is for now.
> > >
> > > Maybe there's something we can do to make this easier (e.g. allowing
> > > --kunitconfig to be repeated and mergable)?
> >
> > I would like --kunitconfig to be repeadable and mergable.
>
> Ack.
> There's some things to consider first.

I wasn't saying I want you to do it now. I just like the idea.

> 1. This will conflict w/
> https://patchwork.kernel.org/project/linux-kselftest/patch/20220226212325.2984807-1-dlatypov@google.com/,
> so I'm going to wait until that gets merged first.

Agreed.

> 2. some kconfigs can be incompatible (e.g. these options only work on
> UML, can't combine w/ a non-UML compatible file)
> How do we make this less of a footgun?
> We'd talked about how it'd be nice if kconfig/"make olddefconfig"
> could print out *why* options get dropped (either they're not visible,
> have unmet deps, etc.). If we had that, I'd feel more comfortable w/
> repeatable kunitconfig.

Good point. Something to think about.

> 3. People have the ability to do this already if they're really sure it's safe
> $ cat <files...> | ./tools/testing/kunit/kunit.py run --kunitconfig=/dev/stdin

Sure, but I still think multiple --kunitconfig s would be a good
feature to add. I think it makes it a bit easier to think about mixing
and matching kunitconfigs.

> 4. are we committed to supporting a "uml_coverage.kunitconfig" file?
> As shown by the existence of this patch, we've let it get broken for a
> bit, at least against linux-next (afaik, it was working on
> torvalds/master up until the 5.18 window opened and we had some
> patches reworking CONFIG_DEBUG_INFO).

Good point. I don't think we want to get in that business. UML
Coverage needs a lot of work, and I don't think we have the time or
resources to own that work by ourselves.

If someone else wants to add - and then own - such a kunitconfig, I
would fully support them and maybe even help them a bit, but I don't
want to own such a file until UML coverage gets a bit more stable.

> These instructions exist so others don't have to try and re-figure out
> the steps/workarounds.
> But they're not more formally "part of KUnit" since no one has had the
> expertise to maintain it (and fix issues like the reliance on gcc-6),
> etc.
>
> Creating a kunitconfig file for this will further imply ownership.

Agreed.
