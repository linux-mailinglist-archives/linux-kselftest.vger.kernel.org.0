Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07F25503ED
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jun 2022 11:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiFRJDj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Jun 2022 05:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbiFRJDi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Jun 2022 05:03:38 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3527E2F00D
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Jun 2022 02:03:35 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id lw3-20020a17090b180300b001e31fad7d5aso4190115pjb.6
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Jun 2022 02:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xcKhd2ovDrzW4TN5oKPRjlu0BegYI/Ed8HUs8ET36D0=;
        b=XAbzUsj91wrGwVolFVA6fl0C5dE56VX4gaU68QvHoo1q3J3md2ju8twxWO9ypQkCXo
         YLVk/g/eJWGTIbdLeaj1iVfuXi4pFirKgvm3QQO+2adT3Zyn0WhtT3kF/y+YrRov5iCB
         1IG+AzyTtkagpco0Pied13GoHBw6TtqSUqXnZFl/mxEC19JfwK45blxTEmq5HPbvm0yS
         xMNmNyjXVVA+BDnILrP8sZc4XRNJysY9F32F83W41WgSeLJkkF15ABFdfUX2Vf1rzi9f
         s7e484WAj9LMLHRcoD1EwraInpSjASQFFoaoaT2/p4CS9pfTdFvSQT/RLjYT7XoYKHaJ
         lyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xcKhd2ovDrzW4TN5oKPRjlu0BegYI/Ed8HUs8ET36D0=;
        b=OqEAl+1ZAcNGjkcSqYZRhoAyRLtRxtUv3MDxs4dgCcs/oL+Um4N/AEEs4BkRo11QR0
         RwaX+anTHlqVhvat5puBxCOpux8A0bgm/7EZ24tFoRKXXWCtxbxGuSUk5cOUJ4+1/1jI
         5vdkJCDN8SVCVxEmRNtjGiif0ZJ3tWx2fBRdyBXf5DoypYdmkri4RVTcIWg3YIgFdFm8
         6+HQHWMDEgGWskful85d7dty3SOUTXWjx/+hTRFsOvWyZ+IRhG1Y5oafPreEeQWkABGb
         ua8Rep+sazI6TVvYmYGqpQwMJADN+QtIYr4JQaVWy72NOlsMCIsVFbf2+Chy+hnAEVU0
         qGnw==
X-Gm-Message-State: AJIora+2SHA25mrF7QhRD/gFyaUYB3pZyqNqIQmTGEzSmJaTRjrlV7E7
        vg/UuudvkY7sIdYZb44qWT8wxOQFbFsmcQ==
X-Google-Smtp-Source: AGRyM1vDoXfonjmrvKRgfpNxP1jpWSSE8piUJc9c0Ybgfw+LPYyVsMqQgH5/9pfMsNlOGK3dDvBe5L4hQK9aAA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:902:b610:b0:168:cd85:d7a2 with SMTP
 id b16-20020a170902b61000b00168cd85d7a2mr14297035pls.125.1655543015440; Sat,
 18 Jun 2022 02:03:35 -0700 (PDT)
Date:   Sat, 18 Jun 2022 17:03:06 +0800
In-Reply-To: <20220618090310.1174932-1-davidgow@google.com>
Message-Id: <20220618090310.1174932-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220618090310.1174932-1-davidgow@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 1/5] kunit: unify module and builtin suite definitions
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Ma=C3=ADra=20Canal?=" <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>,
        David Gow <davidgow@google.com>
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

From: Jeremy Kerr <jk@codeconstruct.com.au>

Currently, KUnit runs built-in tests and tests loaded from modules
differently. For built-in tests, the kunit_test_suite{,s}() macro adds a
list of suites in the .kunit_test_suites linker section. However, for
kernel modules, a module_init() function is used to run the test suites.

This causes problems if tests are included in a module which already
defines module_init/exit_module functions, as they'll conflict with the
kunit-provided ones.

This change removes the kunit-defined module inits, and instead parses
the kunit tests from their own section in the module. After module init,
we call __kunit_test_suites_init() on the contents of that section,
which prepares and runs the suite.

