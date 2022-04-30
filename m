Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CCB5159F7
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Apr 2022 05:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiD3DEE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 23:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240546AbiD3DDt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 23:03:49 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24D1A196
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 20:00:25 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id x2-20020a63aa42000000b003aafe948eeeso4299243pgo.0
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 20:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y0mJtz6kGToZ1XuYtks7aF8CEo8QOuFB6egMwMGeOWg=;
        b=nbl8KYpua6DCCViS49Tu7tFMSfJFNtItyA9PjOYQUt/zaQpxJ+Qk+MzKnJ2Uws5813
         xILu9buerl4skg+dLPG/xwJtdhMH3qEk5SBHQt7izarOoqvXn5fBrbXlNdo9FWjmOCtt
         k46+OAwUgCUm2leSRfcbs5hVejtSDmlCDWUzfHxc8J8u5APkCXBPw9AYO+c0gI1hDA0a
         t4l0pVkk10pT2rq+2WfVNPeHTchGYQ5ggguwhCUF7XocASQx2Sud+OyHJNMIPlu+8BSU
         0foH7DU3KVCt+LPQ7JLp3CyA7ngS1P4UENLCGzqoVwxsuv3R4da85sDJd2h6T4dEDxWl
         wjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y0mJtz6kGToZ1XuYtks7aF8CEo8QOuFB6egMwMGeOWg=;
        b=BQl4PdkLK3CWFQzTgZ5hZpr2r42RTEn7yXKE55ZBV73ZuiXvAYuGHeHozP7kvaorGO
         na6rRyUjFJVf88yUgc7yJ57rCUo41ZJQdKyAWYYHgXRBTxEnm29ho8t29P9+YvOVu7u3
         OKlBaSIgiXFEVvUEjx/hISlM4o69n/lcVPlhakIkqnst7RcdBvLNticQWT2idB4ZlREj
         DS2IHQ+2ze878nmIjX5KwSkR6pE1IeBgNhBQc3FKSG+vwthpiOwb99kFdDSbEeTfwQ+D
         5hPCn/WZovF33sJ3/0fxcTwIPfzvN/45gRhA3YLYns8jgtpKBFT5ZfnEEIdfkqiL8eqT
         4QGA==
X-Gm-Message-State: AOAM531J1SGMSaohoNRCj8D+ZHo//1YgzKppeJiFP/i41i9EiRH1u4x9
        bD5pe8bHsdaKmvWtET5rlDXYf+1LWcnXBA==
X-Google-Smtp-Source: ABdhPJyrr+ZW4u6syRGXqvYmBAKZH0ORoShKd169l9smKllVepRzNAcvxS7PCTyychjlH0jQZuqOha85xnlSKg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:c986:b0:1d9:56e7:4e83 with SMTP
 id w6-20020a17090ac98600b001d956e74e83mr497866pjt.1.1651287624304; Fri, 29
 Apr 2022 20:00:24 -0700 (PDT)
Date:   Sat, 30 Apr 2022 11:00:19 +0800
In-Reply-To: <20220429043913.626647-1-davidgow@google.com>
Message-Id: <20220430030019.803481-1-davidgow@google.com>
Mime-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2] kunit: Taint kernel if any tests run
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit tests are not supposed to run on production systems: they may do
deliberately illegal things to trigger errors, and have security
implications (assertions will often deliberately leak kernel addresses).

Add a new taint type, TAINT_KUNIT to signal that a KUnit test has been
run. This will be printed as 'N' (for kuNit, as K, U and T were already
taken).

This should discourage people from running KUnit tests on production
systems, and to make it easier to tell if tests have been run
accidentally (by loading the wrong configuration, etc.)

Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220429043913.626647-1-davidgow@google.com/
- Make the taint per-module, to handle the case when tests are in
  (longer lasting) modules. (Thanks Greg KH).

Note that this still has checkpatch.pl warnings around bracket
placement, which are intentional as part of matching the surrounding
code.

---
 Documentation/admin-guide/tainted-kernels.rst | 1 +
 include/linux/panic.h                         | 3 ++-
 kernel/panic.c                                | 1 +
 lib/kunit/test.c                              | 4 ++++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index ceeed7b0798d..8f18fc4659d4 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -100,6 +100,7 @@ Bit  Log  Number  Reason that got the kernel tainted
  15  _/K   32768  kernel has been live patched
  16  _/X   65536  auxiliary taint, defined for and used by distros
  17  _/T  131072  kernel was built with the struct randomization plugin
+ 18  _/N  262144  a KUnit test has been run
 ===  ===  ======  ========================================================
 
 Note: The character ``_`` is representing a blank in this table to make reading
diff --git a/include/linux/panic.h b/include/linux/panic.h
index f5844908a089..1d316c26bf27 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -74,7 +74,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_LIVEPATCH			15
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
-#define TAINT_FLAGS_COUNT		18
+#define TAINT_KUNIT			18
+#define TAINT_FLAGS_COUNT		19
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/kernel/panic.c b/kernel/panic.c
index eb4dfb932c85..9a026d98a00c 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -404,6 +404,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
 	[ TAINT_AUX ]			= { 'X', ' ', true },
 	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
+	[ TAINT_KUNIT ]			= { 'N', ' ', true },
 };
 
 /**
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 0f66c13d126e..ea8e9162445d 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -11,6 +11,7 @@
 #include <kunit/test-bug.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
+#include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
 
@@ -498,6 +499,9 @@ int kunit_run_tests(struct kunit_suite *suite)
 	struct kunit_result_stats suite_stats = { 0 };
 	struct kunit_result_stats total_stats = { 0 };
 
+	/* Taint the kernel so we know we've run tests. */
+	add_taint(TAINT_KUNIT, LOCKDEP_STILL_OK);
+
 	kunit_print_subtest_start(suite);
 
 	kunit_suite_for_each_test_case(suite, test_case) {
-- 
2.36.0.464.gb9c8b46e94-goog

