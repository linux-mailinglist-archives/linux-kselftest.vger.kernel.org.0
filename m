Return-Path: <linux-kselftest+bounces-18148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E69F397CF88
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 02:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8501F24BF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 00:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49783161;
	Fri, 20 Sep 2024 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RpOMIuZq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7DA24B26;
	Fri, 20 Sep 2024 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726791021; cv=none; b=LsSb0uzxM7gH9tjehoVfpBLVrkhhsfvUdthF/h0Yd52ibZLKpQKpoIbLvC5zPGQiTCfusW69fDgGYPE1GGwGOEcM/Rd49Dsy2qWd1kxCbUFzJU7JVNUtWn2mLbrtTr+W6Og0YQGFZ5EeQkmnct7v6qnngTIaNR9nLs7V2wxjBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726791021; c=relaxed/simple;
	bh=wabpurVZ+Y3E4VY/nY/VEx/NseEYQHhUMudMY7Funuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yhp2X2iVcv1w6Mu02KIip6FL4axAHP68KxDOCfANF5Czhn3fA42l3hYK8MdfdksIoLQU4RLzqK4kbOMwD2E01fdS3tdpyvxy4hvMwENiMbhfoGzc0PjXGJnJlnaC1kV1IB+Yldvf4/SbiGHWoWjsvMPxUnVHKGZVFbrotRVAorA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RpOMIuZq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JLMYw2022678;
	Fri, 20 Sep 2024 00:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=W
	9WegfPDiHTRKx+jMJJOmaobaNfizbKXAonvUDY1QFY=; b=RpOMIuZqpRtUGsUpg
	eRgVFI0LfhSuXE/yJP1ty5Nc6rK9/u+/m7bz8Dd+Y1j7Exp/8YikIQ+96oLIkJnX
	ZkyYYo9Xjl6tXxdL3BdlzhQBsVxch3q/ZesDfL1DPMM0lAhv5ssQ5vt6iZx9jxDX
	eMVrwZQturx07pSm9UdLeXBAvq0/UccTkSAjyVJ+nl64C8RlVVCITHAZmbiE7Kr6
	oA/hxnktE/DqUMD+9AkrCuXJhhMli8QUB1amifVZ7VIhSTY074EgU1NAsJgOxEBf
	rrs8C+vAxmJBpJkgYAz9WxmD5mksa+3IOiuT7Z8uKQsW/pZbrxzUhRg9uJ9dq7Ff
	7kmFA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rk585d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 00:09:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48JMREX8019165;
	Fri, 20 Sep 2024 00:09:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyd17ehq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 00:09:38 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48K09ZKF022155;
	Fri, 20 Sep 2024 00:09:38 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41nyd17egc-3;
	Fri, 20 Sep 2024 00:09:38 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: davem@davemloft.net, Liam.Howlett@Oracle.com
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, oleg@redhat.com,
        akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
        mhocko@suse.com, alexjlzheng@tencent.com, willy@infradead.org,
        michael.christie@oracle.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, anjali.k.kulkarni@oracle.com,
        peili.io@oracle.com
Subject: [PATCH net-next 2/2] connector/cn_proc: Selftest for threads case
Date: Thu, 19 Sep 2024 17:09:33 -0700
Message-ID: <20240920000933.185090-3-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240920000933.185090-1-anjali.k.kulkarni@oracle.com>
References: <20240920000933.185090-1-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_23,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409190161
X-Proofpoint-ORIG-GUID: P0q2sBH-T4w2wvs-zGF3YAZd2rar3nLI
X-Proofpoint-GUID: P0q2sBH-T4w2wvs-zGF3YAZd2rar3nLI

Test to check if setting PROC_CN_MCAST_NOTIFY in proc connector API, allows
a thread's non-zero exit status to be returned to proc_filter.

The threads.c program creates 2 child threads. 1st thread handles signal
SIGSEGV, and 2nd thread needs to indicate some error condition (value 1)
to the kernel, instead of using pthread_exit() with 1.

In both cases, child sends notify_netlink_thread_exit(exit_code) to kernel,
to let kernel know it has exited abnormally with exit_code.

Compile:
    make thread
    make proc_filter
To see non-zero exit notifications, run:
    ./proc_filter -f
Run threads code in another window:
    ./threads
Note the 2 child thread IDs reported above
Send SIGSEGV signal to the child handling SIGSEGV:
    kill -11 <child1-tid>
