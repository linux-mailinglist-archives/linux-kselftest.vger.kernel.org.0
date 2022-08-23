Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA8F59E7E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243792AbiHWQrK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 12:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344137AbiHWQqu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 12:46:50 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F206C6EA6
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 07:25:05 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id b25-20020aa78119000000b00536a929d8e4so2548389pfi.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=pCH+0+WgsyXCYOEIW3yqb1d5hzYj9lEXIljmIvf1UF4=;
        b=GKnHlleymq6aVUseYQkCkYJTcj3+Hllew3xD3cBBcATPMgtQht5r0zd6CNdNPkGZ2E
         cIuhwPujGAJbEIybRkp5h8BCUG05Ni7Aqy5hlvyeV7ytytijPlGF0ML4yLsdbnxBlT7O
         v/Q4vYjT27cq8xCAfXaMxibDaCtMD0R+Wg8Xg6fxszjEq+5wNeGHhC8zjOk5uvyfOqWx
         ekWKec3iTLIBe1ko+sjdYz7CP8xzuVD0fcU/rY0CuNqyMJxQWRUIVOZfQDeldrSLAVCe
         KMOYtyEW1xBRTqndO+xaq0kjGZY0s5akiv1QJ/rF2MLw2HQZL7Ju5l7pMQIyVe7WlRjl
         6/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=pCH+0+WgsyXCYOEIW3yqb1d5hzYj9lEXIljmIvf1UF4=;
        b=zMj4t1DPABMmPV1LxpuYyBQydSxhKLDJ0TVcj7mWCVx7J7JYwOZnLrAx4n4d6e9Re5
         N4NYHqr5xh7zMsXEgrMP5tbmYOS3CFaEKp2sSZUdgwy1ZIgMvRvkkE6Ix51jzfvkVykl
         sd3EIBl3h7jx6PFNo3Dn5WJ2tOJmhbklqvHPc3cC2E6ObzZc8hL+z9LWBslCRGyyVZC4
         e85IUm4Fm7dYA7mYmrHxCPkLRzjjYs+hkGwjinZQ8n5qEpf8MW6XoRD62ROn+imxPEfv
         7D3m9OecTauiIN2BK4JQjcLb4/hjdXxTCnzVYsxOsksKlXBhhAdy6A0sz6GHxhGpvXhp
         tuUA==
X-Gm-Message-State: ACgBeo0lBK+49ahVb2KGxt1onlGeCUQkfW072uk3VqMRdttBF6Nbbdyc
        05QLQSLj27biysFWZJAxAMkvvxTiBgZTmBQ=
X-Google-Smtp-Source: AA6agR6nYNAxXcwgvNFnFPYMJnYjm6NiVtfJwycgVCE4j79759ovERhuyFxKEVo91melnqmvoQrKMdCuAiJDSamH
X-Received: from joefradley-custom-96.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:831])
 (user=joefradley job=sendgmr) by 2002:aa7:8430:0:b0:536:5173:a2c6 with SMTP
 id q16-20020aa78430000000b005365173a2c6mr15526807pfn.4.1661264704758; Tue, 23
 Aug 2022 07:25:04 -0700 (PDT)
Date:   Tue, 23 Aug 2022 07:24:54 -0700
In-Reply-To: <20220823142456.3977086-1-joefradley@google.com>
Message-Id: <20220823142456.3977086-2-joefradley@google.com>
Mime-Version: 1.0
References: <20220823142456.3977086-1-joefradley@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2 1/2] kunit: add kunit.enable to enable/disable KUnit test
From:   Joe Fradley <joefradley@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     Joe Fradley <joefradley@google.com>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
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

This patch adds the kunit.enable module parameter that will need to be
set to true in addition to KUNIT being enabled for KUnit tests to run.
The default value is true giving backwards compatibility. However, for
the production+testing use case the new config option
KUNIT_DEFAULT_ENABLED can be set to N requiring the tester to opt-in
by passing kunit.enable=1 to the kernel.

Signed-off-by: Joe Fradley <joefradley@google.com>
---
Changes since v1:
- Created a function to get kunit enable state
- Check kunit enable state in kunit_run_all_tests() in executor.c
- Load test module even if KUnit is disabled but still don't execute
  tests
- Simplified kunit disable message and kunit.enable parameter
  description
