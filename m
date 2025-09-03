Return-Path: <linux-kselftest+bounces-40708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33252B42B16
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 22:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACEEC1895DAD
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 20:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFE62EC08F;
	Wed,  3 Sep 2025 20:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RQvMmzg8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703B819DF4F;
	Wed,  3 Sep 2025 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931896; cv=none; b=a2MiC23yVchZ8RGYkZfcvHu8h3sULFM6Dwxz/NRyuQAaJgWX2YhByIq1taiqNDS9z6fX8O2e7Nv+9lbSKgBeWH8nS81O2utBTz1WEowcAkewrb8QUjlDBu0vWnCZEwcrS2ZiyyqcQjHdkWIwbiqGWg5IT9RQ5sXD8UucVu68MJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931896; c=relaxed/simple;
	bh=ligHIj7J3WzMIdQw9KdRklA5O5Pt90++X+gleuSQImc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rKZ6okzEzVfZYcY/G/2bFgRxa1tv/j4CI4EePYOlgzMk/T5GQk/f7IAah1DYBes5BvHFJY1u0K/qi7RISj7rFwejAJ6LYsfikwGYvhAJcnBANxBXpDGQRdVyOCyXnm4zo8wMI4BBdGf+4AU8oGWfmGPirbyICT3oIz2HnXPSbvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RQvMmzg8; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583JtiMN027980;
	Wed, 3 Sep 2025 20:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=oC2mAt0hbSCXCcWI5x1a5bkQceWB8
	XR1UnRWuIlVkik=; b=RQvMmzg8HAFkkJ3fKgssXOEYX8P6aGiZDRUd6ORqqjabh
	U/Qb4ENUblLEJTVuEXqT//TVvDEPTurACQHlHR5NTSGSM+IxC0VwbOBJbbF9HVIZ
	KiDXo8uhiTd0jmTJ1RZTTzUlC2jSgAvk3E4wuszKzUdGOEqmIW+QGNIZAp56qMeX
	rzBEsgZoyuoB9XUBSdZHaBbJBfC/V8fFQF+PVoBq06S5gswj0MSePNxdKp9xlxQb
	QJ93DeexPj+XVLq5fOX4FedQ1Sk2MSJwhlha9Id/mSqHTrCDS138upIGki8tAOa2
	UeTiMgo4L+Mqxuh77q+cYvMeHnRpfP4V036MPy1PQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usm9qcmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 20:38:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583KSTC9030946;
	Wed, 3 Sep 2025 20:38:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqravvef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 20:38:07 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 583Kc6iw002627;
	Wed, 3 Sep 2025 20:38:06 GMT
Received: from thromatk-ol9-oracleexplain.allregionalphxs.osdevelopmenphx.oraclevcn.com (thromatk-ol9-oracleexplain.allregionalphxs.osdevelopmenphx.oraclevcn.com [100.107.197.181])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48uqravvdj-1;
	Wed, 03 Sep 2025 20:38:06 +0000
From: Tom Hromatka <tom.hromatka@oracle.com>
To: kees@kernel.org, luto@amacapital.net, wad@chromium.org, sargun@sargun.me,
        corbet@lwn.net, shuah@kernel.org, brauner@kernel.org,
        tom.hromatka@oracle.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH] seccomp: Add SECCOMP_CLONE_FILTER operation
Date: Wed,  3 Sep 2025 20:38:03 +0000
Message-ID: <20250903203805.1335307-1-tom.hromatka@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_10,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030207
X-Proofpoint-GUID: N0YOy4qoBOgOrhjcRJ53UQVwBCj-1iPw
X-Authority-Analysis: v=2.4 cv=I7xlRMgg c=1 sm=1 tr=0 ts=68b8a730 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=R4ZDeqtCAAAA:20 a=yPCof4ZbAAAA:8 a=Yz0eLya9xGtTCq0thckA:9
 a=bA3UWDv6hWIuX7UZL3qL:22 cc=ntf awl=host:13602
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX4J/aKaqetqRx
 QN4wi7Fx3vb/0dG9beDv3vit1AAXddCwbIG9hLDLPSsD1o5Ebeuqb6Tau1PptdOBkZQzFj9Pmp2
 kczribqSb/ybolJnzGE5AoFhLrXwv/wIHfgw3K468BD7XSkw+XJdez90o3UcJ+KnT6dtdctv27x
 51TkvjjfL5wf6Se89N66wYhYwjzirkhR6Z6dAL1bmD1S/OIgqWIzZmBGLh5agAVCjVDbuPay5ID
 69WLMIvcFC35d9XO9PSXLd/RstYMzBgpr8CI3zruHKO08RtlCDSFDZx7cS5gVxjFKeHuVRMi32i
 16nBpBO+CNCOS4DNBSpnUr54jykn0tP+eiBvC95WAYcTh9RvBUfZCi2/7DmjQFB+ib704Vzb2b1
 fp6uc+Rwsg15eHzqdiBFPWM52sOU9w==
