Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245BB35FF37
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Apr 2021 03:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhDOBUT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Apr 2021 21:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhDOBUS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Apr 2021 21:20:18 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451B7C06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Apr 2021 18:19:51 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r8so36235003lfp.10
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Apr 2021 18:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wWj5r8K+b2y8jPccyFlj/HjStlsD2875PmIiZru4XIw=;
        b=h9dCjQApzgJVCTtN4ukr7huGAYA2os7egzwY7BWQqcjeUMP4G2Wu/jIA4jLYE9IEaT
         7d0n+ZLWnwJMG1ewRES6dWccakaMHmNVc/e2qpbbm1Ayf9mT2aS89DMKRSbAou+ixe3F
         66WxKqr0lP2gW21vpas0MTduVFTcK4eVjxFJC+kO0NwEgIqAioxpuBOUYPIA1mhsv725
         ulNsSaaVviIZBTbX0C2ddh8J+51yYLF46Rakcte8JuAmsf6RyJraDX+SXhyI1xBfXKXV
         FGqSugavjcc0LgZVHSTgjHHkp+KSl+gSapLLBBdtj4b5TiD8Wj4UyAd/o/qFYq77h/hT
         6XHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wWj5r8K+b2y8jPccyFlj/HjStlsD2875PmIiZru4XIw=;
        b=c1JhGqWVfHBFrE7cfpMjqmdomGIA45cEULumqcfNGUis5dR9PSAly5/CYPA7+CKx/+
         t7clbKCWq9csHBOmaV/Ww31tx1PgGJ1OZptDRcy8A4XyoTnbM8peh5HSF6XSzSg6JgMZ
         71THEiworJG0HOHLpny8+VKWGOwwH2zBI3+OeywIElf0LDB1kz+FMog9KkDt7KG4TF/a
         QCn5bV1stQ+FhQH9n3hrTj7wwS5SA1uZPYMzlUaxnw4uQaZ2m0ZLlgs5CbxTWSSPxcOa
         94tDPFIVvrJIzLF8/cYVcAl+VgpquvDmKaGgdnBQ2nijoCmh7xn3xc2M6dKG+oG3DUYy
         E6DQ==
X-Gm-Message-State: AOAM531a/Zj+ujp3cI7F29GdClfEqwgqwxgHY5k0jzWYq2nzCe7QpjUM
        p8BLp5675eWxmfsLR0axoEQpaos0lG/UEO0X15v2dA==
X-Google-Smtp-Source: ABdhPJwa1DEB3yQFlcc2QsEJ5RGzqq2frKXJ7CpoH1stM4dLHqyCwogELgZzlI1wQUka6alSXe/Vud1zkTtUVkskcdE=
X-Received: by 2002:a19:f802:: with SMTP id a2mr664651lff.545.1618449589203;
 Wed, 14 Apr 2021 18:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210414081428.337494-1-davidgow@google.com> <CAGS_qxryjASsRy9Ozox8UXx1=9PittUs=WmkO7=QpWt9HrLj7A@mail.gmail.com>
In-Reply-To: <CAGS_qxryjASsRy9Ozox8UXx1=9PittUs=WmkO7=QpWt9HrLj7A@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 15 Apr 2021 09:19:36 +0800
Message-ID: <CABVgOSmOzex8jJQzjzjnd+gPLaFHZFy6ifugsAxq+PGr-tvH6A@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: dev-tools: Add Testing Overview
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 15, 2021 at 12:30 AM Daniel Latypov <dlatypov@google.com> wrote=
:
>
> On Wed, Apr 14, 2021 at 1:15 AM David Gow <davidgow@google.com> wrote:
> >
> > The kernel now has a number of testing and debugging tools, and we've
> > seen a bit of confusion about what the differences between them are.
> >
> > Add a basic documentation outlining the testing tools, when to use each=
,
> > and how they interact.
> >
> > This is a pretty quick overview rather than the idealised "kernel
> > testing guide" that'd probably be optimal, but given the number of time=
s
> > questions like "When do you use KUnit and when do you use Kselftest?"
> > are being asked, it seemed worth at least having something. Hopefully
> > this can form the basis for more detailed documentation later.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
>
> Looks good to me. Some minor typos and nits about wording here and there.
>

Thanks: I'll send out v3 with some fixes to your suggestions soon.

Cheers,
-- David

