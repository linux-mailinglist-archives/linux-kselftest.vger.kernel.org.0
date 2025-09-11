Return-Path: <linux-kselftest+bounces-41260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C955BB53AC0
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 19:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06571C84A3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 17:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19225368083;
	Thu, 11 Sep 2025 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FT7G3mCG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A3362999;
	Thu, 11 Sep 2025 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613151; cv=none; b=dY3hc0J9qbPfOgqidjLHdn8whzNZU5mvgfVornRaxzBJRsddT2Y/1ytRHtw2InFSfLqMUtdut/CMgmkOkaj3r5d5Xrw8BZu/CGec2uAgoO1QzOIy7o/6GSNS1pyGkdV6v4HAyy8pjMt2WmSou/l7aDFugAuTJrvY3M/XTJ8zbCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613151; c=relaxed/simple;
	bh=pv0Le1I/8kyb8OOojFvMK4r7sqInuLMNvSNzwHoyIxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q26+dEwR0TR9WAeXuMkA9hgea2OTo1UtVl/Z4C5svuNQqpHFNKt/JDAJiQhTHjcuZ6piNpwdBWoTFaNTVJ4c6BRzSmU5u9UyioN04WO7EWhlVf9lBcKJ8Xe0K+efdt15CtilDFWr3VLOrVOVPkjNF2yimTePT9FjbvnR47gvGNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FT7G3mCG; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BHBfAi025903;
	Thu, 11 Sep 2025 17:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=czilZ
	+lB3YW1FJdBSp8ullY1EEqC9yv4cN9ifpNvlY4=; b=FT7G3mCGFi/TQS83fHQMz
	IXxZ7xXP6gdJinV+07g+zZ5bcXJf+nMqwxWvWgtVWzAaMaprMUXjGkMGsxyWnfp4
	I4T4zxR3r5uRfELk1BN8vkZFNpIq8ZrN0cRk9NvwF4NlVdJPhKnSJDbRi3S5s0HY
	PPJl/OHhjQYrwBcfmsdr+rNtVZubwO3n/wuvp54k5QtRI0NQHx40GUCBZCKS6FfS
	LHuAG3d/YIkGwtNdoK6vJXPE5IbxvAsVbSS11RUoLG2DxcsDO+WPV8lEGkHFzSIe
	CWCR1xaetUxOoog5t8JwtAHcPjwpEd3PfKSWV4RVgbf05hQqkjafuloB5YJqWiZG
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226sxte4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:52:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BG8Mgj032957;
	Thu, 11 Sep 2025 17:52:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bddrae8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:52:19 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58BHqHCZ031675;
	Thu, 11 Sep 2025 17:52:18 GMT
