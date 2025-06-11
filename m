Return-Path: <linux-kselftest+bounces-34657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D7CAD4D42
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EEB17DCA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5662475E3;
	Wed, 11 Jun 2025 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eLrUCPsY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wj2au+nK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA73523F412;
	Wed, 11 Jun 2025 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627522; cv=none; b=JpMwxMYTNL3/xvDqdhWxnvVfi4qi5inp3IXR8+KyRyA0BSx6cl/pqev8LPUmE1hjSMapNAuME7k+k+m23lXMx00BbUV07Neo5HuGOXS0U9X4sqYLmYL6AoRQ4Jgij/r7/ePloQpRONwTangMxj9q1Odq4T+G3gRrX2auY+eHr6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627522; c=relaxed/simple;
	bh=LrqS14BgBBh1vJManAT++TMRX3/0WwlTJmmoCOXwvPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKuky/3BfQP3BJoUgTG6CeVYtDplXqZGkPIMeGlwcHNswuSSODWsbQ+K99db7kkAA+w0TnmdJTlkphlXd68elpYccmrciH3igHvyjc9hpj45JJZcJ+FSW3j1TxaNcv3ujZRdFusz5fE7Q3b3SiZhrRr0ArtBcLMDch3r/fMHuGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eLrUCPsY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wj2au+nK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749627518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gsOOrGBakifNVCfKsVVVvhphUazsao0TPGogrQbBl2g=;
	b=eLrUCPsYv5gADn8+3sK2GRnIrrpbSOpLe4GNHneQO4DeP8C62gwifn+84R6qE6uQ0loLKO
	J7tRzhsIW2w2ZxBLzEHNzLzDaAbJC8DiyQ5usTIoZN4Hrq+IM7BX35S7uPcWDNw2XOzygz
	GWeqUYv9000ZCnvIPizgUcCqARevMeSEVp2tCo2A6k6J4XGzUewxv/OckUyMAXcIPDttmW
	pYaom6imO2ePjMaZsA1D81UhfrmRDzZGejo5Mvhm4ovSknOtoAa4elJNmvb8upHsvRGR7T
	W0vYFIrkNqYZBxRrjF0NcfqJDzlDsRZw3eqI+Sx5RTXPZIK0c4Pu446HOCkazg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749627518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gsOOrGBakifNVCfKsVVVvhphUazsao0TPGogrQbBl2g=;
	b=Wj2au+nKYQgPGmH1T5ci+Jv8EalPVdjiAV4Ttu2hoAj7phxQJbDRiWJOHEwtpSMw30xZ0X
	S6KPIrFpsnG0gKBA==
Date: Wed, 11 Jun 2025 09:38:21 +0200
Subject: [PATCH v3 15/16] kunit: uapi: Introduce preinit executable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-kselftests-v3-15-55e3d148cbc6@linutronix.de>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749627510; l=4665;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=LrqS14BgBBh1vJManAT++TMRX3/0WwlTJmmoCOXwvPw=;
 b=QOBN8OgiUAjyXsyLfqrFeeDagneiyz16sdrt6s8Kt0CsPoZwX20L0gJ0EWVEx35SoA0gC5np6
 aKnUPlAdBi/Bn5I+vXXqYQUmndHsyI4s3CWGST2VM+c22P+zHSAbrle
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
 lib/kunit/uapi-preinit.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/uapi.c         | 11 +++++++--
 3 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index e406a31df1df834a87961663de0b7921b59481c2..19493ec320c61e2ccbb58e8b2e943e9a4ec447e2 100644
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
index 0000000000000000000000000000000000000000..81182039965a8c93aebb2d5d76f4113bfef277a6
--- /dev/null
+++ b/lib/kunit/uapi-preinit.c
@@ -0,0 +1,63 @@
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
+#include <sys/mount.h>
+#include <sys/stat.h>
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
index 121146dda533b3f90aca37c20bd0e7a1d20cb3b5..bccc081a6538507724c1ef340203cfd147170dc4 100644
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


