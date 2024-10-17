Return-Path: <linux-kselftest+bounces-20019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C069A2BE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E88286025
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5F61E1C07;
	Thu, 17 Oct 2024 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G0F8h98F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815BA184D;
	Thu, 17 Oct 2024 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188908; cv=none; b=PcYWHQT3+1RTeWmORTjJJYIQJ23I6crUzixo6gCoHyl+0JOZOFRn5HJm88GxZup9cafKy9trt1ZpBW6ZX+oKdms91Cm+7IdyImoxaPf+M4nJ234eOAbjmrvs2OZZTz810O0VGFy7oJBeuoF9xzdp2tK1FlTeH17mX1HPUYrawH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188908; c=relaxed/simple;
	bh=vDAAHZj4bDD9eVgphWG10z6ugAaqL/dtWRy/SMZS16E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNhyNYeFexc0fflJSLNf9HySge6ZxubDrFwo1HasK35wSpCnB3qfQ3qWZmChWA9RymeyDroJagHLSdrNb5DFXRK3Y5h/ZokvLvAU/Ht4QQmuHe6WlLaIDkEw8LqQbZSqrQLJBvzTSS1c3naJOi+TIgJY2i+BGU4koChCfCioSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G0F8h98F; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBooB002190;
	Thu, 17 Oct 2024 18:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=cnhe9
	VSX2bLWjmOVKj7JINYA/sD/CFH1T1PVnqlW+DQ=; b=G0F8h98FBHrjhwZomSUzA
	Dzen/xLKtAtbKrOa0fBr01GSIlqLqdDGSbb0PnNsUF1zJ+5/gSuPQIuGMBiCCfUY
	RCKSreO4gB5zomB2V+QnkGHdWzc9qJXKKnIWaBne7/QnJ1Mp5FxrJaXvchMolm5U
	g/vRyOkPwdG15jFfo6HmbZG+p3liYRQtvQCNk09Ps8ll0zAxuoyd7G+UgNrgYwlK
	pgbN63iRmorxFGG7pTxBwrBTZl4JscrjOFa4t8OQQTpaE62tzGp/nm3zzFXLJQfA
	1SJPkbasBlVIp7jQIFBjH/vQNaANSt9vvy+vh3HdtWd/kIsLymEkt8YW0kjzHdP4
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2q855-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 18:14:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HHG2ja010433;
	Thu, 17 Oct 2024 18:14:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjgxky5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 18:14:48 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49HIA0bR039328;
	Thu, 17 Oct 2024 18:14:47 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 427fjgxkpk-4;
	Thu, 17 Oct 2024 18:14:47 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: davem@davemloft.net, Liam.Howlett@Oracle.com
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, jiri@resnulli.us, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, akpm@linux-foundation.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, anjali.k.kulkarni@oracle.com,
        peili.io@oracle.com
Subject: [PATCH net-next v5 3/3] connector/cn_proc: Selftest for threads
Date: Thu, 17 Oct 2024 11:14:36 -0700
Message-ID: <20241017181436.2047508-4-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241017181436.2047508-1-anjali.k.kulkarni@oracle.com>
References: <20241017181436.2047508-1-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_20,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170124
X-Proofpoint-GUID: Gjt0vaJlCE-tGrJTbaOALzMQUoi8E-E6
X-Proofpoint-ORIG-GUID: Gjt0vaJlCE-tGrJTbaOALzMQUoi8E-E6

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
Run:
    ./threads

Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
---
 tools/testing/selftests/connector/Makefile    |  23 +-
 .../testing/selftests/connector/proc_filter.c |  34 ++-
 tools/testing/selftests/connector/thread.c    | 232 ++++++++++++++++++
 .../selftests/connector/thread_filter.c       |  96 ++++++++
 4 files changed, 378 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/connector/thread.c
 create mode 100644 tools/testing/selftests/connector/thread_filter.c

diff --git a/tools/testing/selftests/connector/Makefile b/tools/testing/selftests/connector/Makefile
index 92188b9bac5c..bf335826bc3b 100644
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
+	rm *.o thread
+endef
 
 TEST_GEN_PROGS = proc_filter
 
diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/testing/selftests/connector/proc_filter.c
index 4a825b997666..5bf992deb792 100644
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
@@ -28,6 +33,7 @@
 volatile static int interrupted;
 static int nl_sock, ret_errno, tcount;
 static struct epoll_event evn;
+FILE *file;
 
 static int filter;
 
@@ -37,6 +43,8 @@ static int filter;
 #define Printf ksft_print_msg
 #endif
 
+#define EXIT_LOG
+
 int send_message(void *pinp)
 {
 	char buff[NL_MESSAGE_SIZE];
@@ -146,6 +154,12 @@ int handle_packet(char *buff, int fd, struct proc_event *event)
 		tcount++;
 		switch (event->what) {
 		case PROC_EVENT_EXIT:
+#ifdef EXIT_LOG
+			fprintf(file, "pid %d tgid %d code %d\n",
+				event->event_data.exit.process_pid,
+				event->event_data.exit.process_tgid,
+				event->event_data.exit.exit_code);
+#endif
 			Printf("Exit process %d (tgid %d) with code %d, signal %d\n",
 			       event->event_data.exit.process_pid,
 			       event->event_data.exit.process_tgid,
@@ -279,17 +293,24 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+#ifdef EXIT_LOG
+	file = fopen("exit.log", "w");
+	if (file == NULL) {
+		perror("Error opening file exit.log");
+		close(nl_sock);
+		close(epoll_fd);
+		exit(1);
+	}
+#endif
+
 	while (!interrupted) {
 		err = handle_events(epoll_fd, &proc_ev);
 		if (err < 0) {
 			if (ret_errno == EINTR)
 				continue;
-			if (err == -2)
-				close(nl_sock);
-			if (err == -3) {
-				close(nl_sock);
-				close(epoll_fd);
-			}
+			close(nl_sock);
+			close(epoll_fd);
+			fclose(file);
 			exit(1);
 		}
 	}
@@ -304,6 +325,7 @@ int main(int argc, char *argv[])
 
 	close(epoll_fd);
 	close(nl_sock);
+	fclose(file);
 
 	printf("Done total count: %d\n", tcount);
 	exit(0);
diff --git a/tools/testing/selftests/connector/thread.c b/tools/testing/selftests/connector/thread.c
new file mode 100644
index 000000000000..70c475ce3176
--- /dev/null
+++ b/tools/testing/selftests/connector/thread.c
@@ -0,0 +1,232 @@
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
+ * Compile:
+ *	make thread
+ *	make proc_filter
+ * Run:
+ *	./threads
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
+
+	*(int *)ptr = gettid();
+
+	printf("Child 1 thread id %d, handling SIGSEGV\n", gettid());
+	sleep(10);
+	pthread_exit(NULL);
+}
+
+void *threadc2(void *ptr)
+{
+	int exit_val = 1;
+
+	*(int *)ptr = gettid();
+
+	printf("Child 2 thread id %d, wants to exit with value %d\n",
+			gettid(), exit_val);
+	sleep(2);
+	notify_netlink_thread_exit(exit_val);
+	pthread_exit(NULL);
+}
+
+static void verify_exit_status(int tid1, int tid2)
+{
+	int found1 = 0, found2 = 0;
+	int pid, tgid, exit_code;
+	size_t size = 1024;
+	FILE *file;
+	char *data;
+	int ret;
+
+	data = malloc(size * sizeof(char));
+	if (data == NULL) {
+		perror("malloc for data failed");
+		exit(1);
+	}
+
+	file = fopen("exit.log", "r");
+	if (file == NULL) {
+		perror("fopen of exit.log failed");
+		free(data);
+		exit(1);
+	}
+
+	while (getline(&data, &size, file) != -1) {
+		ret = sscanf(data, "pid %d tgid %d code %d",
+				&pid, &tgid, &exit_code);
+		if (ret != 3) {
+			perror("sscanf error");
+			free(data);
+			fclose(file);
+			exit(1);
+		}
+
+		if (tgid != getpid())
+			continue;
+
+		if (pid == tid1) {
+			if (exit_code == 11) {
+				printf("Successful notification of SIGSEGV, tid %d\n",
+						pid);
+			} else {
+				printf("Failure SIGSEGV tid %d, exit code %d\n",
+					       pid, exit_code);
+			}
+			found1 = 1;
+		} else if (pid == tid2) {
+			if (exit_code == 1) {
+				printf("Successful notification of thread exit tid %d\n",
+						pid);
+			} else {
+				printf("Failure thread exit tid %d, exit code %d\n",
+					       pid, exit_code);
+			}
+			found2 = 1;
+		}
+	}
+
+	if (!found1)
+		printf("tid %d not present in exit.log file\n", tid1);
+
+	if (!found2)
+		printf("tid %d not present in exit.log file\n", tid2);
+
+	fclose(file);
+	free(data);
+}
+
+static inline void init_threads(pthread_attr_t *attr)
+{
+	int ret;
+
+	ret = pthread_attr_init(attr);
+	if (ret != 0) {
+		perror("pthread_attr_init failed");
+		exit(ret);
+	}
+
+	ret = pthread_attr_setdetachstate(attr, PTHREAD_CREATE_DETACHED);
+	if (ret != 0) {
+		perror("pthread_attr_setdetachstate failed");
+		exit(ret);
+	}
+}
+
+static inline void destroy_thread_attr(pthread_attr_t *attr)
+{
+	int ret;
+
+	ret = pthread_attr_destroy(attr);
+	if (ret != 0) {
+		perror("pthread_attr_destroy failed");
+		exit(ret);
+	}
+}
+
+
+static inline pid_t start_proc_filter(void)
+{
+	pid_t proc_filter = 0;
+
+	proc_filter = fork();
+	if (proc_filter == -1) {
+		perror("fork()");
+		exit(1);
+	}
+
+	if (proc_filter == 0) {
+		char* arr[] = {"proc_filter", "-f", NULL};
+		execv("./proc_filter", arr);
+	}
+	sleep(1);
+	return proc_filter;
+}
+
+int main(int argc, char **argv)
+{
+	pthread_t thread1, thread2;
+	pthread_attr_t attr1, attr2;
+	int tid1, tid2, ret;
+	pid_t proc_filter_pid;
+
+	proc_filter_pid = start_proc_filter();
+
+	init_threads(&attr1);
+	ret = pthread_create(&thread1, &attr1, *threadc1, &tid1);
+	if (ret != 0) {
+		perror("pthread_create failed");
+		exit(ret);
+	}
+
+	init_threads(&attr2);
+	ret = pthread_create(&thread2, &attr2, *threadc2, &tid2);
+	if (ret != 0) {
+		perror("pthread_create failed");
+		exit(ret);
+	}
+
+	sleep(1);
+
+	/* Send SIGSEGV to tid1 */
+	kill(tid1, SIGSEGV);
+
+	/*
+	 * Wait for children to exit or be killed and for exit.log to
+	 * be generated by ./proc_filter
+	 */
+	sleep(2);
+
+	/*
+	 * Kill proc_filter to get exit.log
+	 */
+	kill(proc_filter_pid, SIGINT);
+
+	/* Required to allow kill to be processed */
+	sleep(1);
+
+	verify_exit_status(tid1, tid2);
+
+	destroy_thread_attr(&attr1);
+	destroy_thread_attr(&attr2);
+
+	exit(0);
+}
diff --git a/tools/testing/selftests/connector/thread_filter.c b/tools/testing/selftests/connector/thread_filter.c
new file mode 100644
index 000000000000..3da740aa7537
--- /dev/null
+++ b/tools/testing/selftests/connector/thread_filter.c
@@ -0,0 +1,96 @@
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
+		close(nl_sock);
+		return -errno;
+	}
+
+	err = send_message(nl_sock, exit_code);
+
+	close(nl_sock);
+
+	if (err < 0)
+		return err;
+
+	return 0;
+}
-- 
2.46.0


