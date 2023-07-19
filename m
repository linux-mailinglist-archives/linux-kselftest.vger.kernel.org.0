Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ACF75A1B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 00:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjGSWXu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 18:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjGSWXt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 18:23:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF011FE2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 15:23:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-cbcffb18afeso114099276.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 15:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689805428; x=1692397428;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wQ30uDB639VGNW+T7EeVAUkSIhG2Jevrm/2Jy436reA=;
        b=jGBW4v5uLMfOolbkZxtwRaLLhDb+BMh1OFRzrhGuOBXni+46bSXTF9cgl+VZEDO8Zi
         TrLvdFk/cyvWRxefzpSNGAOjgf6RjvfmnAO/RNmU2XbF19LVe4549pnH4RDAy4354SDL
         9gr3n8hzyoRQqFH0nUeXAmfAl3J0bzU9aVdfrmQrYG6FjniIUtREGJUpiN+akhOB2Yfs
         8V8GW9tAbO8kT0Xitj+p3G9GwiWPi4wxSsvL1f9o2OLllrYDR/o3RxkAJTNZKOIYoLhv
         7/LJk9tRrF9kMjmXactWkHW9l1NDolQBeLzictRKTBB/5LojaVtXTRImzGTMfPsV1e7d
         htxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805428; x=1692397428;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wQ30uDB639VGNW+T7EeVAUkSIhG2Jevrm/2Jy436reA=;
        b=eEQCkuB+qUSnl68QfohZWY43CGcBpNKemU9cqWGDlhitPMUylYNvrlpKIA1F2NzuKJ
         5RxslOHpujHQBZPUTw7vUn873O6DQ+K1YcrVp/JGtplfgg/zJ/JTXvKebgyA5WIcErP8
         2pEbfeUSfdPaLAfFvmiVjfxKIexKzAvu9uKt/rYMNKWGpPF7vyVsGCGKVHCSEQS7I1vg
         FK9QKJVtTapMjAW4SPBsQ7Syb73LyUxKIzuD73KLZ+fjUJyQ+sMFuo/TU1yZvhq93zoh
         jI6zk41f4bc9QQZCttETZWQXH3glop+UV0CKHpDIwUT9ARoUIdhuczl7U9qpeFwxz2lV
         yX/Q==
X-Gm-Message-State: ABy/qLavJ1DkVpRD7S5QtPS4gi7lhf5Nr9dORQPd7cpM80zmTEyLLkD1
        tproDRMIg042qyqM/Enhs95bbyP9MA==
X-Google-Smtp-Source: APBJJlFrNajcvUKs2zJQGw2iGbgoAs6cobJeNjOkOO+vtQ7UQaL9jkZXJPWY6CCIfr6/5UEwBDIrwYfWSA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:1709:b0:cab:e42c:876b with SMTP id
 by9-20020a056902170900b00cabe42c876bmr34333ybb.3.1689805427820; Wed, 19 Jul
 2023 15:23:47 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:23:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719222338.259684-1-rmoar@google.com>
Subject: [PATCH v1 0/9] kunit: Add test attributes API
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

 .../dev-tools/kunit/running_tips.rst          | 166 +++++++
 include/kunit/attributes.h                    |  50 +++
 include/kunit/test.h                          |  70 ++-
 kernel/time/time_test.c                       |   2 +-
 lib/Kconfig.debug                             |   3 +
 lib/kunit/Makefile                            |   3 +-
 lib/kunit/attributes.c                        | 421 ++++++++++++++++++
 lib/kunit/executor.c                          | 115 ++++-
 lib/kunit/executor_test.c                     | 128 +++++-
 lib/kunit/kunit-example-test.c                |   9 +
 lib/kunit/test.c                              |  27 +-
 lib/memcpy_kunit.c                            |   8 +-
 tools/testing/kunit/kunit.py                  |  70 ++-
 tools/testing/kunit/kunit_kernel.py           |   8 +-
 tools/testing/kunit/kunit_parser.py           |  11 +-
 tools/testing/kunit/kunit_tool_test.py        |  39 +-
 16 files changed, 1054 insertions(+), 76 deletions(-)
 create mode 100644 include/kunit/attributes.h
 create mode 100644 lib/kunit/attributes.c


base-commit: 64bd4641310c41a1ecf07c13c67bc0ed61045dfd
-- 
2.41.0.255.g8b1d071c50-goog

