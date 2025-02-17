Return-Path: <linux-kselftest+bounces-26769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA1DA38124
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 12:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DFE3A50C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 11:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD0F21A931;
	Mon, 17 Feb 2025 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cvz9N0q/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wkXAKeDK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F90218821;
	Mon, 17 Feb 2025 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790044; cv=none; b=GvYJV+PuC44nUTyC3wtGIMjwEpHbU8ubt8vjNsc+hA70Y6JwkSgPdPzJ+sKZYMWifsq+0YsoqIIJmBp8d2wDFgy9lLfQ4DDNkt6V3coJoSLhfe/mOBLbAcSAbOJaxctTwuzkeUoZiu7ZuBR0PbfdI+jLww5ekZVyYa9KuOYIRK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790044; c=relaxed/simple;
	bh=34AMfccJyLcBH84STO1VZXha6yixDc3MiV7ZpqvLAr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rC65RXxlFyPLcWIpmUDhuHdxG/COGpGTk4hap7i8qM2XsjOkcfOL4Kpsh+T9hqqq3hMneEif3TT84Z3sK8qLy4gHJ7F0zHywYryYMRaiV0BDvAcD+PazIBgYrWTJ3070mWNl7BxZPwhzGiYhKdWRLcJk7RszZj8UZS1/uT0bkH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cvz9N0q/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wkXAKeDK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739790040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PinOl+NovMq8VEGwrJxMZ57WRxpBIh00nLZNCtv5D2s=;
	b=Cvz9N0q/aEIFQw5lCdor6zsdxKV7+Jx1Uzqza451bYBAwCxadMDzJhydVpputqb/qSOJn9
	NSkU4kZLfl+O4EmeFnYLUd8zDwFq9jqunIkE7p8GiCPKmc4EFGu4vaBEHfSmi1+DPBUZ35
	lt9qdJ7609V+oIalVcDodgW1M91EyGqTMZ6b7VNNsh1/j+NuKm/3JTAPJda4v7vBXVECUp
	NXAxGB3m9EIISpMhPvzj5tsz4HalsmNleZW7QILm5RJx6et7dbX7qbXCJMhslApRmdPSyM
	DoT1QMZSZ6wmFecTIGvoVFYrxgq7YaMRA4rtGxTMGVIhb+YcvT6cAPDCbNop4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739790040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PinOl+NovMq8VEGwrJxMZ57WRxpBIh00nLZNCtv5D2s=;
	b=wkXAKeDK6R4Kaz/1mECHOuRFBs2YYcTHhW17BXeEA0LBFGQca+iyvJ1D6YqQ92PXai5FyU
	iP5cp+jVMRYxhrBA==
Date: Mon, 17 Feb 2025 11:59:29 +0100
Subject: [PATCH 09/12] kunit: Introduce UAPI testing framework
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-kunit-kselftests-v1-9-42b4524c3b0a@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739790034; l=8296;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=34AMfccJyLcBH84STO1VZXha6yixDc3MiV7ZpqvLAr0=;
 b=ughB+neAU8Wvl83YqlOgbkKUbGH66SdIHs9oHvnjU2yTyMptq7+QGFs9Rh+1bW0doTBBYWU6D
 tUUSwHcvwURA0IpzDpaC1TNS/pwOl65Zl2oMO5iWUOljC2D5AW+TkUy
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Enable running UAPI tests as part of kunit.
The selftests are embedded into the kernel image and their output is
forwarded to kunit for unified reporting.

The implementation reuses parts of usermode drivers and usermode
helpers. However these frameworks are not used directly as they make it
impossible to retrieve a thread's exit code.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/kunit/uapi.h |  17 ++++
 lib/kunit/Kconfig    |   9 ++
 lib/kunit/Makefile   |   2 +
 lib/kunit/uapi.c     | 239 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 267 insertions(+)

diff --git a/include/kunit/uapi.h b/include/kunit/uapi.h
new file mode 100644
index 0000000000000000000000000000000000000000..760fad98884e12cbbec33155d3cc8ae083b0882b
--- /dev/null
+++ b/include/kunit/uapi.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit Userspace testing API.
+ *
+ * Copyright (C) 2025, Linuxtronix GmbH.
+ * Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ */
+
+#ifndef _KUNIT_UAPI_H
+#define _KUNIT_UAPI_H
+
+struct blob;
+struct kunit;
+
+void kunit_uapi_run_executable(struct kunit *test, const struct blob *blob);
+
+#endif /* _KUNIT_UAPI_H */
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index a97897edd9642f3e5df7fdd9dee26ee5cf00d6a4..e15b9a678a6ad2b37c898f8b4e17e06567eb7bb5 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -15,6 +15,15 @@ menuconfig KUNIT
 
 if KUNIT
 
