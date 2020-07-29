Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906CA232735
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jul 2020 23:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgG2V5z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jul 2020 17:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgG2V5y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jul 2020 17:57:54 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C24C0619D2
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 14:57:54 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id a34so8325722ybj.9
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 14:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/ukW0X/5BiKbJEKr2oeHvITKKVidatQzqB3tkKKQNg=;
        b=rJaH5wiXRvUWjGwEt7fJ1cni+QUEQC+KArZY6p9dqwr+4i9DiQKMSTcR2iiDPSaH8u
         fs+PexYNdlCvXC5wsnATdxceiAcJXPGlFX2e9AmEodp+cXu385RH3dMPBV1cVaFZ8sWv
         DQ823qFab2ZxTt4iFeEC9dVOjJgenL7Ch/RIR1u/PCbMpZXEOui01nlr3cARdxjtAy9L
         CzpjWgxyXcgh931rMjLjrAVgbhTDVmK0kglNHoNPDvJhLXtUMjjdo47t8tApp/WMUli+
         +Veo/yRPfOpoJnwAamAlxDyucbmT1wpFRznchCnqhxMgKido4q6VF/LK607lXukFaMP1
         AX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/ukW0X/5BiKbJEKr2oeHvITKKVidatQzqB3tkKKQNg=;
        b=DxLBuXt72SfLHr6Sg9kuRVW/DEBzKrxBUGFPDwPozdE3fgw1o/oPuNltED43WHLdSB
         b8JGwNdBIuWH51bG0sf0VqzU9IIl7b9Ts+VjBhszBSXWxZ33nmI1orcYkmqopwRCptQX
         msTeIDwD6Dwr+zle1A9ST1Qk/gRK80U9w4Uf3iRvgMShGc3x4KLSKMc0r0n8+rAKfkO/
         28t9odZ3OwrFqPGAifaiVyfw1ibt1d1HL+Da4nFfFNbF2f5svqIRX28a3kQPZiEq0Dq+
         b06nBFtLYm0iT6CeZlWzRfwbhIhg+SAq9Nx/N454TG8pagCN9pgkOhkNfpwRoxYJUZWL
         Er9g==
X-Gm-Message-State: AOAM5303Y3qWEUz6e4moHEXb/USFDDEYFCQ6lls7Kui3IwcdDQ/Uul6i
        TwYIm3I0ou0hgPFdIo17IQXYvnQo8i5jyJRs1qqVXg==
X-Google-Smtp-Source: ABdhPJz9dkLbOEKynG62lQISCs1yNneZEmgV3y/1OTZdR9Y2aBJ9odsOuCArdCa9NY4jjb6DO9llKm9ES6IszlsGFk4=
X-Received: by 2002:a25:361b:: with SMTP id d27mr66842yba.348.1596059873438;
 Wed, 29 Jul 2020 14:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200729201146.537433-1-vitor@massaru.org> <20200729203908.GD2655@hirez.programming.kicks-ass.net>
In-Reply-To: <20200729203908.GD2655@hirez.programming.kicks-ass.net>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Wed, 29 Jul 2020 18:57:17 -0300
Message-ID: <CADQ6JjW-=SNjV-abGpGA9NfHD4yGG_bD5FmvW99W-Vo06twkbw@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit: add test_min_heap test conversion to KUnit
To:     peterz@infradead.org
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org, irogers@google.com,
        mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

On Wed, Jul 29, 2020 at 5:39 PM <peterz@infradead.org> wrote:
>
> On Wed, Jul 29, 2020 at 05:11:46PM -0300, Vitor Massaru Iha wrote:
> > This adds the conversion of the runtime tests of test_min_heap,
> > from `lib/test_min_heap.c` to KUnit tests.
> >
> > Please apply this commit first (linux-kselftest/kunit-fixes):
> > 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space
> >
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > ---
> >  lib/Kconfig.debug                         |  29 ++++--
> >  lib/Makefile                              |   2 +-
> >  lib/{test_min_heap.c => min_heap_kunit.c} | 117 ++++++++++++----------
> >  3 files changed, 83 insertions(+), 65 deletions(-)
> >  rename lib/{test_min_heap.c => min_heap_kunit.c} (60%)
>
> So where's the win? What's KUnit, why should I care and more lines.

KUnit is a unit testing and mocking framework for the Linux kernel. [0]

In Kconfig.debug you only have some more information about KUnit.

If the number of lines is a parameter that should be considered, I can
change sections like this

-                       if (last > values[0]) {
-                               pr_err("error: expected %d <= %d\n", last,
-                                       values[0]);
-                               err++;
-                       }
+                       KUNIT_EXPECT_FALSE_MSG(context,
+                                              last > values[0],
+                                              "expected %d <= %d\n",
+                                              last, values[0]);

To this:

-                       if (last > values[0]) {
-                               pr_err("error: expected %d <= %d\n", last,
-                                       values[0]);
-                               err++;
-                       }
+                       KUNIT_EXPECT_FALSE_MSG(context, last >
values[0],  "expected %d <= %d\n",  last, values[0]);

And from this:

+static struct kunit_case __refdata min_heap_test_cases[] = {
+       KUNIT_CASE(test_heapify_all_true),
+       KUNIT_CASE(test_heapify_all_false),
+       KUNIT_CASE(test_heap_push_true),
+       KUNIT_CASE(test_heap_push_false),
+       KUNIT_CASE(test_heap_pop_push_true),
+       KUNIT_CASE(test_heap_pop_push_false),
+       {}

To this:

+static struct kunit_case __refdata min_heap_test_cases[] = {
+       KUNIT_CASE(test_min_heap),
+       {}

I did the latter this way to be more informative, but if the goal is
to reduce lines of code, this is possible.

The results can be seen this way:

This is an excerpt from the test.log with the result in TAP format:
[snip]
ok 5 - example
    # Subtest: min-heap
    1..6
    ok 1 - test_heapify_all_true
    ok 2 - test_heapify_all_false
    ok 3 - test_heap_push_true
    ok 4 - test_heap_push_false
    ok 5 - test_heap_pop_push_true
    ok 6 - test_heap_pop_push_false
[snip]

And this from kunit-tool:
[snip]
[18:43:32] ============================================================
[18:43:32] ======== [PASSED] min-heap ========
[18:43:32] [PASSED] test_heapify_all_true
[18:43:32] [PASSED] test_heapify_all_false
[18:43:32] [PASSED] test_heap_push_true
[18:43:32] [PASSED] test_heap_push_false
[18:43:32] [PASSED] test_heap_pop_push_true
[18:43:32] [PASSED] test_heap_pop_push_false
[18:43:32] ============================================================
[18:43:32] Testing complete. 20 tests run. 0 failed. 0 crashed.
[18:43:32] Elapsed time: 9.758s total, 0.001s configuring, 6.012s
building, 0.000s running
[snip]

BR,
Vitor

[0] https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html#what-is-kunit
