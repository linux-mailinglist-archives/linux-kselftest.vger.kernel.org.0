Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5503E35F0F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Apr 2021 11:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhDNJkR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Apr 2021 05:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhDNJkP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Apr 2021 05:40:15 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD5AC061574
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Apr 2021 02:39:53 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id h3-20020a4ae8c30000b02901b68b39e2d3so4479919ooe.9
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Apr 2021 02:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h6merFAI8nWuQUtaPMgNZzm0Zs+GfD/helzkO3aNm6M=;
        b=Gpi0MuCR1W1QhfNJMyeuLEMzdGv2u9cUgcQKDLr2A2Z7SlRIk59djZP/Zf2H2SyFPx
         3VEVmAZd++akAu43BavcVWFhv9+DDOwmy/w75/C8gJu84rvaeDKX3u8PRUDObn13vjsQ
         EH0FugmPO04mpdbLrUyBhZezJXw8AmazdE4oNGrziKL2NBpWqW6axbhhveuM8DG10Z5w
         HvxLjD53Swn9y2BGDbZ20Ln0jlLgm+eV5Jyyiq6JMc7yimjZlApDjq2kQY+nRW4ZrP9J
         WYCO3nUgu1Fa/EVFWIVYKC3JXOSWIFw6Sbd5W3br/yYvm/xOc2xatsMsVkwwKp2sZ2yR
         z5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h6merFAI8nWuQUtaPMgNZzm0Zs+GfD/helzkO3aNm6M=;
        b=brmdkCMGutEwRA0/3dpnIVnDME/WMNyym/9Ty2uDyOdZUbJe6yVRI9WbDF3k3nkfa8
         aA4jgkMh23RbkJ3iRm0upkV4HeqZI4tExQV7p+2kYCtXCXFuTKzQSd0T6fNjOxOXdUpH
         mAUXmlb5cvRM9n7zgncWkJuRTQxvnZInn8CnhmdHKXOI+F839eznJWtthwHo8gYA08i9
         LZALCfMzeRSvZeez7VYGUj/t1IOvkylmShWj7lVNEKGa4q+ga/ElZ4aijoWq3uZBnX7U
         0ZXrwKft7vo5JYnCqrriuwf9++9RTeFVyoXXQXn35gE5okpqO6Xi1PuN0/SOufXpmX2P
         l4KA==
X-Gm-Message-State: AOAM53098oIHXB7Ahaxx3FRRY0W1Wjka2dASYjuJISSMvm+PMIz3pLiC
        DZNy7u7N7kSl7WOJbXmvHbDohp4zDRBGi6JNQGlDXw==
X-Google-Smtp-Source: ABdhPJwP+m7PQ2KqWNLVMQtbp6TPlsLhusBZ0RCccTszTcZThlUiM1pmE6bpAXBBzKEcpDp9Xu+2/Ec/7YpA8CYjwrY=
X-Received: by 2002:a4a:d0ce:: with SMTP id u14mr30250246oor.36.1618393192568;
 Wed, 14 Apr 2021 02:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210414081428.337494-1-davidgow@google.com>
In-Reply-To: <20210414081428.337494-1-davidgow@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 14 Apr 2021 11:39:39 +0200
Message-ID: <CANpmjNNWQZGOCiNQaTWr5ebh7jp7TMzTp0OXnss_5xpRP9GvSw@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: dev-tools: Add Testing Overview
To:     David Gow <davidgow@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 14 Apr 2021 at 10:15, David Gow <davidgow@google.com> wrote:
>
> The kernel now has a number of testing and debugging tools, and we've
> seen a bit of confusion about what the differences between them are.
>
> Add a basic documentation outlining the testing tools, when to use each,
> and how they interact.
>
> This is a pretty quick overview rather than the idealised "kernel
> testing guide" that'd probably be optimal, but given the number of times
> questions like "When do you use KUnit and when do you use Kselftest?"
> are being asked, it seemed worth at least having something. Hopefully
> this can form the basis for more detailed documentation later.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Marco Elver <elver@google.com>

Looks good to me, thanks. I think one can write whole articles (or
even books) about this topic, so it's easy to forget this is a quick
overview, and keep on adding.

