Return-Path: <linux-kselftest+bounces-30229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB36CA7D68E
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 09:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060A416C332
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 07:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76913225797;
	Mon,  7 Apr 2025 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xc9xbUdx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eWkI91IU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6976227E97;
	Mon,  7 Apr 2025 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011786; cv=none; b=ENT6aRndKtSJMwnqTC2zaTuamB8Z1/qbIVW2ne2++vaNVHGbOGN+tDDPhg8SwoEa6pJjGLtNs6hjDDyHC+gD6rP1mMvVfXpp3NQOjDwG6W5wdm/kmjIA8RSeaaFqWEqe8T0xeoXGUHUrCEShYUw7ellMkg+vK6tonfHcb0FAMcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011786; c=relaxed/simple;
	bh=BJjxDVOAScIUTDwIklTYMi6GjYN1Y6hswgbnbM6bCic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JlQTqtn9aAcjb/oIJpMavriNk4wGX38LyujNzsnRgW51H5WGO4k6TaLrsNDP5PryRgmF7Q9EJtmdVMzu6kL4Uz5Z5gz6mDY8Y8PYa/LwL5+eja7pfQPciqdd1wk8ybbLzdQ/faYmQJw0aqflwXF3sxKmptdVsptVIUWGcal1Loo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xc9xbUdx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eWkI91IU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744011781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWHOXiEgR336RbzqYYV1p85OpVn4Usorgcrpl6yAPSI=;
	b=Xc9xbUdxRyump+8gfCPyVulGUDomdQHhawumfaDgxVlq6ybZGMuOuhg7QEzlt68vcIWk9y
	KvgDVPYT15UFLnVSiILRBwB0buKrhKDA2m91/ZXnuNT7q9Ur25sgO/HwtgIYt1gbkH/eeS
	Qn7qdzGCzBzXo9dA/UTIBD8wLuG58lmhrgu8u/rAzw8XaJNP8nqcyX02cK/E91P3Fe+QNS
	vzwDlFnn9geGuSU8qecXQr+/wLQ8OvYcMRVy0czRI4Zv9/z0HvRh6adAt0TbLU04z88+Cx
	zAs0fRxmmI9Vl+s2QWrCif3In/7rp9yQN0igbQPqiVfv2INAC5zszmawWxbYTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744011781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWHOXiEgR336RbzqYYV1p85OpVn4Usorgcrpl6yAPSI=;
	b=eWkI91IUG8tdyP7VcMzCTzlONqxNiTcBjsjlCU54tRobZMT1g93wucwKgdGdZR82IpGKWj
	/jJ8e6KDNcgZIABQ==
Date: Mon, 07 Apr 2025 09:42:45 +0200
Subject: [PATCH v2 08/11] kunit: Introduce UAPI testing framework
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-kunit-kselftests-v2-8-454114e287fd@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744011776; l=11612;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=BJjxDVOAScIUTDwIklTYMi6GjYN1Y6hswgbnbM6bCic=;
 b=TxVkciELYktAzCZ0/FiXRQDVHJ/mX91C7FEKwy32O821rrsEohzX9n16eShxqXCD5HIw6JELE
 6+cYO2dYp6aAjGxi/G0TuDXMOvgS4M+7s2DunvTigz35u0THlNhNqAR
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
Currently this depends on CONFIG_KUNIT=y as it uses some non-exported
symbols around process management.
---
 Documentation/dev-tools/kunit/api/index.rst |   5 +
 Documentation/dev-tools/kunit/api/uapi.rst  |  12 ++
 include/kunit/uapi.h                        |  24 +++
 lib/kunit/Kconfig                           |  11 ++
 lib/kunit/Makefile                          |   2 +
 lib/kunit/uapi.c                            | 287 ++++++++++++++++++++++++++++
 6 files changed, 341 insertions(+)

diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
index 5cdb552a0808f25baeff5e47a9227b7b62c69e40..34d8fee9a97059d6da919a6fb1a7e359b5e0beef 100644
--- a/Documentation/dev-tools/kunit/api/index.rst
+++ b/Documentation/dev-tools/kunit/api/index.rst
@@ -9,6 +9,7 @@ API Reference
 	test
 	resource
 	functionredirection