This essentially unifies the module- and non-module kunit init formats.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

This is essentially the patch at:
https://lore.kernel.org/linux-kselftest/101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au/
I've basically just rebased it, tweaked some wording, and it made it
still compile when CONFIG_MODULES is not set.


 include/kunit/test.h   | 47 ++++----------------------------------
 include/linux/module.h |  5 ++++
 kernel/module/main.c   |  6 +++++
 lib/kunit/test.c       | 52 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 67 insertions(+), 43 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 8ffcd7de9607..54306271cfbf 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -250,41 +250,8 @@ static inline int kunit_run_all_tests(void)
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
 
@@ -294,16 +261,12 @@ static inline int kunit_run_all_tests(void)
  *
  * @__suites: a statically allocated list of &struct kunit_suite.
  *
- * Registers @suites with the test framework. See &struct kunit_suite for
- * more information.
- *
- * When builtin,  KUnit tests are all run via executor; this is done
- * by placing the array of struct kunit_suite * in the .kunit_test_suites
- * ELF section.
+ * Registers @suites with the test framework.
+ * This is done by placing the array of struct kunit_suite * in the
+ * .kunit_test_suites ELF section.
  *
- * An alternative is to build the tests as a module.  Because modules do not
- * support multiple initcall()s, we need to initialize an array of suites for a
- * module.
+ * When builtin, KUnit tests are all run via the executor at boot, and when
+ * built as a module, they run on module load.
  *
  */
 #define kunit_test_suites(__suites...)						\
diff --git a/include/linux/module.h b/include/linux/module.h
index abd9fa916b7d..e3cd6c325794 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -505,6 +505,11 @@ struct module {
 	int num_static_call_sites;
 	struct static_call_site *static_call_sites;
 #endif
+#ifdef CONFIG_KUNIT
+	int num_kunit_suites;
+	struct kunit_suite ***kunit_suites;
+#endif
+
 
 #ifdef CONFIG_LIVEPATCH
 	bool klp; /* Is this a livepatch module? */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index fed58d30725d..4542db7cdf54 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2087,6 +2087,12 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					      sizeof(*mod->static_call_sites),
 					      &mod->num_static_call_sites);
 #endif
+#ifdef CONFIG_KUNIT
+	mod->kunit_suites = section_objs(info, ".kunit_test_suites",
+					      sizeof(*mod->kunit_suites),
+					      &mod->num_kunit_suites);
+#endif
+
 	mod->extable = section_objs(info, "__ex_table",
 				    sizeof(*mod->extable), &mod->num_exentries);
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index a5053a07409f..3052526b9b89 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -10,6 +10,7 @@
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
@@ -609,6 +610,49 @@ void __kunit_test_suites_exit(struct kunit_suite **suites)
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 
+#ifdef CONFIG_MODULES
+static void kunit_module_init(struct module *mod)
+{
+	unsigned int i;
+
+	for (i = 0; i < mod->num_kunit_suites; i++)
+		__kunit_test_suites_init(mod->kunit_suites[i]);
+}
+
+static void kunit_module_exit(struct module *mod)
+{
+	unsigned int i;
+
+	for (i = 0; i < mod->num_kunit_suites; i++)
+		__kunit_test_suites_exit(mod->kunit_suites[i]);
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
+#endif
+
 struct kunit_kmalloc_array_params {
 	size_t n;
 	size_t size;
@@ -703,13 +747,19 @@ EXPORT_SYMBOL_GPL(kunit_cleanup);
 static int __init kunit_init(void)
 {
 	kunit_debugfs_init();
-
+#ifdef CONFIG_MODULES
+	return register_module_notifier(&kunit_mod_nb);
+#else
 	return 0;
+#endif
 }
 late_initcall(kunit_init);
 
 static void __exit kunit_exit(void)
 {
+#ifdef CONFIG_MODULES
+	unregister_module_notifier(&kunit_mod_nb);
+#endif
 	kunit_debugfs_cleanup();
 }
 module_exit(kunit_exit);
-- 
2.36.1.476.g0c4daa206d-goog