X-Proofpoint-ORIG-GUID: N0YOy4qoBOgOrhjcRJ53UQVwBCj-1iPw

Add an operation, SECCOMP_CLONE_FILTER, that can copy the seccomp filters
from another process to the current process.

I roughly reproduced the Docker seccomp filter [1] and timed how long it
takes to build it (via libseccomp) and attach it to a process.  After
1000 runs, on average it took 3,740,000 TSC ticks (or ~1440 microseconds)
on an AMD EPYC 9J14 running at 2596 MHz.  The median build/load time was
3,715,000 TSC ticks.

On the same system, I preloaded the above Docker seccomp filter onto a
process.  (Note that I opened a pidfd to the reference process and left
the pidfd open for the entire run.)  I then cloned the filter using the
feature in this patch to 1000 new processes.  On average, it took 9,300
TSC ticks (or ~3.6 microseconds) to copy the filter to the new processes.
The median clone time was 9,048 TSC ticks.

This is approximately a 400x performance improvement for those container
managers that are using the exact same seccomp filter across all of their
containers.

[1] https://raw.githubusercontent.com/moby/moby/refs/heads/master/profiles/seccomp/default.json

Signed-off-by: Tom Hromatka <tom.hromatka@oracle.com>
---
 .../userspace-api/seccomp_filter.rst          |  10 ++
 include/uapi/linux/seccomp.h                  |   1 +
 kernel/seccomp.c                              |  48 ++++++
 samples/seccomp/Makefile                      |   2 +-
 samples/seccomp/clone-filter.c                | 143 ++++++++++++++++++
 tools/include/uapi/linux/seccomp.h            |   1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c |  71 +++++++++
 7 files changed, 275 insertions(+), 1 deletion(-)
 create mode 100644 samples/seccomp/clone-filter.c

diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
index cff0fa7f3175..ef1797d093f6 100644
--- a/Documentation/userspace-api/seccomp_filter.rst
+++ b/Documentation/userspace-api/seccomp_filter.rst
@@ -289,6 +289,16 @@ above in this document: all arguments being read from the tracee's memory
 should be read into the tracer's memory before any policy decisions are made.
 This allows for an atomic decision on syscall arguments.
 
+Cloning an Existing Seccomp Filter
+==================================
+
+Constructing and loading a complex seccomp filter can often take a non-trivial
+amount of time. If a user wants to use the same seccomp filter across more
+than one process, it can be cloned to new processes via the
+``SECCOMP_CLONE_FILTER`` operation. Note that the clone will only succeed if
+the destination process does not have any seccomp filters already applied to
+it. See ``samples/seccomp/clone-filter.c`` for an example.
+
 Sysctls
 =======
 
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index dbfc9b37fcae..b0917e333b4b 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -16,6 +16,7 @@
 #define SECCOMP_SET_MODE_FILTER		1
 #define SECCOMP_GET_ACTION_AVAIL	2
 #define SECCOMP_GET_NOTIF_SIZES		3
+#define SECCOMP_CLONE_FILTER		4
 
 /* Valid flags for SECCOMP_SET_MODE_FILTER */
 #define SECCOMP_FILTER_FLAG_TSYNC		(1UL << 0)
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 41aa761c7738..b726e0d6715d 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2081,6 +2081,49 @@ static long seccomp_get_notif_sizes(void __user *usizes)
 	return 0;
 }
 
