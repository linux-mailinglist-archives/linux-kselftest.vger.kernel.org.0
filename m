Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31062350FA
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Aug 2020 09:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgHAHRu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Aug 2020 03:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHAHRt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Aug 2020 03:17:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354B4C06174A
        for <linux-kselftest@vger.kernel.org>; Sat,  1 Aug 2020 00:17:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so29820089wrw.1
        for <linux-kselftest@vger.kernel.org>; Sat, 01 Aug 2020 00:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TWNF9js53PcdlvlEQGLSj775mBS94SUQ30AaksVxoQ=;
        b=VO0K6ryau/F3M3Dq1GKbT+Ju+3xjYUSKkECGfWdRqLobEciqL0RcUz4/iC4W8lVZ1q
         QA65GiZKQRJr/myRRsw4n89yDhKQQOONOJwQnTjs+pu3xamfaa5Ztrhg1KJ7WQ6hqxwT
         HpvI5KkYtiS+X3q/w9LUpob+E8OmwtQpPwY41OJOatDMZ4FJ2ajQnBJeHFXQEI2IBXM7
         MDUn65w+5blACPpkaQSuWTxoz6eBj+Z525rXmhOva11Ma9iXX49xrtd/jnFAqRdGvaJV
         bwnx1R+Q4aZqlB/MlC6CMAFZqmfYn0i6aTCn07ZkMzdpUVfq9VE49aHj6u4s5Br5Zexc
         mwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TWNF9js53PcdlvlEQGLSj775mBS94SUQ30AaksVxoQ=;
        b=VCLMJvI0kNnHKeiqzzgZtN0nugyalOnrmHTFc3wy60n72bJdHgUfxAs3t0fJ7M6f58
         C2NvRmpCA8lYKeFLYot6EuLVnIiwCPeV0FEOBytB8qNRLQUChtN4enL21ryffdZt8Jtc
         XnJ2MDjiYpVLa9Mbyl3PSdR0qk/DF42FNrQCp1g7vrXPUct/lkPK9Sx4rz8znYP6gqga
         gb2JTRLESmjjrR68TjPV9O1KSedD/8YfGqzm7MYjXhjoyX3sUlwL2oWmR71sJxgDWGzo
         k+2Lp83392kXSW1IZcb9CZ2efWLnDYGw5mbxMQ9lZAsDP4kUdmjuwM4nSiDQhJS712TZ
         tjVA==
X-Gm-Message-State: AOAM532P0EZjOffUCcswVXq68Zftx9Lbj671VXCQmRNO5HMHZunVKz7U
        soXV2lNXfA94SDdDn53TkLgiXS1UuC4ddmaxlaKRZA==
X-Google-Smtp-Source: ABdhPJzq/rzZHdZ2pAKBHdqSrbybtRNlexfh0RgiZS1svnsLG/Wioiod4eAFn6JHc7/uJob0VxLcIqfDs+pDzu5POMw=
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr6436942wru.19.1596266267633;
 Sat, 01 Aug 2020 00:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200731044242.1323143-1-davidgow@google.com> <CAAeHK+z0wJ-3+dXey9o3zysy9fPOqk-YdFFtVOB5==WcG3B8+Q@mail.gmail.com>
In-Reply-To: <CAAeHK+z0wJ-3+dXey9o3zysy9fPOqk-YdFFtVOB5==WcG3B8+Q@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 1 Aug 2020 15:17:36 +0800
Message-ID: <CABVgOSnFanyCtBFaFAdrArr+hkXCdNu5vCNmciLP0ftQRgAsXQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] KASAN-KUnit Integration
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 31, 2020 at 9:25 PM 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Fri, Jul 31, 2020 at 6:43 AM David Gow <davidgow@google.com> wrote:
> >
> > This patchset contains everything needed to integrate KASAN and KUnit.
> >
> > KUnit will be able to:
> > (1) Fail tests when an unexpected KASAN error occurs
> > (2) Pass tests when an expected KASAN error occurs
> >
> > Convert KASAN tests to KUnit with the exception of copy_user_test
> > because KUnit is unable to test those.
> >
> > Add documentation on how to run the KASAN tests with KUnit and what to
> > expect when running these tests.
> >
> > This patchset depends on:
> > - "kunit: extend kunit resources API" [1]
> >  - This is already present in the kselftest/kunit branch
> >
> > I'd _really_ like to get this into 5.9 if possible: we also have some
> > other changes which depend on some things here.
>
> Hi David,
>
> You'll need to rebase this on top of the mm tree, which currently
> contains Walter's patch titled "kasan: fix KASAN unit tests for
> tag-based KASAN".
>
> There's also another patch that touches KASAN tests in the series I've
> just mailed titled "kasan: support stack instrumentation for tag-based
> mode".
>
> Thanks!
>

I've rebased this on top of a linux-next (with the pending KUnit
patches from kselftest/kunit and the "kasan: support stack
instrumentation for tag-based mode" patchset applied):
https://lore.kernel.org/linux-kselftest/20200801070924.1786166-1-davidgow@google.com/T/#u

Note that the RCU test doesn't seem to be compatible with KUnit's
KASAN integration at present: I'm no expert on RCU, but it looks like
the current test context might not be propagated to the callback, so
expecting the failure doesn't work. Given that KUnit also doesn't look
for the aux stacks (just that a failure occurred), it seemed best to
avoid trying to port that one to KUnit, so I've left it in the
test_kasan_module.c file. It may be possible to port it at a later
date.

Note that I don't have an arm64 setup here, so I haven't actually
tested the tag-based KASAN stuff yet.

Cheers,
-- David
