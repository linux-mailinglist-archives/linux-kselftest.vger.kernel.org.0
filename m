Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FF972A719
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 02:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjFJAwJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 20:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjFJAwI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 20:52:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349949E
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 17:52:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb78a3daaso3198038276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 17:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686358326; x=1688950326;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wg++2gE8/jht9e+KkYaoylKtJ1FY+uAMq5VBMWkg2vI=;
        b=vZa0uQJub1/SthRtIpRIUdBcECAOCf4iTZtfveOCEH2qhZXN6OXSLQU4rxA4XAuWzc
         rrF2wOzq4rqLr6cV80saM9nYxWLvo2dzC2QqLpKrmAn1QFps3fMUVaLZpX+hs6doupWf
         +pcjaEgSTskPgaJ+dIkjcli6C7/q6N210FLnQScBFO/2EXIWNa4dYsshbKQ4hJK7OqOp
         K3eLXaGxkOgCzqdEkUJPZgzhf8YRFJ4BmCoXVPCvTSlou9mIQf835BE68v9uc1K8AR9K
         naQ/WX8z5MCpfalOCjg4+ro4EyFf4vZOzWQX2gmnoKO08v9Kvq1jPYFGpDGQW6QQZ9aL
         30zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686358326; x=1688950326;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wg++2gE8/jht9e+KkYaoylKtJ1FY+uAMq5VBMWkg2vI=;
        b=hv0tfLU1Qg3QjWJnbtleiIHPXYB9uxVOs5oOjZKt+276ksRHyE2buASJwQNRVPvr+A
         YWm0oMIusxfyrLMn71Cw2WqvYydpfCwyNdZY1oasSvr1DznLQyBVaH/3fE9DToRhAXnI
         p+upszjQZjgdPf0CnaoCX08JiMiawGlrCcnmxEBjPrUxEcPLS4LeorJrsqKDeDzVkgVW
         cR6V4lXBCpvGt3gxJh0VWMLwnD+IKl5DTQCKoDH0qGLQobowYc7ESADfoqKFP0yeNlRR
         Y90N5UxmM8tFum8gYL59Y7/8Fop5sQDjcgCrSL1A2muyPotVYnpoQzKatOsC4d1wW1Rk
         3+Yg==
X-Gm-Message-State: AC+VfDw8UmUAX/Si1PvxVR7jIE95c0Rkf1nEeFe0IhRZQRvlrZXCQ7oY
        CqBY5pAAx0NdnoSncOvKjsS7HN+6yg==
X-Google-Smtp-Source: ACHHUZ69QKqtFpwkYTh0ifon5IJmXcPzuTd7nuUrM8iS0yUyytLtTaZAuHUDpCTiTnbU9TDufxE0QfX6wA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a5b:b4a:0:b0:bac:f608:7113 with SMTP id
 b10-20020a5b0b4a000000b00bacf6087113mr1547448ybr.4.1686358326518; Fri, 09 Jun
 2023 17:52:06 -0700 (PDT)
Date:   Sat, 10 Jun 2023 00:51:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230610005149.1145665-1-rmoar@google.com>
Subject: [RFC v1 0/6] kunit: Add test attributes API
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello everyone,

This is an RFC patch series to propose the addition of a test attributes
framework to KUnit.

There has been interest in filtering out "slow" KUnit tests. Most notably,
a new config, CONFIG_MEMCPY_SLOW_KUNIT_TEST, has been added to exclude
particularly slow memcpy tests
(https://lore.kernel.org/all/20230118200653.give.574-kees@kernel.org/).

This proposed attributes framework would be used to save and access test
associated data, including whether a test is slow. These attributes would
be reportable (via KTAP and command line output) and some will be
filterable.

This framework is designed to allow for the addition of other attributes in
the future. These attributes could include whether the test is flaky,
associated test files, etc.

Note that this could intersect with the discussions on how to format
test-associated data in KTAP v2 that I am also involved in
(https://lore.kernel.org/all/20230420205734.1288498-1-rmoar@google.com/).

If the overall idea seems good, I'll make sure to add tests/documentation,
and more patches marking existing tests as slow to the patch series.

Thanks!
Rae

Rae Moar (6):
  kunit: Add test attributes API structure
  kunit: Add speed attribute
  kunit: Add ability to filter attributes
  kunit: tool: Add command line interface to filter and report
    attributes
  kunit: memcpy: Mark tests as slow using test attributes
  kunit: time: Mark test as slow using test attributes

 include/kunit/attributes.h             |  41 ++++
 include/kunit/test.h                   |  62 ++++++
 kernel/time/time_test.c                |   2 +-
 lib/kunit/Makefile                     |   3 +-
 lib/kunit/attributes.c                 | 280 +++++++++++++++++++++++++
 lib/kunit/executor.c                   |  89 ++++++--
 lib/kunit/executor_test.c              |   8 +-
 lib/kunit/kunit-example-test.c         |   9 +
 lib/kunit/test.c                       |  17 +-
 lib/memcpy_kunit.c                     |   8 +-
 tools/testing/kunit/kunit.py           |  34 ++-
 tools/testing/kunit/kunit_kernel.py    |   6 +-
 tools/testing/kunit/kunit_tool_test.py |  41 ++--
 13 files changed, 536 insertions(+), 64 deletions(-)
 create mode 100644 include/kunit/attributes.h
 create mode 100644 lib/kunit/attributes.c


base-commit: fefdb43943c1a0d87e1b43ae4d03e5f9a1d058f4
-- 
2.41.0.162.gfafddb0af9-goog

