Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D2242C9C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Oct 2021 21:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhJMTSs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 15:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbhJMTSr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 15:18:47 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE34C061570
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Oct 2021 12:16:44 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id m20so957907iol.4
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Oct 2021 12:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=es9WSp6Pqy9K5HCY+DO0ug/YfkVtqR6t1QNl791AIg4=;
        b=fPwr3R13gEOToRuQvqIKANYni462MUdHsINsuv1LEzI4ApR8Oye+lXQR2EzKrKonQK
         IwgeoVMxj9x/0GzGXE9intqQbxuvarYGY5hXqgthKnfAjUROHlCvhr6G7oEV2E5rxcnh
         mZ2zHPAcCaK6ZZ6D2p5J/zBdrS+13eiJg7bg66ZYfwrrb38cqM9e1tjNECO/Q3oO8B3i
         MDww7X4g7T+TZtr12sGiRaTC+lYbWcrb2kSqiwR73ICYYA7UsxDAv9nNH+6EP4svmVga
         T4fOOoPurHfDEaOMhVJAz/1ThiKdZ1uD/XcQntKsbRng+khKFuxRG8ExmWtOn8opVKHp
         lVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=es9WSp6Pqy9K5HCY+DO0ug/YfkVtqR6t1QNl791AIg4=;
        b=jJPXsNEvJ2b+OHlHntGTM1UvAg6aFxzkSNLpuDM9f6eRUd0QnP7q2Qny+IoQlhDaGI
         4WUuaNWS8pzMYwKbZ8tlM96TWDVCRhzlCYW52S/TPxxMjYcV7aADdxlQ0AoT8ORo0Zv9
         MStLwFoUlG6do28voo+Inbsir89/kJq4613Jln4eSKh7d60d2vZu0dfLeCSe4OznvneL
         bYR0ahSe+KFUxqFsCYPFxYSCqdVp737qnYwG8P5eHyd0LSqhPzNCCmk7JiHYX8dbEddj
         /A0OoHYHPu7Xuw+PsvVy3roYlQ43IVcv+/prQSuffWV8fR77M1YAPmUR9n0RI2N57db1
         v+4Q==
X-Gm-Message-State: AOAM531oD+Nkp95qm/S2F1+ZRx1Bd26lTs4YJ09dbLMhf6yGeS0Ht4KI
        1o/Gpp2GHAPCNVHIO1EYCBa5gv8JX8zgYo7KihlrVz0/iYc=
X-Google-Smtp-Source: ABdhPJwvqoHcsJoaIcnbFaTCAcX0xHrjhW8//IUoRvzpsrd5Q+MBPxjidO83ad9x41CpME0GIGohjo2TP9OqM09s5H0=
X-Received: by 2002:a05:6638:34ac:: with SMTP id t44mr929001jal.104.1634152603250;
 Wed, 13 Oct 2021 12:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211002022656.1681956-1-jk@codeconstruct.com.au>
 <CABVgOS=F9K_AzoWjKPRT9m014NAo37vKHYEp-jHWDt5M+pkzSw@mail.gmail.com>
 <101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au>
 <CABVgOSmOFtYMiHWKTbbXST00pbYE88eu3DagD8pHt5=QdmCqyg@mail.gmail.com>
 <de7b75062fbc19824111685a9b8119545ee83e35.camel@codeconstruct.com.au>
 <CABVgOS=evHzhP5k9EshZM4MG+Zt9qDwn11tf2Q7EaYgVwdWGOQ@mail.gmail.com> <CAGS_qxo5Esn6jzgtp1THAWgHC_pPXfYwNigfPVGD_q2mkHNtwQ@mail.gmail.com>
In-Reply-To: <CAGS_qxo5Esn6jzgtp1THAWgHC_pPXfYwNigfPVGD_q2mkHNtwQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 13 Oct 2021 12:16:30 -0700
Message-ID: <CAGS_qxoC3FgFR4YEmtVwXALbBuoi_a2NWCaGpWzU+GJMCfPWwg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mctp: test: disallow MCTP_TEST when building
 as a module
To:     David Gow <davidgow@google.com>
Cc:     Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 12, 2021 at 1:27 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Mon, Oct 11, 2021 at 9:38 PM David Gow <davidgow@google.com> wrote:
> >
> > On Mon, Oct 11, 2021 at 10:10 AM Jeremy Kerr <jk@codeconstruct.com.au> wrote:
> > >
> > > Hi David,
> > >
> > > > In any case, thanks a lot -- this is awesome.
> > >
> > > Oh neat, glad it's useful!
>
> +1
>
> > >
> > > I'm happy to keep hacking on this if it's in a direction that makes
> > > sense for kunit in general. As an approximate plan, I can fix the UML
> > > breakages, then work on some resulting simplifications for tree-wide
> > > initialisers (we'd no longer need the null-terminated arrays of suites
> > > everywhere, for example).
>
> Getting rid of the arrays of arrays of suites sounds great to me.
>
> I could also pick that bit up, since I'm the person who most recently
> added code that depends on it:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=3b29021ddd10cfb6b2565c623595bd3b02036f33

I made the executor internally flatten the array-of-arrays into just
an array to flush out the changes we'd need to make.
I've sent that here:
https://lore.kernel.org/linux-kselftest/20211013191320.2490913-1-dlatypov@google.com

After doing it and seeing the diffstat (2 files changed, 85
insertions(+), 178 deletions(-)), I'm actually tempted to have that go
in as an actual patch.

When we rework the kunit_test_suites section, we could then just drop
the flattening helper function.

>
> > >
> > +dlatypov, +kunit-dev
> >
> > Yeah, we think this would be a much better direction for KUnit to go
> > for modules. If you're happy to work on it, that'd be great! Brendan,
> > Daniel (CCed), and I would be more than willing to help out with
> > questions, reviews, etc, as well.
> >
> > On the other hand, if you're really busy and you'd rather we pick this
> > up, improved module support has been on the to-do list for ages, so we
> > could bump it up the list a bit and finish it off.
> >
> > The UML breakages were mostly pretty simple: our default config
> > doesn't require module support at all, so the various functions should
> > just need to go behind the appropriate #ifdefs. A quick way to test it
> > is just to run './tools/testing/kunit/kunit.py run' from the kernel
> > source directory, which will configure, build, and run everything in
> > the .kunit builddir.
> >
> > Cheers,
> > -- David
