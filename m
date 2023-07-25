Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928AD76244C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 23:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjGYVZb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 17:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGYVZb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 17:25:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1100F1FDD
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 14:25:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5840614b107so26440887b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 14:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690320328; x=1690925128;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1BncUN+zxsP5jL5qBPBFJiIzgW7UOfc4w8KYyzj3ScI=;
        b=QnwBoAOnhYZ7R8UVvGHqcCPy1vPb+326cnbSsoW+eyzwAp1kyyFf2dWTCh301GsO0y
         eg+XQAfZkVmwh7hK6uLYgDQXtcr3qALDorbc86Num/iM/d2mLNdAQVjatQQu27QuonEO
         cHfDnO2FbYZUE5OwnTdjqTEsLvU1hpYSn1HdstuDvGnRToxW3zkg28CYdnVeus/tCktl
         6nobV9L7yp7kfcq6xUDOq+zY4y3mD6u+KNDo+fKe0d41z7vbUppES+YSVmdNl+z8A5a2
         Nkek+41sNJ6KZZPX43KtYO55nZvg0qAiKUVJ8VP2v2eIVQPJR8pKlMOclG5wqFGBdItB
         kpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690320328; x=1690925128;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1BncUN+zxsP5jL5qBPBFJiIzgW7UOfc4w8KYyzj3ScI=;
        b=Yagm/14taKfksaYnEJZozbAsd+eb5/TrRnZOkYO3o48g/OzNK4hlHiAqQG35VLlMaH
         9MronflEfglxzv9VGOe+1QhGr07R7YB8XVSspmM1AO+Q8H0HIGgTXyZ/nK//K7sBfYBA
         XHNlnUckcDYocy9ZnAUbYVMbIzH3VuffR8npIlDf2q7AkkwthwYkQIUNl0ZuTNT5Vmjl
         M6M0js0ZOXabI6NA33pUUbPwojSES9WFaEc96mrJtNrblKP83SMU4O7rBq0W9ENrip7Y
         J0Xa4M00oRMNQsKQSK+MknExQrPXuFSs70crLT7sfdver+K9pUyk36j57R5dxwRqSw8c
         9vlQ==
X-Gm-Message-State: ABy/qLaiaNnnObVJ/+Tq3q3Eyf7Fu0mNSrGa1+kfbv7siFQthsAPruyi
        Hjp811ftWwGACKNzSss1DE7FWo1Z7w==
X-Google-Smtp-Source: APBJJlGjCCMA10e7CahKn3Uv2jbrI8fZUrnzONQDvt/eO6t0mDZDvfZsl4xMumEZoLlH9NnSSYnocYkdkA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:b71d:0:b0:579:e379:d5ab with SMTP id
 v29-20020a81b71d000000b00579e379d5abmr3453ywh.6.1690320328318; Tue, 25 Jul
 2023 14:25:28 -0700 (PDT)
Date:   Tue, 25 Jul 2023 21:25:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725212522.1622716-1-rmoar@google.com>
Subject: [PATCH v3 0/9] kunit: Add test attributes API
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
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello everyone,

This patch series adds a test attributes framework to KUnit.

There has been interest in filtering out "slow" KUnit tests. Most notably,
a new config, CONFIG_MEMCPY_SLOW_KUNIT_TEST, has been added to exclude a
particularly slow memcpy test
(https://lore.kernel.org/all/20230118200653.give.574-kees@kernel.org/).

This attributes framework can be used to save and access test associated
data, including whether a test is slow. These attributes are reportable
(via KTAP and command line output) and are also filterable.

This framework is designed to allow for the addition of other attributes in
the future. These attributes could include whether the test can be run
concurrently, test file path, etc.

To try out the framework I suggest running:
"./tools/testing/kunit/kunit.py run --filter speed!=slow"

This patch series was originally sent out as an RFC. Here is a link to the
RFC v2:
https://lore.kernel.org/all/20230707210947.1208717-1-rmoar@google.com/

Thanks!
Rae

Rae Moar (9):
  kunit: Add test attributes API structure
  kunit: Add speed attribute
  kunit: Add module attribute
  kunit: Add ability to filter attributes
  kunit: tool: Add command line interface to filter and report
    attributes
  kunit: memcpy: Mark tests as slow using test attributes
  kunit: time: Mark test as slow using test attributes
  kunit: add tests for filtering attributes
  kunit: Add documentation of KUnit test attributes

 Documentation/dev-tools/kunit/run_wrapper.rst |  12 +
 .../dev-tools/kunit/running_tips.rst          | 166 +++++++
 include/kunit/attributes.h                    |  50 +++
 include/kunit/test.h                          |  70 ++-
 kernel/time/time_test.c                       |   2 +-
 lib/Kconfig.debug                             |   3 +
 lib/kunit/Makefile                            |   3 +-
 lib/kunit/attributes.c                        | 418 ++++++++++++++++++
 lib/kunit/executor.c                          | 114 ++++-
 lib/kunit/executor_test.c                     | 128 +++++-
 lib/kunit/kunit-example-test.c                |   9 +
 lib/kunit/test.c                              |  27 +-
 lib/memcpy_kunit.c                            |   8 +-
 tools/testing/kunit/kunit.py                  |  70 ++-
 tools/testing/kunit/kunit_kernel.py           |   8 +-
 tools/testing/kunit/kunit_parser.py           |  11 +-
 tools/testing/kunit/kunit_tool_test.py        |  39 +-
 17 files changed, 1062 insertions(+), 76 deletions(-)
 create mode 100644 include/kunit/attributes.h
 create mode 100644 lib/kunit/attributes.c


base-commit: 64bd4641310c41a1ecf07c13c67bc0ed61045dfd
-- 
2.41.0.487.g6d72f3e995-goog

