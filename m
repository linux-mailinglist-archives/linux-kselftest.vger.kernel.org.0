Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E344204E0
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Oct 2021 04:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhJDCXq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Oct 2021 22:23:46 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]:34622 "EHLO
        codeconstruct.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbhJDCXq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Oct 2021 22:23:46 -0400
Received: from [172.16.66.73] (unknown [49.255.141.98])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id AA3952012C;
        Mon,  4 Oct 2021 10:21:48 +0800 (AWST)
Message-ID: <101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 1/2] mctp: test: disallow MCTP_TEST when
 building as a module
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     David Gow <davidgow@google.com>
Cc:     Matt Johnston <matt@codeconstruct.com.au>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Date:   Mon, 04 Oct 2021 10:21:47 +0800
In-Reply-To: <CABVgOS=F9K_AzoWjKPRT9m014NAo37vKHYEp-jHWDt5M+pkzSw@mail.gmail.com>
References: <20211002022656.1681956-1-jk@codeconstruct.com.au>
         <CABVgOS=F9K_AzoWjKPRT9m014NAo37vKHYEp-jHWDt5M+pkzSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

[removing netdev, this is more kunit-related]

> This looks good to me. I don't think you'll be the only person to hit
> this issue, so -- while it's probably overall nicer if tests can sit
> in their own module -- we'll look into finding a way of supporting
> this with KUnit at some point.

Just digging in to this a little: what's the intended structure here? Is
it intended to have the tests as their own loadable modules?

For MCTP, I'd like to enable tests when we're built as a module; in that
case, are you expecting we'd now have two modules: the core, and the
kunit tests?

As you've seen, my test implementation here is to directly include the
<tests>.c file; this means I don't need to EXPORT_SYMBOL all of the
MCTP-internal functions that I want to test; they can remain private to
the individual compilation unit. However, the current kunit_test_suites
implementation prevents this.

I've been hacking around with the (very experimental) patch below, to
allow tests in modules (without open-coding kunit_test_suites, which the
aspeed mmc sdhci driver has done), but I don't have much background on
kunit, so I'm not sure whether this is a useful direction to take.

However, this might allow a bunch of cleanups in future - we'd no longer
need the array-of-arrays of suites, and can remove some of the custom
suites definitions scattered around the tree.

Cheers,


Jeremy

---
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Sun, 3 Oct 2021 10:13:02 +0800
Subject: [RFC] kunit: Don't steal module_init

Currently, the MODULE version of kunit_test_suites defines its own
module_init/exit_module functions, meaning that you can't define a
module that has both an init and a kunit test suite.

This change removes the kunit-defined module inits, and instead parses
the kunit tests from their own section in the module. After module init,
we call __kunit_test_suites_init() on the contents of that section,
which prepares and runs the suite.

This essentially unifies the module- and non-module kunit init formats.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 include/kunit/test.h   | 43 ++---------------------------------------
 include/linux/module.h |  4 ++++
 kernel/module.c        |  6 ++++++
 lib/kunit/test.c       | 44 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 55 insertions(+), 42 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 24b40e5c160b..8f34fc5c85ec 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -307,41 +307,8 @@ static inline int kunit_run_all_tests(void)
 }
 #endif /* IS_BUILTIN(CONFIG_KUNIT) */
 
-#ifdef MODULE
-/**
- * kunit_test_suites_for_module() - used to register one or more
- *			 &struct kunit_suite with KUnit.
- *
- * @__suites: a statically allocated list of &struct kunit_suite.
- *
- * Registers @__suites with the test framework. See &struct kunit_suite for
- * more information.
- *
- * If a test suite is built-in, module_init() gets translated into
- * an initcall which we don't want as the idea is that for builtins
- * the executor will manage execution.  So ensure we do not define
- * module_{init|exit} functions for the builtin case when registering
- * suites via kunit_test_suites() below.
- */
-#define kunit_test_suites_for_module(__suites)				\
-	static int __init kunit_test_suites_init(void)			\
-	{								\
-		return __kunit_test_suites_init(__suites);		\
-	}								\
-	module_init(kunit_test_suites_init);				\
-									\
-	static void __exit kunit_test_suites_exit(void)			\
-	{								\
-		return __kunit_test_suites_exit(__suites);		\
-	}								\
-	module_exit(kunit_test_suites_exit)
-#else
-#define kunit_test_suites_for_module(__suites)
-#endif /* MODULE */
-
 #define __kunit_test_suites(unique_array, unique_suites, ...)		       \
 	static struct kunit_suite *unique_array[] = { __VA_ARGS__, NULL };     \
