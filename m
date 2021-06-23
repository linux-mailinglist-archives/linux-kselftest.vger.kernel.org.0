Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8483B21F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 22:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhFWUmO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 16:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhFWUmL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 16:42:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37D2C06124A
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 13:39:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id a2so2776063pgi.6
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 13:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YB1QMw2s0p49cREGQrJQXXCv+ldkY+DRAMCGguZikW8=;
        b=QCgdBpKERk/oxmDtJWmPRe5iXuRywxoCtBOMMPl2fsOfN2lt0gypHfssBeJUjeIpAe
         r/6BlPJsRYWkp4Rp9nsmY2QWIgJKIczzkRvvZsOXjfTZtDNhPW5GlQJWTg/sb+ctk/2H
         C7QryRFfUdzV5I0Vk35+Hh3BDZdHAJi7oOUPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YB1QMw2s0p49cREGQrJQXXCv+ldkY+DRAMCGguZikW8=;
        b=dXXzxlkupzk2gV6QYTCKpifnziR59dR4FmqLLt83BBrEeQvsPL+uTC0n28VIZEBPAN
         XHYmgwoP9OMe14lKjlpum1JkJUYetq1uJNlmsCxvHGcqeqTng4l/WdHC1ekzEJC4F/cu
         4VHlffxqQAff0vKhEXihc9DHoNU3GW5fISM3H+nPrZnFGyINbYOqcUr8syqCI9Me4upy
         pd86nNMFMLGwhFOuxU41lX7Caq8cAl9/HzPl4DS8U85UtGuXdLonL77qKV1ZFUKZP36z
         Ej5ylXk32kkRZ5KXtglS8o/PfRMiQ9TwM6joLLTKQqzQY3q3O5MBKxX/Cnixtkrpq9Iz
         UruA==
X-Gm-Message-State: AOAM532PbuAy4stM5kpudl+m6yf/QdRWmiQZM2LpW8g/hBE1W9za/28S
        PV91gCr0oKGWvDonXUWJNHOQxA==
X-Google-Smtp-Source: ABdhPJwQ5a7FgN9vtmDlBSFnMdebSU0VYgGX5dWwgCwReRBkdFbBsjqF5eY9+7pn3qqXus6bKdnW1g==
X-Received: by 2002:a62:30c2:0:b029:289:116c:ec81 with SMTP id w185-20020a6230c20000b0290289116cec81mr1524946pfw.42.1624480791508;
        Wed, 23 Jun 2021 13:39:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gg5sm5947796pjb.0.2021.06.23.13.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 7/9] lkdtm: Add CONFIG hints in errors where possible
