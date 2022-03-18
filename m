Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39004DD2EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 03:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiCRCOw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Mar 2022 22:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiCRCOv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Mar 2022 22:14:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A26F2135
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Mar 2022 19:13:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e599f0c613so60442437b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Mar 2022 19:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lJQh/Exyrm7jkuouuP+OFVuB8hBfkh2Al21bjlOl0AQ=;
        b=bU5cNjnSbfuOBeInriKiwJ43wTavdmlH3NKiDX7FoCYGJjoGx81eqzj7U/cGMRVN+S
         DMAklEp0sQd5oNelJoM25F6J37gJQbf0lKfBertZq3LzbXhzrW6tYNWdm6G/1KHXCJ+V
         otWWGManMbwWjWugM9Jsmq/7mlLH08ZnG4XePmjQ/kBySP/moZ2ySLLga770efdOZH06
         tVfT6yyWqxj8CGnUX4LQvsZZ6ABJn15pYZgm3xG5aDxm4ejOZMOqAa+058F5aEM+7uml
         djP9jWDcgSeJp/UhFl8jXTatDsG2tsmri+wPhNrF9xF84EQRYVV1kcJpwiZAYEcJ0DUL
         mkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lJQh/Exyrm7jkuouuP+OFVuB8hBfkh2Al21bjlOl0AQ=;
        b=s41WJLMRsfay11h55j8cZQblXz6oN6AqNbCUhtcs1OGeKRoY/iGfKLMrC+/ULa/B74
         VpgqqRyjgGC2D8YawHc0AMmiv9IyKBZgm7Wx91ue95P/QIPJWoJgjde9exXRCaW9eita
         /wO0PCjcOPaw0NGP8vXTd5V6r7GMWJuJ9BmaTYoEiJU6xEhdKV5Dijgs8bil256NsoI4
         jKoeCgky62LCtWahG7skbVTAySDskU8yZSyuz3LbqnpjUs31icyZIysUoXTZBt3V9Rtb
         zZx20RZ0VOJDTOuAdQhUIvwulsUpwGdNacZVCUHdDTHmsWkK43tPURHPF7UGgUAOQ3Ux
         JGXQ==
X-Gm-Message-State: AOAM5323fzUDhovhAmxWo2yAFmn0WZnZ/0LwzfY6Mjy0UejQIA1bO/Xl
        Pmnw8WNm+LQosOTsz2lPGveXsVDszjloIQ==
X-Google-Smtp-Source: ABdhPJwfzO6Vfvq0NFoAyajCpwKamuadpZgMSHI9lgsqF5mO2tNkiNrQDm5hddG34QkZKXXe+1YreV64q/yv9A==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a0d:d756:0:b0:2e5:9b8a:78f6 with SMTP id
 z83-20020a0dd756000000b002e59b8a78f6mr9179301ywd.216.1647569613119; Thu, 17
 Mar 2022 19:13:33 -0700 (PDT)
Date:   Fri, 18 Mar 2022 10:13:12 +0800
Message-Id: <20220318021314.3225240-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [RFC PATCH 0/2] kunit: Support redirecting function calls
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

2: ftrace_stub: Functions are intercepted using ftrace and livepatch.
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

Cheers,
-- David

Daniel Latypov (1):
  kunit: expose ftrace-based API for stubbing out functions during tests

David Gow (1):
  kunit: Expose 'static stub' API to redirect functions

 include/kunit/ftrace_stub.h         |  84 +++++++++++++++++
 include/kunit/static_stub.h         | 106 +++++++++++++++++++++
 lib/kunit/Kconfig                   |  11 +++
 lib/kunit/Makefile                  |   5 +
 lib/kunit/ftrace_stub.c             | 138 ++++++++++++++++++++++++++++
 lib/kunit/kunit-example-test.c      |  64 +++++++++++++
 lib/kunit/static_stub.c             | 125 +++++++++++++++++++++++++
 lib/kunit/stubs_example.kunitconfig |  11 +++
 8 files changed, 544 insertions(+)
 create mode 100644 include/kunit/ftrace_stub.h
 create mode 100644 include/kunit/static_stub.h
 create mode 100644 lib/kunit/ftrace_stub.c
 create mode 100644 lib/kunit/static_stub.c
 create mode 100644 lib/kunit/stubs_example.kunitconfig

-- 
2.35.1.894.gb6a874cedc-goog