+	uapi
 	clk
 	of
 	platformdevice
@@ -32,6 +33,10 @@ Documentation/dev-tools/kunit/api/functionredirection.rst
 
  - Documents the KUnit Function Redirection API
 
+Documentation/dev-tools/kunit/api/uapi.rst
+
+ - Documents the KUnit Userspace testing API
+
 Driver KUnit API
 ================
 
diff --git a/Documentation/dev-tools/kunit/api/uapi.rst b/Documentation/dev-tools/kunit/api/uapi.rst
new file mode 100644
index 0000000000000000000000000000000000000000..b4764424c629bf69194cf2786f52aef154b02bf8
--- /dev/null
+++ b/Documentation/dev-tools/kunit/api/uapi.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
+Userspace Test API
+==================
+
+This file documents all of the userspace testing API.
+Userspace tests should be built as :ref:`userprogs <kbuild_userprogs>` and included into the test
+module or kernel as :ref:`blobs <kbuild_blobs>`.
+
+.. kernel-doc:: include/kunit/uapi.h
+   :internal:
diff --git a/include/kunit/uapi.h b/include/kunit/uapi.h
new file mode 100644
index 0000000000000000000000000000000000000000..a6181790c96a42df05839097991c1fbfd889cdbe
--- /dev/null
+++ b/include/kunit/uapi.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit Userspace testing API.
+ *
+ * Copyright (C) 2025, Linutronix GmbH.
+ * Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ */
+
+#ifndef _KUNIT_UAPI_H
+#define _KUNIT_UAPI_H
+
+struct blob;
+struct kunit;
+
+/**
+ * kunit_uapi_run_kselftest() - Run a userspace kselftest as part of kunit
+ * @test: The test context object.
+ * @executable: kselftest executable to run
+ *
+ * Runs the kselftest and forwards its TAP output and exit status to kunit.
+ */
+void kunit_uapi_run_kselftest(struct kunit *test, const struct blob *executable);
+
+#endif /* _KUNIT_UAPI_H */
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index a97897edd9642f3e5df7fdd9dee26ee5cf00d6a4..79fcf0565f60100920b9613199421bf9cae1c2b0 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -93,4 +93,15 @@ config KUNIT_AUTORUN_ENABLED
 	  In most cases this should be left as Y. Only if additional opt-in
 	  behavior is needed should this be set to N.
 
+config KUNIT_UAPI
+	def_bool y
+	depends on KUNIT=y
+	depends on CC_CAN_LINK_STATIC || ARCH_HAS_NOLIBC
+	depends on TMPFS
+	select HEADERS_INSTALL
+	help
+	  Enables support for building and running userspace selftests as part of kunit.
+	  These tests should be statically linked and use kselftest.h or kselftest_harness.h
+	  for status reporting.
+
 endif # KUNIT
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 5aa51978e456ab3bb60c12071a26cf2bdcb1b508..989933dab9ad2267f376db470b876ce2a88711b4 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -12,6 +12,8 @@ kunit-objs +=				test.o \
 					device.o \
 					platform.o
 
+kunit-$(CONFIG_KUNIT_UAPI) +=		uapi.o
+
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
 endif