- Flipped around logic of new config to be KUNIT_DEFAULT_ENABLED
- kunit_tool.py now passes kunit.enable=1 to kernel

 .../admin-guide/kernel-parameters.txt         |  6 +++++
 include/kunit/test.h                          |  2 ++
 lib/kunit/Kconfig                             | 11 +++++++++
 lib/kunit/executor.c                          |  4 ++++
 lib/kunit/test.c                              | 24 +++++++++++++++++++
 tools/testing/kunit/kunit_kernel.py           |  1 +
 6 files changed, 48 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index adfda56b2691..7aa3abd7f1c5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2432,6 +2432,12 @@
 			0: force disabled
 			1: force enabled
 
+	kunit.enable=	[KUNIT] Enable executing KUnit tests. Requires
+			CONFIG_KUNIT to be set to be fully enabled. The
+			default value can be overridden via
+			KUNIT_DEFAULT_ENABLED.
+			Default is 1 (enabled)
+
 	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
 			Default is 0 (don't ignore, but inject #GP)
 
diff --git a/include/kunit/test.h b/include/kunit/test.h
index c958855681cc..ee6bf4ecbd89 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -228,6 +228,8 @@ static inline void kunit_set_failure(struct kunit *test)
 	WRITE_ONCE(test->status, KUNIT_FAILURE);
 }
 
+bool kunit_enabled(void);
+
 void kunit_init_test(struct kunit *test, const char *name, char *log);
 
 int kunit_run_tests(struct kunit_suite *suite);
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 0b5dfb001bac..626719b95bad 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -59,4 +59,15 @@ config KUNIT_ALL_TESTS
 
 	  If unsure, say N.
 
+config KUNIT_DEFAULT_ENABLED
+	bool "Default value of kunit.enable"
+	default y
+	help
+	  Sets the default value of kunit.enable. If set to N then KUnit
+	  tests will not execute unless kunit.enable=1 is passed to the
+	  kernel command line.
+
+	  In most cases this should be left as Y. Only if additional opt-in
+	  behavior is needed should this be set to N.
+
 endif # KUNIT
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 5e223327196a..9bbc422c284b 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -190,6 +190,10 @@ int kunit_run_all_tests(void)
 {
 	struct suite_set suite_set = {__kunit_suites_start, __kunit_suites_end};
 	int err = 0;
+	if (!kunit_enabled()) {
+		pr_info("kunit: disabled\n");
+		goto out;
+	}
 
 	if (filter_glob_param) {
 		suite_set = kunit_filter_suites(&suite_set, filter_glob_param, &err);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index b73d5bb5c473..1e54373309a4 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -54,6 +54,17 @@ void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
 EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
 #endif
 
+/*
+ * Enable KUnit tests to run.
+ */
+#ifdef CONFIG_KUNIT_DEFAULT_ENABLED
+static bool enable_param = true;
+#else
+static bool enable_param;
+#endif
+module_param_named(enable, enable_param, bool, 0);
+MODULE_PARM_DESC(enable, "Enable KUnit tests");
+
 /*
  * KUnit statistic mode:
  * 0 - disabled
@@ -586,10 +597,20 @@ static void kunit_init_suite(struct kunit_suite *suite)
 	suite->suite_init_err = 0;
 }
 
+bool kunit_enabled(void)
+{
+	return enable_param;
+}
+
 int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites)
 {
 	unsigned int i;
 
+	if (!kunit_enabled() && num_suites > 0) {
+		pr_info("kunit: disabled\n");
+		return 0;
+	}
+
 	for (i = 0; i < num_suites; i++) {
 		kunit_init_suite(suites[i]);
 		kunit_run_tests(suites[i]);
@@ -607,6 +628,9 @@ void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites)
 {
 	unsigned int i;
 
+	if (!kunit_enabled())
+		return;
+
 	for (i = 0; i < num_suites; i++)
 		kunit_exit_suite(suites[i]);
 
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index f5c26ea89714..ef794da420d7 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -359,6 +359,7 @@ class LinuxSourceTree:
 			args = []
 		if filter_glob:
 			args.append('kunit.filter_glob='+filter_glob)
+		args.append('kunit.enable=1')
 
 		process = self._ops.start(args, build_dir)
 		assert process.stdout is not None  # tell mypy it's set
-- 
2.37.1.595.g718a3a8f04-goog