> ---
> Thanks, everyone, for the comments on the doc. I've made a few of the
> suggested changes. Please let me know what you think!
>
> -- David
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20210410070529.4113432-1-davidgow=
@google.com/
> - Note KUnit's speed and that one should provide selftests for syscalls
> - Mention lockdep as a Dynamic Analysis Tool
> - Refer to "Dynamic Analysis Tools" instead of "Sanitizers"
> - A number of minor formatting tweaks and rewordings for clarity.
>
> Not changed:
> - I haven't included an exhaustive list of differences, advantages, etc,
>   between KUnit and kselftest: for now, the doc continues to focus on
>   the difference between 'in-kernel' and 'userspace' testing here.
> - Similarly, I'm not linking out to docs defining and describing "Unit"
>   tests versus "End-to-end" tests. None of the existing documentation
>   elsewhere quite matches what we do in the kernel perfectly, so it
>   seems less confusing to focus on the 'in-kernel'/'userspace'
>   distinction, and leave other definitions as a passing mention for
>   those who are already familiar with the concepts.
> - I haven't linked to any talk videos here: a few of them are linked on
>   (e.g.) the KUnit webpage, but I wanted to keep the Kernel documentation
>   more self-contained for now. No objection to adding them in a follow-up
>   patch if people feel strongly about it, though.
> - The link from index.rst to this doc is unchanged. I personally think
>   that the link is prominent enough there: it's the first link, and
>   shows up a few times. One possibility if people disagreed would be to
>   merge this page with the index, but given not all dev-tools are going
>   to be testing-related, it seemed a bit arrogant. :-)
>
>  Documentation/dev-tools/index.rst            |   3 +
>  Documentation/dev-tools/testing-overview.rst | 117 +++++++++++++++++++
>  2 files changed, 120 insertions(+)
>  create mode 100644 Documentation/dev-tools/testing-overview.rst
>
> diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/=
index.rst
> index 1b1cf4f5c9d9..f590e5860794 100644
> --- a/Documentation/dev-tools/index.rst
> +++ b/Documentation/dev-tools/index.rst
> @@ -7,6 +7,8 @@ be used to work on the kernel. For now, the documents hav=
e been pulled
>  together without any significant effort to integrate them into a coheren=
t
>  whole; patches welcome!
>
> +A brief overview of testing-specific tools can be found in :doc:`testing=
-overview`.
> +
>  .. class:: toc-title
>
>            Table of contents
> @@ -14,6 +16,7 @@ whole; patches welcome!
>  .. toctree::
>     :maxdepth: 2
>
> +   testing-overview
>     coccinelle
>     sparse
>     kcov
> diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation=
/dev-tools/testing-overview.rst
> new file mode 100644
> index 000000000000..ce36a8cdf6b5
> --- /dev/null
> +++ b/Documentation/dev-tools/testing-overview.rst
> @@ -0,0 +1,117 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Kernel Testing Guide
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +
> +There are a number of different tools for testing the Linux kernel, so k=
nowing
> +when to use each of them can be a challenge. This document provides a ro=
ugh
> +overview of their differences, and how they fit together.
> +
> +
> +Writing and Running Tests
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +The bulk of kernel tests are written using either the kselftest or KUnit
> +frameworks. These both provide infrastructure to help make running tests=
 and
> +groups of tests easier, as well as providing helpers to aid in writing n=
ew
> +tests.
> +
> +If you're looking to verify the behaviour of the Kernel =E2=80=94 partic=
ularly specific
> +parts of the kernel =E2=80=94 then you'll want to use KUnit or kselftest=
.
> +
> +
> +The Difference Between KUnit and kselftest
> +------------------------------------------
> +
> +KUnit (Documentation/dev-tools/kunit/index.rst) is an entirely in-kernel=
 system
> +for "white box" testing: because test code is part of the kernel, it can=
 access
