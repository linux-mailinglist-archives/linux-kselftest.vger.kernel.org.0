Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81B42047BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jun 2020 04:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbgFWC6s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 22:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731690AbgFWC6r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 22:58:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75528C061573
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 19:58:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r12so1565266wrj.13
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 19:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXi+ZPhOfi04UEldTn/C6lZw7iAKx1vkRfbVboyu5Z0=;
        b=Y3HOJcUYWQT1B2yupxS5EPA1NVpsex3gMAWe6SIbFh7bAvgDF0uBzQN6I/bkTGE/OB
         Gu8DKIv7rOKRPkkKD9Iba6bbTMsFaGiB1ebC7uZfytnVLiGAj3AyixHelJfe4ChL/y3s
         jCy0cr3BlqjdTezrgeEzGm1E+bvPhB78v+J8fFfQ/Cc14IDVVjWo1e1xCP/UHI6BKORS
         duqXl3Nc/ydmQws6UK1NZ8spaSbr8jiVeqV+YxO8BzCY0ACDgX5q+T44qgxEocQCYbfk
         c6GfLkrtiEshevPCtEWNWQiDGpGOt1DpuHu7k2HAHwdpJ1/QwrJZfHLqAmpnLGw0ZG9s
         7qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXi+ZPhOfi04UEldTn/C6lZw7iAKx1vkRfbVboyu5Z0=;
        b=KDfLyG9PXvtOHE2Ci7YYhd0oJQCMD0Ab2WJk/1ZrotUVulw+TlY9VBwsfb21HZJw7H
         xE5QkEkMO6IVPvG590+Zywm91Xienzoep/SIdiHn194N3AaWqUqbfXSKJtetaiDrZzKJ
         SuUBWx4V9u7iVO0zlgZRGTYP6WGo53RfHrPJrVvtrBuPuu9fhxewGGuDasL0RG/jqFHi
         hix7wDqalcjpoKH+EdIBz+r0VX4ATD8z6K810+QPeGtLFCqONLR5TD5pabZoCFE+m0qd
         y7KlzJ5935nqCj81FwuFhA9QTFmrJC20aLBCTjyvpXIl/bB8njJUtyZm7oatAC8+vvzc
         BJ0w==
X-Gm-Message-State: AOAM531AYoYSObmWOlvN6XgyKSWTpQI08/tW4josG5hNL9q6wAdiPx3b
        g9sQUBJUNNsIhy1+WqFiCmAQUgvPNToQsS8Me7cfUw==
X-Google-Smtp-Source: ABdhPJzzX/FACj8yCdz+hoPmTXjLPzc/aJfnbVwkEq7r5hSinTj1eUQC2ZstlXF36DK/MV9XiqivfcNA49+Ievk6AQ0=
X-Received: by 2002:a5d:5642:: with SMTP id j2mr15456656wrw.19.1592881124921;
 Mon, 22 Jun 2020 19:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook> <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <7161fadb-45ba-c4c0-8bbb-cb47d2dd0265@redhat.com> <dc853d83-649e-b652-819f-4766ea294d78@gmail.com>
 <CABVgOS=qSMY9xP7db4-hkSt71YKyPpJuQv=fqcfzV-kCC1k9qQ@mail.gmail.com> <5b4c248a-f8c9-0913-5280-8e436cdc5838@gmail.com>
