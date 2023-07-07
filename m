Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC5474B882
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 23:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjGGVJy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 17:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGVJy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 17:09:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BD61BEE
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jul 2023 14:09:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c6db61f7f64so1178062276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jul 2023 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688764192; x=1691356192;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZTrWAIUayaBHwDRCQHgGm0qH9ucv7JkIRMB8GVQtyc8=;
        b=pmsOikxbpPPKi6SHT/ZT9CcQCmKqH1TPbAL1YPRN+/EvfSYqZWCf7863xGKzcQw3sc
         nGY1ZvpN6V73iMT5yLIJSRHdqLgxPw7aJYWkMGrfhzlOyvibq/HcsR9w/z4z/VyaZgfp
         n91L4Uj89hsFLFnir4XCaN/Z43f4e72guBYeLJrmAbIU1n4ebxgu/frUIpm4/JM2GMSR
         ac/7WzQi4sFjz0Kq6KC8XUhUlg+jcGnjcx5QuqG/cGR+5WgczLyULdXlRnx//5JSW+Hl
         ZEmlEvSZcKJg4Loxr8JjWRoh0Iz1sAtEdqzc6s3cCGH4jMGc1xAdc2VL8/SEYbnBCp8K
         Rppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764192; x=1691356192;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZTrWAIUayaBHwDRCQHgGm0qH9ucv7JkIRMB8GVQtyc8=;
        b=Ar3edHj48W/8YFkbaiwEV/i7uuw3YKPxKqDWnAla5oJ1gv4KSCd4wFxfMsa22kyJJA
         fkn71bkDogEyuz/m6O+m3SR8aUQZhNJ2xJMYt+F9GHeqbjcf5avxMcJ9q6rYvtVZVA32
         G0K6iGINHyHRb4/aabFHUDU/aK48ti9hnp+Vx9uyKHXB3nMOIjdd7bVVNllrpSlkRn6O
         MB+LZakWsZ4SQTN3X/wRvNLgosa2zeSPS2WLQ6nqrm781IuLdmf4BbD6ziEG+lxuQSb7
         5EnmkdtUIuEfVfFaEgXiet3DsIzhrJngVo5+84Km8UYI4KWFKdzqSwGJo9eq2K2IbQeF
         cPuQ==
X-Gm-Message-State: ABy/qLYHHkLCGsIv2nkpgjXTBne3ZY7nQjfdabH284GwUhYddzyErxIA
        1ZT7nDmrPR1njXiCjuRBDRFFlpc9hg==
X-Google-Smtp-Source: APBJJlEPnJyZGvM2uGKYUD1nOk5qT6VODaXbHCvI2N2eVZ52/OvsSLtf0T7C4cYLKR9etuF/AgRHl9cpLA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:ae8a:0:b0:c5f:85f5:a0e5 with SMTP id
 b10-20020a25ae8a000000b00c5f85f5a0e5mr56453ybj.5.1688764192066; Fri, 07 Jul
 2023 14:09:52 -0700 (PDT)
Date:   Fri,  7 Jul 2023 21:09:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707210947.1208717-1-rmoar@google.com>
Subject: [RFC v2 0/9] kunit: Add test attributes API
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
a new config, CONFIG_MEMCPY_SLOW_KUNIT_TEST, has been added to exclude a
particularly slow memcpy test
(https://lore.kernel.org/all/20230118200653.give.574-kees@kernel.org/).

This proposed attributes framework would be used to save and access test
associated data, including whether a test is slow. These attributes would
be reportable (via KTAP and command line output) and some will be
filterable.

This framework is designed to allow for the addition of other attributes in
the future. These attributes could include whether the test is flaky,
associated test files, etc.

This is the second version of the RFC I have added a few big changes:
- Change method for inputting filters to allow for spaces in filtering
  values
- Add option to skip filtered tests instead of not run or show them with
  the --filter_skip flag
- Separate the new feature to list tests and their attributes into both
  --list_tests (lists just tests) and --list_tests_attr (lists all)
- Add new attribute to store module name associated with test
- Add Tests to executor_test.c
- Add Documentation
- A few small changes to code commented on previously

I would love to hear about the new features. If the series seems overall
good I will send out the next version as an official patch series.

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

 .../dev-tools/kunit/running_tips.rst          | 163 +++++++
 include/kunit/attributes.h                    |  50 +++
 include/kunit/test.h                          |  68 ++-
 kernel/time/time_test.c                       |   2 +-
 lib/Kconfig.debug                             |   3 +
 lib/kunit/Makefile                            |   3 +-
 lib/kunit/attributes.c                        | 406 ++++++++++++++++++
 lib/kunit/executor.c                          | 115 ++++-
 lib/kunit/executor_test.c                     | 119 ++++-
 lib/kunit/kunit-example-test.c                |   9 +
 lib/kunit/test.c                              |  27 +-
 lib/memcpy_kunit.c                            |   8 +-
 tools/testing/kunit/kunit.py                  |  80 +++-
 tools/testing/kunit/kunit_kernel.py           |   6 +-
 tools/testing/kunit/kunit_tool_test.py        |  39 +-
 15 files changed, 1022 insertions(+), 76 deletions(-)
 create mode 100644 include/kunit/attributes.h
 create mode 100644 lib/kunit/attributes.c


base-commit: 2e66833579ed759d7b7da1a8f07eb727ec6e80db
-- 
2.41.0.255.g8b1d071c50-goog

