Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABABA6EA288
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 06:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjDUECl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 00:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjDUECh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 00:02:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6A465B8
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Apr 2023 21:02:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f34ed571bso1933464276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Apr 2023 21:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682049753; x=1684641753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEBiF7ByWZHT8hk8CTAs7S8P0dMCig1qp9ER8e9wTTI=;
        b=zaKGvpPPkSpchoZHU6U0I24jBX2qIKZqPmCqLKQwxNsTvgcZmojAMcmLO77HZwoA2Q
         5PUv8FWzIKAwO240MbvzUMu1QzqMgdq3d5WqERH/Hdv8lsL3xy/hdKDD63Pm3IzQqwrI
         gsqPoRnR/DC0HzKjOoaX2jp9LOfsnJerUmo1ZVU+dsM8uAMc8gqqZyUUTPMgBnW/t69x
         qcb4IqlcuqLlfka5CuirZs99gUDidt8kf3a0DXbNZHAJsStpaVx9/w9FVVBQhONmB82C
         GpyMdm0ZR+qTmteIe5XzfNe3lffxuOTR2xK/Y3B6tQ1v9dMVZEciYyM+grJaVeMepiOD
         qNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682049753; x=1684641753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEBiF7ByWZHT8hk8CTAs7S8P0dMCig1qp9ER8e9wTTI=;
        b=HjGviQPLPvEqWeqCwM/8BaECFb9ZYHz6pA7Vwesxnc1yO9MOXmxrMNl+NJ3Wicq6II
         QAR/8/eOoefNDBHdVqzGB8Qt1PVy9O7ydSQZkiC7yHc5uTYBFkBZy56NdbaktNA1x1YM
         vwvodz0x/sIAJIVrdJgRkqeolBYUJ58Gxw1KQ0UoYu9PGZb3ezxUpE8EM7yLdPVdWPcj
         hYUNymrz8aojo0WGoHAAdFP1O04kxzLfCNcKk/3de0HrkU5kt9QkXnW/EkS45acYn1sg
         ni8SvHx3wNIbZjjpeNNGk+24UaDw/0QLUXfi5cLr6DpwP/PCM4JlEwMiSII56Yw/L0U5
         ap0Q==
X-Gm-Message-State: AAQBX9e+SNgiNHIZruZwR3/LpCZaU2dfIrik3yP1UT9HQtTuV7Kyo7PQ
        FZQulPY5mk5VKcyshHnzL6ufSByr384O0A==
X-Google-Smtp-Source: AKy350Z4qe08DAOgSQCJ/aJkhSWjti/yq3AmrcunrXa5Dr5OO3XBAOZOvW7bm47CFcUVlqiZuF1VXH8w6XShUQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:ca12:0:b0:b96:347d:46e7 with SMTP id
 a18-20020a25ca12000000b00b96347d46e7mr905278ybg.1.1682049753474; Thu, 20 Apr
 2023 21:02:33 -0700 (PDT)
Date:   Fri, 21 Apr 2023 12:02:17 +0800
In-Reply-To: <20230421040218.2156548-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230421040218.2156548-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421040218.2156548-3-davidgow@google.com>
Subject: [PATCH v3 3/4] Documentation: kunit: Warn that exit functions run
 even if init fails
From:   David Gow <davidgow@google.com>
To:     Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, maxime@cerno.tech,
        Stephen Boyd <sboyd@kernel.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sadiya Kazi <sadiyakazi@google.com>
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

KUnit's exit functions will run even if the corresponding init function
fails. It's easy, when writing an exit function, to assume the init
function succeeded, and (for example) access uninitialised memory or
dereference NULL pointers.

Note that this case exists and should be handled in the documentation.

Suggested-by: Benjamin Berg <benjamin@sipsolutions.net>
Link: https://lore.kernel.org/linux-kselftest/a39af0400abedb2e9b31d84c37551cecc3eed0e1.camel@sipsolutions.net/
Signed-off-by: David Gow <davidgow@google.com>
---

No changes since v2:
https://lore.kernel.org/linux-kselftest/20230419085426.1671703-3-davidgow@google.com/

This patch was introduced in v2.

---
 Documentation/dev-tools/kunit/usage.rst | 12 ++++++++++--
 include/kunit/test.h                    |  3 +++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 9f720f1317d3..f6d6c9a9ff54 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -166,7 +166,12 @@ many similar tests. In order to reduce duplication in these closely related
 tests, most unit testing frameworks (including KUnit) provide the concept of a
 *test suite*. A test suite is a collection of test cases for a unit of code
 with optional setup and teardown functions that run before/after the whole
-suite and/or every test case. For example:
+suite and/or every test case.
+
+.. note::
+   A test case will only run if it is associated with a test suite.
+
+For example:
 
 .. code-block:: c
 
@@ -196,7 +201,10 @@ after everything else. ``kunit_test_suite(example_test_suite)`` registers the
 test suite with the KUnit test framework.
 
 .. note::
-   A test case will only run if it is associated with a test suite.
+   The ``exit`` and ``suite_exit`` functions will run even if ``init`` or
+   ``suite_init`` fail. Make sure that they can handle any inconsistent
+   state which may result from ``init`` or ``suite_init`` encoutering errors
+   or exiting early.
 
 ``kunit_test_suite(...)`` is a macro which tells the linker to put the
 specified test suite in a special linker section so that it can be run by KUnit
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 57b309c6ca27..3028a1a3fcad 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -168,6 +168,9 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  * test case, similar to the notion of a *test fixture* or a *test class*
  * in other unit testing frameworks like JUnit or Googletest.
  *
+ * Note that @exit and @suite_exit will run even if @init or @suite_init
+ * fail: make sure they can handle any inconsistent state which may result.
+ *
  * Every &struct kunit_case must be associated with a kunit_suite for KUnit
  * to run it.
  */
-- 
2.40.0.634.g4ca3ef3211-goog

