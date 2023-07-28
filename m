Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA43B7670DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 17:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbjG1Ppl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 11:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbjG1Ppi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 11:45:38 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD4426A0;
        Fri, 28 Jul 2023 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690559136; x=1722095136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZkxLWuOXNO9qLoZngSzFjUGnT0mXINuDPjbNOs/XV+4=;
  b=VPvkd9aVIY4z7NJCMkqXlEu6toqRZa47k83RQ19t6vjCf1LLIR8898JL
   UT3tVjEkB0zarE6dits06cWOuwkD74fTYqWZ+swZ7T5bFq8ZnNZybpy8G
   FettWoFa4/CzNW22QmF7nAIPbh/+YQonWlBz7/qzghlCqjZ12z6snGWkf
   gJMbvczsUxd0gRFGbXKO/KGtA26a49Abp8T8+hF01eezm5YjCt6PdhNt4
   ofKMg4yZugQmn1KF2aGv/hpstQkjA8k2F0e72KUHQ/NwQQnlGuYwZ+q1s
   z/IO66x3RhibymztDBlUxvWW1VGA/6pCrU2VrzJzUAdqg+KJvU2jrR0tU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="371323424"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="371323424"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 08:45:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817557443"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="817557443"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO jkrzyszt-mobl2.lan) ([10.213.24.93])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 08:45:33 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        igt-dev@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kunit: Allow kunit test modules to use test filtering
Date:   Fri, 28 Jul 2023 17:44:23 +0200
Message-ID: <20230728154419.1810177-8-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728154419.1810177-5-janusz.krzysztofik@linux.intel.com>
References: <20230728154419.1810177-5-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 include/kunit/test.h | 13 +++++++++++++
 lib/kunit/executor.c | 36 ++++++++++++++++++------------------
 lib/kunit/test.c     | 22 ++++++++++++++++++++++
 3 files changed, 53 insertions(+), 18 deletions(-)

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
index d1c0616569dfd..816e14f4fcb64 100644
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

