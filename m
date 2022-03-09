Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7A84D2C04
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 10:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiCIJbU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 04:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiCIJbU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 04:31:20 -0500
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121A016E7FD;
        Wed,  9 Mar 2022 01:30:21 -0800 (PST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2299TvBX019363;
        Wed, 9 Mar 2022 18:29:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2299TvBX019363
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646818197;
        bh=clWEPD6AdacDEOa6KCj1PoO9ewauxhdqGkF+hXLwHwk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2ZBjVKdPQdgv2Bf5DpuDj5qDdwZB+cQOy2j0ZK9KEuJ8nKf0zltZI2QKpVNNqI+c2
         9H6KpNZTD+L0I4dyEwZz2u3ARS8LJGcnlah2So+0nnWOFJAFVVhgfK5krPahB7fRlG
         YoBBWPI6/IFnZ49FivVSUifs4Uq9OnvURv5QFuGT8aa0UQpG/kSbruV5k+lmYTwnQt
         nK7IVR9NKZMnqiS/vJvMZk3YZQzXclhu2/7h54TQqnFFlC1buCF4W7ox3Bt/R0+g3V
         tPf1GjqDaeTAbnX1G0r4dNfYbAPot4bPrNrNsji9Huh0xrZ8kb9dpib6iUf0TiQHmK
         TQuRWnbOPnjLg==
X-Nifty-SrcIP: [209.85.214.177]
Received: by mail-pl1-f177.google.com with SMTP id e2so1433120pls.10;
        Wed, 09 Mar 2022 01:29:57 -0800 (PST)
X-Gm-Message-State: AOAM530XQQNkjEIj90aXVvAqxQowb/zaVXFeZ0wjO/SRzw4yxT4/dJDo
        eKQSaxNnIfK6uno75PkrrzvMm4BXjz1iRb0wgqw=
X-Google-Smtp-Source: ABdhPJzc8aP7snE9Ier6y4JJAKFK3/PD64bYVfxzp+1b47gYUv+R/6gaz0BM5wKcDEzUg6jYau3NZwheI8vd7fEoeDA=
X-Received: by 2002:a17:902:eb84:b0:151:f80e:e98b with SMTP id
 q4-20020a170902eb8400b00151f80ee98bmr10526055plg.99.1646818196448; Wed, 09
 Mar 2022 01:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20220304170813.1689186-1-nathan@kernel.org> <CAKwvOd=Q-7vPaRPj1wQagFsY3txcAKzrqU_D2UAX3h4ym91uUA@mail.gmail.com>
 <YieGARVP2dhn8tbQ@casper.infradead.org>
In-Reply-To: <YieGARVP2dhn8tbQ@casper.infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 9 Mar 2022 18:29:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQnAgOqd1Zr3R0KBuGJps8K+Z7PGH5av9nA-VpJwZ4MeQ@mail.gmail.com>
Message-ID: <CAK7LNAQnAgOqd1Zr3R0KBuGJps8K+Z7PGH5av9nA-VpJwZ4MeQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Make $(LLVM) more flexible
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, llvm@lists.linux.dev,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 9, 2022 at 1:36 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Mar 07, 2022 at 11:08:29AM -0800, Nick Desaulniers wrote:
> > > +``LLVM=0`` is not the same as omitting ``LLVM`` altogether, it will behave like
> > > +``LLVM=1``.
> >
> > Hmm... I can see someone's build wrappers setting LLVM=1, then them
> > being surprised that appending LLVM=0 doesn't disable LLVM=1 as they
> > might expect.  But Masahiro says let's fix this later which is fine.
>
> What happens if you say LLVM= instead of LLVM=0 ?  Would that "undo"
> a prior LLVM=1 and use GCC instead?

I think so.


-- 
Best Regards
Masahiro Yamada