Date:   Wed, 23 Jun 2021 13:39:34 -0700
Message-Id: <20210623203936.3151093-8-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623203936.3151093-1-keescook@chromium.org>
References: <20210623203936.3151093-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9367; h=from:subject; bh=q2QNqMgAexEB6nQ3zg2sqZfAvavargjahO0eYPmdvCw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg05wG4oZYfg5oXBkAUiS7zKMgQP0ZzqhhfgjrSHrn bVv2xfaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYNOcBgAKCRCJcvTf3G3AJpkcD/ 9inpuVoFbo5B22k8y5L+UmtkzhAKDvVa0DgKjpKc0nxrjALIK/Zfddd/jsIMweIcrX/vni4XQZhOib 3siKclmnhR0VeUwQIXmV+zOo1xI4Rt5gm4lEcXBV1cqLV0cixKxyyFyPHN/n969TaJlIgPuPk90xXK RRVgRqEM5DKfZr/i98JuDXgB/eJdOk8oa257YETFU5d6eRA77E6xtOGXOtPJZTotf2Vc8wPjm0siMe taqX07HGuCJkUVh3nSLv+RQjbh9OC3bfFuYyrCACy69N/H1YIbfxfPbV48HTEWXRRbfw6e63gOtsn6 jqN6CjSwKk5fs86PcHAysomqkHVzUOumehxWv4aQB4/TSqMi5of5dVPG5NegjoFbCenekNRbfqyuhH 1J8M7wRS/RMadn9L9YliuFnMgncmKP6aiQGL5JdAw9dmCc51T9GNPCTc77FiBp77+xRwCjSdTxxIx0 sEvvAPVp+y+TRodhHSPqhK+/91guFdwrEAULZkR8TEqACapiUP/SlLU5tN9xboFET5xH9jJ1UCYYXc EqaJ3ZbYZWxMYDYR+TL0ka/ht80b54Lf+fZgnlk8yrRNE80VZHHOdibH9RuhP7n7yDnVZve9wxAkcO ASeXLns8bnbwIgqiIiRdqTOBAv2lF6Vw1P7saIHer9yuCp54SIFd55CSxuFQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For various failure conditions, try to include some details about where
to look for reasons about the failure.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c                     |  8 ++-
 drivers/misc/lkdtm/cfi.c                      |  3 +-
 drivers/misc/lkdtm/core.c                     | 51 +++++++++++++++++++
 drivers/misc/lkdtm/fortify.c                  |  3 +-
 drivers/misc/lkdtm/heap.c                     | 10 ++--
 drivers/misc/lkdtm/lkdtm.h                    | 41 +++++++++++++++
 drivers/misc/lkdtm/stackleak.c                |  4 +-
 drivers/misc/lkdtm/usercopy.c                 |  7 ++-
 .../testing/selftests/lkdtm/stack-entropy.sh  |  1 +
 9 files changed, 117 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 9ff02bdf3153..7c7335506c45 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -303,8 +303,10 @@ void lkdtm_CORRUPT_LIST_ADD(void)
 
 	if (target[0] == NULL && target[1] == NULL)
 		pr_err("Overwrite did not happen, but no BUG?!\n");
-	else
+	else {
 		pr_err("list_add() corruption not detected!\n");
+		pr_expected_config(CONFIG_DEBUG_LIST);
+	}
 }
 
 void lkdtm_CORRUPT_LIST_DEL(void)
@@ -328,8 +330,10 @@ void lkdtm_CORRUPT_LIST_DEL(void)
 
 	if (target[0] == NULL && target[1] == NULL)
 		pr_err("Overwrite did not happen, but no BUG?!\n");
-	else
+	else {
 		pr_err("list_del() corruption not detected!\n");
+		pr_expected_config(CONFIG_DEBUG_LIST);
+	}
 }
 
 /* Test that VMAP_STACK is actually allocating with a leading guard page */
diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
index e73ebdbfa806..c9aeddef1044 100644
--- a/drivers/misc/lkdtm/cfi.c
+++ b/drivers/misc/lkdtm/cfi.c
@@ -38,5 +38,6 @@ void lkdtm_CFI_FORWARD_PROTO(void)
 	func = (void *)lkdtm_increment_int;
 	func(&called_count);
 
-	pr_info("Fail: survived mismatched prototype function call!\n");
+	pr_err("FAIL: survived mismatched prototype function call!\n");
+	pr_expected_config(CONFIG_CFI_CLANG);
 }
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 2c89fc18669f..c185ae4719c3 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/debugfs.h>
+#include <linux/init.h>
 
 #define DEFAULT_COUNT 10
 
@@ -398,6 +399,56 @@ static ssize_t direct_entry(struct file *f, const char __user *user_buf,
 	return count;
 }
 
