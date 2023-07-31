Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDED768BCE
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 08:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjGaGRw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 02:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjGaGRj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 02:17:39 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E6A1701;
        Sun, 30 Jul 2023 23:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690784247; x=1722320247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5mV52st8S+7Kz9fwv8kMVAqrLyOFoCT+yXcQ6mlNwlM=;
  b=IFMor3BdYuF53LI3muNEqPYaZMjfr5Gm+JcjUB7MD5SzEPw6AsNYq3tx
   yr0nwy+eHRf8IIrKjs8F5lm6tBN2nAR4LJD8JQ1X/2jkCf1bEFY8Js7Bz
   acgvpcrx1Zxz2UdQwivJ1O+7F6CPLQc3sxk+Xe3U/Uc0gG3t+yT2jLVB3
   uZlcw7EitgfCQEL5+CP83vl1epophVa2ZVkCYKuI9CCoQR7Q9K3AekeUC
   0PZUYa/gRozM8qf+qYiitCtNcdkaynthg69BR0iiMUL138ujgbdToGJh5
   aqJ7kyVX1C0AmzH3WFEM9FYC+IlXiC3BjQIoIe8btVr50+YXnt2biQKsZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="435231379"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="435231379"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 23:16:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="1058827755"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="1058827755"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO jkrzyszt-mobl2.intranet) ([10.213.1.128])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 23:16:49 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        igt-dev@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] kunit: Allow kunit test modules to use test filtering
Date:   Mon, 31 Jul 2023 07:45:56 +0200
Message-ID: <20230731054552.2145292-8-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731054552.2145292-5-janusz.krzysztofik@linux.intel.com>
References: <20230731054552.2145292-5-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

External tools, e.g., Intel GPU tools (IGT), support execution of
individual selftests provided by kernel modules.  That could be also
applicable to kunit test modules if they provided test filtering.  But
test filtering is now possible only when kunit code is built into the
kernel.  Moreover, a filter can be specified only at boot time, then
reboot is required each time a different filter is needed.

Build the test filtering code also when kunit is configured as a module,
expose test filtering functions to other kunit source files, and use them
in kunit module notifier callback functions.  Userspace can then reload
the kunit module with a value of the filter_glob parameter tuned to a
specific kunit test module every time it wants to limit the scope of tests
executed on that module load.  Make the kunit.filter_glob parameter
visible in sysfs for user convenience.

v2: Fix new name of a structure moved to kunit namespace not updated
    across all uses.

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 include/kunit/test.h | 13 +++++++++++++
 lib/kunit/executor.c | 42 ++++++++++++++++++++++--------------------
 lib/kunit/test.c     | 22 ++++++++++++++++++++++
 3 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 6d693f21a4833..14ff12e72252a 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -190,6 +190,12 @@ struct kunit_suite {
 	int suite_init_err;
 };
 
+/* Stores an array of suites, end points one past the end */
+struct kunit_suite_set {
+	struct kunit_suite * const *start;
+	struct kunit_suite * const *end;
+};
+
 /**
  * struct kunit - represents a running instance of a test.
  *
@@ -238,6 +244,7 @@ static inline void kunit_set_failure(struct kunit *test)
 
 bool kunit_enabled(void);
 const char *kunit_action(void);
+const char *kunit_filter_glob(void);
 
 void kunit_init_test(struct kunit *test, const char *name, char *log);
 
@@ -248,6 +255,12 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite);
 unsigned int kunit_test_case_num(struct kunit_suite *suite,
 				 struct kunit_case *test_case);
 
+struct kunit_suite_set
+kunit_filter_suites(const struct kunit_suite_set *suite_set,
+		    const char *filter_glob,
+		    int *err);
+void kunit_free_suite_set(struct kunit_suite_set suite_set);
+
 int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites);
 
 void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites);
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index d1c0616569dfd..49fe40cc8f1af 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -25,14 +25,17 @@ const char *kunit_action(void)
 	return action_param;
 }
 
-#if IS_BUILTIN(CONFIG_KUNIT)
-
 static char *filter_glob_param;
 
-module_param_named(filter_glob, filter_glob_param, charp, 0);
+module_param_named(filter_glob, filter_glob_param, charp, 0400);
 MODULE_PARM_DESC(filter_glob,
 		"Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test");
 
+const char *kunit_filter_glob(void)
+{
+	return filter_glob_param;
+}
+
 /* glob_match() needs NULL terminated strings, so we need a copy of filter_glob_param. */
 struct kunit_test_filter {
 	char *suite_glob;
@@ -96,16 +99,7 @@ kunit_filter_tests(const struct kunit_suite *const suite, const char *test_glob)
 	return copy;
 }
 
