Return-Path: <linux-kselftest+bounces-6748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E29588F23A
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 23:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21BD29CA74
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 22:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509B6154424;
	Wed, 27 Mar 2024 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/Zjr4l+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8A6153BED;
	Wed, 27 Mar 2024 22:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580134; cv=none; b=pUuf9B3m9q5HZyudtmB+WqL4PJEjzbemyEtAVhUJhj5tKXdpUNzQE8MQ0zIeWWnJCsVT+LS3zy4v8H54nwm/A7DAq/Nnb70cyVvmehyd9AH21p2nXSST+BYOgu5UnFYNY50nStb7I6Wmkdp2dZA6VLxarBTru9dLDuRhRxfUJXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580134; c=relaxed/simple;
	bh=VUW8SqAA/+2sHQhA2ammk2FQgHtxhgRr3LE1tD2/QzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JslUuwivjy5PvuZC8/MCIyzTNw3GwX278ugCJofTsKHzHeUbyUtGhMV+SnhMbxHcxgxsSZ0y9Bt/BdivQtqYswTKkyI66XpYHuyhlPSDrqfABjIZP9yzTrbViG90vrgw/kZu5/dG+qiN/Z4mU7Go0CZpMGeyQ7iKkbDAQM1NKmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/Zjr4l+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-341b01dbebbso225149f8f.0;
        Wed, 27 Mar 2024 15:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711580131; x=1712184931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP36tHqP7P+dmRhIwVHlpSLJhJGKUjScQFwDQs5TYi4=;
        b=C/Zjr4l+ZoGJCbtUKuI6eEVuWw7ytQwA85B7OqHbm+1IJENhsToM8Q/YmKGUp8YNBI
         /dlbd3a4I8oPTbTRBC/oB1hk1PzxF4xJMXdhPYx6lNwR5tYZykJS0JmayosHJBdOsPZ0
         9cOhzZL/ADQCxjkw7rhAaBNWAOA6iz0UGjpx4FjRQ+FQqFHM/iYkmg2R4F5vcReFOsfz
         O81I2usonFRDvDGw4tsB9F+h4ZbQ2cQ7tVwIhxi5G8oQER+m10QmNU5vuBYjUAEMPrOt
         QUz0bZPi8iIWIqBjh2hWwf8xcEtbArdfzm3/j9hfj0WSbC3axiJlGg13Xu5KEYEQdZzV
         bxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711580131; x=1712184931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP36tHqP7P+dmRhIwVHlpSLJhJGKUjScQFwDQs5TYi4=;
        b=Nreev+sZ6A/mUJHZ5Vq1d3TJpRp+0fYfXDYOIlA/i2JlC1UQBhjWmG0+L2c4Hk9+tB
         hKLsDmZQeZqIdXC4UWwpt8sOAdolIdoOBiTAgyfqWnh49NZLXJmpNYVu1e7v7vNpQySw
         QKttZuJdM0yxadXVxAV7dK2ws/LDJtfGwsTWHokN0n0z3R4W+JiO2wcrvbVAFuIv8Oh1
         W5DISwj5k9e+orjBWINZTuvHrH7pNV8ZJn69tzb7SbyySt0l1550fvIZuuIaBWyQr/td
         DB0FUP5EhVGWShygzln2obOkvZTlES3qFyRJxPOa3K8DL+DQMLxcePWeu4atwqmt/cOP
         nk2w==
X-Forwarded-Encrypted: i=1; AJvYcCXL5RmUvIVqR/IBt00Ew1BKiCGSdjwVQmMrx9WNGNxrYEf3zDWedp++pTbsxRcLuMkqgo4/M67mnEeREAO4IoeRLTJ+pL7xUcE2mUNzWaFMkX/RI6GPLGbvj6lhZbMpNLaM4UIBnOd1qOiSHjJMk/wKuyX0NPhsK2H2ZlKCur8d5Jw9FjflNR4/Kvs81o821N2Dfd9fJrdOleaB4A==
X-Gm-Message-State: AOJu0Yw+jlk351tRu/fYMADJ2C1jE9uR847o1Y5FE72QGbyffAJwVphR
	2ZZTEiywoUL/PPGqjsSoIAmRKX7xU/HrN2yFmcKddMoXI1YMPTmL