Received: from thromatk-ol10.osdevelopmeniad.oraclevcn.com (thromatk-ol10.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bddraaw-2;
	Thu, 11 Sep 2025 17:52:18 +0000
From: Tom Hromatka <tom.hromatka@oracle.com>
To: tom.hromatka@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org, corbet@lwn.net,
        shuah@kernel.org, brauner@kernel.org
Subject: [PATCH v2 1/1] seccomp: Add SECCOMP_CLONE_FILTER operation
Date: Thu, 11 Sep 2025 17:50:33 +0000
Message-ID: <20250911175215.147938-2-tom.hromatka@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911175215.147938-1-tom.hromatka@oracle.com>
References: <20250911175215.147938-1-tom.hromatka@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110159
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c30c54 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=yJojWOMRYYMA:10 a=R4ZDeqtCAAAA:20 a=yPCof4ZbAAAA:8 a=k8PFyzEPRq4tZizcb9gA:9
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: yxvFpcMZ9HW3T9yT4eVCrcdkpVxG2xVQ
X-Proofpoint-GUID: yxvFpcMZ9HW3T9yT4eVCrcdkpVxG2xVQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX/uhv1fph5RL0
 +h1KYyjgfBTJruu8S24HscjkIWRYN1+KnxEBmhps0YaPNqaPmb9sbJqmq9lVcGZH+xPyEC1mvba
 VUoCnlanrEmoeqeZZ+XyDlP2WY7PmsOFq1id70xofsiCoBHGCPEcSA3Soy4vqve7C3nUutcOpZD
 hBOfeMXBDPC5nUfL40p1zfDd4LPgbWeeTTeGXfNbjDb3dy9Gt+bZ5uH4QyHmTqFVw29ibLgtVnn
 FC21sez0pdK58Sn/T/ECpKpTCB4RpQeJ2N/LKOrNORDjQBlBj8Dvib0LZUlCB+sHCbtFI6C1Vkl
 aO/0iI6yKPvyMcQUiAxJtexzC4K4xoh/sQ7fftLq4tjTAV1Ua+pkjI4UoptoWLYk7ylQcxSZk1d
 JPm1nx6G

Add an operation, SECCOMP_CLONE_FILTER, that can copy the seccomp filters
from another process to the current process.

I roughly reproduced the Docker seccomp filter [1] and timed how long it
takes to build it (via libseccomp) and attach it to a process.  After
1000 runs, on average it took 3,720,000 TSC ticks (or ~1430 microseconds)
on an AMD EPYC 9J14 running at 2596 MHz.  The median build/load time was
3,704,000 TSC ticks.

On the same system, I preloaded the above Docker seccomp filter onto a
process.  (Note that I opened a pidfd to the reference process and left
the pidfd open for the entire run.)  I then cloned the filter using the
feature in this patch to 1000 new processes.  On average, it took 1,900
TSC ticks (or ~0.7 microseconds) to copy the filter to the new processes.
The median clone time was 1,716 TSC ticks.

This is approximately a 1900x performance improvement for those container
managers that are using the exact same seccomp filter across all of their
containers.

[1] https://raw.githubusercontent.com/moby/moby/refs/heads/master/profiles/seccomp/default.json

Signed-off-by: Tom Hromatka <tom.hromatka@oracle.com>
---
 .../userspace-api/seccomp_filter.rst          |  10 ++
 include/uapi/linux/seccomp.h                  |   1 +
 kernel/seccomp.c                              |  48 ++++++
 samples/seccomp/.gitignore                    |   1 +
 samples/seccomp/Makefile                      |   2 +-
 samples/seccomp/clone-filter.c                | 150 ++++++++++++++++++
 tools/include/uapi/linux/seccomp.h            |   1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c | 114 +++++++++++++
 8 files changed, 326 insertions(+), 1 deletion(-)
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
index 3bbfba30a777..efc7ae1d5505 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2079,6 +2079,49 @@ static long seccomp_get_notif_sizes(void __user *usizes)
 	return 0;
 }
 