+config KUNIT_UAPI
+	def_bool y
+	depends on CC_CAN_LINK_STATIC || ARCH_HAS_NOLIBC
+	select HEADERS_INSTALL
+	select TMPFS
+	help
+	  Enables support for build and running userspace selftests as part of kunit.
+	  These tests should use kselftest.h for status reporting.
+
 config KUNIT_DEBUGFS
 	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation" if !KUNIT_ALL_TESTS
 	default KUNIT_ALL_TESTS
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 5aa51978e456ab3bb60c12071a26cf2bdcb1b508..2b68f9bd20137edb705dcd8cb2dc145f9684cf73 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -12,6 +12,8 @@ kunit-objs +=				test.o \
 					device.o \
 					platform.o
 
+obj-$(CONFIG_KUNIT_UAPI) +=		uapi.o
+
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
 endif
diff --git a/lib/kunit/uapi.c b/lib/kunit/uapi.c
new file mode 100644
index 0000000000000000000000000000000000000000..9fbba13669e8e5cf349e596636f2cdc4adce4978
--- /dev/null
+++ b/lib/kunit/uapi.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit Userspace testing API.
+ *
+ * Copyright (C) 2025, Linuxtronix GmbH.
+ * Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ */
+
+#include <linux/binfmts.h>
+#include <linux/blob.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/fs_struct.h>
+#include <linux/pid.h>
+#include <linux/pipe_fs_i.h>
+#include <linux/sched/task.h>
+#include <linux/types.h>
+
+#include <kunit/test.h>
+#include <kunit/uapi.h>
+
+static struct vfsmount *kunit_uapi_mount_tmpfs(void)
+{
+	struct file_system_type *type;
+	struct vfsmount *mnt;
+
+	type = get_fs_type("tmpfs");
+	if (!type)
+		return ERR_PTR(-ENODEV);
+
+	/* FIXME
+	 * The mount setup is supposed to look like this:
+	 * kunit_uapi_mount_tmpfs() sets up a private mount,
+	 * with nothing visible except the new tmpfs.
+	 * Then each executable execution gets a new namespace on top of that
+	 * on which it can mount whatever it needs.
+	 * However I didn't manage to set this up, so keep everything simple
+	 * for now and let somebody familiar with the VFS figure this out.
+	 */
+
+	mnt = kern_mount(type);
+	put_filesystem(type);
+
+	return mnt;
+}
+
+static int kunit_uapi_write_file(struct vfsmount *mnt, const char *name, mode_t mode,
+				 const u8 *data, size_t size)
+{
+	struct file *file;
+	ssize_t written;
+
+	file = file_open_root_mnt(mnt, name, O_CREAT | O_WRONLY, mode);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	written = kernel_write(file, data, size, NULL);
+	filp_close(file, NULL);
+	if (written != size) {
+		if (written >= 0)
+			return -ENOMEM;
+		return written;
+	}
+
+	/* Flush delayed fput so exec can open the file read-only */
+	flush_delayed_fput();
+
+	return 0;
+}
+
+struct kunit_uapi_user_mode_thread_ctx {
+	const char *executable;
+
+	/* Signals mnt, out, pwd and tgid */
+	struct completion setup_done;
+	struct vfsmount *mnt;
+	struct file *out;
+	struct path pwd;
+	pid_t tgid;
+
+	/* Valid after wait(tgid) */
+	int exec_err;
+};
+
+static int kunit_uapi_user_mode_thread_init(void *data)
+{
+	struct kunit_uapi_user_mode_thread_ctx *ctx = data;
+	const char *const argv[] = {
+		ctx->executable,
+		NULL
+	};
+	struct file *out[2];
+	int err;
+
+	err = create_pipe_files(out, 0);
+	if (err)
+		return err;
+
+	err = replace_fd(1, out[1], 0);
+	if (err < 0) {
+		fput(out[1]);
+		return err;
+	}
+
+	err = replace_fd(2, out[1], 0);
+	if (err < 0) {
+		replace_fd(0, NULL, 0);
+		fput(out[1]);
+		return err;
+	}
+
+	fput(out[1]);
+
+	ctx->out = out[0];
+	ctx->tgid = current->tgid;
+
+	set_fs_pwd(current->fs, &ctx->pwd);
+	kernel_sigaction(SIGKILL, SIG_DFL);
+
+	complete(&ctx->setup_done);
+	ctx->exec_err = kernel_execve(ctx->executable, argv, NULL);
+	if (!ctx->exec_err)
+		return 0;
+	do_exit(0);
+}
+
+static size_t kunit_uapi_printk_subtest_lines(char *buf, size_t s)
+{
+	const char *ptr = buf, *newline;
+	size_t n;
+
+	while (s) {
+		newline = strnchr(ptr, s, '\n');
+		if (!newline)
+			break;
+
+		n = newline - ptr + 1;
+
+		pr_info(KUNIT_SUBSUBTEST_INDENT "%.*s", (int)n, ptr);
+		ptr += n;
+		s -= n;
+	}
+
+	memmove(buf, ptr, s);
+
+	return s;
+}
+
+static int kunit_uapi_forward_to_printk(struct file *output)
+{
+	char buf[512];
+	size_t s = 0;
+	ssize_t n;
+
+	while (1) {
+		n = kernel_read(output, buf + s, sizeof(buf) - s, NULL);
+		if (n <= 0)
+			return n;
+		s = kunit_uapi_printk_subtest_lines(buf, s + n);
+	}
+}
+
+static void kunit_uapi_kill_pid(pid_t pid)
+{
+	struct pid *p;
+
+	p = find_get_pid(pid);
+	kill_pid(p, SIGKILL, 1);
+	put_pid(p);
+}
+
+static int kunit_uapi_run_executable_in_mount(struct kunit *test, const char *executable,
+						   struct vfsmount *mnt)
+{
+	struct kunit_uapi_user_mode_thread_ctx ctx = {
+		.setup_done = COMPLETION_INITIALIZER_ONSTACK(ctx.setup_done),
+		.executable = executable,
+		.pwd = {
+			.mnt = mnt,
+			.dentry = mnt->mnt_root,
+		},
+	};
+	int forward_err, wait_err, ret;
+	pid_t pid;
+
+	/* If SIGCHLD is ignored do_wait won't populate the status. */
+	kernel_sigaction(SIGCHLD, SIG_DFL);
+	pid = user_mode_thread(kunit_uapi_user_mode_thread_init, &ctx, SIGCHLD);
+	if (pid < 0) {
+		kernel_sigaction(SIGCHLD, SIG_IGN);
+		return pid;
+	}
+
+	wait_for_completion(&ctx.setup_done);
+
+	forward_err = kunit_uapi_forward_to_printk(ctx.out);
+	if (forward_err)
+		kunit_uapi_kill_pid(ctx.tgid);
+
+	wait_err = kernel_wait(ctx.tgid, &ret);
+
+	/* Restore default kernel sig handler */
+	kernel_sigaction(SIGCHLD, SIG_IGN);
+
+	if (ctx.exec_err)
+		return ctx.exec_err;
+	if (forward_err)
+		return forward_err;
+	if (wait_err < 0)
+		return wait_err;
+	return ret;
+}
+
+void kunit_uapi_run_executable(struct kunit *test, const struct blob *blob)
+{
+	const char *exe_name = kbasename(blob->path);
+	struct vfsmount *mnt;
+	int err;
+
+	mnt = kunit_uapi_mount_tmpfs();
+	KUNIT_EXPECT_FALSE_MSG(test, IS_ERR(mnt), "Could not mount tmpfs for test: %pe", mnt);
+	if (IS_ERR(mnt))
+		return;
+
+	err = kunit_uapi_write_file(mnt, exe_name, 0700, blob->data, blob_size(blob));
+	KUNIT_EXPECT_EQ_MSG(test, 0, err, "Could not add test executable: %pe", ERR_PTR(err));
+
+	if (!err) {
+		err = kunit_uapi_run_executable_in_mount(test, exe_name, mnt);
+		KUNIT_EXPECT_GE_MSG(test, err, 0, "Error when running executable: %pe\n",
+				    ERR_PTR(err));
+		KUNIT_EXPECT_EQ_MSG(test, 0, err, "Executable signal/exitcode: %d/%d\n",
+				    err & 0xff, err >> 8);
+	}
+
+	kern_unmount(mnt);
+
+}
+EXPORT_SYMBOL_GPL(kunit_uapi_run_executable);

-- 
2.48.1