> +internal structures and functions which aren't exposed to userspace.
> +
> +KUnit tests therefore are best written against small, self-contained par=
ts
> +of the kernel, which can be tested in isolation. This aligns well with t=
he
> +concept of 'unit' testing.
> +
> +For example, a KUnit test might test an individual kernel function (or e=
ven a
> +single codepath through a function, such as an error handling case), rat=
her
> +than a feature as a whole.
> +
> +This also makes KUnit tests very fast to build and run, allowing them to=
 be
> +run frequently as part of the development process.
> +
> +There is a KUnit test style guide which may give further pointers in
> +Documentation/dev-tools/kunit/style.rst
> +
> +
> +kselftest (Documentation/dev-tools/kselftest.rst), on the other hand, is
> +largely implemented in userspace, and tests are normal userspace scripts=
 or
> +programs.
> +
> +This makes it easier to write more complicated tests, or tests which nee=
d to
> +manipulate the overall system state more (e.g., spawning processes, etc.=
).
> +However, it's not possible to call kernel functions directly from kselft=
est.
> +This means that only kernel functionality which is exposed to userspace =
somhow
> +(e.g. by a syscall, device, filesystem, etc.) can be tested with kselfte=
st.  To
> +work around this, some tests include a companion kernel module which exp=
oses
> +more information or functionality. If a test runs mostly or entirely wit=
hin the
> +kernel, however,  KUnit may be the more appropriate tool.
> +
> +kselftest is therefore suited well to tests of whole features, as these =
will
> +expose an interface to userspace, which can be tested, but not implement=
ation
> +details. This aligns well with 'system' or 'end-to-end' testing.
> +
> +For example, all new system calls should be accompanied by kselftest tes=
ts.
> +
> +Code Coverage Tools
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Linux Kernel supports two different code coverage measurement tools.=
 These
> +can be used to verify that a test is executing particular functions or l=
ines
> +of code. This is useful for determining how much of the kernel is being =
tested,
> +and for finding corner-cases which are not covered by the appropriate te=
st.
> +
> +:doc:`gcov` is GCC's coverage testing tool, which can be used with the k=
ernel
> +to get global or per-module coverage. Unlike KCOV, it does not record pe=
r-task
> +coverage. Coverage data can be read from debugfs, and interpreted using =
the
> +usual gcov tooling.
> +
> +:doc:`kcov` is a feature which can be built in to the kernel to allow
> +capturing coverage on a per-task level. It's therefore useful for fuzzin=
g and
> +other situations where information about code executed during, for examp=
le, a
> +single syscall is useful.
> +
> +
> +Dynamic Analysis Tools
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The kernel also supports a number of dynamic analysis tools, which attem=
pt to
> +detect classes of issues when the occur in a running kernel. These typic=
ally
> +look for undefined behaviour of some kind, such as invalid memory access=
es,
> +concurrency issues such as data races, or other undefined behaviour like
> +integer overflows.
> +
> +Some of these tools are listed below:
> +
> +* kmemleak detects possible memory leaks. See
> +  Documentation/dev-tools/kmemleak.rst
> +* KASAN detects invalid memory accesses such as out-of-bounds and
> +  use-after-free errors. See Documentation/dev-tools/kasan.rst
> +* UBSAN detects behaviour that is undefined by the C standard, like inte=
ger
> +  overflows. See Documentation/dev-tools/ubsan.rst
> +* KCSAN detects data races. See Documentation/dev-tools/kcsan.rst
> +* KFENCE is a low-overhead detector of memory issues, which is much fast=
er than
> +  KASAN and can be used in production. See Documentation/dev-tools/kfenc=
e.rst
> +* lockdep is a locking correctness validator. See
> +  Documentation/locking/lockdep-design.rst
> +* There are several other pieces of debug instrumentation in the kernel,=
 many
> +  of which can be found in lib/Kconfig.debug
> +
> +These tools tend to test the kernel as a whole, and do not "pass" like
> +kselftest or KUnit tests. They can be combined with KUnit or kselftest b=
y
> +running tests on a kernel with a sanitizer enabled: you can then be sure
> +that none of these errors are occurring during the test.
> +
> +Some of these tools integrate with KUnit or kselftest and will
> +automatically fail tests if an issue is detected.
> +
> --
> 2.31.1.295.g9ea45b61b8-goog
>
