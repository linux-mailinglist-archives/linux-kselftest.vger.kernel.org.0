Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590141F8A02
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jun 2020 20:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgFNSRx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 Jun 2020 14:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgFNSRw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 Jun 2020 14:17:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A612C03E969
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Jun 2020 11:17:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b201so6827320pfb.0
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Jun 2020 11:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=cb72U6z8Cr3P1sDvU4qKoKm5R8JCyir5KudWL5PBfe4=;
        b=imO/Ri9IjD4cKro9T+4QV21TjLNGHMG84h8k8JDVGRPG/lHK243ckZNCe+G3H+somu
         OL/M8bk8nLvnmkjCfLFwJZiSPs5XKzfU+4zW6+kqGhPBJJ8/qUvOa0ltRzQlWUf1kUh+
         64Kjo3XlIX2tF4GTCv0UO0eZxM2cMtYeM7dBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=cb72U6z8Cr3P1sDvU4qKoKm5R8JCyir5KudWL5PBfe4=;
        b=nIQD7MH+0H5UcbkKKrs/7kPRyt0B4j6s0SQKb7v7U69X40RvRsVq1c16mEWN7SfyWb
         apaKHASfaIVj/Y0D6jAdw4NI1AN7B/FDBCVZYfxeeaBNKqVIJ7cXVM0DY+x+UjRIIuy2
         71Xa3A8c1Q38uqL4sKSgKTcYe3Htwbsp12/CsOYLoFoehFS9ukRNPot4+j+1kBua3qYI
         JGmodO6li9JIpzWClsL3/I0GezBsHiw4ozkgCzoIhEyZWOQgFSqypUztx0n+qpRqWTT8
         KYIpjaBiU/xiPQ4von6qfGJ7RfKSPSR/yymZ+A7myHqE/ZjEu2EcPQozpq7i96cFqkNv
         Wisw==
X-Gm-Message-State: AOAM530bE6idJuyrvIsD3SkoqO3jYVymJ+CIuHIUxzHVZTquvaGeZLwF
        pTFKL6BcDv5N6TwDNmDxapb/bw==
X-Google-Smtp-Source: ABdhPJwu5IBcA4n/0wLJc3MDmle+pQFHlC4oN8rj1R1/IVTU3LUF6VllWPCiJNuJcKG+Kg8WLb0yAQ==
X-Received: by 2002:a65:52c3:: with SMTP id z3mr18513447pgp.146.1592158671493;
        Sun, 14 Jun 2020 11:17:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 4sm1469791pgk.68.2020.06.14.11.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 11:17:50 -0700 (PDT)
Date:   Sun, 14 Jun 2020 11:17:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux@rasmusvillemoes.dk
Subject: Re: RFC - kernel selftest result documentation (KTAP)
Message-ID: <202006141050.5512F17@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 13, 2020 at 02:51:17PM +0800, David Gow wrote:
> On Sat, Jun 13, 2020 at 6:36 AM Kees Cook <keescook@chromium.org> wrote:
> > Regarding output:
> >
> > [   36.611358] TAP version 14
> > [   36.611953]     # Subtest: overflow
> > [   36.611954]     1..3
> > ...
> > [   36.622914]     # overflow_calculation_test: s64: 21 arithmetic tests
> > [   36.624020]     ok 1 - overflow_calculation_test
> > ...
> > [   36.731096]     # overflow_shift_test: ok: (s64)(0 << 63) == 0
> > [   36.731840]     ok 2 - overflow_shift_test
> > ...
> > [   36.750294] kunit_try_catch: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
> > ...
> > [   36.805350]     # overflow_allocation_test: devm_kzalloc detected saturation
> > [   36.807763]     ok 3 - overflow_allocation_test
> > [   36.807765] ok 1 - overflow
> >
> > A few things here....
>
> Tim Bird has just sent out an RFC for a "KTAP" specification, which
> we'll hope to support in KUnit:

Ah-ha! Thanks for the heads-up. :)

> https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/T/#u

*thread split/merge*

This is coming from:
https://lore.kernel.org/linux-kselftest/CABVgOSnofuJQ_fiCL-8KdKezg3Hnqk3A+X509c4YP_toKeBVBg@mail.gmail.com/
But I'm attempting a thread jump... ;)

> That's probably where we'll end up trying to hash out exactly what
> this format should be. Fortunately, I don't think any of these will
> require any per-test work, just changes to the KUnit implementation.

Yup, good.

> > - On the outer test report, there is no "plan" line (I was expecting
> >   "1..1"). Technically it's optional, but it seems like the information
> >   is available. :)
>
> There's work underway to support this, but it's hit a few minor snags:
> https://lkml.org/lkml/2020/2/27/2155

Okay, cool. It's not critical, I don't think.

> > - The subtest should have its own "TAP version 14" line, and it should
> >   be using the diagnostic line prefix for the top-level test (this is
> >   what kselftest is doing).
>
> Alas, TAP itself hasn't standardised subtests. Personally, I think it
> doesn't fundamentally matter which way we do this (I actually prefer
> the way we're doing it currently slightly), but converging with what
> kselftest does would be ideal.

