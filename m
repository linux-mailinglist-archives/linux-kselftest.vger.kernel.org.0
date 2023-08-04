Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EDB770C2C
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 00:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjHDWzp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 18:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjHDWzl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 18:55:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541B8524A;
        Fri,  4 Aug 2023 15:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691189737; x=1722725737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2fvEsveno8xxmnboEXIklg54Ni9FCooh+WfUEmGZ3+M=;
  b=BIvm8GSdxf9W2XfN5FZblXGiK8CQbsDVG5ujo45HhvVMcvAUZplQvWzj
   ynCzy4q/y19HZ4xKs1Z2BmRY0EszhRp0fX/aX13fLpkORpwsnm73mMxPm
   f9Pjqr3yyQM+qHLOu3wy0L3Jt6K7rlKluxW7ZUdtN67aaCyL76e7UG3Ln
   GaXhJNDr5ODaGDTbEWVaKjVEPeVhrzs4rdltPZJnaxmrPojs2W7NRS0Jq
   24kK9E3IEmZolKqjLuHxmkm6tZS16TfF9dguSXbwmNZydXQsaflABBcvy
   IMbNxh28bVV74aa30+P089++YUc66RJjqB35yO7KFDi9Ov9DHBiRYb/u3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="360325240"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="360325240"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 15:55:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="733445199"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="733445199"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO jkrzyszt-mobl2.intranet) ([10.213.4.149])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 15:55:26 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        igt-dev@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH v4 3/3] kunit: Allow kunit test modules to use test filtering
Date:   Sat,  5 Aug 2023 00:52:24 +0200
Message-ID: <20230804225220.8005-8-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804225220.8005-5-janusz.krzysztofik@linux.intel.com>
References: <20230804225220.8005-5-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
executed on that module load.  Make the kunit.filter* parameters visible
in sysfs for user convenience.

v4: Refresh on top of newly applied attributes patches and changes
    introdced by new versions of other patches submitted in series with
    this one.
v3: Fix CONFIG_GLOB, required by filtering functions, not selected when
    building as a module.
v2: Fix new name of a structure moved to kunit namespace not updated
    across all uses.

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 include/kunit/test.h | 11 ++++++++
 lib/kunit/Kconfig    |  2 +-
 lib/kunit/executor.c | 63 ++++++++++++++++++++++++++------------------
 lib/kunit/test.c     | 20 ++++++++++++++
 4 files changed, 69 insertions(+), 27 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 6a338a3267ed5..d33114097d0d0 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -310,6 +310,9 @@ static inline void kunit_set_failure(struct kunit *test)
 
 bool kunit_enabled(void);
 const char *kunit_action(void);
+const char *kunit_filter_glob(void);
+char *kunit_filter(void);
+char *kunit_filter_action(void);
 
 void kunit_init_test(struct kunit *test, const char *name, char *log);
 
@@ -320,6 +323,14 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite);
 unsigned int kunit_test_case_num(struct kunit_suite *suite,
 				 struct kunit_case *test_case);
 
+struct kunit_suite_set
+kunit_filter_suites(const struct kunit_suite_set *suite_set,
+		    const char *filter_glob,
+		    char *filters,
+		    char *filter_action,
+		    int *err);
+void kunit_free_suite_set(struct kunit_suite_set suite_set);
+
 int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites);
 
 void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites);
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 626719b95badd..68a6daec0aef1 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -4,7 +4,7 @@
 
 menuconfig KUNIT
 	tristate "KUnit - Enable support for unit tests"
-	select GLOB if KUNIT=y
+	select GLOB
 	help
 	  Enables support for kernel unit tests (KUnit), a lightweight unit
 	  testing and mocking framework for the Linux kernel. These tests are
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index b3878a34c35a5..a3e49c9deb6f0 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -27,24 +27,37 @@ const char *kunit_action(void)
 	return action_param;
 }
 
-#if IS_BUILTIN(CONFIG_KUNIT)
-
 static char *filter_glob_param;
 static char *filter_param;
 static char *filter_action_param;
 
-module_param_named(filter_glob, filter_glob_param, charp, 0);
+module_param_named(filter_glob, filter_glob_param, charp, 0400);
 MODULE_PARM_DESC(filter_glob,
 		"Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test");
-module_param_named(filter, filter_param, charp, 0);
+module_param_named(filter, filter_param, charp, 0400);
 MODULE_PARM_DESC(filter,
 		"Filter which KUnit test suites/tests run at boot-time using attributes, e.g. speed>slow");
