Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960AA5F0F6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 18:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiI3QAL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 12:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiI3P7x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 11:59:53 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BBD14006
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 08:59:39 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id j10so2921781qtv.4
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 08:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NK6zfHFnMf5a+HdLSDIx93EDC/e6X/0+F6ZlZy78SrM=;
        b=oI44i8ct1miKHvC15nqHdpFZsiQN/a6fBOW+ZYxIuHgcgrSgEMiy1UDyFqNCnVQflK
         e8RynzGvVbPEIr334P0F2XEgZVy/hznfl/4rSmPKGh5lulb5qPi4/9UgvgyQ6BOQk1l4
         VcV/Qev9ROuqB14ytynnwQv7acnIJh1lOteutIjv3x5mhvIoMKy6EXeBNoP1jxeeCFqm
         rgGpdpCOCSPhxtiRqotxIJq5HVLIO9GGne2Ht8GTXS7malqIMoa4MBWLmLtcFNGWecH5
         S0RtWkjqiVOwRAlsCYJk1MlNUBEk/EUoNLZAUWO78kJR4ZdUbb3P0QIwnWYLsFEBUFeC
         vrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NK6zfHFnMf5a+HdLSDIx93EDC/e6X/0+F6ZlZy78SrM=;
        b=JLzej7mqDy8d7yBuXsSV1bk5skciYz70XVR8Sf2/IEokIbhHQVhi7uAuRPK09xW2qr
         jcT7MljwNNDBNvzsmV8XUueCmRp/eg5LiaSj5eQ3ATw1gqYbwctgis4/FESA6IQscsBU
         Oteq+61++ncVP2eUdtbjzKqajwV+n1TM5cZrGiCZN2ZDD0fRoOhMSt764vexT0qlOpDY
         QcADMNVDOD5Rz4TH1iZlsyEbdisZu10O5TWeAsMwEcbwxBRK0wOo06Wy8jqiuJbr49mx
         +VX5L0Az1HJV1bycFnntSMfA+y6RL8hzYFMYKQYDcrpbmNcOWnvPY3h08+DqIhdcmytY
         Disw==
X-Gm-Message-State: ACrzQf3aeIzFrV7kqghVviYXtAJd9T37NIZuYYaXQEpzsnILYO/nDZTY
        38fll9kkNiW0o8YAkS4O5efxky/AkJGHXAZO618I
X-Google-Smtp-Source: AMsMyM6O1DIA75QYTgiw5H+ZOOhVdREd5TKnxPtjDN29ygv/Oonp/S7A+UWlQGh3fqZMAZyTVpZeQGt2sgUrjPPNBSk=
X-Received: by 2002:ac8:5e51:0:b0:35c:e40f:d898 with SMTP id
 i17-20020ac85e51000000b0035ce40fd898mr7287109qtx.685.1664553578206; Fri, 30
 Sep 2022 08:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220910212804.670622-1-davidgow@google.com>
In-Reply-To: <20220910212804.670622-1-davidgow@google.com>
From:   Joe Fradley <joefradley@google.com>
Date:   Fri, 30 Sep 2022 08:59:26 -0700
Message-ID: <CAF-60z0Tmr_DkJumaT6O84EQoR_XEJVYaT2TTYcwGFfJETD1KA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] kunit: Support redirecting function calls
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steve Muckle <smuckle@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 10, 2022 at 2:28 PM David Gow <davidgow@google.com> wrote:
>
> When writing tests, it'd often be very useful to be able to intercept
> calls to a function in the code being tested and replace it with a
> test-specific stub. This has always been an obviously missing piece of
> KUnit, and the solutions always involve some tradeoffs with cleanliness,
> performance, or impact on non-test code. See the folowing document for
> some of the challenges:
> https://kunit.dev/mocking.html
>
> This series consists of two prototype patches which add support for this
> sort of redirection to KUnit tests:
>
> 1: static_stub: Any function which might want to be intercepted adds a
> call to a macro which checks if a test has redirected calls to it, and
> calls the corresponding replacement.
>
> 2: ftrace_stub: Functions are intercepted using ftrace.
> This doesn't require adding a new prologue to each function being
> replaced, but does have more dependencies (which restricts it to a small
> number of architectures, not including UML), and doesn't work well with
> inline functions.
>
> The API for both implementations is very similar, so it should be easy
> to migrate from one to the other if necessary.  Both of these
> implementations restrict the redirection to the test context: it is
> automatically undone after the KUnit test completes, and does not affect
> calls in other threads. If CONFIG_KUNIT is not enabled, there should be
> no overhead in either implementation.
>
> Does either (or both) of these features sound useful, and is this
> sort-of API the right model? (Personally, I think there's a reasonable
> scope for both.) Is anything obviously missing or wrong? Do the names,
> descriptions etc. make any sense?

