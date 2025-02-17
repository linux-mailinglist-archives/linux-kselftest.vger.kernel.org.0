Return-Path: <linux-kselftest+bounces-26772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC2A3814A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 12:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C370B1896A38
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 11:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11AF21B8F8;
	Mon, 17 Feb 2025 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pziicZDT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A6ZpWf7J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6FC21A43A;
	Mon, 17 Feb 2025 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790045; cv=none; b=U3d4nQEH48ZCXAo1cke67oWHvRBOgolPRBSl71u1uxJ2FdBboqYX1taxgBWWzd1uFgbpj2bxwC/uTVQ76Ss+DjxQaV7ldeUdsSllvSvomDx0+QB1kgKyHWIg/vpjeyjvU0X1VzWozV0sldEhi4MgVnMC37vge5B0nBIaLgW0IUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790045; c=relaxed/simple;
	bh=CBzQ5kaZsZ50e4JQy4iRm48GR6StcWRxcndjr8omck8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Le1UHRT2e4xFZ525YmF17mao4pZIESZr6zRvGzRqbotOEDlpDTF/LjO9tq4eggP+SNyWE8L3tOBkUTOXtyHOxOZpUTHyLz6ztRXNlubYJYDWOzkOBU2U9ySkOZmkwOtf60scb26nNPy5wBZ+BOcGO9aWCZnUMS5xkSSBlEjXQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pziicZDT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A6ZpWf7J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739790041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nX2HOx+bJgJaC3JjTaAXzc9i8877zcwuFmMI1HtrRck=;
	b=pziicZDTc6yyMW5Y/TIlMmn3w96HIf9bfNKaAlY7TXVNWXjjW8CJXF44PMHlIDIZro1Poo
	knc/gwUQZlINz0kvHEUh503n/tbLcmzx8aO/4WAIV25a0r5MgsjrLQ4eEvKVfRwX6EmurY
	/Oe5zaG/VJzImYiA+SKzlr0xUm8SEJdC89ShnClMUlG7LZt1mkLo7MqAQxMPtxWNHBwNp8
	EvYAMhmUtiv8UdpPyGUYod6u7E4ooZlJPOLcup6Ds8vA/LnZ0dvBxqzHnMmigQURXhDiI5
	8Fh9g2uCOWcajdoL7D04JRpavQ3dOclX0OIVuWGx7Ye45nEUUlBu+W4lNZJgcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739790041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nX2HOx+bJgJaC3JjTaAXzc9i8877zcwuFmMI1HtrRck=;
	b=A6ZpWf7Jg+suU1tB9VpabOZE/P8DL8eUapALNeLtAun/2XgKOH/vLhB8Sm2BWdPZpLqgfW
	AB0keKAbulOwplDQ==
Date: Mon, 17 Feb 2025 11:59:31 +0100
Subject: [PATCH 11/12] kunit: uapi: Introduce preinit executable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-kunit-kselftests-v1-11-42b4524c3b0a@linutronix.de>
References: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
In-Reply-To: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739790034; l=5047;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=CBzQ5kaZsZ50e4JQy4iRm48GR6StcWRxcndjr8omck8=;
 b=3I9kUaQ2vhawRxm4Lyg56ktFvC7y1mumBBb5+MlgW6y+GLdq/rKqek59NOPoCfQLP1to6S/Yl
 l90hxGkcKNIA+quGEQRuYQdwZo8mn/wcIPIWFiezY/Zll8BNvFaxiu8
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

UAPI selftests may expect a "normal" userspace environment.
For example the normal kernel API pseudo-filesystems should be mounted.
This could be done from kernel code but it is non-idiomatic.

Add a preinit userspace executable which performs these setup steps
before running the final test executable.
This preinit executable is only ever run from the kernel.
Give it access to autoconf.h and kconfig.h to adapt itself to the
tested kernel.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/kunit/Makefile       |  9 ++++++-
 lib/kunit/uapi-preinit.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/uapi.c         | 17 +++++++++++---
 3 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 0d89b666fcad12a542d3e2ffacedd26b122c5449..b1d9851f1a14ecd7fb48a20c5500058811259142 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -12,7 +12,14 @@ kunit-objs +=				test.o \
 					device.o \
 					platform.o
 