+static long seccomp_clone_filter(void __user *upidfd)
+{
+	struct task_struct *task;
+	unsigned int flags;
+	pid_t pidfd;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (atomic_read(&current->seccomp.filter_count) > 0)
+		return -EINVAL;
+
+	if (copy_from_user(&pidfd, upidfd, sizeof(pid_t)))
+		return -EFAULT;
+
+	task = pidfd_get_task(pidfd, &flags);
+	if (IS_ERR(task))
+		return -ESRCH;
+
+	spin_lock_irq(&current->sighand->siglock);
+	spin_lock_irq(&task->sighand->siglock);
+
+	if (atomic_read(&task->seccomp.filter_count) == 0) {
+		spin_unlock_irq(&task->sighand->siglock);
+		spin_unlock_irq(&current->sighand->siglock);
+		put_task_struct(task);
+		return -EINVAL;
+	}
+
+	get_seccomp_filter(task);
+	current->seccomp = task->seccomp;
+
+	spin_unlock_irq(&task->sighand->siglock);
+
+	set_task_syscall_work(current, SECCOMP);
+
+	spin_unlock_irq(&current->sighand->siglock);
+
+	put_task_struct(task);
+
+	return 0;
+}
+
 /* Common entry point for both prctl and syscall. */
 static long do_seccomp(unsigned int op, unsigned int flags,
 		       void __user *uargs)
@@ -2102,6 +2145,11 @@ static long do_seccomp(unsigned int op, unsigned int flags,
 			return -EINVAL;
 
 		return seccomp_get_notif_sizes(uargs);
+	case SECCOMP_CLONE_FILTER:
+		if (flags != 0)
+			return -EINVAL;
+
+		return seccomp_clone_filter(uargs);
 	default:
 		return -EINVAL;
 	}
diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index c85ae0ed8342..d38977f41b86 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-userprogs-always-y += bpf-fancy dropper bpf-direct user-trap
+userprogs-always-y += bpf-fancy dropper bpf-direct user-trap clone-filter
 
 bpf-fancy-objs := bpf-fancy.o bpf-helper.o
 
