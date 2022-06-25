Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C40955A735
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jun 2022 07:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiFYFKr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jun 2022 01:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiFYFKq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jun 2022 01:10:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9371B4831A
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 22:10:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q185-20020a252ac2000000b0066c8c68a474so433227ybq.5
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 22:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=vrjZekKBybPl/drx0oLqOH79U/y2dy8euPYI76X69ME=;
        b=kEbHA6VeUQla5W6034Rg8coOQxVxBzPZzFXk3CpNJfQ/QS8JAU39CFSWQ0JQL95P9n
         q8nSPy8mB7Ujdv8IhmhD7LZR81D+tj/P19bx3ZVzT6i2VsqY0U5qbdMxDDcnJPN7xVGm
         fb9p13aYbt8Sx+kxyTRdn3dBl2zrcGZ1gYYadx1S8UeqGLN+JtNvTjPG4EApZ5qgQkbc
         A3SX334PUv5H+3V5AFjIjoghU5RpwbpL+JFg0bvui8TbuRAf69GxXK+EaTuRKoIO9ncE
         K9gMTvSttjBE0btTiCl7q25ec6gSIedgOILmGT0AKBNEaZrrSi2pGK73wzTg75AxPMFX
         eTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=vrjZekKBybPl/drx0oLqOH79U/y2dy8euPYI76X69ME=;
        b=6eMxIj9lqRqqiQENbDRP3dZWzCdxxbLYHUZMuExkZ6c8oF5S1eiqaZWcLCGqqPmQug
         bTYtVEjYP9LRRVZlO7x0HgdFy/HBHD5Pzs5yUf09LSkEx+N7yFO+zXnV5TSfytXYJaF6
         RDOQKtZ2aeS3CEXdz5x4q8gi5N3tacbqgEibDnRT0CaQPvbvKWAGasQpTmb2SjnOjSGS
         IbDQilg6FJPahIYEDR2DDNplnWKtQqtJ9RomWqORtzd0hp8vXz93CnGtR8kDA8gYNDjN
         L2sOX+tKMkcQ4vDEaQfq4yOEnVA82prE+rpw369+lsWeZiVXvsuDXTn8tikKo7+xdiJJ
         99TQ==
X-Gm-Message-State: AJIora9vojQAGuLwb0C4Y6+Uv/yDQgo9lcS0s/XZT54ZKeExEXdXk3Zm
        94HBr500BP0t8XM4/0XrcjphbK/572yMGw==
X-Google-Smtp-Source: AGRyM1uJnVtv6429gNEgQta4nIHvXYCSqUn3YbcYRmR8hIyXQqEzF+cOo4YMUekXPjSXwP+imECz4RQUQv6OfA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:3cc4:0:b0:668:af4d:310b with SMTP id
 j187-20020a253cc4000000b00668af4d310bmr2505700yba.487.1656133843887; Fri, 24
 Jun 2022 22:10:43 -0700 (PDT)
Date:   Sat, 25 Jun 2022 13:08:35 +0800
In-Reply-To: <20220625050838.1618469-1-davidgow@google.com>
Message-Id: <20220625050838.1618469-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220625050838.1618469-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 1/5] kunit: unify module and builtin suite definitions
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Ma=C3=ADra=20Canal?=" <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Tested-by: Ma=C3=ADra Canal <maira.canal@usp.br>
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

No changes to this patch since v2:
https://lore.kernel.org/linux-kselftest/20220621085345.603820-2-davidgow@go=
ogle.com/

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220618090310.1174932-2-davidgow@g=
oogle.com/
- Fix a compile error with CONFIG_KUNIT=3Dm (Thanks Christophe Leroy,
  kernel test robot)
- Add Ma=C3=ADra's Tested-by.

Changes since RFC:
https://lore.kernel.org/linux-kselftest/101d12fc9250b7a445ff50a9e7a25cd74d0=
e16eb.camel@codeconstruct.com.au/
- I've basically just rebased it, tweaked some wording, and it made it
still compile when CONFIG_MODULES is not set.

---
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
=20
-#ifdef MODULE
-/**
- * kunit_test_suites_for_module() - used to register one or more
- *			 &struct kunit_suite with KUnit.
- *
- * @__suites: a statically allocated list of &struct kunit_suite.
- *
- * Registers @__suites with the test framework. See &struct kunit_suite fo=
r
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
 	static struct kunit_suite *unique_array[] =3D { __VA_ARGS__, NULL };     =
\
-	kunit_test_suites_for_module(unique_array);			       \
 	static struct kunit_suite **unique_suites			       \
 	__used __section(".kunit_test_suites") =3D unique_array
=20
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
- * An alternative is to build the tests as a module.  Because modules do n=
ot
- * support multiple initcall()s, we need to initialize an array of suites =
for a
- * module.
+ * When builtin, KUnit tests are all run via the executor at boot, and whe=
n
+ * built as a module, they run on module load.
  *
  */
 #define kunit_test_suites(__suites...)						\
diff --git a/include/linux/module.h b/include/linux/module.h
index abd9fa916b7d..2490223c975d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -505,6 +505,11 @@ struct module {
 	int num_static_call_sites;
 	struct static_call_site *static_call_sites;
 #endif
+#if IS_ENABLED(CONFIG_KUNIT)
+	int num_kunit_suites;
+	struct kunit_suite ***kunit_suites;
+#endif
+
=20
 #ifdef CONFIG_LIVEPATCH
 	bool klp; /* Is this a livepatch module? */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index fed58d30725d..4542db7cdf54 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2087,6 +2087,12 @@ static int find_module_sections(struct module *mod, =
struct load_info *info)
 					      sizeof(*mod->static_call_sites),
 					      &mod->num_static_call_sites);
 #endif
+#ifdef CONFIG_KUNIT
+	mod->kunit_suites =3D section_objs(info, ".kunit_test_suites",
+					      sizeof(*mod->kunit_suites),
+					      &mod->num_kunit_suites);
+#endif
+
 	mod->extable =3D section_objs(info, "__ex_table",
 				    sizeof(*mod->extable), &mod->num_exentries);
=20
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
@@ -609,6 +610,49 @@ void __kunit_test_suites_exit(struct kunit_suite **sui=
tes)
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
=20
+#ifdef CONFIG_MODULES
+static void kunit_module_init(struct module *mod)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < mod->num_kunit_suites; i++)
+		__kunit_test_suites_init(mod->kunit_suites[i]);
+}
+
+static void kunit_module_exit(struct module *mod)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < mod->num_kunit_suites; i++)
+		__kunit_test_suites_exit(mod->kunit_suites[i]);
+}
+
+static int kunit_module_notify(struct notifier_block *nb, unsigned long va=
l,
+			       void *data)
+{
+	struct module *mod =3D data;
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
+static struct notifier_block kunit_mod_nb =3D {
+	.notifier_call =3D kunit_module_notify,
+	.priority =3D 0,
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
=20
 static void __exit kunit_exit(void)
 {
+#ifdef CONFIG_MODULES
+	unregister_module_notifier(&kunit_mod_nb);
+#endif
 	kunit_debugfs_cleanup();
 }
 module_exit(kunit_exit);
--=20
2.37.0.rc0.161.g10f37bed90-goog