+static long seccomp_clone_filter(void __user *pidfd)
+{
+	struct seccomp new_seccomp;
+	struct task_struct *task;
+	unsigned int flags;
+
+	if (!task_no_new_privs(current) &&
+	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
+		return -EACCES;
+
+	task = pidfd_get_task((intptr_t)pidfd, &flags);
+	if (IS_ERR(task))
+		return -ESRCH;
+
+	spin_lock_irq(&task->sighand->siglock);
+	if (atomic_read(&task->seccomp.filter_count) == 0) {
+		spin_unlock_irq(&task->sighand->siglock);
+		put_task_struct(task);
+		return -EINVAL;
+	}
+
+	get_seccomp_filter(task);
+	new_seccomp = task->seccomp;
+	spin_unlock_irq(&task->sighand->siglock);
+
+	spin_lock_irq(&current->sighand->siglock);
+	/* Fail the clone operation if this process already has filters */
+	if (atomic_read(&current->seccomp.filter_count) > 0) {
+		spin_unlock_irq(&current->sighand->siglock);
+		__seccomp_filter_release(new_seccomp.filter);
+		put_task_struct(task);
+		return -EINVAL;
+	}
+
+	/* no barriers - only current->seccomp.filter is read locklessly */
+	current->seccomp = new_seccomp;
+	set_task_syscall_work(current, SECCOMP);
+	spin_unlock_irq(&current->sighand->siglock);
+	put_task_struct(task);
+
+	return 0;
+}
+
 /* Common entry point for both prctl and syscall. */
 static long do_seccomp(unsigned int op, unsigned int flags,
 		       void __user *uargs)
@@ -2100,6 +2143,11 @@ static long do_seccomp(unsigned int op, unsigned int flags,
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
diff --git a/samples/seccomp/.gitignore b/samples/seccomp/.gitignore
index a6df0da77c5d..b404cba5bb69 100644
--- a/samples/seccomp/.gitignore
+++ b/samples/seccomp/.gitignore
@@ -3,3 +3,4 @@
 /bpf-fancy
 /dropper
 /user-trap
+/clone-filter
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
index 000000000000..c7d520bf61cf
--- /dev/null
+++ b/samples/seccomp/clone-filter.c
@@ -0,0 +1,150 @@
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
+#include <sys/prctl.h>
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
+	ret = seccomp(SECCOMP_CLONE_FILTER, 0, (void *)(intptr_t)ref_pidfd);
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
+	int ret = -EINVAL, status;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	if (ret) {
+		perror("set no new privs unexpectedly failed\n");
+		exit(errno);
+	}
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
index fc4910d35342..53ea2610dcf8 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -178,6 +178,10 @@ struct seccomp_data {
 #define SECCOMP_GET_NOTIF_SIZES 3
 #endif
 
+#ifndef SECCOMP_CLONE_FILTER
+#define SECCOMP_CLONE_FILTER 4
+#endif
+
 #ifndef SECCOMP_FILTER_FLAG_TSYNC
 #define SECCOMP_FILTER_FLAG_TSYNC (1UL << 0)
 #endif
@@ -5221,6 +5225,116 @@ TEST_F(URETPROBE, uretprobe_default_block_with_uretprobe_syscall)
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
+
+	pid_t child_pid, self_pid, res;
+	int child_pidfd, ret, status;
+	int pipe_c2p[2], pipe_p2c[2];
+	ssize_t bytes_read;
+	char buf = ' ';
+
+	/* Setup two pipes for communicating between parent and child */
+	ASSERT_EQ(0, pipe(pipe_c2p));
+	ASSERT_EQ(0, pipe(pipe_p2c));
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	self_pid = getpid();
+
+	child_pid = fork();
+	ASSERT_GE(child_pid, 0);
+
+	if (child_pid == 0) {
+		EXPECT_EQ(0, close(pipe_c2p[0]));
+		EXPECT_EQ(0, close(pipe_p2c[1]));
+
+		ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+		ASSERT_EQ(0, prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &deny_prog));
+
+		res = syscall(__NR_getppid);
+		EXPECT_EQ(res, -1);
+		EXPECT_EQ(errno, ESRCH);
+
+		/* Tell the parent that our filter is ready to be cloned */
+		EXPECT_EQ(1, write(pipe_c2p[1], ".", 1));
+
+		/* Wait for the parent to tell us we can exit */
+		bytes_read = read(pipe_p2c[0], &buf, 1);
+		EXPECT_EQ(bytes_read, 1);
+		EXPECT_EQ(0, close(pipe_c2p[1]));
+		EXPECT_EQ(0, close(pipe_p2c[0]));
+		_exit(0);
+	}
+
+	ASSERT_EQ(0, close(pipe_p2c[0]));
+	ASSERT_EQ(0, close(pipe_c2p[1]));
+
+	/* Wait for the child pid to load its filter */
+	bytes_read = read(pipe_c2p[0], &buf, 1);
+	ASSERT_EQ(bytes_read, 1);
+
+	child_pidfd = syscall(SYS_pidfd_open, child_pid, 0);
+	EXPECT_GE(child_pidfd, 0);
+
+	/* Invalid flags provided */
+	ret = seccomp(SECCOMP_CLONE_FILTER, -1, (void *)(intptr_t)child_pidfd);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* Invalid pidfd provided */
+	errno = 0;
+	ret = seccomp(SECCOMP_CLONE_FILTER, 0, (void *)(intptr_t)123456);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(errno, ESRCH);
+
+	errno = 0;
+	res = syscall(__NR_getppid);
+	EXPECT_GE(res, 0);
+	EXPECT_EQ(errno, 0);
+
+	ret = seccomp(SECCOMP_CLONE_FILTER, 0, (void *)(intptr_t)child_pidfd);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(errno, 0);
+
+	/* Cloning another set of filters is not currently allowed */
+	ret = seccomp(SECCOMP_CLONE_FILTER, 0, (void *)(intptr_t)child_pidfd);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(errno, EINVAL);
+
+	res = syscall(__NR_getppid);
+	EXPECT_EQ(res, -1);
+	EXPECT_EQ(errno, ESRCH);
+
+	res = syscall(__NR_getpid);
+	EXPECT_EQ(res, self_pid);
+
+	close(child_pidfd);
+
+	/* Tell the child it can exit */
+	ASSERT_EQ(1, write(pipe_p2c[1], ".", 1));
+
+	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
+	ASSERT_EQ(true, WIFEXITED(status));
+
+	ASSERT_EQ(0, close(pipe_p2c[1]));
+	ASSERT_EQ(0, close(pipe_c2p[0]));
+}
+
 /*
  * TODO:
  * - expand NNP testing
-- 
2.47.3