+#ifndef MODULE
+/*
+ * To avoid needing to export parse_args(), just don't use this code
+ * when LKDTM is built as a module.
+ */
+struct check_cmdline_args {
+	const char *param;
+	int value;
+};
+
+static int lkdtm_parse_one(char *param, char *val,
+			   const char *unused, void *arg)
+{
+	struct check_cmdline_args *args = arg;
+
+	/* short circuit if we already found a value. */
+	if (args->value != -ESRCH)
+		return 0;
+	if (strncmp(param, args->param, strlen(args->param)) == 0) {
+		bool bool_result;
+		int ret;
+
+		ret = kstrtobool(val, &bool_result);
+		if (ret == 0)
+			args->value = bool_result;
+	}
+	return 0;
+}
+
+int lkdtm_check_bool_cmdline(const char *param)
+{
+	char *command_line;
+	struct check_cmdline_args args = {
+		.param = param,
+		.value = -ESRCH,
+	};
+
+	command_line = kstrdup(saved_command_line, GFP_KERNEL);
+	if (!command_line)
+		return -ENOMEM;
+
+	parse_args("Setting sysctl args", command_line,
+		   NULL, 0, -1, -1, &args, lkdtm_parse_one);
+
+	kfree(command_line);
+
+	return args.value;
+}
+#endif
+
 static struct dentry *lkdtm_debugfs_root;
 
 static int __init lkdtm_module_init(void)
diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
index faf29cf04baa..0f51d31b57ca 100644
--- a/drivers/misc/lkdtm/fortify.c
+++ b/drivers/misc/lkdtm/fortify.c
@@ -76,7 +76,8 @@ void lkdtm_FORTIFIED_STRSCPY(void)
 	 */
 	strscpy(dst, src, strlen(src));
 
-	pr_warn("FAIL: No overflow in above strscpy()\n");
+	pr_err("FAIL: strscpy() overflow not detected!\n");
+	pr_expected_config(CONFIG_FORTIFY_SOURCE);
 
 	kfree(src);
 }
diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 36be5e353cd0..a3bb0577ed8b 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -109,9 +109,10 @@ void lkdtm_READ_AFTER_FREE(void)
 	if (saw != *val) {
 		/* Good! Poisoning happened, so declare a win. */
 		pr_info("Memory correctly poisoned (%x)\n", saw);
-		BUG();
+	} else {
+		pr_err("FAIL: Memory was not poisoned!\n");
+		pr_expected_config_param(CONFIG_INIT_ON_FREE_DEFAULT_ON, "init_on_free");
 	}
-	pr_info("Memory was not poisoned\n");
 
 	kfree(val);
 }
@@ -165,9 +166,10 @@ void lkdtm_READ_BUDDY_AFTER_FREE(void)
 	if (saw != *val) {
 		/* Good! Poisoning happened, so declare a win. */
 		pr_info("Memory correctly poisoned (%x)\n", saw);
-		BUG();
+	} else {
+		pr_err("FAIL: Buddy page was not poisoned!\n");
+		pr_expected_config_param(CONFIG_INIT_ON_FREE_DEFAULT_ON, "init_on_free");
 	}
-	pr_info("Buddy page was not poisoned\n");
 
 	kfree(val);
 }
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index c6baf4f1e1db..e491bc571808 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -6,6 +6,47 @@
 
 #include <linux/kernel.h>
 