David,
This will be a great addition to the KUnit framework and another tool in
the toolbox for test writers. Both approaches have their merits. If all
things were equal the ftrace option would be preffered in my opinion.
The ability to add tests without having to touch the source of what
you're testing is superior. However, all things aren't equal as you've
detailed. There are a number of open items for the ftrace approach that
will limit its scope of use. Given that a solid amount of test developers
already develop on what they're testing, the static stub option sounds
like the one to go with for now, if you had to choose one.

Regarding the implementation, could there be more granualitary in the
activation of these stubs? Considering there's a small amount overhead
for these stubs when CONFIG_KUNIT is enabled, a developer's environment
could be adversely affected when they're testing a completely different
area that doesn't require mocks.

Maybe only activate these with CONFIG_KUNIT_FTRACE_STUBS and
CONFIG_KUNIT_STATIC_STUBS respectively?

Joe

>
> Note that these patches are definitely still at the "prototype" level,
> and things like error-handling, documentation, and testing are still
> pretty sparse. There is also quite a bit of room for optimisation.
> These'll all be improved for v1 if the concept seems good.
>
> We're going to be talking about this again at LPC, so it's worth having
> another look before then if you're interested and/or will be attending:
> https://lpc.events/event/16/contributions/1308/
>
> Cheers,
> -- David
>
> ---
>
> Changes since RFC v1:
> https://lore.kernel.org/lkml/20220318021314.3225240-1-davidgow@google.com/
> - Fix some typos (thanks Daniel)
> - Use typecheck_fn() to fix typechecking in some cases (thanks Brendan)
> - Use ftrace_instruction_pointer_set() in place of kernel livepatch,
>   which seems to have disappeared:
>   https://lore.kernel.org/lkml/0a76550d-008d-0364-8244-4dae2981ea05@csgroup.eu/T/
> - Fix a copy-paste name error in the resource finding function.
> - Rebase on top of torvalds/master, as it wasn't applying cleanly.
>
> Note that the Kernel Livepatch -> ftrace change seems to allow more
> architectures to work, but while they compile, there still seems to be
> issues. So, this will compile on (e.g.) arm64, but fails:
> $ ./tools/testing/kunit/kunit.py run 'example*' --kunitconfig lib/kunit/stubs_example.kunitconfig --arch arm64 --make_options LLVM=1
> [05:00:13] # example_ftrace_stub_test: initializing
> [05:00:13] # example_ftrace_stub_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:179
> [05:00:13] Expected add_one(1) == 0, but
> [05:00:13] add_one(1) == 2
> [05:00:13] not ok 6 - example_ftrace_stub_test
> [05:00:13] [FAILED] example_ftrace_stub_test
>
>
>
> Daniel Latypov (1):
>   kunit: expose ftrace-based API for stubbing out functions during tests
>
> David Gow (1):
>   kunit: Expose 'static stub' API to redirect functions
>
>  include/kunit/ftrace_stub.h         |  84 +++++++++++++++++
>  include/kunit/static_stub.h         | 106 +++++++++++++++++++++
>  lib/kunit/Kconfig                   |  11 +++
>  lib/kunit/Makefile                  |   5 +
>  lib/kunit/ftrace_stub.c             | 137 ++++++++++++++++++++++++++++
>  lib/kunit/kunit-example-test.c      |  63 +++++++++++++
>  lib/kunit/static_stub.c             | 125 +++++++++++++++++++++++++
>  lib/kunit/stubs_example.kunitconfig |  10 ++
>  8 files changed, 541 insertions(+)
>  create mode 100644 include/kunit/ftrace_stub.h
>  create mode 100644 include/kunit/static_stub.h
>  create mode 100644 lib/kunit/ftrace_stub.c
>  create mode 100644 lib/kunit/static_stub.c
>  create mode 100644 lib/kunit/stubs_example.kunitconfig
>
> --
> 2.37.2.789.g6183377224-goog
>
