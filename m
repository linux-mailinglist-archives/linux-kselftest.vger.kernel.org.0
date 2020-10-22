Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2A7296676
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Oct 2020 23:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897561AbgJVVVw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 17:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503270AbgJVVVv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 17:21:51 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90EDC0613CF
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Oct 2020 14:21:51 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r10so1650405plx.3
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Oct 2020 14:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fySJoHhy5YXPAElLVamAnhk0uMbmYI/MuJ+gPrhlm5M=;
        b=aJrov6ao+8CE/Gun5k6QqQK1z7aQZZ8lKvbtdkftZTGDpMOIypCtDI2KauHPz0xAvd
         zDM0uWfpckROSxXz1Fz7eok7d7r26AdnAdiaYuYk0VwYQkNT0dKNUFTQlzu7Tsb4EKRH
         6M0VyHWhR/6rhgK2MNcQsBZeeFdVLUIm5BmweL4Z5nY08tlGJ18DnAWyQDQXF1lmeRpx
         P3A1ulvNdXaao3s1oMYrYfI8NQA4OH0nMfwsoPVuPd5dnf0PYbeBWh6wZReOU0H3rZ71
         LggDcqgJUFybk56ZG7lLOx+JAlGm5MZQdOci/UnMLxhRZ8nqF9rQsZdx1B4BowBiuV0D
         BAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fySJoHhy5YXPAElLVamAnhk0uMbmYI/MuJ+gPrhlm5M=;
        b=ZJC4KeB+/hnmAQ3sfLmkYA2LkaSQYCDosykKM4GAJrxaQRwx4m7anlT1qnnlJVV8JU
         R/tqdAH0JvnMeRki4dhLo42iEpMZ5Uh5sM8fqWwYV0/YblCky78ybfAZUI6S+aSVSqfm
         LE7/E2sTHJ6YoF95qqkVcB6mIJ5SP5vc9r6I3x4gOF/+mIRWBHeJiA98FmdmnQYEvMrU
         Cf5fayvIpjakY+LdNCx4YuV0zf2MyDdT1JFRPSBjQUJ44oxGBDdBmb0CTX1bNZQ22f2Z
         zY6IeOsVsMTI8PkPD+ho1cReTHZ4s3ytPurOycW7S5tsYGDzgMNDNy2hm7y0zmev9D4R
         ylaQ==
X-Gm-Message-State: AOAM531T0QqpWFJGt/ON1tBP9LbrmF855id61yL4YuLpduGOUiIT9Kbn
        aTpc0YM1Cm8MVA/SSy334uAsvwmysZILaYmLgzr0Hg==
X-Google-Smtp-Source: ABdhPJxXN4eVC1xO2hexMCghAZ0nThEQtIn2QS0/SNAo+/D8igL/3ibstbTSiZkDtq2Yp683TAYK+MhSfj8bEWTTYc8=
X-Received: by 2002:a17:902:ba96:b029:d5:f36b:44af with SMTP id
 k22-20020a170902ba96b02900d5f36b44afmr4237070pls.51.1603401711083; Thu, 22
 Oct 2020 14:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201019224556.3536790-1-dlatypov@google.com> <CABVgOS=Kucf3QV=jpo3cLDgG38WvnuKpzEdP_RkBtRwHHPLe3Q@mail.gmail.com>
 <CAGS_qxpX0Do+z-wzCC=twbt-htL=Jkqvrk4L4rKTtXFPfX-TCA@mail.gmail.com>
 <20201022150648.GH4077@smile.fi.intel.com> <CAFd5g45o2G-bUvHNk2ehNuCsK6zVjN+rp88TyNmuJpfLbQi07g@mail.gmail.com>
 <20201022190526.GN4077@smile.fi.intel.com>
In-Reply-To: <20201022190526.GN4077@smile.fi.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 22 Oct 2020 14:21:40 -0700
Message-ID: <CAFd5g46RBSgqujAbPSKasP5B6ufojHwTztvOWjSg3Lxk5QGHxw@mail.gmail.com>
Subject: Re: [PATCH] lib: add basic KUnit test for lib/math
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 22, 2020 at 12:04 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 22, 2020 at 11:53:50AM -0700, Brendan Higgins wrote:
> > On Thu, Oct 22, 2020 at 8:06 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Oct 21, 2020 at 10:47:50AM -0700, Daniel Latypov wrote:
>
> ...
>
> > > You need to put detailed comments in the code to have it as real example how to
> > > create the KUnit test. But hey, it will mean that documentation sucks. So,
> > > please update documentation to cover issues that you found and which motivated
> > > you to create these test cases.
> >
> > I don't entirely disagree; leaning too heavily on code examples can be
> > detrimental to docs. That being said, when I use other people's code,
> > I often don't even look at the docs. So, I think the ideal is to have
> > both.
>
> Why do we have docs in the first place?
> For test cases I think it's a crucial part, because tests many time are written
> by newbies, who would like to understand all under-the-hood stuff. You imply

Good point. Yeah, we don't really have any documentation that explains
the internals at all. I agree: we need to fix that.

> that they need to drop themselves into the code directly. It's very harsh to
> begin with Linux kernel development, really.

No, I was not trying to imply that everyone should just jump in the
code and ignore the docs. I was just trying to point out that some
people - myself included - rather see code than docs. Clearly some
people prefer docs over code as well. Thus, I was trying to argue that
both are appropriate.

Nevertheless, based on the other comments you sent, I don't think
that's what we are talking about: sounds like you just want us to
improve the docs first to make sure we do it. That's fine with me.

> > > Summarize this, please create usable documentation first.
>
> So, no go for this w/o documentation being up-to-date. Or be honest to
> everybody, it's sucks it needs to be removed. Then I will get your point.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