Watch the child 1 tid being notified with exit code 11 to proc_filter
Watch child 2 tid being notified with exit code 1 (value defined in code)
to proc_filter

Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
---
 tools/testing/selftests/connector/Makefile    | 23 ++++-
 .../testing/selftests/connector/proc_filter.c |  5 +
 tools/testing/selftests/connector/thread.c    | 87 +++++++++++++++++
 .../selftests/connector/thread_filter.c       | 93 +++++++++++++++++++
 4 files changed, 207 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/connector/thread.c
 create mode 100644 tools/testing/selftests/connector/thread_filter.c

diff --git a/tools/testing/selftests/connector/Makefile b/tools/testing/selftests/connector/Makefile
index 92188b9bac5c..453f5fbcdfb1 100644
--- a/tools/testing/selftests/connector/Makefile
+++ b/tools/testing/selftests/connector/Makefile
@@ -1,5 +1,26 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -Wall $(KHDR_INCLUDES)
+KERNEL="../../../.."
+
+CFLAGS += -Wall $(KHDR_INCLUDES) -I $(KERNEL)/include/uapi -I $(KERNEL)/include
+
+proc_filter: proc_filter.o
+	cc proc_filter.o -o proc_filter
+
+proc_filter.o: proc_filter.c
+	cc -c proc_filter.c -o proc_filter.o $(CFLAGS)
+
+thread: thread.o thread_filter.o
+	cc thread.o thread_filter.o -o thread
+
+thread.o: thread.c $(DEPS)
+		cc -c thread.c -o thread.o $(CFLAGS)
+
+thread_filter.o: thread_filter.c
+		cc -c thread_filter.c -o thread_filter.o $(CFLAGS)
+
+define EXTRA_CLEAN
+	rm *.o
+endef
 
 TEST_GEN_PROGS = proc_filter
 
diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/testing/selftests/connector/proc_filter.c
index 4a825b997666..6fb4842894f8 100644
--- a/tools/testing/selftests/connector/proc_filter.c
+++ b/tools/testing/selftests/connector/proc_filter.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
+ *
+ * Copyright (c) 2024 Oracle and/or its affiliates.
+ */
 
 #include <sys/types.h>
 #include <sys/epoll.h>