-module_param_named(filter_action, filter_action_param, charp, 0);
+module_param_named(filter_action, filter_action_param, charp, 0400);
 MODULE_PARM_DESC(filter_action,
 		"Changes behavior of filtered tests using attributes, valid values are:\n"
 		"<none>: do not run filtered tests as normal\n"
 		"'skip': skip all filtered tests instead so tests will appear in output\n");
 
+const char *kunit_filter_glob(void)
+{
+	return filter_glob_param;
+}
+
+char *kunit_filter(void)
+{
+	return filter_param;
+}
+
+char *kunit_filter_action(void)
+{
+	return filter_action_param;
+}
+
 /* glob_match() needs NULL terminated strings, so we need a copy of filter_glob_param. */
 struct kunit_glob_filter {
 	char *suite_glob;
@@ -108,10 +121,7 @@ kunit_filter_glob_tests(const struct kunit_suite *const suite, const char *test_
 	return copy;
 }
 
-static char *kunit_shutdown;
-core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
-
-static void kunit_free_suite_set(struct kunit_suite_set suite_set)
+void kunit_free_suite_set(struct kunit_suite_set suite_set)
 {
 	struct kunit_suite * const *suites;
 
@@ -120,7 +130,7 @@ static void kunit_free_suite_set(struct kunit_suite_set suite_set)
 	kfree(suite_set.start);
 }
 
-static struct kunit_suite_set
+struct kunit_suite_set
 kunit_filter_suites(const struct kunit_suite_set *suite_set,
 		    const char *filter_glob,
 		    char *filters,
@@ -207,22 +217,6 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 	return filtered;
 }
 
-static void kunit_handle_shutdown(void)
-{
-	if (!kunit_shutdown)
-		return;
-
-	if (!strcmp(kunit_shutdown, "poweroff"))
-		kernel_power_off();
-	else if (!strcmp(kunit_shutdown, "halt"))
-		kernel_halt();
-	else if (!strcmp(kunit_shutdown, "reboot"))
-		kernel_restart(NULL);
-
-}
-
-#endif
-
 void kunit_exec_run_tests(struct kunit_suite_set *suite_set, bool builtin)
 {
 	size_t num_suites = suite_set->end - suite_set->start;
@@ -260,6 +254,23 @@ void kunit_exec_list_tests(struct kunit_suite_set *suite_set, bool include_attr)
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
+static char *kunit_shutdown;
+core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
+
+static void kunit_handle_shutdown(void)
+{
+	if (!kunit_shutdown)
+		return;
+
+	if (!strcmp(kunit_shutdown, "poweroff"))
+		kernel_power_off();
+	else if (!strcmp(kunit_shutdown, "halt"))
+		kernel_halt();
+	else if (!strcmp(kunit_shutdown, "reboot"))
+		kernel_restart(NULL);
+
+}
+
 int kunit_run_all_tests(void)
 {
 	struct kunit_suite_set suite_set = {
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 5232a43737826..8162f2ea73b59 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -740,6 +740,20 @@ static void kunit_module_init(struct module *mod)
 		mod->kunit_suites, mod->kunit_suites + mod->num_kunit_suites,
 	};
 	const char *action = kunit_action();
+	int err = 0;
+
+	suite_set = kunit_filter_suites(&suite_set,
+					kunit_filter_glob() ?: "*.*",
+					kunit_filter(), kunit_filter_action(),
+					&err);
+	if (err) {
+		pr_err("kunit module: error filtering suites: %d\n",
+		       err);
+		kfree(suite_set.start);
+		suite_set.start = NULL;
+	}
+	mod->kunit_suites = (struct kunit_suite **)suite_set.start;
+	mod->num_kunit_suites = suite_set.end - suite_set.start;
 
 	if (!action)
 		kunit_exec_run_tests(&suite_set, false);
@@ -753,11 +767,17 @@ static void kunit_module_init(struct module *mod)
 
 static void kunit_module_exit(struct module *mod)
 {
+	struct kunit_suite_set suite_set = {
+		mod->kunit_suites, mod->kunit_suites + mod->num_kunit_suites,
+	};
 	const char *action = kunit_action();
 
 	if (!action)
 		__kunit_test_suites_exit(mod->kunit_suites,
 					 mod->num_kunit_suites);
+
+	if (suite_set.start)
+		kunit_free_suite_set(suite_set);
 }
 
 static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
-- 
2.41.0