+#define pr_expected_config(kconfig)				\
+{								\
+	if (IS_ENABLED(kconfig)) 				\
+		pr_err("Unexpected! This kernel was built with " #kconfig "=y\n"); \
+	else							\
+		pr_warn("This is probably expected, since this kernel was built *without* " #kconfig "=y\n"); \
+}
+
+#ifndef MODULE
+int lkdtm_check_bool_cmdline(const char *param);
+#define pr_expected_config_param(kconfig, param)		\
+{								\
+	if (IS_ENABLED(kconfig)) {				\
+		switch (lkdtm_check_bool_cmdline(param)) {	\
+		case 0:						\
+			pr_warn("This is probably expected, since this kernel was built with " #kconfig "=y but booted with '" param "=N'\n"); \
+			break;					\
+		case 1:						\
+			pr_err("Unexpected! This kernel was built with " #kconfig "=y and booted with '" param "=Y'\n"); \
+			break;					\
+		default:					\
+			pr_err("Unexpected! This kernel was built with " #kconfig "=y (and booted without '" param "' specified)\n"); \
+		}						\
+	} else {						\
+		switch (lkdtm_check_bool_cmdline(param)) {	\
+		case 0:						\
+			pr_warn("This is probably expected, as kernel was built *without* " #kconfig "=y and booted with '" param "=N'\n"); \
+			break;					\
+		case 1:						\
+			pr_err("Unexpected! This kernel was built *without* " #kconfig "=y but booted with '" param "=Y'\n"); \
+			break;					\
+		default:					\
+			pr_err("This is probably expected, since this kernel was built *without* " #kconfig "=y (and booted without '" param "' specified)\n"); \
+			break;					\
+		}						\
+	}							\
+}
+#else
+#define pr_expected_config_param(kconfig, param) pr_expected_config(kconfig)
+#endif
+
 /* bugs.c */
 void __init lkdtm_bugs_init(int *recur_param);
 void lkdtm_PANIC(void);
diff --git a/drivers/misc/lkdtm/stackleak.c b/drivers/misc/lkdtm/stackleak.c
index d1a5c0705be3..00db21ff115e 100644
--- a/drivers/misc/lkdtm/stackleak.c
+++ b/drivers/misc/lkdtm/stackleak.c
@@ -74,8 +74,8 @@ void lkdtm_STACKLEAK_ERASING(void)
 
 end:
 	if (test_failed) {
-		pr_err("FAIL: the thread stack is NOT properly erased\n");
-		dump_stack();
+		pr_err("FAIL: the thread stack is NOT properly erased!\n");
+		pr_expected_config(CONFIG_GCC_PLUGIN_STACKLEAK);
 	} else {
 		pr_info("OK: the rest of the thread stack is properly erased\n");
 	}
diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 15d220ef35a5..9161ce7ed47a 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -173,6 +173,8 @@ static void do_usercopy_heap_size(bool to_user)
 			goto free_user;
 		}
 	}
+	pr_err("FAIL: bad usercopy not detected!\n");
+	pr_expected_config_param(CONFIG_HARDENED_USERCOPY, "hardened_usercopy");
 
 free_user:
 	vm_munmap(user_addr, PAGE_SIZE);
@@ -248,6 +250,8 @@ static void do_usercopy_heap_whitelist(bool to_user)
 			goto free_user;
 		}
 	}
+	pr_err("FAIL: bad usercopy not detected!\n");
+	pr_expected_config_param(CONFIG_HARDENED_USERCOPY, "hardened_usercopy");
 
 free_user:
 	vm_munmap(user_alloc, PAGE_SIZE);
@@ -319,7 +323,8 @@ void lkdtm_USERCOPY_KERNEL(void)
 		pr_warn("copy_to_user failed, but lacked Oops\n");
 		goto free_user;
 	}
-	pr_err("FAIL: survived bad copy_to_user()\n");
+	pr_err("FAIL: bad copy_to_user() not detected!\n");
+	pr_expected_config_param(CONFIG_HARDENED_USERCOPY, "hardened_usercopy");
 
 free_user:
 	vm_munmap(user_addr, PAGE_SIZE);
diff --git a/tools/testing/selftests/lkdtm/stack-entropy.sh b/tools/testing/selftests/lkdtm/stack-entropy.sh
index b1b8a5097cbb..1b4d95d575f8 100755
--- a/tools/testing/selftests/lkdtm/stack-entropy.sh
+++ b/tools/testing/selftests/lkdtm/stack-entropy.sh
@@ -30,6 +30,7 @@ rm -f "$log"
 
 # We would expect any functional stack randomization to be at least 5 bits.
 if [ "$bits" -lt 5 ]; then
+	echo "Stack entropy is low! Booted without 'randomize_kstack_offset=y'?"
 	exit 1
 else
 	exit 0
-- 
2.30.2