diff --git a/tools/testing/selftests/connector/thread.c b/tools/testing/selftests/connector/thread.c
new file mode 100644
index 000000000000..e20f209c980c
--- /dev/null
+++ b/tools/testing/selftests/connector/thread.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
+ *
+ * Copyright (c) 2024 Oracle and/or its affiliates.
+ */
+
+#include <pthread.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <signal.h>
+
+/*
+ * This code tests a thread exit notification when thread exits abnormally.
+ * Normally, when a thread exits abnormally, the kernel is not aware of the
+ * exit code. This is usually only conveyed from child to parent via the
+ * pthread_exit() and pthread_join() calls. Sometimes, however, a parent
+ * process cannot monitor all child processes via pthread_join(), particularly
+ * when there is a huge amount of child processes. In this case, the parent
+ * has created the child with PTHREAD_CREATE_DETACHED attribute.
+ * To fix this problem, either when child wants to convey non-zero exit via
+ * pthread_exit() or in a signal handler, the child can notify the kernel's
+ * connector module it's exit status via a netlink call with new type
+ * PROC_CN_MCAST_NOTIFY. (Implemented in the thread_filter.c file).
+ * This will send the exit code from the child to the kernel, which the kernel
+ * can later return to proc_filter program when the child actually exits.
+ * To test this usecase:
+ * Compile:
+ *	make thread
+ *	make proc_filter
+ * To see non-zero exit notifications, run:
+ *	./proc_filter -f
+ * Start the threads code, creating 2 threads, in another window:
+ *	./threads
+ * Note the 2 child thread IDs reported above
+ * Send SIGSEGV signal to the child handling SIGSEGV:
+ *	kill -11 <child1-tid>
+ * Watch the event being notified with exit code 11 to proc_filter
+ * Watch child 2 tid being notified with exit code 1 (value defined in code)
+ * to proc_filter
+ */
+
+extern int notify_netlink_thread_exit(unsigned int exit_code);
+
+static void sigsegvh(int sig)
+{
+	unsigned int exit_code = (unsigned int) sig;
+	/*
+	 * Send any non-zero value to get a notification. Here we are
+	 * sending the signal number for SIGSEGV which is 11
+	 */
+	notify_netlink_thread_exit(exit_code);
+}
+
+void *threadc1(void *ptr)
+{
+	signal(SIGSEGV, sigsegvh);
+	printf("Child 1 thread id %d, handling SIGSEGV\n", gettid());
+	sleep(50);
+	pthread_exit(NULL);
+}
+
+void *threadc2(void *ptr)
+{
+	printf("Child 2 thread id %d\n", gettid());
+	sleep(2);
+	notify_netlink_thread_exit(1);
+	pthread_exit(NULL);
+}
+
+int main(int argc, char **argv)
+{
+	pthread_t thread1, thread2;
+	pthread_attr_t attr1, attr2;
+
+	pthread_attr_init(&attr1);
+	pthread_attr_setdetachstate(&attr1, PTHREAD_CREATE_DETACHED);
+	pthread_create(&thread1, &attr1, *threadc1, NULL);
+
+	pthread_attr_init(&attr2);
+	pthread_attr_setdetachstate(&attr2, PTHREAD_CREATE_DETACHED);
+	pthread_create(&thread2, &attr2, *threadc2, NULL);
+
+	sleep(50);
+	exit(0);
+}
diff --git a/tools/testing/selftests/connector/thread_filter.c b/tools/testing/selftests/connector/thread_filter.c
new file mode 100644
index 000000000000..4b666004313b
--- /dev/null
+++ b/tools/testing/selftests/connector/thread_filter.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
+ *
+ * Copyright (c) 2024 Oracle and/or its affiliates.
+ */
+
+#include <sys/types.h>
+#include <sys/epoll.h>
+#include <sys/socket.h>
+#include <linux/netlink.h>
+#include <linux/connector.h>
+#include <linux/cn_proc.h>
+
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <strings.h>
+#include <errno.h>
+#include <signal.h>
+#include <string.h>
+
+#define NL_MESSAGE_SIZE (sizeof(struct nlmsghdr) + sizeof(struct cn_msg) + \
+			sizeof(struct proc_input))
+
+/*
+ * Send PROC_CN_MCAST_NOTIFY type notification to the connector code in kernel.
+ * This will send the exit_code specified by user to the connector layer, so
+ * it can send a notification for that event to any listening process
+ */
+int send_message(int nl_sock, unsigned int exit_code)
+{
+	char buff[NL_MESSAGE_SIZE];
+	struct nlmsghdr *hdr;
+	struct cn_msg *msg;
+
+	hdr = (struct nlmsghdr *)buff;
+	hdr->nlmsg_len = NL_MESSAGE_SIZE;
+	hdr->nlmsg_type = NLMSG_DONE;
+	hdr->nlmsg_flags = 0;
+	hdr->nlmsg_seq = 0;
+	hdr->nlmsg_pid = getpid();
+
+	msg = (struct cn_msg *)NLMSG_DATA(hdr);
+	msg->id.idx = CN_IDX_PROC;
+	msg->id.val = CN_VAL_PROC;
+	msg->seq = 0;
+	msg->ack = 0;
+	msg->flags = 0;
+
+	msg->len = sizeof(struct proc_input);
+	((struct proc_input *)msg->data)->mcast_op =
+		PROC_CN_MCAST_NOTIFY;
+	((struct proc_input *)msg->data)->uexit_code = exit_code;
+
+	if (send(nl_sock, hdr, hdr->nlmsg_len, 0) == -1) {
+		perror("send failed");
+		return -errno;
+	}
+	return 0;
+}
+
+int notify_netlink_thread_exit(unsigned int exit_code)
+{
+	struct sockaddr_nl sa_nl;
+	int err = 0;
+	int nl_sock;
+
+	nl_sock = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_CONNECTOR);
+
+	if (nl_sock == -1) {
+		perror("socket failed");
+		return -errno;
+	}
+
+	bzero(&sa_nl, sizeof(sa_nl));
+	sa_nl.nl_family = AF_NETLINK;
+	sa_nl.nl_groups = CN_IDX_PROC;
+	sa_nl.nl_pid    = gettid();
+
+	if (bind(nl_sock, (struct sockaddr *)&sa_nl, sizeof(sa_nl)) == -1) {
+		perror("bind failed");
+		return -errno;
+	}
+
+	err = send_message(nl_sock, exit_code);
+
+	if (err < 0)
+		return err;
+
+	return 0;
+}
-- 
2.45.2