X-Google-Smtp-Source: AGHT+IH7e2g0Y7KVgrgTneD3KILz2Xw+4uPpn/4EBcTEadHjIlt00UCW1BykdWehFemRxO7De3P+fw==
X-Received: by 2002:a5d:59a8:0:b0:341:e5d1:d353 with SMTP id p8-20020a5d59a8000000b00341e5d1d353mr1355183wrr.14.1711580130666;
        Wed, 27 Mar 2024 15:55:30 -0700 (PDT)
Received: from rorona-tty.. ([154.121.114.3])
        by smtp.googlemail.com with ESMTPSA id cc7-20020a5d5c07000000b0033e75e5f280sm152348wrb.113.2024.03.27.15.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:55:30 -0700 (PDT)
From: Djalal Harouni <tixxdz@gmail.com>
To: tixxdz@gmail.com
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH bpf-next 3/3] selftests/bpf: add selftest for bpf_task_freeze_cgroup
Date: Wed, 27 Mar 2024 23:53:25 +0100
Message-Id: <20240327225334.58474-4-tixxdz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327225334.58474-1-tixxdz@gmail.com>
References: <20240327-ccb56fc7a6e80136db80876c@djalal>
 <20240327225334.58474-1-tixxdz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a selftest for `bpf_task_freeze_cgroup` kfunc. The test works
by forking a child then:

1. Child:
 - Migrate to a new cgroup
 - Loads bpf programs
 - Trigger the 'lsm_freeze_cgroup' bpf program so it freeze itself.
   by calling "bpf_task_freeze_cgroup(child, 1)"

   <- wait for parent to unthaw

 - On unthaw it continues, forks another process and triggers the
   'tp_newchild' bpf program to set some monitored pids of the new
   process, that are asserted at user space, to ensure that we
   resumed correctly.

2. Parent:
 - Keeps reading the 'cgroup.freeze' file of the child cgroup until
   it prints 1 which means the child cgroup is frozen
 - Attaches the sample 'lsm_task_free' so it triggers the bpf program
   and then calls "bpf_task_freeze_cgroup(task, 0);" on the child task
   to unthaw its cgroup.
 - Then waits for a clean exit of the child process.

The scenario allows to test both: freeze and unthaw a task cgroup.

Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
---
 .../bpf/prog_tests/task_freeze_cgroup.c       | 165 ++++++++++++++++++
 .../bpf/progs/test_task_freeze_cgroup.c       | 110 ++++++++++++
 2 files changed, 275 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_freeze_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_freeze_cgroup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_freeze_cgroup.c b/tools/testing/selftests/bpf/prog_tests/task_freeze_cgroup.c