> > ---
> > Thanks, everyone, for the comments on the doc. I've made a few of the
> > suggested changes. Please let me know what you think!
> >
> > -- David
> >
> > Changes since v1:
> > https://lore.kernel.org/linux-kselftest/20210410070529.4113432-1-davidg=
ow@google.com/
> > - Note KUnit's speed and that one should provide selftests for syscalls
> > - Mention lockdep as a Dynamic Analysis Tool
> > - Refer to "Dynamic Analysis Tools" instead of "Sanitizers"
> > - A number of minor formatting tweaks and rewordings for clarity.
> >
> > Not changed:
> > - I haven't included an exhaustive list of differences, advantages, etc=
,
> >   between KUnit and kselftest: for now, the doc continues to focus on
> >   the difference between 'in-kernel' and 'userspace' testing here.
> > - Similarly, I'm not linking out to docs defining and describing "Unit"
> >   tests versus "End-to-end" tests. None of the existing documentation
> >   elsewhere quite matches what we do in the kernel perfectly, so it
> >   seems less confusing to focus on the 'in-kernel'/'userspace'
> >   distinction, and leave other definitions as a passing mention for
> >   those who are already familiar with the concepts.
> > - I haven't linked to any talk videos here: a few of them are linked on
> >   (e.g.) the KUnit webpage, but I wanted to keep the Kernel documentati=
on
> >   more self-contained for now. No objection to adding them in a follow-=
up
> >   patch if people feel strongly about it, though.
> > - The link from index.rst to this doc is unchanged. I personally think
> >   that the link is prominent enough there: it's the first link, and
> >   shows up a few times. One possibility if people disagreed would be to
> >   merge this page with the index, but given not all dev-tools are going
> >   to be testing-related, it seemed a bit arrogant. :-)
> >
> >  Documentation/dev-tools/index.rst            |   3 +
> >  Documentation/dev-tools/testing-overview.rst | 117 +++++++++++++++++++
> >  2 files changed, 120 insertions(+)
> >  create mode 100644 Documentation/dev-tools/testing-overview.rst
> >
> > diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tool=
s/index.rst
> > index 1b1cf4f5c9d9..f590e5860794 100644
> > --- a/Documentation/dev-tools/index.rst
> > +++ b/Documentation/dev-tools/index.rst
> > @@ -7,6 +7,8 @@ be used to work on the kernel. For now, the documents h=
ave been pulled
> >  together without any significant effort to integrate them into a coher=
ent
> >  whole; patches welcome!
> >
> > +A brief overview of testing-specific tools can be found in :doc:`testi=
ng-overview`.
> > +
> >  .. class:: toc-title
> >
> >            Table of contents
> > @@ -14,6 +16,7 @@ whole; patches welcome!
> >  .. toctree::
> >     :maxdepth: 2
> >
> > +   testing-overview
> >     coccinelle
> >     sparse
> >     kcov
> > diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentati=
on/dev-tools/testing-overview.rst
> > new file mode 100644
> > index 000000000000..ce36a8cdf6b5
> > --- /dev/null
> > +++ b/Documentation/dev-tools/testing-overview.rst
> > @@ -0,0 +1,117 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Kernel Testing Guide
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +
> > +There are a number of different tools for testing the Linux kernel, so=
 knowing
> > +when to use each of them can be a challenge. This document provides a =
rough
> > +overview of their differences, and how they fit together.
> > +
> > +
> > +Writing and Running Tests
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +The bulk of kernel tests are written using either the kselftest or KUn=
it
> > +frameworks. These both provide infrastructure to help make running tes=
ts and
> > +groups of tests easier, as well as providing helpers to aid in writing=
 new
> > +tests.
> > +
> > +If you're looking to verify the behaviour of the Kernel =E2=80=94 part=
icularly specific
> > +parts of the kernel =E2=80=94 then you'll want to use KUnit or kselfte=
st.
> > +
> > +
> > +The Difference Between KUnit and kselftest
> > +------------------------------------------
> > +
> > +KUnit (Documentation/dev-tools/kunit/index.rst) is an entirely in-kern=
el system
> > +for "white box" testing: because test code is part of the kernel, it c=
an access
> > +internal structures and functions which aren't exposed to userspace.
> > +
> > +KUnit tests therefore are best written against small, self-contained p=
arts
> > +of the kernel, which can be tested in isolation. This aligns well with=
 the
> > +concept of 'unit' testing.
> > +
> > +For example, a KUnit test might test an individual kernel function (or=
 even a
> > +single codepath through a function, such as an error handling case), r=
ather
> > +than a feature as a whole.
> > +
> > +This also makes KUnit tests very fast to build and run, allowing them =
to be
> > +run frequently as part of the development process.
> > +
> > +There is a KUnit test style guide which may give further pointers in
> > +Documentation/dev-tools/kunit/style.rst
> > +
> > +
> > +kselftest (Documentation/dev-tools/kselftest.rst), on the other hand, =
is
> > +largely implemented in userspace, and tests are normal userspace scrip=
ts or
> > +programs.
> > +
> > +This makes it easier to write more complicated tests, or tests which n=
eed to
> > +manipulate the overall system state more (e.g., spawning processes, et=
c.).
> > +However, it's not possible to call kernel functions directly from ksel=
ftest.
> > +This means that only kernel functionality which is exposed to userspac=
e somhow
>
> *s/somhow/somehow
>