I see the KTAP RFC doesn't discuss subtests at all, but kselftest actually
already handles subtests. I strongly feel that line-start formatting is
the correct way to deal with this, with each subtest having it's own
self-contained KTAP. This allows for several important features:

- the subtest, run on its own, needs no knowledge about its execution
  environment: it simply emits its standard KTAP output.

- subtest output can be externally parsed separably, without any
  knowledge or parsing of the enclosing test.

For example, with my recent series[1], "make -C seccomp run_tests"
produces:

TAP version 13
1..2
# selftests: seccomp: seccomp_bpf
# TAP version 13
# 1..77
# # Starting 77 tests from 6 test cases.
# #  RUN           global.mode_strict_support ...
# #            OK  global.mode_strict_support
# ok 1 global.mode_strict_support
...
# ok 77 TSYNC.two_siblings_not_under_filter
# # FAILED: 73 / 77 tests passed.
# # Totals: pass:72 fail:4 xfail:1 xpass:0 skip:0 error:0
not ok 1 selftests: seccomp: seccomp_bpf # exit=1
# selftests: seccomp: seccomp_benchmark
#
not ok 2 selftests: seccomp: seccomp_benchmark # TIMEOUT

> > - There is no way to distinguish top-level TAP output from kernel log
> >   lines. I think we should stick with the existing marker, which is
> >   "# ", so that kernel output has no way to be interpreted as TAP
> >   details -- unless it intentionally starts adding "#"s. ;)
>
> At the moment, we're doing this in KUnit tool by stripping anything
> before "TAP version 14" (e.g., the timestamp), and then only incuding
> lines which parse correctly (are a test plan, result, or a diagnostic
> line beginning with '#').
> This has worked pretty well thus far, and we do have the ability to
> get results from debugfs instead of the kernel log, which won't have
> the same problems.
>
> It's worth considering, though, particularly since our parser should
> handle this anyway without any changes.

For the KTAP parsing, actually think it's very important to include
kernel log lines in the test output (as diagnostic lines), since they
are "unexpected" (they fail to have the correct indentation) and may
provide additional context for test failures when reading log files.
(As in the "vmalloc: allocation failure" line in the quoted section
above, to be included as a diagnostic line for test #3.)

> > - There is no summary line (to help humans). For example, the kselftest
> >   API produces a final pass/fail report.
>
> Currently, we're relying on the kunit.py script to produce this, but
> it shouldn't be impossible to add to the kernel, particularly once the
> "KUnit Executor" changes mentioned above land.

Cool. Yeah, it's not required, but I think there are two use cases:
humans running a single test (where is a summary is valuable, especially
for long tests that scroll off the screen), and automation (where it can
ignore the summary, as it will produce its own in a regularized fashion).

> > Taken together, I was expecting the output to be:
> >
> > [   36.611358] # TAP version 14
> > [   36.611953] # 1..1
> > [   36.611958] # # TAP version 14
> > [   36.611954] # # 1..3
> > ...
> > [   36.622914] # # # overflow_calculation_test: s64: 21 arithmetic tests
> > [   36.624020] # # ok 1 - overflow_calculation_test
> > ...
> > [   36.731096] # # # overflow_shift_test: ok: (s64)(0 << 63) == 0
> > [   36.731840] # # ok 2 - overflow_shift_test
> > ...
> > [   36.750294] kunit_try_catch: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
> > ...
> > [   36.805350] # # # overflow_allocation_test: devm_kzalloc detected saturation
> > [   36.807763] # # ok 3 - overflow_allocation_test
> > [   36.807763] # # # overflow: PASS
> > [   36.807765] # ok 1 - overflow
> > [   36.807767] # # kunit: PASS
> >
> > But I assume there are threads on this that I've not read... :)
>
> These discussions all seem to be coming to a head now, so this is
> probably just the kick we need to prioritise this a bit more. The KTAP
> thread hasn't covered all of these (particularly the subtest stuff)
> yet, so I confess I hadn't realised the extent of the divergence
> between KUnit and kselftest here.

Cool. Yeah, I'd like to keep things as close as possible. In looking at
this again, I wonder if perhaps it would be better to change the
"indent" from "# " to "  ", which might make things more readable for
both dmesg and terminal output:

[   36.611358]   TAP version 14
[   36.611953]   1..1
[   36.611958]     TAP version 14
[   36.611954]     1..3
...
[   36.622914]     # overflow_calculation_test: s64: 21 arithmetic tests
[   36.624020]     ok 1 - overflow_calculation_test
...
[   36.731096]     # overflow_shift_test: ok: (s64)(0 << 63) == 0
[   36.731840]     ok 2 - overflow_shift_test
...
[   36.750294] kunit_try_catch: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
...
[   36.805350]     # overflow_allocation_test: devm_kzalloc detected saturation
[   36.807763]     ok 3 - overflow_allocation_test
[   36.807763]     # overflow: PASS
[   36.807765]   ok 1 - overflow
[   36.807767]   # kunit: PASS

As it happens, subtests are a bit rare in kselftests right now, but
for kunit, the "common" output (IIUC) will fundamentally be a top-level
test running all the subtests, so we should get it right. :)

-Kees

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=selftests/harness/tap

--
Kees Cook
