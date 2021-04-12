Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD3735D28E
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Apr 2021 23:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244092AbhDLVXL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Apr 2021 17:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238118AbhDLVXL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Apr 2021 17:23:11 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEB2C061756
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 14:22:52 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t22so6740079ply.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 14:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qc1fPa7IFlg3yRWwAkYq3ylbLTApOWrjJOqQ54RWd64=;
        b=oRcZEe1WWNR1b4O5hgurPbe4eU1XlF0/6k+/lee5xmuEQz9haKqfpVbXUwQLJ+q99F
         xGABAeYVJupFfeLVp06b173aCjez+JAwmN/0QnIentA3ksTYcwVW8nSv4woTx3kVI9ga
         IwNbPLl6CRbX1Xdbb1q4Py/k8+sJs9vSxJi4Fp9KcPbwvAdfMB0aECppQNyjgPTwmrCc
         f4hUZZrpwQNA2dUPq6dKB8PjmgLLbgPjCEjaEjZlrFm3p7Y7/P+4quqJ40SmXZ51d3um
         3GqKGShj0rdvCtrlYbocN7TpsZwmumXXyIar1lnFR9Mn2z6pZFEMwagGjMgxFpxle+hP
         Kp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qc1fPa7IFlg3yRWwAkYq3ylbLTApOWrjJOqQ54RWd64=;
        b=DT5VLn7xUdVjkkMAniRibIJLgcmEiRZKZvoqXA+qI+Iuy0YlzcIOwNXe2IUGm2aFRB
         RltQUu96zbVpDi5q1mgoVTDWVxQsEiN5KtiHM01Rjyl0pbc03acA4DCs5ReFjNyj4RC0
         on3QhyTVeSo7sBGG2bt/GJlnGrdRkTJlV6yqlcs+IAJSaXIcEm2RQvn89ywzcz3opmE8
         Tm0cnpyW8vTpEpld29Z8vVI3tEcm7GrGFbT00KDB5VZtCwGufJzG3dthm5NdK251tjXK
         gH2JS55PnPijPvW8F5aD/idHHStLkr0W62StGOUHQYJR9YwgJFtOVluWVOF9dpBlHRUT
         SNUw==
X-Gm-Message-State: AOAM530G2O8MT0A84Jo+Kf2K+qMfRoURQjzfBjudwzPbSIky2Ayy6upk
        7XZHt28mWy+B4AqpTdAolseQY7afM/N0PdEdVYb8mQ==
X-Google-Smtp-Source: ABdhPJyA2f6SqLLY3zGFnnvodLQ3YF0yocUKXnqxcQEvWx+bcaFbkpivGsSjz/OiCyBZeCebMaFmErJsqAiYKrhdgyY=
X-Received: by 2002:a17:90a:c7d5:: with SMTP id gf21mr1196970pjb.80.1618262572057;
 Mon, 12 Apr 2021 14:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210410070529.4113432-1-davidgow@google.com> <CAGS_qxo=BCVfePBcN8NWSAb=htf4pdybcvQuGf2aaWMvfiQMsA@mail.gmail.com>
 <CANpmjNN0sZ1ZrvidqbYaabre_uL14dR0es0Y9Aogq3qyJ9aO2Q@mail.gmail.com>
In-Reply-To: <CANpmjNN0sZ1ZrvidqbYaabre_uL14dR0es0Y9Aogq3qyJ9aO2Q@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 12 Apr 2021 14:22:40 -0700
Message-ID: <CAFd5g46XH0SQUJ+e6C7ov=G-E+e8SkUsjM9iZisYKn7YxMBVTA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: dev-tools: Add Testing Overview
To:     Marco Elver <elver@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 12, 2021 at 3:43 AM Marco Elver <elver@google.com> wrote:
>
> On Sat, 10 Apr 2021 at 13:53, Daniel Latypov <dlatypov@google.com> wrote:
> > On Sat, Apr 10, 2021 at 12:05 AM David Gow <davidgow@google.com> wrote:
> [...]
> > > +
> > > +
> > > +Sanitizers
> > > +==========
> > > +
>
> The "sanitizers" have originally been a group of tools that relied on
> compiler instrumentation to perform various dynamic analysis
> (initially ASan, TSan, MSan for user space). The term "sanitizer" has
> since been broadened to include a few non-compiler based tools such as
> GWP-ASan in user space, of which KFENCE is its kernel cousin but it
> doesn't have "sanitizer" in its name (because we felt GWP-KASAN was
> pushing it with the acronyms ;-)). Also, these days we have HW_TAGS
> based KASAN, which doesn't rely on compiler instrumentation but
> instead on MTE in Arm64.
>
> Things like kmemleak have never really been called a sanitizer, but
> they _are_ dynamic analysis tools.
>
> So to avoid confusion, in particular avoid establishing "sanitizers"
> to be synonymous with "dynamic analysis" ("all sanitizers are dynamic
> analysis tools, but not all dynamic analysis tools are sanitizers"),
> the section here should not be called "Sanitizers" but "Dynamic
> Analysis Tools". We could have a subsection "Sanitizers", but I think
> it's not necessary.
>
> > > +The kernel also supports a number of sanitizers, which attempt to detect
> > > +classes of issues when the occur in a running kernel. These typically
> >
> > *they occur
> >
> > > +look for undefined behaviour of some kind, such as invalid memory accesses,
> > > +concurrency issues such as data races, or other undefined behaviour like
> > > +integer overflows.
> > > +
> > > +* :doc:`kmemleak` (Kmemleak) detects possible memory leaks.
> > > +* :doc:`kasan` detects invalid memory accesses such as out-of-bounds and
> > > +  use-after-free errors.
> > > +* :doc:`ubsan` detects behaviour that is undefined by the C standard, like
> > > +  integer overflows.
> > > +* :doc:`kcsan` detects data races.
> > > +* :doc:`kfence` is a low-overhead detector of memory issues, which is much
> > > +  faster than KASAN and can be used in production.
> >
> > Hmm, it lives elsewhere, but would also calling out lockdep here be useful?
> > I've also not heard anyone call it a sanitizer before, but it fits the
> > definition you've given.
> >
> > Now that I think about it, I've never looked for documentation on it,
> > is this the best page?
> > https://www.kernel.org/doc/html/latest/locking/lockdep-design.html
>
> Not a "sanitizer" but our sanitizers are all dynamic analysis tools,
> and lockdep is also a dynamic analysis tool.
>
> If we want to be pedantic, the kernel has numerous options to add
> "instrumentation" (compiler based or explicit) that will detect some
> kind of error at runtime. Most of them live in lib/Kconfig.debug. I
> think mentioning something like that is in scope of this document, but
> we certainly can't mention all debug tools the kernel has to offer.
> Mentioning the big ones like above and then referring to
> lib/Kconfig.debug is probably fine.
>
> Dmitry recently gave an excellent talk on some of this:
> https://www.youtube.com/watch?v=ufcyOkgFZ2Q

Good point Marco, and we (KUnit - myself, Daniel, and David) gave a
talk on KUnit at LF. Also, I think Shuah is/has given one (soon)?
Might be a good idea to link those here?
