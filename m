Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970455B4A54
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Sep 2022 23:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiIJVme (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Sep 2022 17:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiIJVmQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Sep 2022 17:42:16 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCA34D176
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Sep 2022 14:38:02 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id a8-20020ab04948000000b003b5de1448d2so1950097uad.11
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Sep 2022 14:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=AtmQOz4cqU5AlOnIxEScnXs2STqQsi71nD797NpxF7g=;
        b=ONMGnunKNz4gp6pmKkYtXjmszONPlJmgdmvIFMNIH+l1kH1hr624Pikj7usUwyBpKa
         jdsHPH0YixHNFhP/yHhRREK/X8wkkfqH6qk8dp5aGV6QebWO+f6XMb2QvPYteCi4E4Uc
         T8M/1/I05+yqj5lcEBqf6Xk3mm1+GqkhSuJGBcWXiIU6f3W+6QjI9nzceAR+tOPaenBz
         UTSW3y14Yxlk4TNZ/Wl7n2dP7gYAOGOoyxN1CHYmrWybYD+5sZdz4CQLci8yoJ9emYSc
         Nctku8l/YvfTuqjQV/j26hSEz3mpU5iS7q0UtrBp4MSk+XbJ2haQ1nySY5D37C0eYdQx
         +vRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=AtmQOz4cqU5AlOnIxEScnXs2STqQsi71nD797NpxF7g=;
        b=PXe+W7fmP3S14DSQ2ot8VwT6c1+Q96y71EIxZMupWVE/bQ0dmsdunjM6BFgMIIfXTf
         O7SdssBSjbjqPcSCy+Vjl1hPaYwgZbwl4kMC1TIEhco3lbE+4v798LTZAJmEZxIdTanZ
         fuYPbzhpiC6CazZ0ZwCcS2qR4JgnZyklskVGBm6kesTXn2hFD83hewCGaL7xkrWhpj/z
         W7AvFp+pv+h4qTqZWuRPwkIqczP2z1BWqd446z7FC6cds2M0mC1L/Q649R8DIkAhFwG/
         7GMpm725w+T4ZogS6MbT/SjovAkiP7U5wB03e4RfuC4neFEICP2Gl9keIXGsTZHBgztS
         wOaw==
X-Gm-Message-State: ACgBeo2bWeFQhIaEAW6VMBzI8Pd8I6E80mAVfQb9P2EpyKy2cXEn3OOl
        qKsOY0TPcsViKWoCaDp88L3ogg0tL9SLbA==
X-Google-Smtp-Source: AA6agR4gR+/yHl1fMdZOru1FjRTOUUGrDSviK2l/4Yh1aEqbh8B3ViYymnNaCdL+DMqLzyFefh9vmEOz/DnoEA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:902:bd48:b0:172:bb9d:d6d5 with SMTP
 id b8-20020a170902bd4800b00172bb9dd6d5mr19190501plx.59.1662845297768; Sat, 10
 Sep 2022 14:28:17 -0700 (PDT)
Date:   Sun, 11 Sep 2022 05:28:02 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220910212804.670622-1-davidgow@google.com>
Subject: [RFC PATCH v2 0/2] kunit: Support redirecting function calls
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Fradley <joefradley@google.com>
Cc:     Steve Muckle <smuckle@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When writing tests, it'd often be very useful to be able to intercept
calls to a function in the code being tested and replace it with a
test-specific stub. This has always been an obviously missing piece of
KUnit, and the solutions always involve some tradeoffs with cleanliness,
performance, or impact on non-test code. See the folowing document for
some of the challenges:
https://kunit.dev/mocking.html

This series consists of two prototype patches which add support for this
sort of redirection to KUnit tests:

1: static_stub: Any function which might want to be intercepted adds a
call to a macro which checks if a test has redirected calls to it, and
calls the corresponding replacement.

2: ftrace_stub: Functions are intercepted using ftrace.
This doesn't require adding a new prologue to each function being
replaced, but does have more dependencies (which restricts it to a small
number of architectures, not including UML), and doesn't work well with
inline functions.

The API for both implementations is very similar, so it should be easy
to migrate from one to the other if necessary.  Both of these
implementations restrict the redirection to the test context: it is
automatically undone after the KUnit test completes, and does not affect
calls in other threads. If CONFIG_KUNIT is not enabled, there should be
no overhead in either implementation.

Does either (or both) of these features sound useful, and is this
sort-of API the right model? (Personally, I think there's a reasonable
scope for both.) Is anything obviously missing or wrong? Do the names,
descriptions etc. make any sense?

Note that these patches are definitely still at the "prototype" level,
and things like error-handling, documentation, and testing are still
pretty sparse. There is also quite a bit of room for optimisation.
These'll all be improved for v1 if the concept seems good.

We're going to be talking about this again at LPC, so it's worth having
another look before then if you're interested and/or will be attending:
https://lpc.events/event/16/contributions/1308/

Cheers,
-- David

---

Changes since RFC v1:
https://lore.kernel.org/lkml/20220318021314.3225240-1-davidgow@google.com/
- Fix some typos (thanks Daniel)
- Use typecheck_fn() to fix typechecking in some cases (thanks Brendan)
- Use ftrace_instruction_pointer_set() in place of kernel livepatch,
  which seems to have disappeared:
  https://lore.kernel.org/lkml/0a76550d-008d-0364-8244-4dae2981ea05@csgroup.eu/T/
- Fix a copy-paste name error in the resource finding function.
- Rebase on top of torvalds/master, as it wasn't applying cleanly.

Note that the Kernel Livepatch -> ftrace change seems to allow more
architectures to work, but while they compile, there still seems to be
issues. So, this will compile on (e.g.) arm64, but fails:
$ ./tools/testing/kunit/kunit.py run 'example*' --kunitconfig lib/kunit/stubs_example.kunitconfig --arch arm64 --make_options LLVM=1
[05:00:13] # example_ftrace_stub_test: initializing
[05:00:13] # example_ftrace_stub_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:179
[05:00:13] Expected add_one(1) == 0, but
[05:00:13] add_one(1) == 2 
[05:00:13] not ok 6 - example_ftrace_stub_test                                                                                                                                                                                              
[05:00:13] [FAILED] example_ftrace_stub_test                                                                                                                                                                                                



Daniel Latypov (1):
  kunit: expose ftrace-based API for stubbing out functions during tests

David Gow (1):
  kunit: Expose 'static stub' API to redirect functions

 include/kunit/ftrace_stub.h         |  84 +++++++++++++++++
 include/kunit/static_stub.h         | 106 +++++++++++++++++++++
 lib/kunit/Kconfig                   |  11 +++
 lib/kunit/Makefile                  |   5 +
 lib/kunit/ftrace_stub.c             | 137 ++++++++++++++++++++++++++++
 lib/kunit/kunit-example-test.c      |  63 +++++++++++++
 lib/kunit/static_stub.c             | 125 +++++++++++++++++++++++++
 lib/kunit/stubs_example.kunitconfig |  10 ++
 8 files changed, 541 insertions(+)
 create mode 100644 include/kunit/ftrace_stub.h
 create mode 100644 include/kunit/static_stub.h
 create mode 100644 lib/kunit/ftrace_stub.c
 create mode 100644 lib/kunit/static_stub.c
 create mode 100644 lib/kunit/stubs_example.kunitconfig

-- 
2.37.2.789.g6183377224-goog

