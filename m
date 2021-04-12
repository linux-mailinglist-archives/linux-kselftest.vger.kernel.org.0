Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8A735D276
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Apr 2021 23:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245032AbhDLVUN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Apr 2021 17:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239314AbhDLVUN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Apr 2021 17:20:13 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A88C06175F
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 14:19:53 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u7so5257198plr.6
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 14:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0kani9UuJatzAS1/9+3uG2K1f1p/iIkw7fsZirQY3ag=;
        b=XHUw7EoQPyOWzS9lSH6CeI8PPeegvny96rbvETkWw7Ih+WFM6TCXXLg1GsuPIuaxiW
         +dC11KljPV/iBaU8llpKtkiaBQlBJ5/au9MgLpCoLRt775STpdH/W98WnHbjg/a2zH1G
         BKJceXHc9CRH0Y8zZ1/ubp5g8q0GNB02/0/l6WXwZY835uOqTW+XCEp1hyYQq2FM4ipo
         WpfjP7GLmEbJg7bv65GGmSHRnYW1OV4XFNuh66snuH+hHCWZN2hfKXLVmJQqHKbmNQZK
         mTLq71HGbEgYTcFxVe8DQEQK8z8qczCVa6kqZ8I20Cmye8lYZhAIAn3UX3uOv9ZkTwC5
         14Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0kani9UuJatzAS1/9+3uG2K1f1p/iIkw7fsZirQY3ag=;
        b=elKB8A1f9Ff9EORKiQ3/XAiVjx1LFU9tcKDmWd3mHuOqGjLK8cI2FyCeOFNRpdP687
         pRPEkS69AQ8unDNKZFSJtTNpP4UvyKu2ECEnpexzIzXaqwfw4D5M0aPsEnKIpmJrTGJc
         Fq52FgufBxDW8gUbZihEyF1Vv4F+EjuIzyUS3G+C6RGuoZhhdNLezboAe7iw16mhhZ6X
         r0wtYTrs3THn4D54uxQAHgSldIJKv8c0CuWKirXMkPdv5we4TPgdNgIXegMLE7uU8H1u
         ml04UpznGYu2AZJwAORwx13sTpY+YFZUPdgKAOQM4HZuPw0ZpIdkYqfzbnShiyJRdN/w
         /kcw==
X-Gm-Message-State: AOAM530E3q7GE6TdTJrIjZvu+jTNEf9HhRHvfhGN/BSQkpk8WTCZ5DB1
        VSj/n0i2Q0t8Srt6hSMvpi5yzDRFJr1z3wIdyLojcw==
X-Google-Smtp-Source: ABdhPJwmcpZiKjTv83JiBCa8kw8wss7NgdgSK7YtwJMmJVpqSur+4fkkjvk0WK2d3kjVFkojPUQV2N5PXrpNyi4ji00=
X-Received: by 2002:a17:90a:6a05:: with SMTP id t5mr1327658pjj.20.1618262392856;
 Mon, 12 Apr 2021 14:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210410070529.4113432-1-davidgow@google.com>
In-Reply-To: <20210410070529.4113432-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 12 Apr 2021 14:19:41 -0700
Message-ID: <CAFd5g46YpGaCCK=P0RYaTpLRKMuKrm7xqMSJfX3BeqRiDZ8D0g@mail.gmail.com>
Subject: Re: [PATCH] Documentation: dev-tools: Add Testing Overview
To:     David Gow <davidgow@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Barnes <barnesjonathan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Apr 10, 2021 at 12:05 AM David Gow <davidgow@google.com> wrote:
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

With the exception of some minor nits, I think the below will make a
great initial testing overview guide!

Thanks for getting the ball rolling on this!

> ---
>  Documentation/dev-tools/index.rst            |   3 +
>  Documentation/dev-tools/testing-overview.rst | 102 +++++++++++++++++++
>  2 files changed, 105 insertions(+)
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

I think I would like to make this a little more apparent. This index
here is a bit bare bones and I think this testing-overview could be a
good: "I am lost where do I start?" sort of doc. That being said, I am
not sure what the best way to emphasize this might be. Maybe just have
an intro paragraph here with some callout text like in a `note` or
something like that.

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
> index 000000000000..8452adcb8608
> --- /dev/null
> +++ b/Documentation/dev-tools/testing-overview.rst
> @@ -0,0 +1,102 @@
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
> +The bulk of kernel tests are written using either the :doc:`kselftest
> +<kselftest>` or :doc:`KUnit <kunit/index>` frameworks. These both provid=
e
> +infrastructure to help make running tests and groups of tests easier, as=
 well
