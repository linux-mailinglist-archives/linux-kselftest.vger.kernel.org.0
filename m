Return-Path: <linux-kselftest+bounces-39213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FBFB29D31
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 11:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DEBC16AA16
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2037330DEA5;
	Mon, 18 Aug 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9d5Cnsw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3752C30C373;
	Mon, 18 Aug 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507949; cv=none; b=Apo9J+3zRYGuIK7GvWhFH/EYtkWefCH/E/nBsY1PxI++QfVPQhGITAS1XwylUAkOwg2jXRRGb51I927PUEeiaKgirlZWOpdtTI/xLY/d04p3DObESpNNXtYLpV/Xi7bt5UvqdkfIO1KrXhb02XpAT7QfH3zMivG4WlUTXD6yvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507949; c=relaxed/simple;
	bh=ui50HK25m44XDyXlxN5Vk0gPZfF5Q0/wo8g1CEwvx14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8Cyvwhy9ukr2wSGO5EniF4VfGP2DCrA/dbeQ93vhQvPInBJnIE+NQ/rATLMfdOER0zB6ql4QHXKwDxp9h3+1DbPReR2A7Y2lXPwPFL7iHnY0eXu3sWf8eaNkC6crIDO0oWT+fs7N1xooXCELjZBgarGkuv6U79TyjjacpUlhiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9d5Cnsw; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e93498d41a1so845354276.2;
        Mon, 18 Aug 2025 02:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755507946; x=1756112746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVD0nh+Xz7AM4Njqsa1eRIsZUMskzpyalowmngP9h5Y=;
        b=f9d5CnswxJ6fAzRroeMeXt06HCN+SBbd9kjjJkOSXlzzcSakHxQ98lf9npqgZ9gkUk
         Z16mqeIu5DWnPx5bNx6uNoieOy72m9+gPD5dCRs2H1L2PuxHh/RaJDjgZ3lEXXKQk5BO
         FWKcNyCMw/woIuB7hbwYjafLCmTu1QGkPeD/87xcawj/c2JRqUf/ji1IxqKdFNbn/Ith
         vN+mUwgGHYsBsP8auXNINA1uRe1XyvaOxiAK/0Jp9FsQX7sj7N58Hlv3mehNBmTBo326
         diXE74Dp+Lrj9FbUJ/ClIp3tOVXjezel0AuzQAE00VDC6jWcZ3z2r8GIgMKQPcHF6Vzc
         Yd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507946; x=1756112746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVD0nh+Xz7AM4Njqsa1eRIsZUMskzpyalowmngP9h5Y=;
        b=eLJdjF/INcTxw3Glv0A4Pl1X3mAGNebIADNPUe5fUMCk3cVGkTc4G5QosYQ+Kbv19s
         magAxX7FxJYRYII7RMk60Es+CUdF9Z/HS/TrZYeJ5TFCjX38b11UcOWtRGQrESYNSvdp
         9PwIO3vU4XWNAHyEuiIW4X6tl/oMCJhka43QvRmACs3PkJKanq1Y65Dlzw177E52wUf3
         Qt5UvTI73NLEzvzSMdmXYH/9X+LnFzb8nd3rLkarO9QzYmYIy6RfmvzOBM1AHfbKCYRG
         HNfTIvM8AjUruvSr7qyopJOuEdnvqZ5jUDLBFhqTRlZgi6QHALm/IC8LjTPFpIPkGnvy
         RbXg==
X-Forwarded-Encrypted: i=1; AJvYcCUB55a01bpxyR5rM+Nvrgf7ckUXpCPtNpsO3WJxNuqZrwv516RmG0xWzNCWb8tj0b/1vzau4XPOFg==@vger.kernel.org, AJvYcCUUn1jIP1L+sVMQeMWVSQ1y8Gqk605cMepaYm4Cr8P4dKazK8vu20fps7KEYN+GPWf3UgfcyjOStgg67BRXzE/z@vger.kernel.org, AJvYcCV1TC0EaiLmrHh3rr4FinV31opsOxt76I1BW9RZ5XQ+merzciBnJgYX7Ynu96BvAT48IBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8+BNOVXYgJKHhnK+21zauKdLAV83EOa0ng1nIwOVM54qZC+c
	DWVzPc/rfIER9tXIVWfyF5XACNWdi+LF9OnS96x60nyXpVmxdIoU2gxs