In-Reply-To: <5b4c248a-f8c9-0913-5280-8e436cdc5838@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 23 Jun 2020 10:58:33 +0800
Message-ID: <CABVgOSm3E7hou1oA+Ua1N=NY=ZRRqm3+bKUuvcCqyVZ5-gWU=w@mail.gmail.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>, Kees Cook <keescook@chromium.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 20, 2020 at 11:03 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2020-06-20 01:44, David Gow wrote:
> > On Sat, Jun 20, 2020 at 1:58 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 2020-06-16 07:08, Paolo Bonzini wrote:
> >>> On 15/06/20 21:07, Bird, Tim wrote:
> >
> >>>>>> Finally,
> >>>>>>   - Should a SKIP result be 'ok' (TAP13 spec) or 'not ok' (current kselftest practice)?
> >>>>>> See https://testanything.org/tap-version-13-specification.html
> >>>>>
> >>>>> Oh! I totally missed this. Uhm. I think "not ok" makes sense to me "it
> >>>>> did not run successfully". ... but ... Uhhh ... how do XFAIL and SKIP
> >>>>> relate? Neither SKIP nor XFAIL count toward failure, though, so both
> >>>>> should be "ok"? I guess we should change it to "ok".
> >>>
> >>> See above for XFAIL.
> >>>
> >>> I initially raised the issue with "SKIP" because I have a lot of tests
> >>> that depend on hardware availability---for example, a test that does not
> >>> run on some processor kinds (e.g. on AMD, or old Intel)---and for those
> >>> SKIP should be considered a success.
> >>
> >> No, SKIP should not be considered a success.  It should also not be considered
> >> a failure.  Please do not blur the lines between success, failure, and
> >> skipped.
> >
>
>
> > I agree that skipped tests should be their own thing, separate from
> > success and failure, but the way they tend to behave tends to be
> > closer to a success than a failure.
> >
> > I guess the important note here is that a suite of tests, some of
> > which are SKIPped, can be listed as having passed, so long as none of
> > them failed. So, the rule for "bubbling up" test results is that any
> > failures cause the parent to fail, the parent is marked as skipped if
> > _all_ subtests are skipped, and otherwise is marked as having
> > succeeded. (Reversing the last part: having a suite be marked as
> > skipped if _any_ of the subtests are skipped also makes sense, and has
> > its advantages, but anecdotally seems less common in other systems.)
>
> That really caught my attention as something to be captured in the spec.
>
> My initial response was that bubbling up results is the domain of the
> test analysis tools, not the test code.

KUnit is actually sitting in the middle. Results are bubbled up from
individual tests to the test suites in-kernel (by the common KUnit
code), as the suites are TAP tests (individual test cases being
subtests), and so need to provide results. The kunit.py script then
bubbles those results up (using the same rules) to print a summary.

> If I were writing a test analysis tool, I would want the user to have
> the ability to configure the bubble up rules.  Different use cases
> would desire different rules.

I tend to agree: it'd be nice if test analysis tools could implement
different rules here. If we're using TAP subtests, though, the parent
tests do need to return a result in the test code, so either that
needs to be test-specific (if the parent test is not just a simple
union of its subtests), or it could be ignored by an analysis tool
which would follow its own rules. (In either case, it may make sense
to be able to configure a test analysis tool to always fail or mark
tests with failed or skipped subtests, even if its result is "ok", but
not vice-versa -- a test which failed would stay failed, even if all
its subtests passed.)

> My second response was to start thinking about whether the tests
> themselves should have any sort of bubble up implemented.  I think
> it is a very interesting question.  My current mindset is that
> each test is independent, and their is not a concept of an umbrella
> test that is the union of a set of subtests.  But maybe there is
> value to umbrella tests.  If there is a concept of umbrella tests
> then I think the spec should define how skip bubbles up.
>

KUnit suites are definitely that kind of "umbrella test" at the moment.

> >
> > The other really brave thing one could do to break from the TAP
> > specification would be to add a "skipped" value alongside "ok" and
> > "not ok", and get rid of the whole "SKIP" directive/comment stuff.
> > Possibly not worth the departure from the spec, but it would sidestep
> > part of the problem.
>
> I like being brave in this case.  Elevating SKIP to be a peer of
> "ok" and "not ok" provides a more clear model that SKIP is a first
> class citizen.  It also removes the muddled thinking that the
> current model promotes.
>
> >
> >
> > Cheers,
> > -- David
> >
>