diff --git a/lib/kunit/uapi.c b/lib/kunit/uapi.c
new file mode 100644
index 0000000000000000000000000000000000000000..081ddc46e3ccb9ef88f9cb2a66d5e2bf41da2eb4
--- /dev/null
+++ b/lib/kunit/uapi.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit Userspace testing API.
+ *
+ * Copyright (C) 2025, Linutronix GmbH.
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
+#define KSFT_PASS	0
+#define KSFT_FAIL	1
+#define KSFT_XFAIL	2
+#define KSFT_XPASS	3
+#define KSFT_SKIP	4
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
+	/* stdin, use the *write* end to the pipe to have an unreadable input */
+	err = replace_fd(0, out[1], 0);
+	if (err < 0) {
+		fput(out[0]);
+		fput(out[1]);
+		return err;
+	}
+
+	/* stdout */
+	err = replace_fd(1, out[1], 0);
+	if (err < 0) {
+		replace_fd(0, NULL, 0);
+		fput(out[0]);
+		fput(out[1]);
+		return err;
+	}
+
+	/* stderr */
+	err = replace_fd(2, out[1], 0);
+	if (err < 0) {
+		replace_fd(0, NULL, 0);
+		replace_fd(1, NULL, 0);
+		fput(out[0]);
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
+	kernel_sigaction(SIGABRT, SIG_DFL);
+
+	complete(&ctx->setup_done);
+	ctx->exec_err = kernel_execve(ctx->executable, argv, NULL);
+	if (!ctx->exec_err)
+		return 0;
+	do_exit(0);
+}
+
+static size_t kunit_uapi_printk_subtest_lines(struct kunit *test, char *buf, size_t s)
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
+		kunit_log(KERN_INFO, test, KUNIT_SUBSUBTEST_INDENT "%.*s", (int)n, ptr);
+		ptr += n;
+		s -= n;
+	}
+
+	memmove(buf, ptr, s);
+
+	return s;
+}
+
+static int kunit_uapi_forward_to_printk(struct kunit *test, struct file *output)
+{
+	/*
+	 * printk() automatically adds a newline after each message.
+	 * Therefore only fully accumulated lines can be forwarded.
+	 * Each line needs to fit into the buffer below.
+	 */
+	char buf[512];
+	size_t s = 0;
+	ssize_t n;
+
+	while (1) {
+		n = kernel_read(output, buf + s, sizeof(buf) - s, NULL);
+		if (n <= 0)
+			return n;
+		s = kunit_uapi_printk_subtest_lines(test, buf, s + n);
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
+		.setup_done	= COMPLETION_INITIALIZER_ONSTACK(ctx.setup_done),
+		.executable	= executable,
+		.pwd		= {
+			.mnt	= mnt,
+			.dentry	= mnt->mnt_root,
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
+	forward_err = kunit_uapi_forward_to_printk(test, ctx.out);
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
+static int kunit_uapi_run_executable(struct kunit *test, const struct blob *executable)
+{
+	const char *exe_name = kbasename(executable->path);
+	struct vfsmount *mnt;
+	int err;
+
+	mnt = kunit_uapi_mount_tmpfs();
+	if (IS_ERR(mnt))
+		return PTR_ERR(mnt);
+
+	err = kunit_uapi_write_file(mnt, exe_name, 0755, executable->data, blob_size(executable));
+
+	if (!err)
+		err = kunit_uapi_run_executable_in_mount(test, exe_name, mnt);
+
+	kern_unmount(mnt);
+
+	return err;
+}
+
+void kunit_uapi_run_kselftest(struct kunit *test, const struct blob *executable)
+{
+	u8 exit_code, exit_signal;
+	int err;
+
+	err = kunit_uapi_run_executable(test, executable);
+	if (err < 0)
+		KUNIT_FAIL(test, "Could not run test executable: %pe\n", ERR_PTR(err));
+
+	exit_code = err >> 8;
+	exit_signal = err & 0xff;
+
+	if (exit_signal)
+		KUNIT_FAIL(test, "kselftest exited with signal: %d\n", exit_signal);
+	else if (exit_code == KSFT_PASS)
+		; /* Noop */
+	else if (exit_code == KSFT_FAIL)
+		KUNIT_FAIL(test, "kselftest exited with code KSFT_FAIL\n");
+	else if (exit_code == KSFT_XPASS)
+		KUNIT_FAIL(test, "kselftest exited with code KSFT_XPASS\n");
+	else if (exit_code == KSFT_XFAIL)
+		; /* Noop */
+	else if (exit_code == KSFT_SKIP)
+		kunit_mark_skipped(test, "kselftest exited with code KSFT_SKIP\n");
+	else
+		KUNIT_FAIL(test, "kselftest exited with unknown exit code: %d\n", exit_code);
+}
+EXPORT_SYMBOL_GPL(kunit_uapi_run_kselftest);

-- 
2.49.0