> +as providing helpers to aid in writing new tests.
> +
> +If you're looking to verify the behaviour of the Kernel =E2=80=94 partic=
ularly specific
> +parts of the kernel =E2=80=94 then you'll want to use `KUnit` or `kselft=
est`.
> +
> +
> +The Difference Between KUnit and kselftest
> +------------------------------------------
> +
> +:doc:`KUnit <kunit/index>` is an entirely in-kernel system for "white bo=
x"
> +testing: because test code is part of the kernel, it can access internal
> +structures and functions which aren't exposed to userspace.
> +
> +`KUnit` tests therefore are best written against small, self-contained p=
arts
> +of the kernel, which can be tested in isolation. This aligns well with t=
he
> +concept of Unit testing.

I think I might have pushed the "unit testing" stuff too hard in the
past, but I feel that if you are going to mention "the concept of unit
testing" it might be a good idea to link to an authoritative source on
what unit testing is. Maybe link to Martin Fowler or something like
that?

> +For example, a KUnit test might test an individual kernel function (or e=
ven a
> +single codepath through a function, such as an error handling case), rat=
her
> +than a feature as a whole.
> +
> +There is a KUnit test style guide which may give further pointers

I know you linked the index page for KUnit above, but I think you
might want to link the KUnit style guide here since you mention it.

> +:doc:`kselftest <kselftest>`, on the other hand, is largely implemented =
in
> +userspace, and tests are normal userspace scripts or programs.
> +
> +This makes it easier to write more complicated tests, or tests which nee=
d to
> +manipulate the overall system state more (e.g., spawning processes, etc.=
).
> +However, it's not possible to call kernel functions directly unless they=
're
> +exposed to userspace (by a syscall, device, filesystem, etc.) Some tests=
 to
> +also provide a kernel module which is loaded by the test, though for tes=
ts
> +which run mostly or entirely within the kernel, `KUnit` may be the bette=
r tool.
> +
> +`kselftest` is therefore suited well to tests of whole features, as thes=
e will
> +expose an interface to userspace, which can be tested, but not implement=
ation
> +details. This aligns well with 'system' or 'end-to-end' testing.

Again, I think you might want to link to some sources that explain
what "system" and "end-to-end" testing are.

Also, I think maybe adding a section on some common examples of when
to use Kselftest vs when to use KUnit would be helpful. For example:

 - If I add a new syscall, you might want to mention that the author
is *required*
   to add accompanying Kselftests.
 - A new internal API - for example a new crypto API - is *strongly recomme=
nded*
   to have accompanying KUnit tests.
 - Many new features, that have a large in kernel API, but also have a
user visible
   API should probably have both Kselftests as well as KUnit tests.

Enumerating other examples is probably a good idea, but I think this
offers a good flavor.

> +Code Coverage Tools
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Linux Kernel supports two different code coverage mesurement tools. =
These
> +can be used to verify that a test is executing particular functions or l=
ines
> +of code. This is useful for determining how much of the kernel is being =
tested,
> +and for finding corner-cases which are not covered by the appropriate te=
st.
> +
> +:doc:`kcov` is a feature which can be built in to the kernel to allow
> +capturing coverage on a per-task level. It's therefore useful for fuzzin=
g and
> +other situations where information about code executed during, for examp=
le, a
> +single syscall is useful.
> +
> +:doc:`gcov` is GCC's coverage testing tool, which can be used with the k=
ernel
> +to get global or per-module coverage. Unlike KCOV, it does not record pe=
r-task
> +coverage. Coverage data can be read from debugfs, and interpreted using =
the
> +usual gcov tooling.
> +
> +
> +Sanitizers
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The kernel also supports a number of sanitizers, which attempt to detect
> +classes of issues when the occur in a running kernel. These typically
> +look for undefined behaviour of some kind, such as invalid memory access=
es,
> +concurrency issues such as data races, or other undefined behaviour like
> +integer overflows.
> +
> +* :doc:`kmemleak` (Kmemleak) detects possible memory leaks.
> +* :doc:`kasan` detects invalid memory accesses such as out-of-bounds and
> +  use-after-free errors.
> +* :doc:`ubsan` detects behaviour that is undefined by the C standard, li=
ke
> +  integer overflows.
> +* :doc:`kcsan` detects data races.
> +* :doc:`kfence` is a low-overhead detector of memory issues, which is mu=
ch
> +  faster than KASAN and can be used in production.
> +
> +These tools tend to test the kernel as a whole, and do not "pass" like
> +kselftest or KUnit tests. They can be combined with KUnit or kselftest b=
y
> +running tests on a kernel with a sanitizer enabled: you can then be sure
> +that none of these errors are occurring during the test.
> +
> +Some of these sanitizers integrate with KUnit or kselftest and will
> +automatically fail tests if an issue is detected by a sanitizer.
> +
> --
> 2.31.1.295.g9ea45b61b8-goog
>
