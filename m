Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D743769925
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 16:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjGaONE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 10:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjGaOMt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 10:12:49 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1AFB8;
        Mon, 31 Jul 2023 07:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690812767; x=1722348767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C6julir46vLWT1EqiSA60X1VgzepuKjpvOpc4UuLp2Q=;
  b=PfNsLwHQeh1rqjMmQpEztkJUdzZym0ymEL+BO4uZUNNnZqpRzuWuEw5F
   TrHAL+HfDzuTiDICRjiPzAQsN4GwlhUi/pFFrPnfwNMt+3M1wSKOgspFi
   DP8BgahMiCSlIe8t1zCQufuxNFoWMYVXX4Ca/LJJecppOcxrLh4ZNtwga
   fq5lDe7iUnJzNwfCFrpUO06w64CheWOlviwc6B4jgHaQLucytUp9lFOkc
   1AyP53XlhAoqJ3MwRwP1AgTBc0NGDQgV0Sahf2aE5TAiZ3Ywa/KWP/nZ1
   WQqlqI/Y9f6dCS7Z3cD4LT/bExFmLw3/zjM1E8WjFW1K04EvAWtw5YnON
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="455403643"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="455403643"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 07:12:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="728324355"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="728324355"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO jkrzyszt-mobl2.intranet) ([10.213.1.128])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 07:12:44 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        igt-dev@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH v3 2/3] kunit: Make 'list' action available to kunit test modules
Date:   Mon, 31 Jul 2023 16:10:24 +0200
Message-ID: <20230731141021.2854827-7-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731141021.2854827-5-janusz.krzysztofik@linux.intel.com>
References: <20230731141021.2854827-5-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Results from kunit tests reported via dmesg may be interleaved with other
kernel messages.  When parsing dmesg for modular kunit results in real
time, external tools, e.g., Intel GPU tools (IGT), may want to insert
their own test name markers into dmesg at the start of each test, before
any kernel message related to that test appears there, so existing upper
level test result parsers have no doubt which test to blame for a specific
kernel message.  Unfortunately, kunit reports names of tests only at their
completion (with the exeption of a not standarized "# Subtest: <name>"
header above a test plan of each test suite or parametrized test).

External tools could be able to insert their own "start of the test"
markers with test names included if they new those names in advance.
Test names could be learned from a list if provided by a kunit test
module.

There exists a feature of listing kunit tests without actually executing
them, but it is now limited to configurations with the kunit module built
in and covers only built-in tests, already available at boot time.
Moreover, switching from list to normal mode requires reboot.  If that
feature was also available when kunit is built as a module, userspace
could load the module with action=list parameter, load some kunit test
modules they are interested in and learn about the list of tests provided
by those modules, then unload them, reload the kunit module in normal mode
and execute the tests with their lists already known.

Extend kunit module notifier initialization callback with a processing
path for only listing the tests provided by a module if the kunit action
parameter is set to "list".  For ease of use, submit the list in the
format of a standard KTAP report, with SKIP result from each test case,
giving "list mode" as the reason for skipping.  For each test suite
provided by a kunit test module, make such list of its test cases also
available via kunit debugfs for the lifetime of the module.  For user
convenience, make the kunit.action parameter visible in sysfs.

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 include/kunit/test.h |  1 +
 lib/kunit/executor.c | 19 +++++++++++++------
 lib/kunit/test.c     | 30 +++++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 23120d50499ef..6d693f21a4833 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -237,6 +237,7 @@ static inline void kunit_set_failure(struct kunit *test)
 }
 
 bool kunit_enabled(void);
+const char *kunit_action(void);
 
 void kunit_init_test(struct kunit *test, const char *name, char *log);
 
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 74982b83707ca..d1c0616569dfd 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -12,19 +12,26 @@
 extern struct kunit_suite * const __kunit_suites_start[];
 extern struct kunit_suite * const __kunit_suites_end[];
 
+static char *action_param;
+
+module_param_named(action, action_param, charp, 0400);
+MODULE_PARM_DESC(action,
+		 "Changes KUnit executor behavior, valid values are:\n"
+		 "<none>: run the tests like normal\n"
+		 "'list' to list test names instead of running them.\n");
+
+const char *kunit_action(void)
+{
+	return action_param;
+}
+
 #if IS_BUILTIN(CONFIG_KUNIT)
 
 static char *filter_glob_param;
-static char *action_param;
 
 module_param_named(filter_glob, filter_glob_param, charp, 0);
 MODULE_PARM_DESC(filter_glob,
 		"Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test");
-module_param_named(action, action_param, charp, 0);
-MODULE_PARM_DESC(action,
-		 "Changes KUnit executor behavior, valid values are:\n"
-		 "<none>: run the tests like normal\n"
-		 "'list' to list test names instead of running them.\n");
 
 /* glob_match() needs NULL terminated strings, so we need a copy of filter_glob_param. */
 struct kunit_test_filter {
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index a29ca1acc4d81..413d9fd364a8d 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -674,6 +674,27 @@ int kunit_run_tests(struct kunit_suite *suite)
 }
 EXPORT_SYMBOL_GPL(kunit_run_tests);
 
+static void kunit_list_suite(struct kunit_suite *suite)
+{
+	struct kunit_case *test_case;
+
+	kunit_print_suite_start(suite);
+
+	kunit_suite_for_each_test_case(suite, test_case) {
+		struct kunit test = { .param_value = NULL, .param_index = 0 };
+
+		kunit_init_test(&test, test_case->name, test_case->log);
+
+		kunit_print_ok_not_ok(&test, true, KUNIT_SKIPPED,
+				      kunit_test_case_num(suite, test_case),
+				      test_case->name, "list mode");
+	}
+
+	kunit_print_ok_not_ok((void *)suite, false, KUNIT_SKIPPED,
+			      kunit_suite_counter++,
+			      suite->name, "list mode");
+}
+
 static void kunit_init_suite(struct kunit_suite *suite)
 {
 	kunit_debugfs_create_suite(suite);
@@ -688,6 +709,7 @@ bool kunit_enabled(void)
 
 int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites)
 {
+	const char *action = kunit_action();
 	unsigned int i;
 
 	if (!kunit_enabled() && num_suites > 0) {
@@ -699,7 +721,13 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 
 	for (i = 0; i < num_suites; i++) {
 		kunit_init_suite(suites[i]);
-		kunit_run_tests(suites[i]);
+
+		if (!action)
+			kunit_run_tests(suites[i]);
+		else if (!strcmp(action, "list"))
+			kunit_list_suite(suites[i]);
+		else
+			pr_err("kunit: unknown action '%s'\n", action);
 	}
 
 	static_branch_dec(&kunit_running);
-- 
2.41.0

