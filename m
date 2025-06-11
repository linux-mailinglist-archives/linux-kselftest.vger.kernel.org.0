Return-Path: <linux-kselftest+bounces-34656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A89AD4D3E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D61B3A8587
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CD224679B;
	Wed, 11 Jun 2025 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vvKCN8Tq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LMZ0eyYZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB323C51B;
	Wed, 11 Jun 2025 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627521; cv=none; b=MW72ySTpNlVtmQXj5WIVI9c1p4SUmp6f4rq1OOjMQenMJOyUTPswaIK2yUtti71DB4oZKMkPBJhVXsjeQkzj69DPPW4yxd496TvBAk2V4brfmN41IjYtPbfRKzdrJj9qCpd2nXqA1q/6O2xAmeGkHODqKHjK1EK6R+Lq3psf3EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627521; c=relaxed/simple;
	bh=evEGEaBGQMG0aitCkvMZt05/zY4lUxUR/hnJjYKn4fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eU6THLD4KGenecFq7ZjCsPTAz9iBbarue21vZy9TNve9HPqAMamkhhghcCKIS1sjX8d78NB2gk76mwVk+dzAv+vLkw9BscKymlWsKBfUsHyH8cpTAq+TjraacGRx/rVQ2pVhqDxMK6S/kO4svq7TJOcQ5qnrVgZsIFpO2KWb1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vvKCN8Tq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LMZ0eyYZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749627517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeegnuKXd7oGvHQeYd1FFdhElwCqs7fHSjqNXBdE5Lw=;
	b=vvKCN8Tq4s4gEA2s0fDnxXXUEWuavHqxbTdh4kq+eWnK68mThoL4vhXX+qykTTrkuoa7b8
	JsBgN7lqHEWSBcnhp726AjAc26oaDtiN5FnkYl1hF6XskmYM/dVIR5nUGKJMJqzfdeqsdo
	20u8g/BiO0VMkW2Vr1d+BnrbiDkJq35p4UgKxPrrakt/2CYEsOjmK93Ju7+RrvL9fznxon
	zEQ3XWbbYWZ754DEMW3FTE0NSi+vC0RYJbH7Vi1bUfcyo0yAYIbjUbOhwR9gkaHac+klay
	I8XI+TBQcq3L+tgd8eZrTIx83mixH8g0VEuXbs1Q+DKywtSVUWPItC8eg0x/AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749627517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeegnuKXd7oGvHQeYd1FFdhElwCqs7fHSjqNXBdE5Lw=;
	b=LMZ0eyYZFca1AKrT3UF6v82JYggq0IQgFXwnlR0oe6Ej/5eQoU6SD3Mrot/uxa7VmoOAs5
	j/g50bBqH4GXjBAg==
Date: Wed, 11 Jun 2025 09:38:19 +0200
Subject: [PATCH v3 13/16] kunit: Introduce UAPI testing framework
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-kselftests-v3-13-55e3d148cbc6@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749627510; l=11591;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=evEGEaBGQMG0aitCkvMZt05/zY4lUxUR/hnJjYKn4fo=;
 b=G1B8m25juVZheEKsACqcej0oKhcJmWhf2GqXj6NSs6+lHU67Dg1v+/dwg30pFLbFI1MmLgKWH
 Q5bgeQao7bsAp2if/NQ74k5Ox7BGDDLG7qhA1fb+01Jxtx+om04sG1p
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
 lib/kunit/Kconfig                           |  10 +
 lib/kunit/Makefile                          |   2 +
 lib/kunit/uapi.c                            | 287 ++++++++++++++++++++++++++++
 6 files changed, 340 insertions(+)

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
index a97897edd9642f3e5df7fdd9dee26ee5cf00d6a4..1f2f5f2213a7d8438cd2683955f22e34f3a036dd 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -93,4 +93,14 @@ config KUNIT_AUTORUN_ENABLED
 	  In most cases this should be left as Y. Only if additional opt-in
 	  behavior is needed should this be set to N.
 
+config KUNIT_UAPI
+	def_bool y
+	depends on KUNIT=y
+	depends on CC_CAN_LINK_STATIC || ARCH_HAS_NOLIBC
+	select HEADERS_INSTALL
+	help
+	  Enables support for building and running userspace selftests as part of kunit.
+	  These tests should be statically linked and use kselftest.h or kselftest_harness.h
+	  for status reporting.
+
 endif # KUNIT
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 656f1fa35abcc635e67d5b4cb1bc586b48415ac5..dafa09bd4241c24d31c4c19edecb67bf724127d7 100644
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
index 0000000000000000000000000000000000000000..121146dda533b3f90aca37c20bd0e7a1d20cb3b5
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
+static struct vfsmount *kunit_uapi_mount_ramfs(void)
+{
+	struct file_system_type *type;
+	struct vfsmount *mnt;
+
+	type = get_fs_type("ramfs");
+	if (!type)
+		return ERR_PTR(-ENODEV);
+
+	/* FIXME
+	 * The mount setup is supposed to look like this:
+	 * kunit_uapi_mount_ramfs() sets up a private mount,
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
+	mnt = kunit_uapi_mount_ramfs();
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