X-Gm-Gg: ASbGncuaMpDN/wSfXnRB8ehzIAlsRWStCRz75vHi6CFisKxeqTyg3YqyKPz8o7jQox9
	uW4ux2oQyd4hR0TNblod+5kl4cWsJvFDzTwUZmcV2xHoyxt08Pm2tCCpXBEHs9/RX1s3z3ym1eU
	ZVIfdS9LM9QYbFLUIbfKh+0MBWsNwtW7JzvEHh6dfUgiQ5cstmiP9Qmh7QtOBRvb+oE9PtVQ+V4
	jGm2HhhgyiPztl4+OnnUWR7CJvJUFkVjJa9v+P6JVllMlbD+FEAg1jcQ/phl7050Y7LVYfwD0vu
	m+VMnKFiatpVxfojXhnVxBnHGfAK7Pr8uVaIqW34S+yOPynCVs6UIkoGE5QHd0ctNUMs8AJ9lX4
	/HiVpHEK29UsCEg==
X-Google-Smtp-Source: AGHT+IEcTvZ9qBsUMxrw7/QM1z1TWZh/cEg4gnXk7fZ5oCbUN5HIOh3mspTggwHfnz+5a22KdyuZ9w==
X-Received: by 2002:a05:6902:c0a:b0:e8e:1ccd:6a4e with SMTP id 3f1490d57ef6-e93323c5ba9mr13385898276.19.1755507945798;
        Mon, 18 Aug 2025 02:05:45 -0700 (PDT)
Received: from roronoa.. ([146.70.98.176])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e933264aabcsm2985389276.9.2025.08.18.02.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:05:45 -0700 (PDT)
From: Djalal Harouni <tixxdz@gmail.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	tixxdz@opendz.org
Cc: Djalal Harouni <tixxdz@gmail.com>
Subject: [RFC PATCH v2 bpf-next 3/3] selftests/bpf: add selftest for bpf_cgroup_write_interface
Date: Mon, 18 Aug 2025 10:04:24 +0100
Message-ID: <20250818090424.90458-4-tixxdz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818090424.90458-1-tixxdz@gmail.com>
References: <20250818090424.90458-1-tixxdz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This adds a selftest for `bpf_cgroup_write_interface` kfunc. The test works
by forking a child then:

1. Child:
 - Migrate to a new cgroup
 - Loads bpf programs
 - Trigger the 'lsm_freeze_cgroup' bpf program so it freeze itself.

   <- wait for parent to unthaw

 - On unthaw it continues, forks another process and triggers the
   'tp_newchild' bpf program to set some monitored pids of the new
   process, that assert that the user space resumed correctly.

2. Parent:
 - Keeps reading the 'cgroup.freeze' file of the child cgroup until
   it prints 1 which means the child cgroup is frozen.
 - Attaches the sample 'lsm_task_free' so it triggers the bpf program
   to unthaw the child task cgroup.
 - Then waits for a clean exit of the child process.

The scenario allows to test multiple sides of: freeze and unthaw a cgroup.

Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
---
 .../bpf/prog_tests/task_freeze_cgroup.c       | 172 ++++++++++++++++++
 .../bpf/progs/test_task_freeze_cgroup.c       | 155 ++++++++++++++++
 2 files changed, 327 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_freeze_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_freeze_cgroup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_freeze_cgroup.c b/tools/testing/selftests/bpf/prog_tests/task_freeze_cgroup.c