Whoops: fixed.

> > +(e.g. by a syscall, device, filesystem, etc.) can be tested with kself=
test.  To
> > +work around this, some tests include a companion kernel module which e=
xposes
> > +more information or functionality. If a test runs mostly or entirely w=
ithin the
> > +kernel, however,  KUnit may be the more appropriate tool.
>
> I like this slightly tweaked wording better, thanks.
> Still might be a bit confusing for a reader to see "it's not possible"
> =3D> "it's possible if you have a companion module," but I'm happy
> enough with it as-is.
>

Yeah: I experimented a bit with a couple of other ways to word this,
but it's difficult to find a succinct way of describing that it isn't
possible from a purely-userspace test, but that a workaround exists
and is used. This is what I ended up with, but I'm happy to change it
further (or see it changed in a follow-up) if someone has a brilliant
turn of phrase for it. :-)

> > +
> > +kselftest is therefore suited well to tests of whole features, as thes=
e will
> > +expose an interface to userspace, which can be tested, but not impleme=
ntation
> > +details. This aligns well with 'system' or 'end-to-end' testing.
> > +
> > +For example, all new system calls should be accompanied by kselftest t=
ests.
> > +
> > +Code Coverage Tools
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The Linux Kernel supports two different code coverage measurement tool=
s. These
> > +can be used to verify that a test is executing particular functions or=
 lines
> > +of code. This is useful for determining how much of the kernel is bein=
g tested,
> > +and for finding corner-cases which are not covered by the appropriate =
test.
> > +
> > +:doc:`gcov` is GCC's coverage testing tool, which can be used with the=
 kernel
> > +to get global or per-module coverage. Unlike KCOV, it does not record =
per-task
> > +coverage. Coverage data can be read from debugfs, and interpreted usin=
g the
> > +usual gcov tooling.
> > +
> > +:doc:`kcov` is a feature which can be built in to the kernel to allow
> > +capturing coverage on a per-task level. It's therefore useful for fuzz=
ing and
> > +other situations where information about code executed during, for exa=
mple, a
> > +single syscall is useful.
> > +
> > +
> > +Dynamic Analysis Tools
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The kernel also supports a number of dynamic analysis tools, which att=
empt to
> > +detect classes of issues when the occur in a running kernel. These typ=
ically
>
> *s/the occur/they occur
>

Whoops: fixed.

> > +look for undefined behaviour of some kind, such as invalid memory acce=
sses,
>
> nit: "look for undefined behaviour of some kind"
> Given that I think most readers will interpret UB in the sense that C
> uses it, this might be a bit misleading. E.g. lockdep errors aren't UB
> in that sense.
>
> Perhaps we can reword this to "look for invalid behaviour" or even
> just "look for bugs"
>

I've reworded this to say that each tool "looks for a different class of bu=
gs".

> > +concurrency issues such as data races, or other undefined behaviour li=
ke
> > +integer overflows.
> > +
> > +Some of these tools are listed below:
> > +
> > +* kmemleak detects possible memory leaks. See
> > +  Documentation/dev-tools/kmemleak.rst
> > +* KASAN detects invalid memory accesses such as out-of-bounds and
> > +  use-after-free errors. See Documentation/dev-tools/kasan.rst
> > +* UBSAN detects behaviour that is undefined by the C standard, like in=
teger
> > +  overflows. See Documentation/dev-tools/ubsan.rst
> > +* KCSAN detects data races. See Documentation/dev-tools/kcsan.rst
> > +* KFENCE is a low-overhead detector of memory issues, which is much fa=
ster than
> > +  KASAN and can be used in production. See Documentation/dev-tools/kfe=
nce.rst
> > +* lockdep is a locking correctness validator. See
> > +  Documentation/locking/lockdep-design.rst
> > +* There are several other pieces of debug instrumentation in the kerne=
l, many
> > +  of which can be found in lib/Kconfig.debug
> > +
> > +These tools tend to test the kernel as a whole, and do not "pass" like
> > +kselftest or KUnit tests. They can be combined with KUnit or kselftest=
 by
> > +running tests on a kernel with a sanitizer enabled: you can then be su=
re
>
> nit: we refer to "sanitizers" again, I assume this needs to be updated as=
 well?
>

Yeah: I missed this one: it now just refers to "tools".

> > +that none of these errors are occurring during the test.
> > +
> > +Some of these tools integrate with KUnit or kselftest and will
> > +automatically fail tests if an issue is detected.
> > +
> > --
> > 2.31.1.295.g9ea45b61b8-goog
> >