diff --git a/samples/seccomp/clone-filter.c b/samples/seccomp/clone-filter.c
new file mode 100644
index 000000000000..d26e1375b9dc
--- /dev/null
+++ b/samples/seccomp/clone-filter.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Seccomp filter example for cloning a filter
+ *
+ * Copyright (c) 2025 Oracle and/or its affiliates.
+ * Author: Tom Hromatka <tom.hromatka@oracle.com>
+ *
+ * The code may be used by anyone for any purpose,
+ * and can serve as a starting point for developing
+ * applications that reuse the same seccomp filter
+ * across many processes.
+ */
+#include <linux/seccomp.h>
+#include <linux/filter.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <stdbool.h>
+#include <signal.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <errno.h>
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
+
+static int seccomp(unsigned int op, unsigned int flags, void *args)
+{
+	errno = 0;
+	return syscall(__NR_seccomp, op, flags, args);
+}
+
+static int install_filter(void)
+{
+	struct sock_filter deny_filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ERRNO | ESRCH),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog deny_prog = {
+		.len = (unsigned short)ARRAY_SIZE(deny_filter),
+		.filter = deny_filter,
+	};
+
+	return seccomp(SECCOMP_SET_MODE_FILTER, 0, &deny_prog);
+}
+
+static int clone_filter(pid_t ref_pid)
+{
+	int ref_pidfd, ret;
+
+	ref_pidfd = syscall(SYS_pidfd_open, ref_pid, 0);
+	if (ref_pidfd < 0)
+		return -errno;
+
+	ret = seccomp(SECCOMP_CLONE_FILTER, 0, &ref_pidfd);
+
+	close(ref_pidfd);
+
+	return ret;
+}
+
+static void do_ref_filter(void)
+{
+	int ret;
+
+	ret = install_filter();
+	if (ret) {
+		perror("Failed to install ref filter\n");
+		exit(1);
+	}
+
+	while (true)
+		sleep(1);
+}
+
+static void do_child_process(pid_t ref_pid)
+{
+	pid_t res;
+	int ret;
+
+	ret = clone_filter(ref_pid);
+	if (ret != 0) {
+		perror("Failed to clone filter. Installing filter from scratch\n");
+
+		ret = install_filter();
+		if (ret != 0) {
+			perror("Filter install failed\n");
+			exit(ret);
+		}
+	}
+
+	res = syscall(__NR_getpid);
+	if (res < 0) {
+		perror("getpid() unexpectedly failed\n");
+		exit(errno);
+	}
+
+	res = syscall(__NR_getppid);
+	if (res > 0) {
+		perror("getppid() unexpectedly succeeded\n");
+		exit(1);
+	}
+
+	exit(0);
+}
+
+int main(void)
+{
+	pid_t ref_pid = -1, child_pid = -1;
+	int ret, status;
+
+	ref_pid = fork();
+	if (ref_pid < 0)
+		exit(errno);
+	else if (ref_pid == 0)
+		do_ref_filter();
+
+	child_pid = fork();
+	if (child_pid < 0)
+		goto out;
+	else if (child_pid == 0)
+		do_child_process(ref_pid);
+
+	waitpid(child_pid, &status, 0);
+	if (WEXITSTATUS(status) != 0) {
+		perror("child process failed");
+		ret = WEXITSTATUS(status);
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	if (ref_pid != -1)
+		kill(ref_pid, SIGKILL);
+	if (child_pid != -1)
+		kill(child_pid, SIGKILL);
+
+	exit(ret);
+}
diff --git a/tools/include/uapi/linux/seccomp.h b/tools/include/uapi/linux/seccomp.h
index dbfc9b37fcae..b0917e333b4b 100644
--- a/tools/include/uapi/linux/seccomp.h
+++ b/tools/include/uapi/linux/seccomp.h
@@ -16,6 +16,7 @@
 #define SECCOMP_SET_MODE_FILTER		1
 #define SECCOMP_GET_ACTION_AVAIL	2
 #define SECCOMP_GET_NOTIF_SIZES		3
+#define SECCOMP_CLONE_FILTER		4
 
 /* Valid flags for SECCOMP_SET_MODE_FILTER */
 #define SECCOMP_FILTER_FLAG_TSYNC		(1UL << 0)
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 61acbd45ffaa..df5e0f615da0 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -177,6 +177,10 @@ struct seccomp_data {
 #define SECCOMP_GET_NOTIF_SIZES 3
 #endif
 
+#ifndef SECCOMP_CLONE_FILTER
+#define SECCOMP_CLONE_FILTER 4
+#endif
+
 #ifndef SECCOMP_FILTER_FLAG_TSYNC
 #define SECCOMP_FILTER_FLAG_TSYNC (1UL << 0)
 #endif
@@ -5090,6 +5094,73 @@ TEST_F(URETPROBE, uretprobe_default_block_with_uretprobe_syscall)
 	ASSERT_EQ(0, run_probed_with_filter(&prog));
 }
 
+TEST(clone_filter)
+{
+	struct sock_filter deny_filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ERRNO | ESRCH),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog deny_prog = {
+		.len = (unsigned short)ARRAY_SIZE(deny_filter),
+		.filter = deny_filter,
+	};
+	struct timespec ts = {
+		.tv_sec = 0,
+		.tv_nsec = 100000000,
+	};
+
+	pid_t child_pid, self_pid, res;
+	int child_pidfd, ret;
+
+	/* Only real root can copy a filter. */
+	if (geteuid()) {
+		SKIP(return, "clone_filter requires real root");
+		return;
+	}
+
+	self_pid = getpid();
+
+	child_pid = fork();
+	ASSERT_LE(0, child_pid);
+
+	if (child_pid == 0) {
+		ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+		ASSERT_EQ(0, prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &deny_prog));
+
+		while (true)
+			EXPECT_EQ(0, syscall(__NR_nanosleep, &ts, NULL));
+	}
+
+	/* wait for the child pid to create its seccomp filter */
+	ASSERT_EQ(0, syscall(__NR_nanosleep, &ts, NULL));
+
+	child_pidfd = syscall(SYS_pidfd_open, child_pid, 0);
+	EXPECT_LE(0, child_pidfd);
+
+	/* Invalid flag provided */
+	ret = seccomp(SECCOMP_CLONE_FILTER, 1, &child_pidfd);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(errno, EINVAL);
+
+	errno = 0;
+	ret = seccomp(SECCOMP_CLONE_FILTER, 0, &child_pidfd);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(errno, 0);
+
+	res = syscall(__NR_getppid);
+	EXPECT_EQ(res, -1);
+	EXPECT_EQ(errno, ESRCH);
+
+	res = syscall(__NR_getpid);
+	EXPECT_EQ(res, self_pid);
+
+	close(child_pidfd);
+	kill(child_pid, SIGKILL);
+}
+
 /*
  * TODO:
  * - expand NNP testing
-- 
2.47.3


