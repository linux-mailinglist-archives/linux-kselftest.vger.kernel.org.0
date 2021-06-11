Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62283A4B21
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jun 2021 01:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFKXT7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Jun 2021 19:19:59 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:41500 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhFKXT7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Jun 2021 19:19:59 -0400
Received: by mail-wr1-f52.google.com with SMTP id o3so7589524wri.8
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jun 2021 16:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4YyY/PB/1GkntMMtzmLiz3DtgMaIMXhAiGH6HC8ZVo=;
        b=fDx3Uoz4IG/+tvm194biC9tPPWvPp2f3UOuFoUQeFiDeKRIUv/Ew5J5v9bZg4kSjNO
         j9P+CbLti2o4hrh+17RvqqH//0Hx3Xq6Ylyrr8rbiM5nrRRabbASL76BhaHkXaBktkCl
         0j29DLRWhDXYuRMKSGth0Xea0LhU8rSNAe7iPHxEOd+pSYfbRfvj+xoSVqROCmvlSs3m
         yc1vd85ex23ndBeeS4CErZlBTJmwVXCH4zQfE6a0XNHaTCLJI0zojZVXFhiud8tWH1CD
         i8Zaj4tLb+qYYE3Dp/B8P420Jj8j9szhrJjUfBb7Nsu/9dCj9rqB0789dIIFG+R8mTTJ
         Bvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4YyY/PB/1GkntMMtzmLiz3DtgMaIMXhAiGH6HC8ZVo=;
        b=otfF5pJO70LOeiLgBbGygB7Mo78jtIReGSmzXuQgci9waXrMSa/pv+xok4yQabnD23
         48anhAJ4nQAVH9YwXA8ARbE0RNuHbOVGIGMDMoANwwkpRMITwW5id2694OGpmgtXEtRI
         sropv7BGRWRXMT2grjwBGZM2y20q9oOEoUMugg36gmwXR+LRWGdGNKTK3LX618QAdg2d
         ix+NWELnY3jVsXtWiMvqMLglJxKT6nrrRxRvW77w49BfXccFZC5q8VFbfftoKzdNndLY
         2edi1xY1aY4w3mzcfVpVZknGkNNbeP8lh2EqbS7o5K4ifTBAz0Gx3ctcwo1Yi9KR0zWM
         S5/g==
X-Gm-Message-State: AOAM533oauIIrR1W6bOl4k7/aj+YQ3g3dDCdXmCQFoYqD9ppk0y3rBYe
        OBC1ByQ6ZWEFNo1jaI+K0lXyeVvRs5t7A0mY55KlKg==
X-Google-Smtp-Source: ABdhPJwxqJm3qXI9tz8vyBmbA42h4M9e9EXZWhujK8jq5lMkvf3EvWYi+mivLXPs0W6Smv6aUw8wpY4s5WSJXbHR+jk=
X-Received: by 2002:a5d:474d:: with SMTP id o13mr6216624wrs.176.1623453420286;
 Fri, 11 Jun 2021 16:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210611035725.1248874-1-davidgow@google.com> <CANpmjNOvLz=71PXSi+LGvKZ+9b_rfY1+wp8HfeyZa8u2QZURcg@mail.gmail.com>
 <8a7e6806-97f5-6f13-5e97-328cf0d3a95d@linuxfoundation.org>
In-Reply-To: <8a7e6806-97f5-6f13-5e97-328cf0d3a95d@linuxfoundation.org>
From:   David Gow <davidgow@google.com>
Date:   Sat, 12 Jun 2021 07:16:49 +0800
Message-ID: <CABVgOSk5r3-m_dfF=tGUDo_hO=HWK=VbO42MHpbdM6n4oXjb+w@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix result propagation for parameterised tests
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 12, 2021 at 1:44 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 6/11/21 2:29 AM, Marco Elver wrote:
> > On Fri, 11 Jun 2021 at 05:57, David Gow <davidgow@google.com> wrote:
> >>
> >> When one parameter of a parameterised test failed, its failure would be
> >> propagated to the overall test, but not to the suite result (unless it
> >> was the last parameter).
> >>
> >> This is because test_case->success was being reset to the test->success
> >> result after each parameter was used, so a failing test's result would
> >> be overwritten by a non-failing result. The overall test result was
> >> handled in a third variable, test_result, but this was disacarded after
> >> the status line was printed.
> >>
> >> Instead, just propagate the result after each parameter run.
> >>
> >> Signed-off-by: David Gow <davidgow@google.com>
> >> Fixes: fadb08e7c750 ("kunit: Support for Parameterized Testing")
> >
> > Reviewed-by: Marco Elver <elver@google.com>
> >
> > Would Cc: stable be appropriate?
> >
> > Thanks,
> > -- Marco
> >
> >> ---
> >>
> >> This is fixing quite a serious bug where some test suites would appear
> >> to succeed even if some of their component tests failed. It'd be nice to
> >> get this into kunit-fixes ASAP.
> >>
>
> Will apply this with cc stable.
>

Thanks!

> >> (This will require a rework of some of the skip tests work, for which
> >> I'll send out a new version soon.)
> >>
>
> Thanks for the heads up. I will wait for new version.
>

Thanks: I've sent out v4 which fixes this:
https://lore.kernel.org/linux-kselftest/20210611070802.1318911-1-davidgow@google.com/

It's rebased on top of this patch, so depends on it, and also depends
on the first two patches in the "Do not typecheck binary assertions"
series:
https://lore.kernel.org/linux-kselftest/20210513193204.816681-1-davidgow@google.com/

> thanks,
> -- Shuah
