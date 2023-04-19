Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891516E75B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Apr 2023 10:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjDSIyq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Apr 2023 04:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjDSIyo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Apr 2023 04:54:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D9D975A
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Apr 2023 01:54:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u188-20020a2560c5000000b00b8f15f2111dso22886297ybb.4
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Apr 2023 01:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681894481; x=1684486481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vsadv1gG3CDyEQYTrAe8ESn/fsRH88WCdjO7AUKZ6mI=;
        b=GC9NXcZveJJfKa28bmp/brjsU9DlnA7il8SpiO2vjXq165ktn7pY8f3a9gKPbQsYFh
         rDnG8lbt0KQq43V+J4LPoag8yycHse5JYdFnD8weeosCSO4NgPn8AqYkCyaOjQo43if4
         jZKizq59s9pbd1YWcDuWl5ZDDxRXhnFugR8FX10BLK3Lp2MpdcR1AGFboL5FCERPVq9M
         4I02vg7QmzhsO4hg289OEjfU06p+Nj4iWFx6N78jRj04NpkyeVaNsiI/kCmBfnaSWUq1
         IyfTouUETKPnwJoLbNav6OfMwg0kGE0RWlia9a98mVGQAT3+y+EHbsxUjhU31y3JxkVQ
         rueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681894481; x=1684486481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vsadv1gG3CDyEQYTrAe8ESn/fsRH88WCdjO7AUKZ6mI=;
        b=BhUdpi7YbUDjOOvFYoCIzPpYHZtf9UqDFpOxwLDnX5ePAHw7I+CR5rW7yEno6OkoM+
         PsqymM21XxSDHbxxBq5wrRY/b/ZV1dfwc5ZCwBqk33bwfoVOKcdpN0YKUETcoIhCsfhK
         snIiU/6TNmmnnVWBo4ODta8DsJctsTXTuJGt9jjctRdnar5Ipekb4eGUWV1UYcrdWVEL
         VVrT70NVi7hDEy0XtM5TspcYXi8uTZ5VnDGk0FLUhMjJ9JJpekW2n/ZNCP1tOwba5WeX
         UHm0y4Yt0eF2o90I25A0GORGXysNwu+p3VCJK2FMQVWK3kQdEPPFy3eVpXYSZxDW7nGq
         yfyQ==
X-Gm-Message-State: AAQBX9eCqbWyEnViDFmQtTkga4qTzIOXuM38wDOthyeXLo476sSubytv
        hayobcr9XUeLkMZFlnzLJ+rxHaSlgeyuEg==
X-Google-Smtp-Source: AKy350Zl269OSH2BlaSwkyOfBXt7dTNFIcXx9j9QAC6LHOPv8qed2YPjjSQLXFLl+hSKzsH/ymalqQc95dwvyA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:9f01:0:b0:545:1d7f:acbf with SMTP id
 s1-20020a819f01000000b005451d7facbfmr1501533ywn.10.1681894481486; Wed, 19 Apr
 2023 01:54:41 -0700 (PDT)
Date:   Wed, 19 Apr 2023 16:54:26 +0800
In-Reply-To: <20230419085426.1671703-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230419085426.1671703-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230419085426.1671703-3-davidgow@google.com>
Subject: [PATCH v2 3/3] Documentation: kunit: Warn that exit functions run
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
        autolearn=ham autolearn_force=no version=3.4.6
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

This patch is new in v2.

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