-static char *kunit_shutdown;
-core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
-
-/* Stores an array of suites, end points one past the end */
-struct suite_set {
-	struct kunit_suite * const *start;
-	struct kunit_suite * const *end;
-};
-
-static void kunit_free_suite_set(struct suite_set suite_set)
+void kunit_free_suite_set(struct kunit_suite_set suite_set)
 {
 	struct kunit_suite * const *suites;
 
@@ -114,13 +108,14 @@ static void kunit_free_suite_set(struct suite_set suite_set)
 	kfree(suite_set.start);
 }
 
-static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
-					    const char *filter_glob,
-					    int *err)
+struct kunit_suite_set
+kunit_filter_suites(const struct kunit_suite_set *suite_set,
+		    const char *filter_glob,
+		    int *err)
 {
 	int i;
 	struct kunit_suite **copy, *filtered_suite;
-	struct suite_set filtered;
+	struct kunit_suite_set filtered;
 	struct kunit_test_filter filter;
 
 	const size_t max = suite_set->end - suite_set->start;
@@ -155,6 +150,11 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 	return filtered;
 }
 
+#if IS_BUILTIN(CONFIG_KUNIT)
+
+static char *kunit_shutdown;
+core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
+
 static void kunit_handle_shutdown(void)
 {
 	if (!kunit_shutdown)
@@ -169,7 +169,7 @@ static void kunit_handle_shutdown(void)
 
 }
 
-static void kunit_exec_run_tests(struct suite_set *suite_set)
+static void kunit_exec_run_tests(struct kunit_suite_set *suite_set)
 {
 	size_t num_suites = suite_set->end - suite_set->start;
 
@@ -179,7 +179,7 @@ static void kunit_exec_run_tests(struct suite_set *suite_set)
 	__kunit_test_suites_init(suite_set->start, num_suites);
 }
 
-static void kunit_exec_list_tests(struct suite_set *suite_set)
+static void kunit_exec_list_tests(struct kunit_suite_set *suite_set)
 {
 	struct kunit_suite * const *suites;
 	struct kunit_case *test_case;
@@ -195,7 +195,9 @@ static void kunit_exec_list_tests(struct suite_set *suite_set)
 
 int kunit_run_all_tests(void)
 {
-	struct suite_set suite_set = {__kunit_suites_start, __kunit_suites_end};
+	struct kunit_suite_set suite_set = {
+		__kunit_suites_start, __kunit_suites_end,
+	};
 	int err = 0;
 	if (!kunit_enabled()) {
 		pr_info("kunit: disabled\n");
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 413d9fd364a8d..bfc2f65bd1dae 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -757,6 +757,22 @@ EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 #ifdef CONFIG_MODULES
 static void kunit_module_init(struct module *mod)
 {
+	struct kunit_suite_set suite_set = {
+		mod->kunit_suites, mod->kunit_suites + mod->num_kunit_suites,
+	};
+	int err = 0;
+
+	suite_set = kunit_filter_suites(&suite_set,
+					kunit_filter_glob() ?: "*.*", &err);
+	if (err) {
+		pr_err("kunit module: error filtering suites: %d\n",
+		       err);
+		kfree(suite_set.start);
+		suite_set.start = NULL;
+	}
+	mod->kunit_suites = (struct kunit_suite **)suite_set.start;
+	mod->num_kunit_suites = suite_set.end - suite_set.start;
+
 	if (mod->num_kunit_suites > 0) {
 		pr_info("KTAP version 1\n");
 		pr_info("1..%d\n", mod->num_kunit_suites);
@@ -767,7 +783,13 @@ static void kunit_module_init(struct module *mod)
 
 static void kunit_module_exit(struct module *mod)
 {
+	struct kunit_suite_set suite_set = {
+		mod->kunit_suites, mod->kunit_suites + mod->num_kunit_suites,
+	};
+
 	__kunit_test_suites_exit(mod->kunit_suites, mod->num_kunit_suites);
+	if (suite_set.start)
+		kunit_free_suite_set(suite_set);
 }
 
 static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
-- 
2.41.0

