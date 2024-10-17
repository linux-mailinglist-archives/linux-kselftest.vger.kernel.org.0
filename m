Return-Path: <linux-kselftest+bounces-20071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AD19A2FD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 23:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37BEB1C212BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 21:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5971D12EA;
	Thu, 17 Oct 2024 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YfQb6txF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038CB1D043D;
	Thu, 17 Oct 2024 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729200869; cv=none; b=omjKgAEH3l/gTIq45lODD8NgPkQnebI06tuwR+dkXqMVBdbAcSXqPdeu7r2HRt8hqrIrS8biANAiQT+VQV7S4r/gUmSqZoW2KsHDgkNHkRt/NFlRUF6ewFaBakU7iFQ8PO7HsX76MfsQsBo2XyUgfvHdGC27VDHOaM47PjBeLec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729200869; c=relaxed/simple;
	bh=xwmNibCvTj4rRFMBXudGxehYOkCHI2m9yXq6UfKAT+U=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=aasrCaToMdq7d6MGR1qcY8ovdWcVmfUMjymXrK5jM1dwkJjxX7ZxFYy45tFNdZgfhuqy7W59eUq3tm8r3VYZ4SaBPS1kDpYsMkAQHEs2HRasIu0WIvHhtIJQZcrcwKu74bwb7S4w0wRGqLXNv3WslE7FHFuE/lGolPeBG8ck3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YfQb6txF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [40.64.70.95])
	by linux.microsoft.com (Postfix) with ESMTPSA id 72DCE20F9E01;
	Thu, 17 Oct 2024 14:34:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 72DCE20F9E01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729200865;
	bh=5LDQqCj+7IEmGxL9LpUtIL3zTfShlSU/MVLzhi+m0aI=;
	h=Subject:From:To:Cc:Date:From;
	b=YfQb6txF0bvMAAag2TqVMOhQrIcYh98UoUqkqbNc1fQE+vSOqI+nOBGAPEJ4oJSl4
	 2FKlBpurjQGLOwHZzRsIk5I0pKCjRgWPilV8jMNu/bdRSyroezNXvwyRKHbPQt+Z0W
	 INZ4G0GRkGy5ROL6QRsOxkIDjsIAeNi74OfpiglU=
Subject: [PATCH] kunit: Introduce autorun option
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: brendan.higgins@linux.dev, davidgow@google.com
Cc: rmoar@google.com, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Date: Thu, 17 Oct 2024 21:34:25 +0000
Message-ID: 
 <172920085854.4578.9203147717033046574.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The new option controls tests run on boot or module load. With the new
debugfs "run" dentry allowing to run tests on demand, an ability to disable
automatic tests run becomes a useful option in case of intrusive tests.

The option is set to true by default to preserve the existent behavior. It
can be overridden by either the corresponding module option or by the
corresponding config build option.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 include/kunit/test.h |    4 +++-
 lib/kunit/Kconfig    |   12 ++++++++++++
 lib/kunit/debugfs.c  |    2 +-
 lib/kunit/executor.c |   18 +++++++++++++++++-
 lib/kunit/test.c     |    6 ++++--
 5 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 34b71e42fb10..58dbab60f853 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -312,6 +312,7 @@ static inline void kunit_set_failure(struct kunit *test)
 }
 
 bool kunit_enabled(void);
+bool kunit_autorun(void);
 const char *kunit_action(void);
 const char *kunit_filter_glob(void);
 char *kunit_filter(void);
@@ -334,7 +335,8 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 		    int *err);
 void kunit_free_suite_set(struct kunit_suite_set suite_set);
 
-int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites);
+int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites,
+			     bool run_tests);
 
 void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites);
 
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 34d7242d526d..a97897edd964 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -81,4 +81,16 @@ config KUNIT_DEFAULT_ENABLED
 	  In most cases this should be left as Y. Only if additional opt-in
 	  behavior is needed should this be set to N.
 
+config KUNIT_AUTORUN_ENABLED
+	bool "Default value of kunit.autorun"
+	default y
+	help
+	  Sets the default value of kunit.autorun. If set to N then KUnit
+	  tests will not run after initialization unless kunit.autorun=1 is
+	  passed to the kernel command line. The test can still be run manually
+	  via debugfs interface.
+
+	  In most cases this should be left as Y. Only if additional opt-in
+	  behavior is needed should this be set to N.
+
 endif # KUNIT
diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index d548750a325a..9df064f40d98 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -145,7 +145,7 @@ static ssize_t debugfs_run(struct file *file,
 	struct inode *f_inode = file->f_inode;
 	struct kunit_suite *suite = (struct kunit_suite *) f_inode->i_private;
 
-	__kunit_test_suites_init(&suite, 1);
+	__kunit_test_suites_init(&suite, 1, true);
 
 	return count;
 }
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 34b7b6833df3..340723571b0f 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -29,6 +29,22 @@ const char *kunit_action(void)
 	return action_param;
 }
 
+/*
+ * Run KUnit tests after initialization
+ */
+#ifdef CONFIG_KUNIT_AUTORUN_ENABLED
+static bool autorun_param = true;
+#else
+static bool autorun_param;
+#endif
+module_param_named(autorun, autorun_param, bool, 0);
+MODULE_PARM_DESC(autorun, "Run KUnit tests after initialization");
+
+bool kunit_autorun(void)
+{
+	return autorun_param;
+}
+
 static char *filter_glob_param;
 static char *filter_param;
 static char *filter_action_param;
@@ -266,7 +282,7 @@ void kunit_exec_run_tests(struct kunit_suite_set *suite_set, bool builtin)
 		pr_info("1..%zu\n", num_suites);
 	}
 
-	__kunit_test_suites_init(suite_set->start, num_suites);
+	__kunit_test_suites_init(suite_set->start, num_suites, kunit_autorun());
 }
 
 void kunit_exec_list_tests(struct kunit_suite_set *suite_set, bool include_attr)
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 089c832e3cdb..146d1b48a096 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -708,7 +708,8 @@ bool kunit_enabled(void)
 	return enable_param;
 }
 
-int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites)
+int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites,
+			     bool run_tests)
 {
 	unsigned int i;
 
@@ -731,7 +732,8 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 
 	for (i = 0; i < num_suites; i++) {
 		kunit_init_suite(suites[i]);
-		kunit_run_tests(suites[i]);
+		if (run_tests)
+			kunit_run_tests(suites[i]);
 	}
 
 	static_branch_dec(&kunit_running);