-obj-$(CONFIG_KUNIT_UAPI) +=		uapi.o
+userprogs +=				uapi-preinit
+uapi-preinit-nolibc :=			$(CONFIG_ARCH_HAS_NOLIBC)
+uapi-preinit-userccflags +=		-static \
+					-include include/generated/autoconf.h \
+					-include $(srctree)/tools/include/linux/kconfig.h
+blobs +=				uapi-preinit.blob.o
+uapi-preinit.blob-symbol :=		kunit_uapi_preinit
+obj-$(CONFIG_KUNIT_UAPI) +=		uapi.o uapi-preinit.blob.o
 
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
diff --git a/lib/kunit/uapi-preinit.c b/lib/kunit/uapi-preinit.c
new file mode 100644
index 0000000000000000000000000000000000000000..748599786aaa802982335e536ddae122f5cc2be5
--- /dev/null
+++ b/lib/kunit/uapi-preinit.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit Userspace environment setup.
+ *
+ * Copyright (C) 2025, Linuxtronix GmbH.
+ * Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ */
+
+#ifndef NOLIBC
+#include <sys/mount.h>
+#include <sys/stat.h>
+#endif
+
+#include "../../tools/testing/selftests/kselftest.h"
+
+static int setup_api_mount(const char *target, const char *fstype)
+{
+	int ret;
+
+	ret = mkdir(target, 0755);
+	if (ret && errno != EEXIST)
+		return -errno;
+
+	ret = mount("none", target, fstype, 0, NULL);
+	if (ret && errno != EBUSY)
+		return -errno;
+
+	return 0;
+}
+
+static void exit_failure(const char *stage, int err)
+{
+	/* If preinit fails synthesize a failed test report. */
+	ksft_print_header();
+	ksft_set_plan(1);
+	ksft_test_result_fail("Failed during test setup: %s: %s\n", stage, strerror(-err));
+	ksft_finished();
+}
+
+int main(int argc, char **argv, char **envp)
+{
+	int ret;
+
+	ret = setup_api_mount("/proc", "proc");
+	if (ret)
+		exit_failure("mount /proc", ret);
+	ret = setup_api_mount("/sys", "sysfs");
+	if (ret)
+		exit_failure("mount /sys", ret);
+	if (IS_ENABLED(CONFIG_DEVTMPFS)) {
+		ret = setup_api_mount("/dev", "devtmpfs");
+		if (ret)
+			exit_failure("mount /dev", ret);
+	}
+
+	ret = execve(argv[0], argv, envp);
+	if (ret)
+		exit_failure("execve", ret);
+
+	return 0;
+}
diff --git a/lib/kunit/uapi.c b/lib/kunit/uapi.c
index 9fbba13669e8e5cf349e596636f2cdc4adce4978..d43a1a1e5084ab1c7c4515e3c44fd3e819524737 100644
--- a/lib/kunit/uapi.c
+++ b/lib/kunit/uapi.c
@@ -19,6 +19,8 @@
 #include <kunit/test.h>
 #include <kunit/uapi.h>
 
+#define KUNIT_UAPI_PREINIT	"preinit"
+
 static struct vfsmount *kunit_uapi_mount_tmpfs(void)
 {
 	struct file_system_type *type;
@@ -118,7 +120,7 @@ static int kunit_uapi_user_mode_thread_init(void *data)
 	kernel_sigaction(SIGKILL, SIG_DFL);
 
 	complete(&ctx->setup_done);
-	ctx->exec_err = kernel_execve(ctx->executable, argv, NULL);
+	ctx->exec_err = kernel_execve(KUNIT_UAPI_PREINIT, argv, NULL);
 	if (!ctx->exec_err)
 		return 0;
 	do_exit(0);
@@ -213,6 +215,8 @@ static int kunit_uapi_run_executable_in_mount(struct kunit *test, const char *ex
 
 void kunit_uapi_run_executable(struct kunit *test, const struct blob *blob)
 {
+	DECLARE_BLOB(kunit_uapi_preinit);
+
 	const char *exe_name = kbasename(blob->path);
 	struct vfsmount *mnt;
 	int err;
@@ -222,8 +226,15 @@ void kunit_uapi_run_executable(struct kunit *test, const struct blob *blob)
 	if (IS_ERR(mnt))
 		return;
 
-	err = kunit_uapi_write_file(mnt, exe_name, 0700, blob->data, blob_size(blob));
-	KUNIT_EXPECT_EQ_MSG(test, 0, err, "Could not add test executable: %pe", ERR_PTR(err));
+	err = kunit_uapi_write_file(mnt, KUNIT_UAPI_PREINIT, 0755,
+				    kunit_uapi_preinit.data, blob_size(&kunit_uapi_preinit));
+	KUNIT_EXPECT_EQ_MSG(test, 0, err, "Could not add preinit executable: %pe", ERR_PTR(err));
+
+	if (!err) {
+		err = kunit_uapi_write_file(mnt, exe_name, 0755, blob->data, blob_size(blob));
+		KUNIT_EXPECT_EQ_MSG(test, 0, err, "Could not add test executable: %pe",
+				    ERR_PTR(err));
+	}
 
 	if (!err) {
 		err = kunit_uapi_run_executable_in_mount(test, exe_name, mnt);

-- 
2.48.1


