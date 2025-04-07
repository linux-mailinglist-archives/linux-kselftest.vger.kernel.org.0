Return-Path: <linux-kselftest+bounces-30231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C2EA7D6AD
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 09:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30E4426DDB
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 07:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2904822A81A;
	Mon,  7 Apr 2025 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="unOZspRp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zKRi9Mbc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37B0226170;
	Mon,  7 Apr 2025 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011787; cv=none; b=bwOEHoSlbmGkEhBrULxyZhipdi/NHaHjPE1OaocgaECdN9H3DHoX2/o00OQ+rKIDB/ZuN99uwOy/Z1xQ12xwUlY3zaNt7324OszdggF6U1xj5Va6cEiTDkbnR3oGb7yhwKwRi8Y6QvkHZSfLVD1x02Q1TCsCtBascBOXcAZIaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011787; c=relaxed/simple;
	bh=xUCaF6k9BYP7TOM/3xFonEKp/BSBo2jOg0KnUhM0Eqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E+dn04KLz6bui4UQdBnMfOQ9sENS7epHnhMJ9os9R7uZv1R9dyeKa4t9ePyZovuEQoV8UMePVx01Qx+eD8xoz+coSGbTVS5KUfpjPNNfhviA+dZ4NpLbPlDUpOUvexyCzxebiJhXNmpM3YVpC/FcIYSZjcQJxZRtIVHLeKutrKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=unOZspRp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zKRi9Mbc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744011782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sxk6G7Z5jRjy2/dO8fPQpjCbk+UdXoRV8wS6B4QQkus=;
	b=unOZspRpSui6P7RYwIA4YsN7fEn/9Sr90Rg3tWxwjd3FTF8nLDOJbxc6KWibf/NdGEgCms
	qRK1MxT6s3kc2jv1bCKMrj9t3JA/eCqM+GkNBXcVeFjXlrvNhO4/F0i/u5tkQDBq/PqUj4
	sTqfZQ/wivpvd9i3GQfsh0GdSctDEMr7fZSiqhvR8ZBbsjNMyWbQBiLmX2cPTpiLR308dI
	iAJoT19cBjZ4ZV7pbgZGMXJOuuiG+Pewhk7Bzik7MJpBoPmdjmXi6gu3/xMrj2RDuW7N9T
	5NZe6ICLPQShrvQU7yxfTSbruM7EzsMKyQDxCMRPbRAyMMkCkatVGaG981+4sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744011782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sxk6G7Z5jRjy2/dO8fPQpjCbk+UdXoRV8wS6B4QQkus=;
	b=zKRi9Mbc+dA/qpsArLYMMY+cbx2KuG6iL/4OluhXXu5tJMtfIv9+IofEX5Yn4iJfcvc3hO
	X/upn/hbeZPid3Aw==
Date: Mon, 07 Apr 2025 09:42:47 +0200
Subject: [PATCH v2 10/11] kunit: uapi: Introduce preinit executable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-kunit-kselftests-v2-10-454114e287fd@linutronix.de>
References: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
In-Reply-To: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744011776; l=4690;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=xUCaF6k9BYP7TOM/3xFonEKp/BSBo2jOg0KnUhM0Eqw=;
 b=oiyTkWtQflr5rtCylnwcDKBGvuF5yyQ5gLYJwwUshGhm6oNpqg7mc0B8Co+vgvDWAL3zGow2K
 ulXHDAvMpK7Dceedd75ai+119iIRNq2keYRuLzqpz8jCFzKtL97gkyF
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
 lib/kunit/uapi-preinit.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/uapi.c         | 11 ++++++--
 3 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 1b6be12676f89cafa34f0093d8136b36f4cf5532..0e9a26d90bf4d5128e270ecaa8f3465f28da0fa2 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -12,7 +12,14 @@ kunit-objs +=				test.o \
 					device.o \
 					platform.o
 
-kunit-$(CONFIG_KUNIT_UAPI) +=		uapi.o
+userprogs +=				uapi-preinit
+uapi-preinit-nolibc :=			$(CONFIG_ARCH_HAS_NOLIBC)
+uapi-preinit-userccflags +=		-static \
+					-include include/generated/autoconf.h \
+					-include $(srctree)/tools/include/linux/kconfig.h
+blobs +=				uapi-preinit.blob.o
+uapi-preinit.blob-symbol :=		kunit_uapi_preinit
+kunit-$(CONFIG_KUNIT_UAPI) +=		uapi.o uapi-preinit.blob.o
 
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
diff --git a/lib/kunit/uapi-preinit.c b/lib/kunit/uapi-preinit.c
new file mode 100644
index 0000000000000000000000000000000000000000..56bd50822b91af15d88cb32476fbbe6a85806761
--- /dev/null
+++ b/lib/kunit/uapi-preinit.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit Userspace environment setup.
+ *
+ * Copyright (C) 2025, Linutronix GmbH.
+ * Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ *
+ * This is *userspace* code.
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
+
+	ret = setup_api_mount("/sys", "sysfs");
+	if (ret)
+		exit_failure("mount /sys", ret);
+
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
index 081ddc46e3ccb9ef88f9cb2a66d5e2bf41da2eb4..20eba19cbc0d4e1effcc7813df0da6eb5d1ef846 100644
--- a/lib/kunit/uapi.c
+++ b/lib/kunit/uapi.c
@@ -139,7 +139,7 @@ static int kunit_uapi_user_mode_thread_init(void *data)
 	kernel_sigaction(SIGABRT, SIG_DFL);
 
 	complete(&ctx->setup_done);
-	ctx->exec_err = kernel_execve(ctx->executable, argv, NULL);
+	ctx->exec_err = kernel_execve(kbasename(BLOB(kunit_uapi_preinit)->path), argv, NULL);
 	if (!ctx->exec_err)
 		return 0;
 	do_exit(0);
@@ -239,6 +239,7 @@ static int kunit_uapi_run_executable_in_mount(struct kunit *test, const char *ex
 
 static int kunit_uapi_run_executable(struct kunit *test, const struct blob *executable)
 {
+	const struct blob *preinit = BLOB(kunit_uapi_preinit);
 	const char *exe_name = kbasename(executable->path);
 	struct vfsmount *mnt;
 	int err;
@@ -247,7 +248,13 @@ static int kunit_uapi_run_executable(struct kunit *test, const struct blob *exec
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 
-	err = kunit_uapi_write_file(mnt, exe_name, 0755, executable->data, blob_size(executable));
+	err = kunit_uapi_write_file(mnt, kbasename(preinit->path), 0755,
+				    preinit->data,
+				    blob_size(preinit));
+
+	if (!err)
+		err = kunit_uapi_write_file(mnt, exe_name, 0755,
+					    executable->data, blob_size(executable));
 
 	if (!err)
 		err = kunit_uapi_run_executable_in_mount(test, exe_name, mnt);

-- 
2.49.0