new file mode 100644
index 000000000000..afb7d46194c5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_freeze_cgroup.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Isovalent */
+
+#include <sys/syscall.h>
+#include <test_progs.h>
+#include <cgroup_helpers.h>
+#include <unistd.h>
+#include "test_task_freeze_cgroup.skel.h"
+
+#define FOO	"/test-task-freeze-cgroup"
+
+static int bpf_sleepable(struct test_task_freeze_cgroup *skel)
+{
+	int err, foo;
+	pid_t pid;
+
+	foo = test__join_cgroup(FOO);
+	if (!ASSERT_OK(foo < 0, "cgroup_join_foo"))
+		return -errno;
+
+	skel = test_task_freeze_cgroup__open();
+	if (!ASSERT_OK_PTR(skel, "test_task_freeze_cgroup__open"))
+		return -errno;
+
+	skel->rodata->parent_pid = getppid();
+	skel->rodata->monitor_pid = getpid();
+	skel->rodata->cgid = get_cgroup_id(FOO);
+	skel->bss->new_pid = getpid();
+	skel->bss->freeze = 1;
+
+	err = test_task_freeze_cgroup__load(skel);
+	if (!ASSERT_OK(err, "test_task_freeze_cgroup__load"))
+		goto cleanup;
+
+	/* First, attach the LSM program, and then it will be triggered when the
+	 * TP_BTF program is attached.
+	 */
+	skel->links.lsm_freeze_cgroup =
+		bpf_program__attach_lsm(skel->progs.lsm_freeze_cgroup);
+	if (!ASSERT_OK_PTR(skel->links.lsm_freeze_cgroup, "attach_lsm")) {
+		err = -errno;
+		goto cleanup;
+	}
+
+	/* This will fail */
+	skel->links.tp_newchild =
+		bpf_program__attach_trace(skel->progs.tp_newchild);
+	if (!ASSERT_EQ(errno, EPERM, "attach_trace")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	/* Try again now */
+	skel->links.tp_newchild =
+		bpf_program__attach_trace(skel->progs.tp_newchild);
+	if (!ASSERT_OK_PTR(skel->links.tp_newchild, "attach_trace")) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	/* Trigger a new child and assert unfrozen state */
+	pid = fork();
+	if (pid == 0)
+		exit(0);
+
+	err = (pid == -1);
+	if (ASSERT_OK(err, "fork process"))
+		wait(NULL);
+
+	/* Now we should continue, assert that new_pid reflects child */
+	ASSERT_NEQ(skel->rodata->monitor_pid, skel->bss->new_pid,
+		   "test task_freeze_cgroup failed  at monitor_pid != new_pid");
+	ASSERT_NEQ(0, skel->bss->new_pid,
+		   "test task_freeze_cgroup failed  at remote_pid != 0");
+
+	/* Assert that bpf set new_pid to new forked child pid */
+	ASSERT_EQ(pid, skel->bss->new_pid,
+		   "test task_freeze_cgroup failed  at pid == new_pid");
+
+	test_task_freeze_cgroup__detach(skel);
+
+cleanup:
+	test_task_freeze_cgroup__destroy(skel);
+	close(foo);
+	return err;
+}
+
+void test_task_freeze_cgroup(void)
+{
+	pid_t pid, result;
+	char buf[512] = {0};
+	char path[PATH_MAX] = {0};
+	int ret, status, attempts, frozen = 0;
+	struct test_task_freeze_cgroup *skel = NULL;
+
+	pid = fork();
+	ret = (pid == -1);
+	if (!ASSERT_OK(ret, "fork process"))
+		return;
+
+	if (pid == 0) {
+		ret = bpf_sleepable(skel);
+		ASSERT_EQ(0, ret, "bpf_sleepable failed");
+		exit(ret);
+	}
+
+	skel = test_task_freeze_cgroup__open();
+	if (!ASSERT_OK_PTR(skel, "test_task_freeze_cgroup__open"))
+		goto out;
+
+	snprintf(path, sizeof(path),
+		 "/sys/fs/cgroup/cgroup-test-work-dir%d%s/cgroup.freeze",
+		 pid, FOO);
+
+	for (attempts = 5; attempts >= 0; attempts--) {
+		ret = 0;
+		int fd = open(path, O_RDONLY);
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
+	/* Unthaw child cgroup from parent */
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
index 000000000000..dbd2d60f464e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_task_freeze_cgroup.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Isovalent */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <errno.h>
+#include "bpf_misc.h"
+
+struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
+long bpf_task_under_cgroup(struct task_struct *task, struct cgroup *ancestor) __ksym;
+void bpf_cgroup_release(struct cgroup *p) __ksym;
+struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
+struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+int bpf_task_freeze_cgroup(struct task_struct *task, int freeze) __ksym;
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
+/* This is attached from parent to trigger the bpf lsm hook, so parent
+ * can unthaw the child.
+ */
+SEC("lsm/task_free")
+int BPF_PROG(lsm_task_free, struct task_struct *task)
+{
+	return 0;
+}
+
+SEC("lsm.s/bpf")
+int BPF_PROG(lsm_freeze_cgroup, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	int ret = 0;
+	struct cgroup *cgrp = NULL;
+	struct task_struct *task;
+
+	if (cmd != BPF_LINK_CREATE)
+		return ret;
+
+	task = bpf_get_current_task_btf();
+	if (parent_pid == task->pid) {
+		/* Unthaw child from parent */
+		task = bpf_task_from_pid(monitor_pid);
+		if (!task)
+			return -ENOENT;
+
+		ret = bpf_task_freeze_cgroup(task, 0);
+		bpf_task_release(task);
+		return ret;
+	}
+
+	if (monitor_pid != task->pid)
+		return 0;
+
+	/* Freeze the child cgroup from its context */
+	cgrp = bpf_cgroup_from_id(cgid);
+	if (!cgrp)
+		goto out;
+
+	if (!bpf_task_under_cgroup(task, cgrp))
+		goto out;
+
+	if (freeze) {
+		/* Schedule freeze task and return -EPERM */
+		ret = bpf_task_freeze_cgroup(task, 1);
+		if (!ret) {
+			ret = -EPERM;
+			/* reset for next call */
+			freeze = 0;
+		}
+	}
+out:
+	if (cgrp)
+		bpf_cgroup_release(cgrp);
+	return ret;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