-	kunit_test_suites_for_module(unique_array);			       \
 	static struct kunit_suite **unique_suites			       \
 	__used __section(".kunit_test_suites") = unique_array
 
@@ -354,14 +321,8 @@ static inline int kunit_run_all_tests(void)
  * Registers @suites with the test framework. See &struct kunit_suite for
  * more information.
  *
- * When builtin,  KUnit tests are all run via executor; this is done
- * by placing the array of struct kunit_suite * in the .kunit_test_suites
- * ELF section.
- *
- * An alternative is to build the tests as a module.  Because modules do not
- * support multiple initcall()s, we need to initialize an array of suites for a
- * module.
- *
+ * KUnit tests are all run via executor; this is done by placing the array of
+ * struct kunit_suite * in the .kunit_test_suites ELF section.
  */
 #define kunit_test_suites(__suites...)						\
 	__kunit_test_suites(__UNIQUE_ID(array),				\
diff --git a/include/linux/module.h b/include/linux/module.h
index c9f1200b2312..ff056cc667d4 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -502,6 +502,10 @@ struct module {
 	int num_static_call_sites;
 	struct static_call_site *static_call_sites;
 #endif
+#ifdef CONFIG_KUNIT
+	struct kunit_suite ***kunit_suites_ptrs;
+	int num_kunit_suites_ptrs;
+#endif
 
 #ifdef CONFIG_LIVEPATCH
 	bool klp; /* Is this a livepatch module? */
diff --git a/kernel/module.c b/kernel/module.c
index 40ec9a030eec..4d90157a959d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3365,6 +3365,12 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					      sizeof(*mod->static_call_sites),
 					      &mod->num_static_call_sites);
 #endif
+#ifdef CONFIG_KUNIT
+	mod->kunit_suites_ptrs = section_objs(info, ".kunit_test_suites",
+					      sizeof(*mod->kunit_suites_ptrs),
+					      &mod->num_kunit_suites_ptrs);
+#endif
+
 	mod->extable = section_objs(info, "__ex_table",
 				    sizeof(*mod->extable), &mod->num_exentries);
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index f246b847024e..3b8dcb776030 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -586,6 +586,47 @@ void __kunit_test_suites_exit(struct kunit_suite **suites)
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 
+static void kunit_module_init(struct module *mod)
+{
+	unsigned int i;
+
+	for (i = 0; i < mod->num_kunit_suites_ptrs; i++)
+		__kunit_test_suites_init(mod->kunit_suites_ptrs[i]);
+}
+
+static void kunit_module_exit(struct module *mod)
+{
+	unsigned int i;
+
+	for (i = 0; i < mod->num_kunit_suites_ptrs; i++)
+		__kunit_test_suites_exit(mod->kunit_suites_ptrs[i]);
+}
+
+static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
+			       void *data)
+{
+	struct module *mod = data;
+
+	switch (val) {
+	case MODULE_STATE_LIVE:
+		kunit_module_init(mod);
+		break;
+	case MODULE_STATE_GOING:
+		kunit_module_exit(mod);
+		break;
+	case MODULE_STATE_COMING:
+	case MODULE_STATE_UNFORMED:
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block kunit_mod_nb = {
+	.notifier_call = kunit_module_notify,
+	.priority = 0,
+};
+
 /*
  * Used for static resources and when a kunit_resource * has been created by
  * kunit_alloc_resource().  When an init function is supplied, @data is passed
@@ -795,12 +836,13 @@ static int __init kunit_init(void)
 {
 	kunit_debugfs_init();
 
-	return 0;
+	return register_module_notifier(&kunit_mod_nb);
 }
 late_initcall(kunit_init);
 
 static void __exit kunit_exit(void)
 {
+	unregister_module_notifier(&kunit_mod_nb);
 	kunit_debugfs_cleanup();
 }
 module_exit(kunit_exit);
-- 
2.30.2