new file mode 100644
index 000000000000..d4e9c0f32196
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_freeze_cgroup.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <sys/syscall.h>
+#include <test_progs.h>
+#include <cgroup_helpers.h>
+#include <unistd.h>
+#include "test_task_freeze_cgroup.skel.h"
+
+#define CGROUP_PATH	"/test-task-freeze-cgroup"
+
+static int bpf_sleepable(struct test_task_freeze_cgroup *skel)
+{
+	int err, cgroup_fd;
+	pid_t new_pid2;
+
+	cgroup_fd = cgroup_setup_and_join(CGROUP_PATH);
+	if (!ASSERT_OK(cgroup_fd < 0, "cgroup_setup_and_join"))
+		return -errno;
+
+	skel = test_task_freeze_cgroup__open();
+	if (!ASSERT_OK_PTR(skel, "test_task_freeze_cgroup__open")) {
+		err = -errno;
+		goto cleanup_cgroup;
+	}
+
+	skel->rodata->parent_pid = getppid();
+	skel->rodata->monitor_pid = getpid();
+	skel->rodata->cgid = get_cgroup_id(CGROUP_PATH);
+	skel->bss->new_pid = getpid();
+	skel->bss->freeze = 1;
+
+	err = test_task_freeze_cgroup__load(skel);
+	if (!ASSERT_OK(err, "test_task_freeze_cgroup__load")) {
+		err = -errno;
+		goto cleanup_skel;
+	}
+
+	/* First attach the LSM Program that is triggered on bpf() calls
+	 * especially on TP_BTF programs when attached.
+	 */
+	skel->links.lsm_freeze_cgroup =
+		bpf_program__attach_lsm(skel->progs.lsm_freeze_cgroup);
+	if (!ASSERT_OK_PTR(skel->links.lsm_freeze_cgroup, "attach_lsm")) {
+		err = -errno;
+		goto cleanup_detach;
+	}
+
+	/* Attaching this must fail with -EPERM and freeze current task */
+	skel->links.tp_newchild =
+		bpf_program__attach_trace(skel->progs.tp_newchild);
+	if (!ASSERT_EQ(errno, EPERM, "attach_trace() must fail here")) {
+		err = -EINVAL;
+		goto cleanup_detach;
+	}
+
+	/* Continue */
+
+	/* Attach again now with success */
+	skel->links.tp_newchild =
+		bpf_program__attach_trace(skel->progs.tp_newchild);
+	if (!ASSERT_OK_PTR(skel->links.tp_newchild, "attach_trace")) {
+		err = -EINVAL;
+		goto cleanup_detach;
+	}
+
+	/* Fork, update vars from BPF and assert the unfrozen state */
+	new_pid2 = fork();
+	if (new_pid2 == 0)
+		exit(0);
+
+	err = (new_pid2 == -1);
+	if (ASSERT_OK(err, "fork process"))
+		wait(NULL);
+
+	/* Now assert that new_pid2 reflects this new child */
+	ASSERT_NEQ(0, skel->bss->new_pid,
+		   "test task_freeze_cgroup failed  at new_pid != 0");
+	ASSERT_NEQ(skel->rodata->monitor_pid, skel->bss->new_pid,
+		   "test task_freeze_cgroup failed  at old monitor_pid != new_pid");
+	/* Assert that bpf sets new_pid to new forked child new_pid2 */
+	ASSERT_EQ(skel->bss->new_pid, new_pid2,
+		  "test task_freeze_cgroup failed first child new_pid == new_pid2");
+
+cleanup_detach:
+	test_task_freeze_cgroup__detach(skel);
+cleanup_skel:
+	test_task_freeze_cgroup__destroy(skel);
+cleanup_cgroup:
+	close(cgroup_fd);
+	cleanup_cgroup_environment();
+	return err;
+}
+
+void test_task_freeze_cgroup(void)
+{
+	pid_t pid, result;
+	char buf[512] = {0};
+	char path[PATH_MAX] = {0};
+	int ret, status, attempts, frozen = 0, fd;
+	struct test_task_freeze_cgroup *skel = NULL;
+
+	pid = fork();
+	ret = (pid == -1);
+	if (!ASSERT_OK(ret, "fork process"))
+		return;
+
+	if (pid == 0) {
+		ret = bpf_sleepable(skel);
+		ASSERT_EQ(0, ret, "child bpf_sleepable failed");
+		exit(ret);
+	}
+
+	skel = test_task_freeze_cgroup__open();
+	if (!ASSERT_OK_PTR(skel, "test_task_freeze_cgroup__open"))
+		goto out;
+
+	snprintf(path, sizeof(path),
+		 "/sys/fs/cgroup/cgroup-test-work-dir%d%s/cgroup.freeze",
+		 pid, CGROUP_PATH);
+
+	for (attempts = 10; attempts >= 0; attempts--) {
+		ret = 0;
+
+		fd = open(path, O_RDONLY);
+		if (fd > 0)
+			ret = read(fd, buf, sizeof(buf) - 1);
+		if (ret > 0) {
+			errno = 0;
+			frozen = strtol(buf, NULL, 10);
+			if (errno)
+				frozen = 0;
+		}
+
+		close(fd);
+		if (frozen)
+			break;
+		sleep(1);
+	}
+
+	/* Assert that child cgroup is frozen */
+	if (!ASSERT_EQ(1, frozen, "child cgroup not frozen"))
+		goto out;
+
+	ret = test_task_freeze_cgroup__load(skel);
+	if (!ASSERT_OK(ret, "test_task_freeze_cgroup__load"))
+		goto out;
+
+	/* Trigger the unthaw child cgroup from parent */
+	skel->links.lsm_task_free =
+		bpf_program__attach_lsm(skel->progs.lsm_task_free);
+	if (!ASSERT_OK_PTR(skel->links.lsm_task_free, "attach_lsm"))
+		goto out;
+
+	result = waitpid(pid, &status, WUNTRACED);
+	if (!ASSERT_NEQ(result, -1, "waitpid"))
+		goto detach;
+
+	result = WIFEXITED(status);
+	if (!ASSERT_EQ(result, 1, "forked process did not terminate normally"))
+		goto detach;
+
+	result = WEXITSTATUS(status);
+	if (!ASSERT_EQ(result, 0, "forked process did not exit successfully"))
+		goto detach;
+
+detach:
+	test_task_freeze_cgroup__detach(skel);
+
+out:
+	if (skel)
+		test_task_freeze_cgroup__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_task_freeze_cgroup.c b/tools/testing/selftests/bpf/progs/test_task_freeze_cgroup.c
new file mode 100644
index 000000000000..07b4b65abc36
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_task_freeze_cgroup.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <linux/types.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <errno.h>
+#include "bpf_kfuncs.h"
+#include "bpf_misc.h"
+
+struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
+long bpf_task_under_cgroup(struct task_struct *task, struct cgroup *ancestor) __ksym;
+void bpf_cgroup_release(struct cgroup *p) __ksym;
+struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
+struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+extern int bpf_cgroup_write_interface(struct cgroup *cgrp,
+				      const char *name__str,
+				      const struct bpf_dynptr *value_p,
+				      loff_t off) __ksym __weak;
+
+char freeze_val[] = "1";
+char unthaw_val[] = "0";
+
+const volatile int parent_pid;
+const volatile int monitor_pid;
+const volatile __u64 cgid;
+int new_pid;
+int freeze;
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(tp_newchild, struct task_struct *task, u64 clone_flags)
+{
+	struct cgroup *cgrp = NULL;
+	struct task_struct *acquired;
+
+	if (monitor_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	acquired = bpf_task_acquire(task);
+	if (!acquired)
+		return 0;
+
+	cgrp = bpf_cgroup_from_id(cgid);
+	if (!cgrp)
+		goto out;
+
+	/* Update new_pid with current pid */
+	if (bpf_task_under_cgroup(acquired, cgrp))
+		new_pid = acquired->tgid;
+
+out:
+	if (cgrp)
+		bpf_cgroup_release(cgrp);
+	bpf_task_release(acquired);
+
+	return 0;
+}
+
+/* Try to attach from parent to trigger the bpf lsm hook, so from
+ * parent context we unthaw child cgroup.
+ */
+SEC("lsm/task_free")
+int BPF_PROG(lsm_task_free, struct task_struct *task)
+{
+	return 0;
+}
+
+static int process_freeze_cgroup(int pid, int freeze)
+{
+	int ret = 0;
+	struct task_struct *task;
+	struct bpf_dynptr dyn_ptr;
+	struct cgroup *cgrp = NULL;
+
+	task = bpf_task_from_pid(pid);
+	if (!task)
+		return -EINVAL;
+
+	cgrp = bpf_cgroup_from_id(cgid);
+	if (!cgrp) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!bpf_task_under_cgroup(task, cgrp))
+		goto out;
+
+	if (freeze)
+		bpf_dynptr_from_mem(freeze_val, sizeof(freeze_val), 0, &dyn_ptr);
+	else
+		bpf_dynptr_from_mem(unthaw_val, sizeof(unthaw_val), 0, &dyn_ptr);
+
+	ret = bpf_cgroup_write_interface(cgrp, "cgroup.freeze", &dyn_ptr, 0);
+
+out:
+	if (cgrp)
+		bpf_cgroup_release(cgrp);
+	bpf_task_release(task);
+	return ret;
+}
+
+SEC("lsm.s/bpf")
+int BPF_PROG(lsm_freeze_cgroup, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	int ret = 0;
+	struct task_struct *task;
+	struct cgroup *cgrp = NULL;
+
+	if (cmd != BPF_LINK_CREATE)
+		return 0;
+
+	task = bpf_get_current_task_btf();
+	if (parent_pid == task->pid) {
+		/* Parent context: unthaw child */
+		process_freeze_cgroup(monitor_pid, 0);
+		return 0;
+	}
+
+	/* Nothing todo */
+	if (!freeze)
+		return 0;
+
+	/* Child context */
+	if (monitor_pid != task->pid)
+		return 0;
+
+	/* Ensure we are under the corresponding cgroup so we freeze
+	 * current child from its context
+	 */
+	cgrp = bpf_cgroup_from_id(cgid);
+	if (!cgrp)
+		return 0;
+
+	if (!bpf_task_under_cgroup(task, cgrp))
+		goto out;
+
+	/* Schedule freeze task and return -EPERM */
+	ret = process_freeze_cgroup(monitor_pid, freeze);
+
+	/* On error or 0 we return zero and we catch at
+	 * user space if the cgroup was not frozen.
+	 */
+	ret = (ret > 0) ? -EPERM : 0;
+
+	/* Reset for next calls */
+	freeze = 0;
+out:
+	if (cgrp)
+		bpf_cgroup_release(cgrp);
+	return ret;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


